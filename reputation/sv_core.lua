util.AddNetworkString("REP.Add") -- CLIENT > SERVER
util.AddNetworkString("REP.Rem") -- CLIENT > SERVER
util.AddNetworkString("REP.Get") -- CLIENT > SERVER
--util.AddNetworkString("REP.Mod") -- CLIENT > SERVER -- редактирование отзыва. В себе ид отзыва, таблица keyvalues с новыми данными

util.AddNetworkString("REP.Callback") -- SERVER > CLIENT


local n = function(targ,msg,type,time)
	qq.notify(targ,type or 0,time or 4,msg)
end



function REP.Callback(ply,dat)
	net.Start("REP.Callback")
		net.WriteTable(dat)
	net.Send(ply)
end



-- Не просто Add, потому что функция занята под net вары
function REP.AddAction(sFrom,pTo,iCategory,message,onfinish)
	local from_sid,for_sid = sFrom,pTo:SteamID()

	REP.addRecord(from_sid,for_sid,iCategory,message,function(_,lastid)
		REP.Add(pTo,iCategory)
		REP.AddToFull(pTo,iCategory,{
			id      = lastid,
			from    = from_sid,
			message = message ~= "" and message,
		})

		REP.IDMAP[lastid] = {
			from     = from_sid,
			to       = for_sid,
			category = iCategory
		}

		-- Отмечаем, что человек уже оставил сообщение этой категории
		REP.SIDMAP[from_sid] = REP.SIDMAP[from_sid] or {}
		REP.SIDMAP[from_sid][for_sid] = REP.SIDMAP[from_sid][for_sid] or {}
		REP.SIDMAP[from_sid][for_sid][iCategory] = REP.SIDMAP[from_sid][for_sid][iCategory] or true -- {}
		--REP.SIDMAP[from_sid][for_sid][iCategory][lastid] = true

		-- Переопределяем топ репку
		REP.setTop(pTo, REP.calcTop(pTo) )

		-- Пересчитываем вес репы
		REP.addWeight(pTo, REP.getCatWeightByID(iCategory) )

		if onfinish then onfinish() end
		hook.Call("OnRepAdd",REP, from_sid,for_sid,iCategory,message,lastid)
	end)
end

-- author IS steamid
-- id ДОЛЖЕН БЫТЬ ЧИСЛО
function REP.RemAction(id,author,force,onfinish)
	REP.delRecord(id,!force and author,function(_,_,affected)
		if affected > 0 then
			local owner_sid = REP.getOwner(id) -- не заходил на сервер, если нет

			local target = player.GetBySteamID(owner_sid or "")
			if owner_sid and target then
				local categ = REP.getCatByID(id)

				REP.Rem(target,categ)
				REP.RemFromFull(target,id)

				-- Переопределяем топ репку
				REP.setTop(target, REP.calcTop(target) )

				-- Пересчитываем вес репы
				REP.addWeight(target, -REP.getCatWeightByID(categ) )
			end

			REP.IDMAP[id] = nil -- удаляем ид из карты
			REP.SIDMAP[author] = nil
		end

		if onfinish then onfinish(affected > 0) end
		hook.Call("OnRepRem",REP, id,author,force)
	end)
end







local function isSpamer(ply)
	if ply.lastrepaction and CurTime() - ply.lastrepaction < REP.CFG.DELAY(ply) then
		return true
	end

	ply.lastrepaction = CurTime()

	return false
end

net("REP.Add",function(_,ply)
	if isSpamer(ply) then n(ply,"Не спешите",1) return end

	local from_ply = net.ReadPlayer()
	local for_ply  = net.ReadPlayer()
	local category = net.ReadUInt(7)
	local message  = net.ReadString()

	if !IsValid(from_ply) or !IsValid(for_ply) then
		return n(ply,!IsValid(for_ply) and "Целевой игрок вышел" or "Отправитель вышел",1)
	end

	if from_ply == for_ply then
		return n(ply,"Самому себе? facepalm",1)
	end

	local cm = REP.CFG.canModerate(ply)
	local from_sid,for_sid = from_ply:SteamID(),for_ply:SteamID()

	-- Чел не модер и пытается два отзыва одной категории челу дать
	if REP.SIDMAP[from_sid] and REP.SIDMAP[from_sid][for_sid] and REP.SIDMAP[from_sid][for_sid][category] and !cm then
		return n(ply,"Вы уже оставляли для него такой отзыв",1)
	end

	-- Чел указал автора отзыва, хотя не имел на это права
	if from_ply ~= ply and !cm then
		return n(ply,"Байпасим? Ммм",1)
	end

	local can,err = hook.Run("PlayerCanChangeReputation",ply,for_ply)
	if can == false then
		n(ply,err or "Вы не можете сделать это")
		return
	end

	REP.AddAction(from_sid,for_ply,category,message,function()
		n(ply,"Репутация изменена")
		n(for_ply,from_ply:Name() .. " изменил вам репутацию. /rep")
	end)
end)

net("REP.Rem",function(_,ply)
	if isSpamer(ply) then n(ply,"Не спешите",1) return end

	-- Если чел модер, то удаление форсится, несмотря на то, что не принадлежит человеку
	-- если нет, тогда в "DELETE WHERE from =" указывается sid автора
	local ismod = REP.CFG.canModerate(ply)
	local repid = net.ReadUInt(16)

	-- !ok если, например, чел дважды кнопку удаления нажал (или чужое сообщение пытался удалить)
	REP.RemAction(repid,ply:SteamID(),ismod,function(ok)
		n(ply,ok and "Запись успешно удалена" or "Произошла ошибка удаления",!ok and 1)
	end)
end)

net("REP.Get",function(_,ply)
	if isSpamer(ply) then n(ply,"Не спешите",1) return end

	local for_ply = net.ReadPlayer()
	local id = "REP.Get." .. for_ply:SteamID()

	local rep = REP.GetFull(for_ply)

	REP.Callback(ply,{
		[id]    = true, -- подпись каллбэка
		["REP"] = rep
	})
end)