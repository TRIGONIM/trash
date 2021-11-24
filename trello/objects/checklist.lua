local LIST = TRL.NewObject("CHECKLIST")

function LIST:Name()
	return self.name
end

function LIST:ID()
	return self.id
end

function LIST:AddItem(name,checked,pos,cb)
	TRL.ProcessAPI("checklists", self:ID(), "checkItems", {
		name    = name,
		pos     = pos,
		checked = checked,
	}, cb, "POST") -- POST
end

function LIST:Items(cb)
	TRL.ProcessAPI("checklists", self:ID(), "checkItems", {
		name    = name,
		pos     = pos,
		checked = checked,
	}, function(items)
		for _,item in ipairs(items) do
			items[item.name] = item -- делаем keyvalue
		end

		cb(items)
	end) -- GET
end