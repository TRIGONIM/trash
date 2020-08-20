LVL.BONUSES = --[[ LVL.BONUSES or--]] {}

function LVL.RegisterBonus(lvl,name,func)
	LVL.BONUSES[lvl] = LVL.BONUSES[lvl] or {}
	table.insert(LVL.BONUSES[lvl],{name,func})
end

function LVL.GetBonuses(lvl)
	return LVL.BONUSES[lvl]
end

-- hook.Run("LVL.Upgraded",LocalPlayer(),10)
hook.Add("LVL.Upgraded","Bonuses",function(pl,lvl)
	local tb = LVL.GetBonuses(lvl)
	if !tb then return end

	local txt = ""
	for i,v in ipairs(tb) do
		local name,func = v[1],v[2]
		if CLIENT then
			local line = i .. ": " .. name
			CPrint(line)
			txt = txt .. line .. "\n"
		elseif func then
			func(pl)
		end
	end

	if CLIENT then
		ui.Banner(
			(#tb == 1 and "Открыт бонус" or "Открыто " .. #tb .. " бонуса") .. " за " .. lvl .. " LVL!",
			string.sub(txt,1,-2)
		)
	end
end)

local function catchBonuses()
	hook.Run("LVL.LoadBonuses",LVL.RegisterBonus)
end
hook.Add("Initialize","LVL.CatchBonuses",catchBonuses)
-- catchBonuses()

--[[-------------------------------------------------------------------------
	Эх блэд
---------------------------------------------------------------------------]]

-- Бонусные AR
LVL.RegisterBonus(10,"10 AR при респавне")
LVL.RegisterBonus(20,"20 AR при респавне")
LVL.RegisterBonus(30,"30 AR при респавне")

if SERVER then
hook.Add("PlayerLoadout","LVL.ExtraArmor",function(pl)
	timer.Simple(.1,function() -- пусть сработают остальные хуки
		local lvl = pl:LVL()
		if !lvl or lvl < 10 then return end

		local mult = math.floor(lvl / 10) -- 1-3 (30 lvl)

		local ar = mult * 10
		-- Причина коммента: https://trello.com/c/Sl97oelU/872-стак-брони-при-побеге
		-- Причина раскоммента: https://trello.com/c/ctC2HIcA/942-lvl-броня-перекрывает-тимовскую
		-- Из двух зол меньшее
		pl:AddArmor(ar,150) -- не выдаем, если у профы и так 150+ хп
		-- pl:SetArmor(ar)
		pl:CPrint("+" .. ar .. " AR за " .. lvl .. " уровень")
	end)
end)
end


--[[-------------------------------------------------------------------------
	Бонусы за ЛВЛ, которые я не придумал, куда пристроить
---------------------------------------------------------------------------]]
-- hook.Add("LVL.LoadBonuses","StaffConf",function(ADD)
-- 	ADD(11,"Экскурсия в конфу персонала",function(pl)
-- 		if CLIENT then return end

-- 		VKB.NotifyPlayer(pl,
-- 			"Напишите сюда (https://qweqwe.ovh/jfcZH) для добавления в конференцию персонала"
-- 		)
-- 	end)
-- end)

local function getBoostMultiplier(i)
	if i < 3 then return end
	local lvl = math.Remap(i,1,LVL.max_lvl,1,30)

	local perc = math.floor(lvl / 3) -- 1-10
	return 1 + perc / 100,perc -- 1-1.1
end

local function getPlayerBoostMult(pl)
	-- return pl:LVL() and getBoostMultiplier( pl:LVL() ) or 1 -- не загрузился
	return getBoostMultiplier( pl:LVL() ) -- хз насколько реальна ситуация сверху
end

hook.Add("keypadCrackTimeMult","LVLBoost",getPlayerBoostMult)
hook.Add("lockpickTimeMult","LVLBoost",getPlayerBoostMult)

hook.Add("HATS.SetLVL", "LVL.RegisterBonus", function(HAT, lvl)
	LVL.RegisterBonus(lvl,"Доступ к покупке шапки: " .. HAT:Name())
end)

hook.Add("loadCustomDarkRPItems","LVL.JobsBonuses",function()
	for _,job in ipairs(RPExtraTeams) do
		if job.lvl then
			LVL.RegisterBonus(job.lvl, "Доступ к работе: " .. job.name)
		end
	end
end)

hook.Add("LVL.LoadBonuses","KeypadBoost",function(ADD)
	for i = 1,30 do -- LVL.max_lvl
		if i % 3 == 0 then
			local _,perc = getBoostMultiplier(i)
			ADD(i,perc .. "% ускорения при взломе замков и кейпадов")
		end
	end
end)
