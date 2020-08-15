-- [categ] = count
local function getRepOnly(dat)
	local tab = {}

	for _,v in ipairs(dat) do
		tab[v.value] = tab[v.value] or 0
		tab[v.value] = tab[v.value] + 1
	end

	return tab
end

-- [categ] = {id = "",date....}
local function getFullData(dat)
	local tab = {}

	for _,v in ipairs(dat) do
		tab[v.value] = tab[v.value] or {}
		table.insert(tab[v.value],{
			id      = v.id,
			from    = v.by,
			message = v.message ~= "" and v.message,
			date    = v.date
		})
	end

	return tab
end

local function fillMaps(dat)
	for _,v in ipairs(dat) do
		REP.IDMAP[v.id] = REP.IDMAP[v.id] or {
			from     = v.by,
			to       = v["for"],
			category = v.value
		}

		REP.SIDMAP[v.by] = REP.SIDMAP[v.by] or {}
		REP.SIDMAP[v.by][ v["for"] ] = REP.SIDMAP[v.by][ v["for"] ] or {}
		REP.SIDMAP[v.by][ v["for"] ][v.value] = REP.SIDMAP[v.by][ v["for"] ][v.value] or true --{}
		--REP.SIDMAP[v.by][ v["for"] ][v.value][v.id] = true -- убрал, т.к. ид в IDMAP
		-- /\ говорим, что для человека репу такой категории мы уже оставляли. Антидубликат
	end
end


-- Установка данных с отзывами игроку
hook("PlayerInitialSpawn","REP.GetPlyDat",function(ply)
	timer.Simple(30,function() -- разгружаем .net
		if !IsValid(ply) then return end

		REP.getData(nil,ply:SteamID(),function(dat)

			REP.Set(ply,getRepOnly(dat))
			REP.SetFull(ply,getFullData(dat))
			REP.setTop(ply,REP.calcTop(ply))
			REP.setWeight(ply,REP.calcWeight(ply))

			fillMaps(dat)
		end)
	end)
end)
