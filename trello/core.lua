local KEY   = ""
local TOKEN = ""

function TRL.ProcessAPI(sRealm, sTarget, sMethod, tParams, fCallback, sHttpMethod)
	tParams = tParams or {}
	tParams["key"]   = KEY
	tParams["token"] = TOKEN

	HTTP({
		url = "https://api.trello.com/1/" .. sRealm .. "/" .. (sTarget or "") .. (sMethod and "/" .. sMethod or ""),
		method = sHttpMethod or "GET",
		parameters = tParams,
		success = fCallback and function(_,body)
			local t = util.JSONToTable(body)

			if !t then
				print("Ошибка. Тело:\n" .. body)
				return
			end

			fCallback(t)
		end
	})
end

-- TODO щакинуть это в объект BOARD
function TRL.GetCards(sBoard,cb)
	TRL.ProcessAPI("boards", sBoard, "cards", nil, function(t)
		for _,card in ipairs(t) do
			TRL.SetMeta(card,"CARD")
		end

		cb(t)
	end)
end

function TRL.GetCard(sCardID,cb) -- хавает и ID и shortID
	TRL.ProcessAPI("cards", sCardID, nil, nil, function(card)
		cb( TRL.SetMeta(card,"CARD") )
	end)
end

function TRL.GetLists(sBoard,cb)
	TRL.ProcessAPI("boards", sBoard, "lists", nil, function(lists)
		for _,list in ipairs(lists) do
			TRL.SetMeta(list,"LIST")

			lists[list:Name()] = list -- keyvalue
		end

		cb(lists)
	end)
end

-- function