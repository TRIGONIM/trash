local att, wep, dist, mul

hook.Add("EntityTakeDamage", "SWB_EntityTakeDamage", function(ent, d)
	att = d:GetInflictor()

	if !att:IsPlayer() then return end

	wep = att:GetActiveWeapon()

	if IsValid(wep) and wep.SWBWeapon then
		if !wep.NoDistance and wep.EffectiveRange then
			dist = ent:GetPos():Distance(att:GetPos())

			if dist >= wep.EffectiveRange * 0.5 then
				dist = dist - wep.EffectiveRange * 0.5
				mul = math.Clamp(dist / wep.EffectiveRange, 0, 1)

				d:ScaleDamage(1 - wep.DamageFallOff * mul)
			end
		end

		if !isDoor(ent) then return end

		local fake = DBUST.DamageDoor(ent,att,d:GetDamage() * 0.5) -- *5
		if fake then -- вывалилась
			local pos = ent:GetPos()
			local norm = (pos - att:GetPos()):GetNormal()
			local push = 10000 * norm

			timer.Simple(.01,function()
				fake:SetVelocity(push)
				fake:GetPhysicsObject():ApplyForceCenter(push)
			end)
		end
	end
end)


local function emit(pl,sound)
	pl:EmitSound(sound,60,100,1,CHAN_WEAPON)
end

hook.Add("PlayerSwitchWeapon", "SWB.SwitchSound", function(pl, owep,nwep)
	if nwep and nwep.SWBWeapon then
		emit(pl,"npc/combine_soldier/gear" .. math.random(2) .. ".wav")

	elseif owep and owep.SWBWeapon then
		local id = math.random(2) == 1 and 4 or 6 -- выбираем между 4 и 6 треком
		emit(pl,"npc/combine_soldier/gear" .. id .. ".wav")
	end
end)