local TITLE_PATTERN  = "(.+) %((STEAM_[01]:[01]:[0-9]+)%)"
local BOARD_STAFF    = "mKxab5vi"
local LIST_BLACKLIST = fl.set{"Архив","Уволены"}

-- PL_VISITS = PL.Add("visits",{"вход", "входа", "входов"})

local CARD_MT = TRL.GetObject("CARD")
function CARD_MT:NickSteamID()
	return self:Name():match(TITLE_PATTERN)
end
-- prt{ string.match("Demo (STEAM_0:1:23456789)",TITLE_PATTERN) }

function TRL.FetchStaffCards(cb)
	-- Исключаем архивных и уволенных. За ними учета нет
	local list_blacklist_ids = {}
	TRL.GetLists(BOARD_STAFF,function(lists)
		for _,LIST in ipairs(lists) do
			if LIST_BLACKLIST[LIST:Name()] then
				list_blacklist_ids[LIST:ID()] = true
			end
		end

		TRL.GetCards(BOARD_STAFF,function(t)
			local staff_cards = {}
			for _,CARD in ipairs(t) do
				if list_blacklist_ids[CARD:ListID()] or !CARD:NickSteamID() then continue end -- not IsStaffCard

				table.insert(staff_cards,CARD)
			end

			cb(staff_cards)
		end)
	end)
end

function TRL.GetOrCreateChecklist(cardId,name,cb)
	TRL.GetCard(cardId, function(CARD)
		CARD:Checklists(function(lists)

			if lists[name] then -- чеклист существует
				cb(lists[name])
			else
				CARD:NewChecklist(name,nil,cb) -- не существует
			end

		end)
	end)
end





-- local TEST_CARD_ID = "5988832951cb8eb23c69b549"
-- TRL.GetOrCreateChecklist(TEST_CARD_ID,"Авторизации XXX",prt)