-- Заголовки и ИД сообщений
-- t[1] - ID, t[2] - Title or false
function OM.GetMessages(cb,bIncludeReaded)
	net.Start("OM.GetMessages")
		net.WriteBool(bIncludeReaded)
	net.SendToServer()

	net("OM.GetMessages",function()
		local t = {}
		for i = 1,net.ReadUInt(7) do -- 127
			t[i] = {net.ReadUInt(16), net.ReadBool() and net.ReadString(),net.ReadBool()} -- 65535
		end

		cb(t)
	end)
end

-- Получает текст сообщения
function OM.GetMessageText(iMsgID,cb)
	net.Start("OM.GetText")
		net.WriteUInt(iMsgID,16)
	net.SendToServer()

	net("OM.GetText",function()
		cb(net.ReadString())
	end)
end

-- После прочтения сообщения говорим серверу, что можно удалять
function OM.SendReadCallback(id,bRead,cb)
	net.Start("OM.IReadTheMessage")
		net.WriteUInt(id,16)
		net.WriteBool(bRead)
	net.SendToServer()

	net("OM.IReadTheMessage",function()
		local err = net.ReadBool() or net.ReadString()
		if err == true then
			err = nil
		end

		if cb then
			cb(err)
		end
	end)
end