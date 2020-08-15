/*-------------------------------------------------------------------------
	ДВЕ ОЧЕНЬ МАССИВНЫЕ ТАБЛИЦЫ, КОТОРЫЕ СТОИТ УРЕЗАТЬ TODO TODO
---------------------------------------------------------------------------*/
-- Карта ID и данных сообщения (Для функций удаления)
REP.IDMAP  = REP.IDMAP  or {}
REP.SIDMAP = REP.SIDMAP or {}
-- Автор > получатели > категории > id сообщений = true. Для предотвращения повторной отправки


-- Возвращает название категории по ее ID
-- ошибка может возникнуть, если категории не установятся при инициализации
function REP.getCatNameByID(id)
	return (REP.CFG.CATEGORIES[id] or {})["name"] or "Удаленная категория"
end

-- Вес категории по ИД
function REP.getCatWeightByID(id)
	-- Может не быть, если категория удалена
	return (REP.CFG.CATEGORIES[id] or {})["weight"] or 0
end

-- Возвращает ид категории по ид записи
function REP.getCatByID(repid)
	return REP.IDMAP[repid]["category"]
end

-- Возвращает sid отправителя сообщения
-- function REP.getSender(repid)
-- 	return REP.IDMAP[repid]["from"]
-- end

-- Возвращает steamid владельца репутации
-- очень говняный метод. Надо перепридумать
function REP.getOwner(repid)
	print("REP.getOwner(repid)",repid)
	PrintTable(REP.IDMAP[repid] and REP.IDMAP[repid] or {kek = true})
	return REP.IDMAP[repid] and REP.IDMAP[repid]["to"]
end


/*
Полный вариант. Используется, если человек хочет знать подробности
{
	[категория1] = {
		{
			id      = 228,
			from    = "STEAM",
			message = "Доп. инфа от автора",
			date    = "2016-08-01 00:00:00",
		},
	},
}
*/
function REP.SetFull(ply,dat)
	ply:SetNetVar("REP_FULL",dat)
end

function REP.GetFull(ply)
	return ply:GetNetVar("REP_FULL") or {}
end

function REP.AddToFull(ply,categ,dat)
	dat.date = dat.date or getDatetime()

	local full = REP.GetFull(ply)
	full[categ] = full[categ] or {}
	table.insert(full[categ],dat)

	REP.SetFull(ply,full)
end

function REP.RemFromFull(ply,repid)
	local full = REP.GetFull(ply)

	local cat = REP.getCatByID(repid)
	for i,v in pairs(full[cat]) do
		if v.id == repid then
			full[cat][i] = nil
		end
	end

	REP.SetFull(ply,full)
end


/*
Урезанный вариант для экономии net трафика. Используется глобально
[categ] = count
*/
function REP.Set(ply,dat)
	ply:SetNetVar("REP",dat)
end

function REP.Get(ply)
	return ply:GetNetVar("REP") or {}
end

function REP.Add(ply,categ)
	local rep = REP.Get(ply)
	rep[categ] = rep[categ] or 0
	rep[categ] = rep[categ] + 1

	REP.Set(ply,rep)
end

function REP.Rem(ply,categ)
	local rep = REP.Get(ply)
	rep[categ] = rep[categ] - 1

	REP.Set(ply,rep)
end



/*
Изменение доминирующей категории репутации
*/
function REP.getTop(ply)
	return ply:GetNetVar("REP_TOP")
end

function REP.setTop(ply,categ)
	return ply:SetNetVar("REP_TOP",categ)
end

function REP.calcTop(ply)
	local lasttopval,lasttopcat = 0,0
	for cat,val in pairs(REP.Get(ply)) do
		if val > lasttopval then
			lasttopval = val
			lasttopcat = cat
		end
	end

	if lasttopcat ~= 0 then
		return lasttopcat,lasttopval
	end
end



/*
Вес репутации. Что-то вроде кармы
*/
function REP.getWeight(ply)
	return ply:GetNetVar("REP_WEIGHT") or 0
end

function REP.setWeight(ply,total)
	ply:SetNetVar("REP_WEIGHT",total)
end

function REP.addWeight(ply,amount)
	REP.setWeight(ply, REP.getWeight(ply) + amount )
end

function REP.calcWeight(ply)
	local res = 0

	for categ,records in pairs( REP.GetFull(ply) ) do
		res = res + REP.getCatWeightByID(categ) * #records
	end

	return res
end

function REP.getWeightColor(ply)
	local w = REP.getWeight(ply)

	return Color(
		w > 0 and 0 or 255, -- R
		w < 0 and 0 or 255, -- G
		0, -- B
		math.abs(w) / REP.CFG.DIFFICULT * 255 -- A
	)
end