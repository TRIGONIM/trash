util.AddNetworkString("POP.Data")

local MINS   = 1
local HOURS  = 2
local DAYS   = 3
local MONTHS = 4
local YEARS  = 5

local d_formats = {
	[MINS]   = "%y%m%d%H%M",
	[HOURS]  = "%y%m%d%H",
	[DAYS]   = "%y%m%d",
	[MONTHS] = "%y%m",
	[YEARS]  = "%y",
}

local function sendData(pl, d)
	net.Start("POP.Data")
		net.WriteShort(#d)

		for i = 1,#d do
			net.WriteLong (d[i][1])
			net.WriteShort(d[i][2])
		end
	net.Send(pl)
end


local date_order = {
	-- [1] = {date, 228}
}

local function getrow(i)
	date_order[i] = date_order[i] or {0,0}
	return date_order[i]
end

local function formatData(d, sGroup)
	date_order = {} -- reset

	local i = 0
	for _,v in ipairs(d) do
		local form_date = tonumber(os.date(sGroup,v.date))

		local row = getrow(i)
		if form_date > row[1] then -- если следующая отметка, то переходим на новую ячейку
			i = i + 1
			row = getrow(i)
			row[1] = form_date
		end

		row[2] = row[2] + 1
	end

	date_order[0] = nil -- подчищаем за собой

	return date_order
end

net("POP.Data",function(_,pl)
	if !pl:IsSuperAdmin() then return end

	local bFrom,bTo = net.ReadBool(),net.ReadBool()
	local date_from,date_to = bFrom and net.ReadLong(), bTo and net.ReadLong() -- tstamps or false

	local format = d_formats[net.ReadNibble()]

	POP.GetData(function(d)
		sendData(pl, formatData(d, format))
	end, date_from, date_to)
end)

