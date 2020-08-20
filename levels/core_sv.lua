util.AddNetworkString("LVL.NeedUpgrade") -- SERVER > CLIENT | При выдаче опыта, когда нужно апгрейдиться
util.AddNetworkString("LVL.GainedExp")   -- SERVER > CLIENT | При выдаче опыта
util.AddNetworkString("LVL.Upgraded")    -- SERVER > CLIENT | При левел апе

util.AddNetworkString("LVL.RequestUpgrade") -- CLIENT > SERVER | Запрос повышения уровня

-- Используется при апгрейде на новый уровень, когда человек уже забашлял
function LVL.setLvl(ply,lvl)
	ply:SetNetVar("LVL", math.min(lvl,LVL.max_lvl))
end

function LVL.setExp(ply,exp)
	ply:SetNetVar("EXP",exp)
end

function LVL.setExpToNewLvl(ply,exp)
	ply:SetNetVar("TO_UPGRADE",exp)
end

-- Изменяет кол-во опыта игрока. Нет смысла делать это для SID
-- Дает опыт игроку, не смотря на лимиты уровня. При помощи этой функции можно вытолкнуть игрока на новый лвл
function LVL.addXP(ply,amount,onsuccess,notify)
	local total = LVL.getExp(ply) + amount

	LVL.storeXP(ply:SteamID(),total,function()
		local lvl,exptoupgrade = LVL.expToLevel(total)

		if notify then
			net.Start("LVL.GainedExp")
				net.WriteUInt(amount,LVL.BITS.GAINED_EXP)
			net.Send(ply)
		end

		LVL.setExp(ply,total)
		LVL.setLvl(ply,lvl)
		LVL.setExpToNewLvl(ply,exptoupgrade)

		if onsuccess then
			onsuccess()
		end
	end)
end
--LVL.addXP(player.GetBySteamID("STEAM_0:1:55598730"),-5650)

-- Не дает вылезти на рамку следующего уровня
-- Используется для обычного пополнения опыта игрока
local MAX_EXP
function LVL.addClampedXP(ply,amount)
	if LVL.whetherUpgradeNeeded(ply) then
		net.Ping("LVL.NeedUpgrade",ply)

		return false
	end

	if !MAX_EXP then
		MAX_EXP = LVL.lvlToExp(LVL.max_lvl)
	end

	local need   = LVL.getExpToNewLvl(ply)
	local togive = math.min(need - 1,amount,MAX_EXP)

	LVL.addXP(ply,togive,nil,true)

	return togive
end

-- Функция покупки 1 экспа, который нужен для перепрыгивания на новый лвл
function LVL.purchaseUpgrade(ply,onsuccess)
	if !LVL.whetherUpgradeNeeded(ply) then return "Апгрейд не нужен" end

	local lvl   = ply:LVL()
	local topay = LVL.getUpgradePrice(lvl + 1)

	 -- send money offer
	if !ply:canAfford(topay,true) then return "Недостаточно денег" end

	LVL.addXP(ply,1,function()
		LVL.setLvl(ply,lvl + 1)
		ply:addMoney(-topay,"[LVL] Upgrade")

		if onsuccess then
			onsuccess()
		end

		hook.Run("LVL.Upgraded",ply,lvl + 1)
		net.Start("LVL.Upgraded")
			net.WriteLVL(lvl + 1)
		net.Send(ply)
	end)
end

net.Receive("LVL.RequestUpgrade",function(_,ply)
	local err = LVL.purchaseUpgrade(ply,function()
		local newlvl    = tostring(ply:LVL())

		local white     = Color(255,255,255)
		local yellow    = Color(255,255,0)
		local teamcolor = ply:GetJobColor()

		ULib.tsayColor(nil,false,teamcolor,ply:Name(), white," перешел на ", yellow,newlvl, white," уровень!")
		DarkRP.notify(ply,3,10,"Поздравляем с получением " .. newlvl .. " уровня!")
	end)

	if err then
		DarkRP.notify(ply,1,3,err)
	end
end)
