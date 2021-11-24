local CARD = TRL.NewObject("CARD")

function CARD:Name()
	return self.name
end

function CARD:ID()
	return self.id
end

function CARD:ListID()
	return self.idList
end










function CARD:List(cb)
	TRL.ProcessAPI("lists", self:ListID(), nil, nil, function(t)
		TRL.SetMeta(t,"LIST")

		cb(t)
	end)
end

function CARD:Checklists(cb)
	TRL.ProcessAPI("cards", self:ID(), "checklists", nil, function(t)
		for _,list in ipairs(t) do
			TRL.SetMeta(list,"CHECKLIST")

			t[list:Name()] = list -- они итерированные, делаем key=value
		end

		cb(t)
	end)
end

function CARD:NewChecklist(name,pos,cb) -- pos is bottom or top or number
	TRL.ProcessAPI("checklists", nil, nil, {
		idCard = self:ID(),
		name   = name,
		pos    = pos
	}, function(list)
		TRL.SetMeta(list,"CHECKLIST")
		cb(list)
	end, "POST")
end
