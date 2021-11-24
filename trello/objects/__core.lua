TRL.OBJS = TRL.OBJS or {}
function TRL.NewObject(uid)
	if TRL.OBJS[uid] then return TRL.OBJS[uid] end

	local OBJ = {}
	OBJ.__index = OBJ

	TRL.OBJS[uid] = OBJ

	return OBJ
end

function TRL.GetObject(uid)
	return TRL.OBJS[uid]
end

function TRL.SetMeta(t,uid)
	return setmetatable(t, TRL.OBJS[uid])
end