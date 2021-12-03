local MESSAGE = {}
MESSAGE.__index = MESSAGE

function MESSAGE:ID()
	return self.id
end

function MESSAGE:GetText(cb)
	if self.text then
		cb(self.text)
		return
	end

	OM.GetMessageText(self:ID(),function(text)
		self.text = text
		cb(text)
	end)
end

function MESSAGE:Title()
	return self.title
end

function MESSAGE:Category() return self.category end
function MESSAGE:SetCategory(c) self.category = c end

function MESSAGE:IsRead() return self.read end
function MESSAGE:SetRead(read,cb)
	OM.SendReadCallback(self:ID(),read,function(err)
		if !err then
			self.read = read
		end

		if cb then
			cb(err)
		end
	end)
end


function OM.Message(msg_id,title,read)
	local OBJ = setmetatable({
		id    = msg_id,
		title = title,
		read  = read,
	},MESSAGE)

	return OBJ
end
