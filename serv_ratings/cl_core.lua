function POP.RequestData(cb, iFrom,iTo,iGroupBy)
	net.Start("POP.Data")
		net.WriteBool(iFrom)
		net.WriteBool(iTo)

		if iFrom then
			net.WriteLong(iFrom)
		end

		if iTo then
			net.WriteLong(iTo)
		end

		net.WriteNibble(iGroupBy or 4)
	net.SendToServer()

	net.Receive("POP.Data",function()
		local d = {}
		for i = 1,net.ReadShort() do
			d[i] = {
				net.ReadLong(),
				net.ReadShort()
			}
		end

		cb(d)
	end)
end