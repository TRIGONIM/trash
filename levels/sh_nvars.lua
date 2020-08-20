LVL = LVL or {}

LVL.BITS = {
	LVL = 5,
	EXP = 16,  -- до 65535. С запасом
	TO_UPGRADE = 12,
	GAINED_EXP = 16, -- до 65535. С запасом
}

nw.Register("LVL"):Write(net.WriteUInt,5):Read(net.ReadUInt,LVL.BITS.LVL):SetPlayer() -- Макс ЛВЛ 30 (до 32) (5 бит, 46500 опыта)
nw.Register("EXP"):Write(net.WriteUInt,16):Read(net.ReadUInt,LVL.BITS.EXP):SetLocalPlayer() -- Макс эксп 46500 (127 лвл, 18 бит, но число до 65535)
nw.Register("TO_UPGRADE"):Write(net.WriteUInt,12):Read(net.ReadUInt,LVL.BITS.TO_UPGRADE):SetLocalPlayer() -- опыта к след. уровню (Число до 4096)



local function assertlvl(i)
	assert(math.between(i,0,LVL.max_lvl),"lvl out of range")
	return i
end

function net.WriteLVL(lvl)
	net.WriteUInt(assertlvl(lvl),LVL.BITS.LVL)
end

function net.ReadLVL()
	return assertlvl( net.ReadUInt(LVL.BITS.LVL) )
end
