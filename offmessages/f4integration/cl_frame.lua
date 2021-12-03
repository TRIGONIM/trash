hook.Add("InitPostEntity","OM.NewMessages",function()
	local opened

	OM.GetMessages(function(messages)
		if #messages == 0 then return end

		F4M.AddNotify("У вас " .. #messages .. " новых сообщений!", 10, function()
			opened = true

			F4M.ActivateTab("Оповещения")
		end,function()
			return !opened -- показать, если не открывалось
		end)
	end)
end)

local function buildFrame(area)
	local pan = ui.Create("Panel",area)
	pan:Dock(FILL)
	pan:DockPadding(20,20,20,20)

	function pan:ShowNoMessages()
		-- Централизирующая панелька
		ui.Create("Panel",self,function(centpan)
			centpan:SetTall(100)
			centpan:Dock(TOP)

			ui.Create("DLabel",centpan,function(nomsg)
				nomsg:Dock(FILL)
				nomsg:SetText("У вас нет сообщений")
				nomsg:SetFont("f4_42_bold")
				nomsg:SetTextColor(Color(83,88,100))
				nomsg:SetContentAlignment(5)
			end)

			ui.Create("DButton",centpan,function(stripe)
				stripe:Dock(BOTTOM)
				stripe:DockMargin(150,0,150,0)
				stripe:SetTall(10)
				stripe:SetText("")
				--stripe:SetFont("f4_sidebar")
				stripe:SetTextColor(Color(255,255,255))
				stripe.Paint = F4M.sk.ButtonBlue
			end)
		end)

		-- Для скролла на малых разрешениях
		ui.Create("DScrollPanel",self,function(scr)
			scr:Dock(FILL)
			scr:DockMargin(150,30,150,0)
			scr.Paint = function(s,w,h) end
			scr.VBar.Paint         = F4M.sk.VBar
			scr.VBar.btnUp.Paint   = F4M.sk.VBarUp
			scr.VBar.btnDown.Paint = F4M.sk.VBarDown
			scr.VBar.btnGrip.Paint = F4M.sk.VBarGrip

			ui.Create("DLabel",scr,function(details)
				details:Dock(FILL)
				details:SetText(
					[[
					Эта разработка служит для отображения различного рода оффлайн уведомлений.

					Это могут быть как обычные сообщения о транзакциях и оповещения о прошедших банах, так и важные уведомления от администрации проекта

					Если вы не видите здесь сообщений, значит вы все удалили или же просто не получали.
					]])
				details:SetFont("f4_sidebar")
				details:SetTextColor(Color(83,88,100))
				details:SetWrap(true)
				details:SetAutoStretchVertical(true)
			end)
		end)
	end

	function pan:BuildMessagesPanel(msgs)
		-- Активити
		local activity = ui.Create("DMessagesLayout",self)
		activity:Dock(FILL)

		for _,message in ipairs(msgs) do
			local MSG = OM.Message(message[1],message[2],message[3])
			MSG:SetCategory(message[3] and "Прочитанные" or "Новые")

			activity:AddMessage(MSG)
		end
	end


	OM.GetMessages(function(messages)
		if !IsValid(pan) then return end

		if #messages == 0 then
			pan:ShowNoMessages()
		else
			pan:BuildMessagesPanel(messages)
		end
	end,true)

	return pan
end

hook.Add("F4M.CollectSidebarButtons", "om", function(add)
	add("Оповещения", "materials/icons/fa32/inbox.png", buildFrame, 50)
end)
