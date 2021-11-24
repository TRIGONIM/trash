-- local TEST_CARD_ID = "5988832951cb8eb23c69b549"

-- TRL.GetCard(TEST_CARD_ID, function(CARD)
-- 	CARD:NewChecklist("qwerty",nil, function()

-- 	end)
-- end)
local function extractDate(s)
	return string.match(s,"`(.+)`")
end

local function diffTimeDays(tstamp)
	return math.Round((os.time() - tstamp) / 60 / 60 / 24)
end



local function getVisitsChecklist(CARD,cb)
	TRL.GetOrCreateChecklist(CARD:ID(),"Посещаемость",cb)
end

local function getListItems(LIST,cb)
	LIST:Items(cb)
end

local function playerOnline(s32,cb)
	PDAT.GetTimePlayed(util.SteamIDTo64(s32),cb)
end

local prev_top = {
	rate = 0,
	i = 0
}
local function addStaffListCheckpoint(LIST,list_items,time_sec,nick)
	local LAST_ITEM  = list_items[#list_items]

	local time_hours = time_sec / 60 / 60 -- если первая отметка, то напишет сколько ВСЕГО наигранный часов
	-- local time_hours = LAST_ITEM and (time_sec / 60 / 60) or 0 -- если предыдущей отметки нет, то не будем писать, что чел наиграл 100500 часов
	local time_old   = LAST_ITEM and tonumber(LAST_ITEM.name:match("вс%. (.+)ч%.")) or 0 -- часы. 0 также, если сбить формат строки
	local time_diff  = LAST_ITEM and (time_hours - time_old) or 0 -- часов

	if LAST_ITEM then
		local date = extractDate(LAST_ITEM.name)
		local days_gone = diffTimeDays( dateToStamp(date) )

		-- Прошло меньше 6 дней с момента последнего учета
		if days_gone < 6 then return end
	end

	-- local visits_s = PL_VISITS(visits)
	local s = ("`%s` наиграно %i часов (вс. %iч.)")
		:format(os.date("%Y-%m-%d"),time_diff,time_hours)

	-- LIST:AddItem(s,nil,nil,prt)
	LIST:AddItem(s)
	-- print(s)
end

-- local function print() end
concommand.Add("staff_checkpoint",function(pl,cmd,args)
	if IsValid(pl) then return end -- Console Only

	TRL.FetchStaffCards(function(cards)
		for i,CARD in ipairs(cards) do
			local nick,s32 = CARD:NickSteamID()
			-- if nick ~= "Demo" then continue end
			-- if i > 7 then continue end
			print("\t>> " .. nick)

			getVisitsChecklist(CARD,function(LIST)
				print("\t\t>> " .. nick)
				getListItems(LIST,function(list_items)
					print("\t\t\t\t>> " .. nick)
					playerOnline(s32,function(time_sec)
						print("\t\t\t\t\t>> " .. nick)
						addStaffListCheckpoint(LIST,list_items,time_sec,nick)
					end)
				end)
			end)
		end
	end)
end)

-- RunConsoleCommand("staff_checkpoint")