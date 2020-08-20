-- сек
LVL.time_between_exp_increments = 600
LVL.exp_for_playtime = 20

-- Кол-во опыта, от которого отталкиваемся для подсчета увеличения лвл (чувствительность)
LVL.baseexp = 100

-- Кол-во уровней, после которых сложность повышения будет увеличиваться
LVL.checkpoint_in_lvls = 1

-- Потолок
LVL.max_lvl = 30




-- https://img.qweqwe.ovh/1510487291846.png
local function formatRequestedSum(sum,base)
	-- if sum < base then return nil end
	sum = math.floor(sum)
	sum = sum - sum % base
	return sum
end

local function levelRaiseTotalPrice(lvl)
	return acceleration(lvl / LVL.max_lvl, 0,200 * 1000000)
end

-- Стоимость перехода на lvl уровень
LVL.getUpgradePrice = function(lvl)
	local prev = levelRaiseTotalPrice(lvl - 1)
	local curr = levelRaiseTotalPrice(lvl)

	local ugly = math.Round(curr - prev)
	return formatRequestedSum(ugly,10000)
end
