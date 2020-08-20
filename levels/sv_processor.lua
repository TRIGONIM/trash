local callbacks = {}
function LVL.WaitForPlayer(pl, cback) -- SV
	if pl:LVL() then
		cback(pl)
	else
		if !callbacks[pl] then
			callbacks[pl] = {}
		end

		callbacks[pl][#callbacks[pl] + 1] = cback
	end
end

hook("PlayerInitialSpawn","LVL_SetupPlayerData",function(pl)
	-- получение опыта игрока, запуск таймеров насчитывания опыта
	LVL.getOfflineData(function(dat)
		if !IsValid(pl) then return end -- вышел пока запрос обрабатывался

		dat     = dat     or {}
		dat.exp = dat.exp or 0

		-- Если чел впервые на сервере, то dat.exp будет 0
		local lvl,exptolvlup = LVL.expToLevel(dat.exp)

		dat.lvl        = lvl
		dat.exptolvlup = exptolvlup


		LVL.setLvl(pl,dat.lvl)
		LVL.setExp(pl,dat.exp)
		LVL.setExpToNewLvl(pl,dat.exptolvlup)

		if callbacks[pl] then
			for _,v in ipairs(callbacks[pl]) do
				v(pl)
			end
		end
		callbacks[pl] = nil

		-- hook.Call("LVL.PlayerDataLoaded",nil,pl,dat)
	end,IsValid(pl) and pl:SteamID())
end)




local function checkLevel(pl, tbl)
	local allow,err = LVL.CheckPermission(pl, tbl.level)
	if !allow then
		return false,true,err
	end
end

hook("canBuyPistol",       "LVL:PistolBuy",   checkLevel)
hook("canBuyAmmo",         "LVL:AmmoBuy",     checkLevel)
hook("canBuyShipment",     "LVL:ShipmentBuy", checkLevel)
hook("canBuyVehicle",      "LVL:VehiclesBuy", checkLevel)
hook("canBuyCustomEntity", "LVL:CEntityBuy",  checkLevel)

hook("playerCanChangeTeam","LVL:AllowTeamChange",function(pl,jobno)
	local canchange,_,err = checkLevel(pl,RPExtraTeams[jobno])
	if canchange == false then
		return false,err
	end
end)

-- Наигранное время
timer.Create("LVL.PlayForExp",LVL.time_between_exp_increments,0,function()
	for _,pl in ipairs(player.GetAll()) do
		if pl:LVL() then
			LVL.addClampedXP(pl, LVL.exp_for_playtime)
		end
	end
end)

timer.Create("LVL.UpgradeReminder",60 * 60,0,function()
	for _,pl in ipairs(player.GetAll()) do
		if
			!pl:GetVar("lvl_hint_triggered")
			and pl:LVL() and LVL.whetherUpgradeNeeded(pl)
			and pl:canAfford( LVL.getUpgradePrice(pl:LVL() + 1) )
		then
			notif(pl, "Вы можете улучшить уровень в [F4]", NBLUE)
			pl:SetVar("lvl_hint_triggered", true)
		end
	end
end)
