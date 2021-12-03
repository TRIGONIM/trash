util.AddNetworkString("OM.UI")
util.AddNetworkString("OM.IReadTheMessage") -- CL > SV
util.AddNetworkString("OM.GetMessages") -- SH
util.AddNetworkString("OM.GetText") -- SH


function OM.CheckPlayerOwnMessage(uid,iMsgID,cb)
	OM.GetMessageOwner(iMsgID, function(owner_uid)
		cb(owner_uid == uid)
	end)
end


--[[-------------------------------------------------------------------------
	Заголовки и ИД сообщений игрока
---------------------------------------------------------------------------]]
local function sendMessages(pl,tMsgs)
	net.Start("OM.GetMessages")
		net.WriteUInt(#tMsgs,7) -- 127

		for _,row in ipairs(tMsgs) do
			net.WriteUInt(row.id,16)
			net.WriteBool(row.title)
			if row.title then
				net.WriteString(row.title)
			end
			net.WriteBool(row.read == 1)
		end
	net.Send(pl)
end
net("OM.GetMessages", function(_,pl)
	OM.GetPlayerMessages(pl:SteamID64(), function(data)
		sendMessages(pl, data)
	end, net.ReadBool())
end)


--[[-------------------------------------------------------------------------
	Текст конкретного сообщения
---------------------------------------------------------------------------]]
local function sendMessageText(pl,txt)
	net.Start("OM.GetText")
		net.WriteString(txt)
	net.Send(pl)
end
net("OM.GetText",function(_,pl)
	local iMsgID = net.ReadUInt(16)

	OM.CheckPlayerOwnMessage(pl:UID(), iMsgID, function(own)
		if !own then sendMessageText(pl, "Хуй соси, губой тряси") return end

		OM.GetMessageText(iMsgID, function(text)
			sendMessageText(pl, text)
		end)
	end)
end)


--[[-------------------------------------------------------------------------
	Делаем, чтобы сообщение больше не отображалось
---------------------------------------------------------------------------]]
local function readCb(pl,err)
	local ok = err == true -- ok or str

	net.Start("OM.IReadTheMessage")
		net.WriteBool(ok)
		if !ok then
			net.WriteString(err)
		end
	net.Send(pl)
end
net("OM.IReadTheMessage",function(_,pl)
	local iMsgID = net.ReadUInt(16)
	local read   = net.ReadBool()

	OM.CheckPlayerOwnMessage(pl:UID(), iMsgID, function(own)
		if !own then readCb(pl,"Это не твой месседж, сук") return end

		OM.MarkRead(iMsgID,read,function(ok)
			readCb(pl,ok or "Уже отмечено")
		end)
	end)
end)

