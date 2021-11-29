function TL.PermaSpawnSent(entclass,data,unname)
	local ent = ents.Create(entclass)
	ent:SetPos(util.StringToType(data.vec,"Vector"))
	ent:SetAngles(util.StringToType(data.ang,"Angle"))
	ent:Spawn()
	ent:Activate()

	ent.uniquePermaSentName = unname

	local phys = ent:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if data.models then
		ent:SetModel(table.Random(data.models))
	end

	return ent
end


local function spawnObjects()
	hook.Call("PS.StartPermaSpawn")

	print(" ================================ ")
	print("     СПАВН ПЕРМАНЕНТНЫХ ВЕЩЕЙ     ")
	print(" ================================ ")

	local _,sents = file.Find(PERMASENTS_DATADIR .. "*", "DATA")
	for _,class in pairs(sents) do

		if !scripted_ents.GetStored(class) then
			print(class .. " не существует на сервере")
			continue
		end

		local counter = 0
		for _,filename in pairs( file.Find(PERMASENTS_DATADIR .. class .. "/" .. PERMASENTS_MAPNAME .. "/*", "DATA") ) do

			TL.PermaSpawnSent(
				class,
				util.JSONToTable( file.Read(PERMASENTS_DATADIR .. class .. "/" .. PERMASENTS_MAPNAME .. "/" .. filename, "DATA") ),
				string.sub(filename,1,-5)
			)

			counter = counter + 1
		end

		print(" ЗАСПАВНЕНО " .. counter .. " " .. class)

	end

	print(" ================================ ")
	--hook.Call("PS.PostPermaSpawn") -- Апдейт варов
end


hook.Add("InitPostEntity","spawnObjects",spawnObjects)
