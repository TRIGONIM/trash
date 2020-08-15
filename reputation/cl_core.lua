-- Получает сообщения к репутациям, которые оставили игроку
-- По умолчанию для всех загружаются только цифры. ИД категории и значение репы
-- Эта функция используется для получения подробностей, вроде сообщений
function REP.GetFull(for_ply,callback)
	local id = "REP.Get." .. for_ply:SteamID()
	hook("REP.Callback",id,function(dat)
		if !dat[id] then return end

		callback(dat["REP"])

		hook.Remove("REP.Callback",id)
	end)

	net.Start("REP.Get")
		net.WritePlayer(for_ply)
	net.SendToServer()
end


function REP.AddAction(for_ply,categ,message,from_ply)
	net.Start("REP.Add")
		net.WritePlayer(from_ply or LocalPlayer())
		net.WritePlayer(for_ply)
		net.WriteUInt(categ,7)
		net.WriteString(message or "")
	net.SendToServer()
end

function REP.RemAction(id)
	net.Start("REP.Rem")
		net.WriteUInt(id,16)
	net.SendToServer()
end


net("REP.Callback",function()
	hook.Call("REP.Callback",nil,net.ReadTable())
end)






--[[-------------------------------------------------------------------------
	Предложение оставить репу после слов Спасибо и т.д.
---------------------------------------------------------------------------]]
-- задержка между предложениями в секундах
local COOLDOWN = 60 * 5

local keywords = fl.set{"спс","спасибо","сэнкс","пасиб","благодарю"}
local lastsuggestiontime = 0
hook("OnPlayerChat","RepSuggestionOnSpasipo",function(pl,text)
	if !IsValid(pl) or !pl:IsLocalPlayer() then return end -- console or another player

	local suggested = CurTime() <= lastsuggestiontime + COOLDOWN

	if !suggested and (keywords[ text:utf8lower() ] or text:StartWith("спс")) then
		lastsuggestiontime = CurTime()

		notification.AddLegacy("Напишите в чат '+++', чтобы изменить репутацию игрока",3,20)
	end

	if suggested and text == "+++" then
		ui.PlayerRequest(REP.VGUI_MakeReview)
	end
end)


hook("catchDSHints","REP",function(ADD)
	ADD("Отблагодарите игрока положительной репутацией. Она влияет на шанс получения должности, а также мотивирует игроков хорошо себя вести")
	ADD("Некорректная репутация удаляется администрацией в ручном режиме через специальный канал в телеграм")
end)