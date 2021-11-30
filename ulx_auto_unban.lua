--[[-------------------------------------------------------------------------
	Скрипт, который использовался для автоматического разбана игроком на ULX

	Если тот пытался зайти на сервер и у него был бан, а также деньги на балансе IGS,
		то ему предлагало совершить еще пару попыток входа для подтверждения разбана

	Удален из-за желания переосмыслить баны, чтобы игрок все же мог зайти на сервер даже в бане
---------------------------------------------------------------------------]]



local BM = {} -- Ban Message

BM.cfg = {}
BM.cfg.msgWrongPass =
[[
--------------------------------------------------------------------
                         Неверный пароль
--------------------------------------------------------------------
]]

BM.cfg.msgWrongPassChat =
"{Name} попытался войти в город с фальшивым паспортом: {Pass}"



BM.cfg.msgBanned =
[[Похоже, вы что-то нарушили

Уполномоченный: {AdminName}

Осталось: {TimeLeft}
Статья: {Reason}

Аппеляции на trigon.im]]

BM.cfg.msgBannedChat =
"{Name} попытался вернуться в город, хотя он изгнан за {Reason}"

BM.cfg.msgUnbanPrice =
[[Vas nakazal {AdminName}
Statya: {Reason}
Na donat schetu {Balance} rub.
Perepodkl. escho {Times} raz, dlya advtorazbana.
Cena razbana: {UnbanPrice} rub
Ili sidi v bane escho {TimeLeft}]]

BM.cfg.msgNotEnoughMoney =
[[Vas nakazal {AdminName}
Statya: {Reason}

Na vashem donat schetu {Balance} Alc.
Vam ne hvatayet {Lacks} Alc dlya avtorazbana

Va ne smozete igrat escho {TimeLeft}]]

BM.cfg.msgTlgNotify =
[[%s купил автоматический разбан
💰 Заплатил: %i
⏲ Был забанен на: %s
🐓 Банил: %s
📝 Причина: %s
]]


BM.cfg.chatMsgColorPASS = Color(255,0,0)
BM.cfg.chatMsgColorBAN  = Color(255,0,0)

BM.cfg.notifyAdmins = true
BM.cfg.notifyAll    = false

BM.cfg.prices = {
	{60, 50}, -- час
	{360,70}, -- 6
	{720,100}, -- 12

	{1440,150}, -- сутки
	{2880,250}, -- 2
	{4320,300}, -- 3

	{10080,500}, -- неделя
	{20160,650}, -- 2
	{30240,750}, -- 3

	{43200, 999}, -- месяц
	{86400, 1337}, -- 2
	{129600,1666}, -- 3

	{259200,2300}, -- пол года
	{518400,2500}, -- год
}

local c = BM.cfg


