-- Скрипт в едином лице написан _AMD_ и принадлежит кодерам TRIGON.IM
-- Коммерческая реализация скрипта запрещена свободной лицензией Apache 2.0
-- Вы можете использовать скрипт на своих проектах бесплатно.
-- Платная поддержка скрипта через стим: http://steamcommunity.com/id/AMD-NICK/
-- Если хотите отблагодарить, то можете просто сказать спасибо на почту mail@qweqwe.ovh

SWep = {} -- Single Weapon Script: Main Table

SWep.CFG = {} -- settings table
local c = SWep.CFG
c.WGroups = {}

-- Config Below
------------------------------------------------------------------------------------------------------------------------------------------------

c.ENABLED = true -- Is the single weapon script enabled?

c.ErrT = "%s не может носить оружие" -- team restriction error message %s = e.g. Mayor
c.ErrL = "%s уже не влезают в вашу кобуру" -- limit error message. %s would be like "Pistols"


-- pistol weapon table
-- you can find classes in the spawn menu by right-mouse click on several weapon
c.WGroups["pistols"] = {
	name = "Пистолеты",
	limit = 2, -- max allowed amount of pistols weapons that normal player can wear

	items = {
		["weapon_pistol"] = true,
		["weapon_357"]    = true,
		["weapon_alyxgun"]  = true, -- нету в спавн меню
		-------------------------
		["fas2_ragingbull"] = true,
		["fas2_ots33"]    = true,
		["fas2_p226"]     = true,
		["fas2_m1911"]    = true,
		["fas2_deagle"]   = true,
		["fas2_glock20"]  = true,
		-------------------------
		["swb_357"]       = true,
		["swb_deagle"]    = true,
		["swb_fiveseven"] = true,
		["swb_glock18"]   = true,
		["swb_p228"]      = true,
		["swb_usp"]       = true,
	},

	--lmessage = "Здесь вы можете ввести кастомное сообщение, которое будет выводиться при достижении лимита",
}

c.WGroups["submachines"] = {
	name = "Автоматы",
	limit = 1,

	items = {
		["weapon_ar2"]    = true,
		-------------------------
		["fas2_ak12"]     = true,
		["fas2_ak47"]     = true,
		["fas2_ak74"]     = true,
		["fas2_an94"]     = true,
		["fas2_famas"]    = true,
		["fas2_g36c"]     = true,
		["fas2_g3"]       = true,
		["fas2_galil"]    = true,
		["fas2_m4a1"]     = true,
		["fas2_pp19"]     = true,
		["fas2_rpk"]      = true,
		["fas2_sg550"]    = true,
		["fas2_sg552"]    = true,
		-------------------------
		["swb_ak47"]      = true,
		["swb_famas"]     = true,
		["swb_p90"]       = true,
		["swb_galil"]     = true,
		["swb_m4a1"]      = true,
		["swb_sg552"]     = true,
		["swb_aug"]       = true,
		["swb_m249"]      = true,
	}
}

c.WGroups["semiauto"] = {
	name = "Полуавтоматы",
	limit = 1,

	items = {
		["weapon_smg1"]   = true,
		-------------------------
		["fas2_uzi"]      = true,
		["fas2_mac11"]    = true,
		["fas2_mp5a5"]    = true,
		["fas2_mp5k"]     = true,
		["fas2_mp5sd6"]   = true,
		-------------------------
		["swb_mp5"]       = true,
		["swb_ump"]       = true,
		["swb_mac10"]     = true,
		["swb_tmp"]       = true,
	}
}

c.WGroups["shotguns"] = {
	name = "Дробовики",
	limit = 1,

	items = {
		["weapon_shotgun"] = true,
		-------------------------
		["fas2_ks23"]     = true,
		["fas2_m3s90"]    = true,
		["fas2_rem870"]   = true,
		["fas2_toz34"]    = true,
		-------------------------
		["swb_xm1014"]    = true,
		["swb_m3super90"] = true,
	}
}

c.WGroups["rifles"] = {
	name = "Винтовки",
	limit = 1,

	items = {
		["weapon_crossbow"] = true,
		-------------------------
		["fas2_m14"]      = true,
		["fas2_m21"]      = true,
		["fas2_m24"]      = true,
		["fas2_m82"]      = true,
		["fas2_rk95"]     = true,
		["fas2_sks"]      = true,
		["fas2_sr25"]     = true,
		-------------------------
		["swb_awp"]       = true,
		["swb_g3sg1"]     = true,
		["swb_sg550"]     = true,
		["swb_scout"]     = true,
	}
}

