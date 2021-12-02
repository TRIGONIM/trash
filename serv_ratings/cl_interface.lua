-- Получает самую высокую позицию среди всех позиций столбика
local function getHuge(d)
	local huge,total = 0,0

	for _,v in ipairs(d) do
		if v[2] > huge then
			huge = v[2]
		end

		total = total + v[2]
	end

	return huge,total
end

local function constructPoly(d, scale, w,h) -- делает прямоугольные столбики, хотя сначала планировались колючки
	local polys = {}

	local step = w / #d
	for i,v in ipairs(d) do
		polys[i] = {}
		local p = polys[i] -- alias

		local x = step * i
		p[1] = {
			x = x - step,
			y = h
		}
		p[2] = {
			x = p[1].x,
			y = math.Round(h - h * (v[2] / scale)) -- в скобочках 0-1 (Множитель)
		}
		p[3] = {
			x = x,
			y = math.Round(h - h * (v[2] / scale)) -- в скобочках 0-1 (Множитель)
		}
		p[4] = {
			x = p[3].x,
			y = h
		}
	end

	return polys
end

function POP.UI(iFrom,iTo,iGroupBy)
	local f = ui.Create("ui_frame",function(self)
		self:SetSize(700,450)
		self:Center()
		self:SetTitle("Чарты прироста игроков проекта")
		self:MakePopup()
	end)

	local header = ui.Create("DLabel",f,function(self)
		self:Dock(TOP)
		self:DockMargin(10,10,10,10)
		self:SetText("Здрасьте")
		self.Update = function(s,i)
			self:SetText("Новых пользователей за период: " .. i)
		end
	end)

	local chart = ui.Create("Panel",f,function(self)
		self:Dock(FILL)
		self:DockMargin(100,0,100,0)
		-- self:InvalidateParent(true) -- мгновенный норм размер
		self.UpdateCharts = function(s,d)

		end

		self.polys = {}
		self.Paint = function(s,w,h)
			-- draw.RoundedBox(0,0,0,w,h,Color(50,50,50,100))
			-- surface.SetDrawColor(255,255,255)
			-- surface.SetMaterial(Material("models/wireframe"))
			-- surface.DrawTexturedRect(0,0,w,h)
			draw.Outline(0, 0, w, h, Color(200,200,200,100), 2)

			surface.SetDrawColor(Color(255,255,255,200))
			draw.NoTexture()
			for _,poly in ipairs(self.polys) do
				surface.DrawPoly(poly)
			end
		end
	end)

	ui.Create("DButton",f,function(self)
		self:Dock(BOTTOM)
		self:SetTall(50)
		self:SetText("Получить данные")
		self:DockMargin(10,10,10,10)
		self.DoClick = function()
			POP.RequestData(function(dat)
				local scale,total = getHuge(dat)
				chart.polys = constructPoly(dat, scale * 1.2, chart:GetSize())

				header:Update(total)
			end,iFrom,iTo,iGroupBy)
		end
	end)

	return f
end


-- local qwe = POP.UI(dateToStamp("2017-01-01 00:00:00"),nil,3)
-- timer.Simple(15,function()
-- 	if IsValid(qwe) then
-- 		qwe:Remove()
-- 	end
-- end)