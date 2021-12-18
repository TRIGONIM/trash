-- зум
local wep, CT

function SWEP.PlayerBindPress(ply, b, p)
	if p then
		wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		local zoom = (wep.SWBWeapon and wep.dt and wep.AdjustableZoom and wep.dt.State == SWB_AIMING)
			and (
				(b == "invprev" and (wep.ZoomAmount - 15)) or
				(b == "invnext" and (wep.ZoomAmount + 15))
			)

		if !zoom then return end

		CT = CurTime()
		if CT > wep.ZoomWait and wep.ZoomAmount >= wep.MinZoom then
			wep.ZoomAmount = math.Clamp(zoom, wep.MinZoom, wep.MaxZoom)
			surface.PlaySound("weapons/zoom.wav")
			wep.ZoomWait = CT + 0.15
		end

		return true
	end
end

hook.Add("PlayerBindPress", "SWEP.PlayerBindPress (SWB)", SWEP.PlayerBindPress)