c.WGroups["extra"] = {
	name = "Доп. оружие",
	limit = 3,

	items = {
		["weapon_frag"]   = true,
		["weapon_rpg"]    = true,
		["weapon_slam"]   = true,
		-------------------------
		["fas2_m67"]      = true, -- Руч. граната
		["fas2_ammobox"]  = true, -- ловушка
		["fas2_dv2"]      = true, -- меч
		["fas2_ifak"]     = true, -- медкит
		["fas2_m79"]      = true, -- гранатомет
		["fas2_machete"]  = true, -- мачете
		-------------------------
	}
}

c.IgnoreWhenLicense = true



-- Do Not Tounch Any Staff Below The Line
------------------------------------------------------------------------------------------------------------------------------------------------
if !c.ENABLED then return end

-- Присваеваем пушкам в главной таблице их классы типа pistols или rifles
timer.Simple(.5,function()
	for g,t in pairs(c.WGroups) do
		for class,_ in pairs(t.items) do
			local wTable = weapons.GetStored(class)
			if wTable then wTable.SW_class = g end
		end
	end
end)

-- Возвращает группированые оружия, а в ячейке count их кол-во
-- т.е. пушек, которым присвоена определенная группа, типа shotgun
-- {
--     ['shotguns']    = 1,
--     ['count_']      = 20,
--     ['semiauto']    = 3,
--     ['rifles']      = 3,
--     ['pistols']     = 5,
--     ['submachines'] = 8,
-- }
function SWep.getGroupedWeps(pl)
	local weps = {
		count_ = 0
	}
	local pWeps = pl:GetWeapons()

	for i = 1,#pWeps do -- a bit optimized pairs
		if !pWeps[i]          then continue end
		if !pWeps[i].SW_class then continue end -- группы нет

		weps.count_ = weps.count_ + 1
		weps[pWeps[i].SW_class] = weps[pWeps[i].SW_class] or 0
		weps[pWeps[i].SW_class] = weps[pWeps[i].SW_class] + 1
	end

	return weps
end

--[[-------------------------------------------------------------------------
	HOOKS
---------------------------------------------------------------------------]]
function SWep:canPlayerBypassWeaponsLimit(pl,class) return false end
function SWep:canPlayerPickupWeapon(pl,class) return true end



function SWep.canPickWep(pl,class)
	if hook.Call("canPlayerBypassWeaponsLimit",SWep,pl,class) then return end

	local tmpdat = {}
	for wepGroup,t in pairs(c.WGroups) do
		if t.items[class] then
			tmpdat.class = wepGroup
			break
		end
	end

	-- если пушки нету в таблицах, значит эта пушка, скорее всего, типа кейпад чекера, т.е. техническая
	if !tmpdat.class then return end
	-- если выполняется код ниже, значит пушка есть в конфижных таблицах и ее нужно считать

	-- в профе запрещено брать пушки, но чел пытается
	-- мб у него есть лицензия?
	local canPick = hook.Call("canPlayerPickupWeapon",SWep,pl,class)
	if canPick == false and !(c.IgnoreWhenLicense and pl:hasLicense()) then
		qq.notify(pl,1,4,string.format(c.ErrT,team.GetName(pl:Team())))
		return false
	end

	local wepsInThisGroup = SWep.getGroupedWeps(pl)[tmpdat.class]
	if !wepsInThisGroup then -- если класса проверяемой пушки нет в инвентаре
		return -- если пушка первая, то лимит в любом случае пройдет
	end

	wepsInThisGroup = wepsInThisGroup + 1

	if wepsInThisGroup > c.WGroups[tmpdat.class].limit then
		qq.notify( pl, 1, 4, c.WGroups[tmpdat.class].lmessage or string.format(c.ErrL, c.WGroups[tmpdat.class].name) )

		return false
	end
end


hook.Add("PlayerCanPickupWeapon", "SWep.PickCheck", function(pl,wep)
	return SWep.canPickWep(pl,wep:GetClass())
end)
------------------------------------------------------------------------------------------------------------------------------------------------