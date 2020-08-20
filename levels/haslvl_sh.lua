-- PLAYER:HasLVL(lvl,fbAssert)
-- Дополнительные бонусы за ЛВЛ





-- т.е. 5к за 46500 exp.
-- Считаем, скок exp нужно до желанного ЛВЛ и соотносим\
-- (чтобы было больше выгоды, если чел будет много раз покупать)
local MAX_LVL_PRICE = 3000


local MAX_EXP -- чтобы при изменении конфигов LVL скрипта, цена не сильно прыгала
local function getUpgradePrice(pl,targ_lvl)
	if !MAX_EXP then
		MAX_EXP = LVL.lvlToExp(LVL.max_lvl)
	end

	local cur_lvl  = pl:LVL()
	local cur_exp  = LVL.getExp(pl)
	local targ_exp = LVL.lvlToExp(targ_lvl)
	local need_exp = targ_exp - cur_exp

	-- bypasses
	assert(targ_exp <= MAX_EXP,"targ_exp >  MAX_EXP")
	assert(targ_lvl >  cur_lvl,"targ_lvl <= cur_lvl")

	local discount = 1 - math.Remap(need_exp / MAX_EXP,0,1,0,.3) -- максимальная 30%
	local rub = math.Round(MAX_LVL_PRICE * (need_exp / MAX_EXP) * discount)
	local igs = IGS.PriceInCurrency(rub)
	return igs,need_exp
end



local suggestPurchase,purchaseLVL

if SERVER then
	util.AddNetworkString("LVL.Boost")           -- CLIENT > SERVER
	util.AddNetworkString("LVL.BoostSuggestion") -- SERVER > CLIENT

	function purchaseLVL(pl, lvl)
		local cur_lvl = pl:LVL()
		local igs,need_exp = getUpgradePrice(pl,lvl)

		local canAfford = IGS.CanAfford(pl, igs, true)
		if canAfford then
			pl:AddIGSFunds(igs,"Boost LVL: " .. cur_lvl .. " > " .. lvl,function()
				LVL.addXP(pl,need_exp,nil,true)
			end)
		end
	end

	function suggestPurchase(pl,lvl)
		net.Start("LVL.BoostSuggestion")
			net.WriteLVL(lvl)
		net.Send(pl)
	end

	net.Receive("LVL.Boost",function(_,pl)
		purchaseLVL(pl,net.ReadLVL())
	end)
else
	function purchaseLVL(lvl)
		net.Start("LVL.Boost")
			net.WriteLVL(lvl)
		net.SendToServer()
	end

	function suggestPurchase(pl,lvl)
		local igs = getUpgradePrice(pl,lvl)

		local f = ui.BoolRequest(
			"Нужен " .. lvl .. " уровень",
			"Чтобы сделать это, нужен " .. lvl .. " уровень." ..
			"\n\nЭто совсем не сложно, но если вы не хотите ждать, то можете получить его сразу за " .. PL_IGS(math.Round(igs)),
		function(yes)
			if !yes then return end

			purchaseLVL(lvl)
		end)

		 f.btnOK:SetText("Хочу!")
		f.btnCan:SetText("Сам наберу")
	end

	net.Receive("LVL.BoostSuggestion",function()
		local lvl = net.ReadLVL()
		suggestPurchase(LocalPlayer(),lvl)
	end)
end





-- fbAssert может быть true или функцией
-- Если функция, то выполнится в случае нехватки лвл
-- Если true, то предложитт сразу купить необходимое количество опыта для ЛВЛ, минуя все апгрейды за игровую валюту
function PLAYER:HasLVL(lvl, fbAssert)
	if lvl >= 0 and self:LVL() >= lvl then
		return true
	end

	if fbAssert then
		if isfunction(fbAssert) then
			fbAssert()
		else
			suggestPurchase(self,lvl)
		end
	end

	return false
end
