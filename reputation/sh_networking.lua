nw.Register("REP_FULL"):Write(net.WriteTable):Read(net.ReadTable):SetLocalPlayer()
nw.Register("REP_WEIGHT"):Write(net.WriteInt,16):Read(net.ReadInt,16):SetPlayer()
nw.Register("REP_TOP"):Write(net.WriteUInt,7):Read(net.ReadUInt,7):SetPlayer()
nw.Register("REP"):Write(net.WriteTable):Read(net.ReadTable):SetPlayer()
