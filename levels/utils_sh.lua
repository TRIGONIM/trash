LVL = LVL or {}

-- Конвертирует опыт в уровень
-- Возвращает уровень, кол-во опыта для след. уровня и "сдачу" от текущего опыта
function LVL.expToLevel(exp)
	local lvl  = 0
	local mult = 1

	local qweqwe = LVL.baseexp * LVL.checkpoint_in_lvls

	-- щас считываем кусками для оптимизации
	while exp >=     qweqwe * mult do -- nil только exp
		exp  = exp - qweqwe * mult
		mult = mult + 1
		lvl  = lvl + LVL.checkpoint_in_lvls
	end

	-- А теперь остатки
	while exp >=    LVL.baseexp * mult do
		exp = exp - LVL.baseexp * mult
		lvl = lvl + 1
	end

	return lvl,LVL.baseexp * mult - exp,exp
end

-- Получает множитель дефолтного значения опыта для указанного лвл
function LVL.getLvlMult(lvl)
	return math.floor(lvl / LVL.checkpoint_in_lvls + 1)
end

-- Конвертирует уровень в экспу
function LVL.lvlToExp(lvl)
	local exp = 0

	local mult = LVL.getLvlMult(lvl)
	for i = 1,mult do
		lvl = lvl - LVL.checkpoint_in_lvls

		local expperlvl = LVL.baseexp * i
		exp = exp + expperlvl * (lvl >= 0 and LVL.checkpoint_in_lvls or lvl + LVL.checkpoint_in_lvls)
	end

	return exp
end

function PLAYER:LVL()
	return self:GetNetVar("LVL")
end

function LVL.getExp(ply)
	return ply:GetNetVar("EXP")
end

function LVL.getExpToNewLvl(ply)
	return ply:GetNetVar("TO_UPGRADE")
end

-- Возвращает true, если необходимо уже башлять для перехода на след. уровень
function LVL.whetherUpgradeNeeded(ply)
	-- нужна единица опыта для перехода на след. лвл
	return ply:LVL() < LVL.max_lvl and LVL.getExpToNewLvl(ply) == 1
end

-- Может ли чел выполнять действия заданного уровня
-- Взятие .lvl проф и итемов (патроны, оружие, энтити)
function LVL.CheckPermission(ply, targetLvl)
	if !targetLvl then return true end

	if !ply:LVL() then
		return "Уровень не загружен"
	end

	return ply:LVL() >= targetLvl,
		"Нужен " .. targetLvl .. " уровень"
end
