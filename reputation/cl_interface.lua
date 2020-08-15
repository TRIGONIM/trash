-- делает панель с отзывами человека для встраивания
local function makeInfoPanel(ply,parent)
	local reps_tabs = ui.Create("ui_tablist",parent,function(rtabs)
		rtabs:Dock(FILL)
		rtabs:DockMargin(5,0,5,5)
	end)

	REP.GetFull(ply,function(rep)
		for catid,dat in pairs(rep) do
			local scroll = ui.Create("ui_scrollpanel",function(scr)
				scr:SetSpacing(2)
				scr:Dock(FILL)
			end)

			for _,v in ipairs(dat) do
				scroll:AddItem(ui.Create("DPanel",function(bg)
					bg:SetTall(150)
					bg:Dock(TOP)

					ui.Create("DLabel",bg,function(date)
						date:Dock(TOP)
						date:DockMargin(5,5,5,0)
						date:SetText("Дата:   " .. v.date)
					end)

					local author = player.GetBySteamID(v.from)
					ui.Create("DLabel",bg,function(from)
						from:Dock(TOP)
						from:DockMargin(5,0,5,0)
						from:SetText("От:   " .. (author and author:Name() or v.from))
					end)

					ui.Create("DScrollPanel",bg,function(msgscr)
						msgscr:Dock(FILL)
						msgscr:DockMargin(5,5,5,0)

						ui.Create("DLabel",msgscr,function(message)
							message:Dock(FILL)
							message:DockMargin(2,2,2,2)
							message:SetText(v.message or "Без сообщения")
							message:SetAutoStretchVertical(true)
							message:SetWrap(true)
						end)
					end)

					ui.Create("ui_panel",bg,function(buttons_bg)
						buttons_bg:Dock(BOTTOM)
						buttons_bg:SetTall(30)
						buttons_bg:DockMargin(5,5,5,5)
						buttons_bg.Paint = function() end

						if LocalPlayer():SteamID() == v.from or REP.CFG.canModerate() then
							ui.Create("DButton",buttons_bg,function(remove)
								remove:Dock(RIGHT)
								remove:SetWide(120)
								remove:SetText("Удалить") --. ID " .. v.id)
								remove.DoClick = function()
									REP.RemAction(v.id)
								end
							end)
						end

						ui.Create("DButton",buttons_bg,function(copy)
							copy:Dock(FILL)
							copy:DockMargin(0,0,5,0)
							copy:SetText("Копировать SID выдавшего")
							copy.DoClick = function()
								SetClipboardText(v.from)
								notification.AddLegacy("SID скопирован: " .. v.from,3,3)
							end
						end)
					end)

				end))
			end

			reps_tabs:AddTab(REP.getCatNameByID(catid) .. " (" .. #dat .. ")",scroll)
		end
	end)
end



-- Открывает окно с вкладками-категориями и подробностями изменения репы
function REP.VGUI_ShowInfo(ply)
	ply = ply or LocalPlayer()

	local m = ui.Create("ui_frame",function(self)
		self:SetSize(700,500)
		self:Center()
		self:SetTitle("Просмотр подробностей репутации " .. ply:Name())
		self:MakePopup()
	end)

	makeInfoPanel(ply,m)
end



-- Модальное окошко для оставления "отзыва" о человеке
function REP.VGUI_MakeReview(for_ply)
	local cm = REP.CFG.canModerate()

	local m = ui.Create("ui_frame",function(self)
		self:SetSize(300,cm and 252 or 194)
		self:Center()
		self:SetTitle("Добавление отзыва")
		self:MakePopup()
	end)


	-- От кого
	local from
	if cm then
		ui.Create("DLabel",m,function(self)
			self:Dock(TOP)
			self:DockMargin(0,7,0,0)
			self:SetText("От кого")
			self:SetFont("ui.30")
		end)

		from = ui.Create("DComboBox",m,function(self)
			self:Dock(TOP)
			self:SetTall(30)
			self:SetValue("Нажмите для выбора")
			for _,ply in pairs(player.GetAll()) do
				self:AddChoice(ply:Name(),ply:SteamID())
			end
			self.OnSelect = function(s,i,val,dat)

			end
		end)
	end


	-- Номинация
	ui.Create("DLabel",m,function(self)
		self:Dock(TOP)
		self:DockMargin(0,7,0,0)
		self:SetText("Номинация")
		self:SetFont("ui.30")
	end)

	local cats = REP.CFG.CATEGORIES
	local nomin = ui.Create("DComboBox",m,function(self)
		self:Dock(TOP)
		self:SetTall(30)
		self:SetValue("Выберите категорию")
		for id,dat in pairs(cats) do
			self:AddChoice(dat.name,id)
		end
		self.OnSelect = function(s,i,val,dat)

		end
	end)


	-- Сообщение
	local deftext = "Репутация без объяснения будет удалена (введите)"
	local text = ui.Create("DTextEntry",m,function(self)
		self:Dock(TOP)
		self:SetTall(50)
		self:DockMargin(0,7,0,0)
		self:SetText(deftext)
		self:SetMultiline(true)
	end)


	-- Добавить
	ui.Create("DButton",m,function(add)
		add:Dock(TOP)
		add:DockMargin(5,5,5,5)
		add:SetTall(40)
		add:SetText("ДОБАВИТЬ")
		add:SetFont("ui.35")
		add.DoClick = function()
			local fromsid,fromply

			if from then -- чел одмен
				local _,b = from:GetSelected()
				fromsid = b

				fromply = fromsid and player.GetBySteamID(fromsid)
			end

			local _,categ = nomin:GetSelected()

			local msg = string.Trim(text:GetValue())
			msg = msg ~= deftext and msg or ""

			local err =
				(string.utf8len(msg) < REP.CFG.MINMESSAGELEN and "Введите сообщение от " .. REP.CFG.MINMESSAGELEN .. " символов") or
				(categ == nil and "Выберите номинацию") or
				(fromply and !IsValid(fromply) and "Игрок 'ОТ' вышел с сервера")

			if err then
				notification.AddLegacy(err,1,4)
				return
			end

			REP.AddAction(for_ply,categ,msg,fromply)
		end
	end)
end







function REP.VGUI_Moderate()
	if !REP.CFG.canModerate() then return end

	local m = ui.Create("ui_frame",function(self)
		self:SetSize(700,400)
		self:Center()
		self:SetTitle("Управление репками")
		self:MakePopup()
	end)

	local tabs = ui.Create("ui_tablist",m,function(self)
		self:DockToFrame()
	end)

	for i,ply in pairs(player.GetAll()) do
		tabs:AddTab(
			ply:Name(),


			ui.Create("ui_panel",function(self)
				ui.Create("DButton",self,function(butt)
					butt:Dock(TOP)
					butt:DockMargin(5,5,5,5)
					butt:SetTall(30)
					butt:SetText("= ДОБАВИТЬ ОТЗЫВ =")
					butt.DoClick = function(s)
						REP.VGUI_MakeReview(ply)
					end
				end)

				makeInfoPanel(ply,self)
			end),


		nil)
	end
end

--REP.VGUI_Moderate()