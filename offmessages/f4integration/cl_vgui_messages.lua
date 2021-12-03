local PANEL = {}

local MONTHS = {
	["01"] = "Янв.",
	["02"] = "Фев.",
	["03"] = "Марта",
	["04"] = "Апр.",
	["05"] = "Мая",
	["06"] = "Июня",
	["07"] = "Июля",
	["08"] = "Авг.",
	["09"] = "Сен.",
	["10"] = "Окт.",
	["11"] = "Ноя.",
	["12"] = "Дек.",
}

local SIDE_WIDTH = 300

--[[-------------------------------------------------------------------------
	Балабурдень
---------------------------------------------------------------------------]]
function PANEL:Init()
	self.groups = {}

	-- Правая часть с содержимым сообщения
	self.activity = ui.Create("Panel",self)
	self.activity:SetPos(SIDE_WIDTH + 10)

	-- Левая панель с категориями сообщений
	self.scr = ui.Create("DScrollPanel",self,function(scr)
		scr:SetPos(0,0)
		scr:SetWidth(SIDE_WIDTH)

		scr.Paint = function(s,w,h) end
		scr.VBar.Paint         = F4M.sk.VBar
		scr.VBar.btnUp.Paint   = F4M.sk.VBarUp
		scr.VBar.btnDown.Paint = F4M.sk.VBarDown
		scr.VBar.btnGrip.Paint = F4M.sk.VBarGrip
	end)


	self.infopan  = self:BuildInfoPanel()
	self.controls = self:BuildControlPanel()
	self.message  = self:BuildMessagePanel()
end

function PANEL:PerformLayout()
	local tall = self:GetTall()
	self.scr:SetHeight(tall)
	self.activity:SetSize(self:GetWide() - SIDE_WIDTH - 10,tall)
end





--[[-------------------------------------------------------------------------
	Хелпофункции
---------------------------------------------------------------------------]]
-- self.infopan
-- :SetTitle(title)
-- :SetFrom(from)
-- :SetTime(stamp)
require("wmat")
wmat.SetHandler("https://imgkit.gmod.app/?size=%i&image=")

function PANEL:BuildInfoPanel()
	self.mat = wmat.Get("OM-ICO")
	if !self.mat then
		wmat.Create("OM-ICO", {
			URL = "http://i.imgur.com/2DR60AR.png",
			W 	= 50,
			H 	= 50,
			Cache   = true,
			UseHTTP = true,
		}, function(material)
			self.mat = material
		end)
	end



	-- Панель с иконкой сообщения
	local icon = ui.Create("Panel",function(ico)
		ico:Dock(LEFT)
		ico:DockMargin(0,0,10,0)
		ico:SetSize(50,50)
		ico.Paint = function(s,w,h)
			if !self.mat then return end

			surface.DisableClipping(true)
				surface.SetDrawColor(255,255,255)
				surface.SetMaterial(self.mat)
				surface.DrawTexturedRect(0,0,50,50)
			surface.DisableClipping(false)
		end
	end)

	-- Панель с заголовком и отправителем
	local title_sender = ui.Create("Panel",function(bg)
		bg:Dock(FILL)
		bg:DockPadding(0,5,0,0)

		-- Заголовок сообщения
		bg.title = ui.Create("DLabel",bg,function(self_title)
			self_title:Dock(TOP)
			self_title:SetText("Тема не указана")
			self_title:SetTextColor(Color(0,0,0))
			self_title:SetFont("f4_sidebar")
		end)

		-- От кого
		bg.from = ui.Create("DLabel",bg,function(self_from)
			self_from:Dock(TOP)
			self_from:SetText("Отправитель не указан")
			self_from:SetTextColor(Color(0,0,0))
			self_from:SetFont("f4_price")
		end)
	end)

	-- Время сообщения
	local message_time = ui.Create("DLabel",function(self_time)
		self_time:Dock(RIGHT)
		self_time:SetWidth(140)
		self_time:SetText("Время не указано")
		self_time:SetTextColor(Color(100,100,100))
		self_time:SetFont("f4_price")
		self_time:SetAutoStretchVertical(true)
	end)


	local infopan = ui.Create("Panel",function(inf)
		inf:Dock(TOP)
		inf:SetTall(50)

		        icon:SetParent(inf)
		title_sender:SetParent(inf)
		message_time:SetParent(inf)
	end)

	function infopan:SetTitle(title)
		title_sender.title:SetText("Тема: " .. title)
	end

	function infopan:SetFrom(from)
		title_sender.from:SetText("От: " .. from)
	end

	function infopan:SetTime(stamp)
		message_time:SetText(os.date("%d " .. MONTHS[os.date("%m",stamp)] .. " в %H:%M",stamp))
	end

	-- self.activity:AddItem(infopan)
	infopan:SetParent(self.activity)
	infopan:Dock(TOP)

	return infopan
