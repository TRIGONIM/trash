REP = REP or {
	CFG = {}
}


REP.CFG.canModerate = function(ply)
	ply = CLIENT and LocalPlayer() or ply
	return ply:isAdmin()
end

-- Задержка между оставлением отзывов
-- для тех, кто может модерировать ее нет
REP.CFG.DELAY = function(ply)
	return REP.CFG.canModerate(ply) and 0 or 60
end


REP.CFG.CATEGORIES = {
	[1] = {
		["name"]   = "Помощник",
		["weight"] = 4,
	},
	[2] = {
		["name"]   = "Общительный",
		["weight"] = 1,
	},
	[3] = {
		["name"]   = "Профи РП",
		["weight"] = 2,
	},
	[4] = {
		["name"]   = "Попрошайка отзывов",
		["weight"] = -3,
	},
	[5] = {
		["name"]   = "Кретин",
		["weight"] = -2,
	},
	[6] = {
		["name"]   = "Нарушитель",
		["weight"] = -3,
	},
	[7] = {
		["name"]   = "Nice man",
		["weight"] = 1,
	},
}

-- Минимальное кол-во символов комментария при оставлении репутации
REP.CFG.MINMESSAGELEN = 10



-- Чем больше число - тем больше нужно репутации для заливки цвета репутации
-- т.е. если указать 5, тогда если у чела будет -5 репутации, то ее цвет будет непрозрачным красным
-- если у чела будет 1, то цвет его репутации будет сильно прозрачным зеленым
REP.CFG.DIFFICULT = 50


-- Команды, что ниже вводятся с / в начале

-- Команда открытия менюшки просмотра своей репы
cmd("rep")
:AddParam(cmd.PLAYER_ENTITY,cmd.OPT_OPTIONAL)
:RunOnClient(function(targ)
	REP.VGUI_ShowInfo(targ or LocalPlayer())
end)

-- Открытие меню управления репкой
cmd("repmod")
:RunOnClient(function(targ)
	REP.VGUI_Moderate()
end)



local NEED_LVL = 1
hook.Add("LVL.LoadBonuses","REP",function(ADD)
	ADD(NEED_LVL,"Возможность оставлять репутации другим")
end)

if SERVER then
	hook.Add("PlayerCanChangeReputation","LVL",function(pl)
		if !pl:HasLVL(NEED_LVL,true) then
			return false
		end
	end)
end