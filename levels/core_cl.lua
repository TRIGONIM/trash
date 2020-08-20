local barBgW,barBgH = 320,10
local startX,startY = 20 -- данные получатся при первом вызове функции


local animState
local animSpeed = 0.009
local function drawRaisingExperience(raised)
	animState = 0 -- сброс

	_,startY = chat.GetChatBoxPos()
	startY = startY - 30

	local curExp = LVL.getExp(LocalPlayer()) or 0 -- 0 if new player. Err: https://img.qweqwe.ovh/1538168419062.png
	local curLvl,expToLvlUp,expCharge = LVL.expToLevel(curExp)

	local curLvlExp = LVL.getLvlMult(curLvl) * LVL.baseexp -- нужно набрать всего опыта на текущем уровне

	local ratio = barBgW / curLvlExp
	local startS  = expCharge * ratio - 4 -- начальная позиция ползунка
	local predict = (expCharge + math.Clamp(raised,0,expToLvlUp)) * ratio - 4 -- конечная позиция ползунка

	hook.Add("HUDPaint","LVL.DrawRaisingExperience",function()
		surface.SetFont("Trebuchet24")
		surface.SetTextColor(255,255,255)
		surface.SetTextPos(startX,startY)
		surface.DrawText(curLvl)

		local barBgX = startX + surface.GetTextSize(curLvl) + 10
		local barBgY = startY + 12 - 5

		local filled  = math.Clamp(predict * animState,startS,predict) -- заполненность ползунка

		-- Main background
		surface.SetDrawColor(0,0,0)
		surface.DrawRect(barBgX,barBgY,barBgW,barBgH)

		-- Predicting filled stripe
		surface.SetDrawColor(255,255,255,50)
		surface.DrawRect(barBgX + 2,barBgY + 2,predict,barBgH - 4)

		-- Filled stripe
		surface.SetDrawColor(255,255,255)
		surface.DrawRect(barBgX + 2,barBgY + 2,filled,barBgH - 4)

		surface.SetFont("Trebuchet24")
		surface.SetTextColor(255,255,255)
		surface.SetTextPos(startX + 10 + barBgW + 10 + 20,startY)
		surface.DrawText(curLvl + 1)
	end)

	hook.Add("Tick","LVL_SetAnimSpeed",function()
		animState = math.Clamp(animState + animSpeed,0,1)
	end)

	timer.Create("LvlRemoveHooks",10,1,function()
		hook.Remove("HUDPaint","LVL.DrawRaisingExperience")
		hook.Remove("Tick","LVL_SetAnimSpeed")
	end)
end

net.Receive("LVL.GainedExp",function()
	drawRaisingExperience(net.ReadUInt(LVL.BITS.GAINED_EXP))
end)

-- drawRaisingExperience( 100 )




-- Запрос повышения уровня
function LVL.purchaseUpgrade()
	net.Ping("LVL.RequestUpgrade")
end

net.Receive("LVL.Upgraded",function()
	hook.Run("LVL.Upgraded",LocalPlayer(),net.ReadLVL())
end)