end


-- self.controls
-- :SetupArchive(id,archived)
-- :SetupDelete(id,deleted)
-- :SetupRead(id,read)
function PANEL:BuildControlPanel()
	-- В архив/с архива
	local archive = ui.Create("DButton",function(arch)
		arch:Dock(LEFT)
		arch:SetWidth(100)
		arch:SetText("Архивирование")
		arch:SetFont("f4_simpleinf")
		arch:SetTextColor( Color(255,255,255) )
		arch.Paint = F4M.sk.ButtonBlue
	end)

	-- Удалить/удалено
	local delete = ui.Create("DButton",function(del)
		del:Dock(LEFT)
		del:DockMargin(5,0,0,0)
		del:SetWidth(100)
		del:SetTooltip("Полностью удаляет сообщение. Исчезнет после перезахода")
		del:SetText("Удаление")
		del:SetFont("f4_simpleinf")
		del:SetTextColor( Color(255,255,255) )
		del.Paint = function(s,w,h) F4M.sk.ButtonBlue(s,w,h,s.deleted) end
	end)

	-- Прочитано/не прочитано
	local setread = ui.Create("DButton",function(read)
		read:Dock(LEFT)
		read:DockMargin(5,0,0,0)
		read:SetWidth(100)
		read:SetText("Не прочитано") -- всегда первым будет "не прочитано", т.к. после нажатия кнопки сообщение автоотмечается прочитанным
		read:SetFont("f4_simpleinf")
		read:SetTextColor( Color(255,255,255) )
		read.Paint = F4M.sk.ButtonBlue
	end)

	-- Ссылки (Не задействовано)
	-- local links = v.links and ui.Create("DButton",function(link)
	-- 	link:Dock(LEFT)
	-- 	link:DockMargin(5,0,0,0)
	-- 	link:SetWidth(100)
	-- 	link:SetText("Ссылки (" .. #v.links .. " шт.)")
	-- 	link:SetFont("f4_simpleinf")
	-- 	link:SetTextColor( Color(255,255,255) )
	-- 	link.Paint = F4M.sk.ButtonBlue
	-- 	link.DoClick = function(s)
	-- 		local m = DermaMenu(s)
	-- 		for num = 1,#v.links do
	-- 			m:AddOption(v.links[num].name,function() gui.OpenURL(v.links[num].link) end)
	-- 		end
	-- 		m:Open()
	-- 	end
	-- end) or nil


	local controlpan = ui.Create("Panel",function(cp)
		cp:Dock(TOP)
		cp:SetTall(30)

		-- Скрываем, пока не активируем
		archive:SetParent(cp) archive:SetVisible(false)
		 delete:SetParent(cp)  delete:SetVisible(false)
		setread:SetParent(cp) setread:SetVisible(false)

		if links then
			 links:SetParent(cp)
			 links:SetVisible(false)
		end
	end)

	function controlpan:SetupArchive(MSG,archived)
		archive:SetVisible(true)
		archive:SetText(archived and "С архива" or "В архив")
		archive.DoClick = function(s)
			OM.changeArchive(function(ok)
				if ok then
					archived = !archived
					s:SetText(archived and "С архива" or "В архив")
				end
			end,MSG:ID(),archived and 0 or 1) -- если в архиве, то вытаскиваем
		end
	end

	function controlpan:SetupDelete(MSG,deleted)
		delete:SetVisible(true)
		delete:SetText("Удалить")
		delete.DoClick = function(s)
			if s.deleted then return end

			OM.removeMessage(function(ok)
				if ok then
					s.deleted = true
					s:SetText("Удалено")
				end
			end,MSG:ID()) -- если в архиве, то вытаскиваем
		end
	end

	function controlpan:SetupRead(MSG,read)
		setread:SetVisible(true)
		setread:SetText(read and "Не прочитано" or "Прочитано")
		setread.DoClick = function(s)
			MSG:SetRead(!read,function(err) -- если прочитано, то делаем непрочитанным
				if !err then
					read = !read
					s:SetText(read and "Не прочитано" or "Прочитано")
					return
				end

				s:SetText(err)
			end)
		end
	end

	-- self.activity:AddItem(controlpan)
	controlpan:SetParent(self.activity)
	controlpan:Dock(TOP)

	return controlpan
end


--[[-------------------------------------------------------------------------
	Само сообщение!
---------------------------------------------------------------------------]]
-- self.message
-- :SetText(t)
function PANEL:BuildMessagePanel()
	local scroll = ui.Create("DScrollPanel",act,function(msgpan)
		msgpan:Dock(FILL)
		msgpan:DockMargin(0,5,0,0)

		msgpan.Paint = function(s,w,h) end
		msgpan.VBar.Paint         = F4M.sk.VBar
		msgpan.VBar.btnUp.Paint   = F4M.sk.VBarUp
		msgpan.VBar.btnDown.Paint = F4M.sk.VBarDown
		msgpan.VBar.btnGrip.Paint = F4M.sk.VBarGrip
	end)

	scroll.SetText = function(s,t)
		scroll:Clear()
		scroll:InvalidateLayout(true)
		-- scroll.text:SetText(t)

		local txt = string.Wrap("f4_simple14", t, self:GetWide())
		for _,line in ipairs(txt) do
			local bg = ui.Create("Panel") -- чтобы текст центрировался
			bg:Dock(TOP)
			bg:SetTall(14 + 3)

			ui.Create("DLabel", function(l)
				l:Dock(FILL)
				l:SetText(line)
				l:SetTextColor(Color(123,123,123))
				l:SetFont("f4_simple14")
			end, bg)

			scroll:AddItem(bg)
			scroll:SetTall(self:GetTall() - self.infopan:GetTall() - self.controls:GetTall() - 5) -- 5 is dockmargin 5
		end
	end

	scroll:SetText("Здесь будет текст сообщения")
	scroll:SetTall(150) -- базово. Костыль

	-- print("self.activity",self.activity,self.activity:GetTall())
	-- self.activity:AddItem(scroll)
	scroll:SetParent(self.activity)
	scroll:Dock(TOP)

	return scroll
end






--[[-------------------------------------------------------------------------
	Полезные методы
---------------------------------------------------------------------------]]
function PANEL:AddMessage(MSG)
	local group = self.groups[MSG:Category()] or ui.Create("DCollapsibleCategory",function(collaps)
		collaps:Dock(TOP)
		collaps:SetLabel("")
		collaps.Paint = function(s,w,h) F4M.sk.Category(s,w,h,MSG:Category()) end

		-- Вместилище для кнопочек. Не уверен, что нужно. Мб можно сразу на коллапс кидать
		collaps.btns = ui.Create("DScrollPanel",function(btns)
			btns:Dock(TOP)
			btns.Paint = function(s,w,h) end
			btns.VBar.Paint         = F4M.sk.VBar
			btns.VBar.btnUp.Paint   = F4M.sk.VBarUp
			btns.VBar.btnDown.Paint = F4M.sk.VBarDown
			btns.VBar.btnGrip.Paint = F4M.sk.VBarGrip

			collaps:SetContents(btns)
		end)

		self.scr:AddItem(collaps) -- добавление категории с кнопками-заголовками
		self.groups[MSG:Category()] = collaps
	end)

	-- Кнопки с заголовками
	local btn = ui.Create("DButton",function(b)
		local titl = MSG:Title() or "Без заголовка"

		b:SetTall(30)
		b:Dock(TOP)
		b:SetText(titl)
		b:SetTooltip(titl)
		b:SetTextColor(Color(255,255,255))
		b:SetFont("f4_title18")
		b.Paint = function(s,w,h) F4M.sk.ButtonBlue(s,w,h,MSG:IsRead()) end
	end)

	btn.SetMessage = function(b,OBJ)
		b.DoClick = function()
			if !OBJ:IsRead() then -- если не прочитано, то делаем прочитанным
				OBJ:SetRead(true)
			end

			OBJ:GetText(function(text)
				if !IsValid(self) then return end

				self.infopan:SetTitle(b:GetText())
				-- self.infopan:SetFrom(from)
				-- self.infopan:SetTime(stamp)

				-- self.controls:SetupArchive(OBJ,archived)
				-- self.controls:SetupDelete(OBJ,deleted)
				self.controls:SetupRead(OBJ,true)

				self.message:SetText(text)
			end)
		end
	end
	group.btns:AddItem(btn)

	btn:SetMessage(MSG)

	self:PerformLayout()
end




derma.DefineControl("DMessagesLayout","Панель для сообщений, типа как в почте",PANEL,"Panel")