local prices = c.prices
local function getUnbanPrice(unban)
	local minLeft = (unban - os.time()) / 60

	-- Перма
	if unban == 0 then
		return 3000

	-- Срок меньше часа
	elseif minLeft < prices[1][1] then
		return prices[1][2]

	-- Бан более, чем на год, но не перма
	elseif minLeft > prices[#prices][1] then
		return prices[#prices][2]

	-- Бан в пределах таблицы
	else
		for i,cDat in ipairs(prices) do
			local _,nDat = next(prices,i)

			if minLeft >= cDat[1] and minLeft < nDat[1] then
				return cDat[2]
			end
		end
	end
end


local aUnbanCache = {}

hook("PostGamemodeLoaded","CustomBanMsgPostGamemode", function()
function GAMEMODE:CheckPassword(sid64,_ip_,sv_pass,cl_pass,clientname)

	--[[-------------------------------------------------------------------------
		Стоит пароль
	---------------------------------------------------------------------------]]
	if sv_pass ~= "" and sv_pass ~= cl_pass then
		local msg = string.gsub(c.msgWrongPassChat, "{Name}",clientname)
		      msg = string.gsub(msg, "{Pass}", cl_pass)

		for _,ply in ipairs(
			(c.notifyAdmins and getAllStaff()) or
			(c.notifyAll and player.GetAll()) or {}
		) do
			qq.CMessage(ply,msg,c.chatMsgColorPASS)
		end

		MsgC(c.chatMsgColorPASS, msg .. "\n")

		return false, c.msgWrongPass
	end


	--[[-------------------------------------------------------------------------
		Проверка бана
	---------------------------------------------------------------------------]]
	local sid = util.SteamIDFrom64(sid64)
	local BanInfo = ULib.bans[sid]
	if BanInfo then
		local BanLeft =
		-- tostring, потому что иногда число, а иногда строка попадается. Хз как
			tostring(BanInfo.unban) == "0" and "чуть дольше вечности" or
			timeToStr(BanInfo.unban - os.time())

		local BanReason =
			BanInfo.reason ~= "" and BanInfo.reason or "не указана"

		local UnBanPrice = getUnbanPrice(tonumber(BanInfo.unban))
		UnBanPrice = IGS.PriceInCurrency(UnBanPrice)

		--[[-------------------------------------------------------------------------
			Платный авторазбан
		---------------------------------------------------------------------------]]
		-- Первый вход после бана или ожидания 5 минут
		-- Неизвестно использовал ли чел IGS
		if !aUnbanCache[sid] then
			aUnbanCache[sid] = {
				loginAttempts = 0
			}

			IGS.GetBalance(sid64,function(bal)
				aUnbanCache[sid]["bal"] = bal -- может быть nil
			end)

			timer.Simple(60 * 5,function()
				aUnbanCache[sid] = nil
			end)

		-- Если чел использовал IGS и заходит второй раз
		elseif aUnbanCache[sid]["bal"] then
			aUnbanCache[sid]["loginAttempts"] = aUnbanCache[sid]["loginAttempts"] + 1

			-- Хватает бабла
			if aUnbanCache[sid]["bal"] >= UnBanPrice then
				-- Снимаем деньги и бан после 5 попыток входа
				if aUnbanCache[sid]["loginAttempts"] == 5 then
					-- проверяем еще раз на случай если вдруг БД отвалилась
					-- или чел за это время потратил эти деньги на другом сервере
					IGS.GetBalance(sid64,function(bal)
						aUnbanCache[sid]["bal"] = bal or 0 -- обновляем данные

						if aUnbanCache[sid]["bal"] >= UnBanPrice then
							local notif = c.msgTlgNotify:format(sid,UnBanPrice,BanLeft,BanInfo.admin,BanReason)

							IGS.Transaction(sid64, -UnBanPrice, "Unban " .. BanLeft, function()
								ta.TLGMSG(TLG_CONF_TGDONS,notif)

								RunConsoleCommand("ulx","unban",sid)
								aUnbanCache[sid] = nil
							end)

							OM.SendToAny(sid64,
								"Спасибо за покупку автоматического разбана. Техническая информация:\n\n" .. notif
							)
						end
					end)

					return false,"Перезайдите еще раз.\n\nЕсли все хорошо, то вы уже не в бане\n\nИли свяжитесь с нами через форум trigon.im"
				end

				-- Меньше 5 попыток входа
				return false,c.msgUnbanPrice
					:gsub("{AdminName}",BanInfo.admin)
					:gsub("{Reason}",BanReason)
					:gsub("{Balance}",aUnbanCache[sid]["bal"])
					:gsub("{Times}",5 - aUnbanCache[sid]["loginAttempts"])
					:gsub("{UnbanPrice}",UnBanPrice)
					:gsub("{TimeLeft}",BanLeft)

			-- Не хватает бабла
			else
				return false, c.msgNotEnoughMoney
					:gsub("{AdminName}",BanInfo.admin)
					:gsub("{Reason}",BanReason)
					:gsub("{Balance}",aUnbanCache[sid]["bal"])
					:gsub("{Lacks}",UnBanPrice - aUnbanCache[sid]["bal"])
					:gsub("{TimeLeft}",BanLeft)
			end


		-- Чел НЕ использовал IGS
		--elseif !aUnbanCache[sid]["bal"] then
		end
		--[[-------------------------------------------------------------------------
		---------------------------------------------------------------------------]]


		local SendChatMsg =
			c.msgBannedChat
				:gsub("{Name}",clientname)
				:gsub("{Reason}",BanInfo.reason ~= "" and BanInfo.reason or "хмм.. а причины нет")



		if c.notifyAll then
			qq.CMessage(player.GetAll(),SendChatMsg,c.chatMsgColorPASS)

		elseif c.notifyAdmins then
			qq.CMessage(getAllStaff(),SendChatMsg,c.chatMsgColorPASS)

		end

		MsgC(c.chatMsgColorBAN, SendChatMsg .. "\n" )

		return false, c.msgBanned
			:gsub("{AdminName}",BanInfo.admin or "CONSOLE")
			:gsub("{Reason}",   BanReason)
			:gsub("{TimeBan}",  BanInfo.time == 0 and "Неизвестно" or os.date("%d.%m.%y %H:%M", BanInfo.time))
			:gsub("{TimeLeft}", BanLeft)
	end

end
end)
