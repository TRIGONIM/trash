PERMASENTS_DATADIR = "trigon_scripts/permasents/"
PERMASENTS_MAPNAME = game.GetMap():lower()


local canPermaSave = function(ply) return ply:isAdmin() end
local canPermaRemove = canPermaSave


-- Функция должна вызываться шаредно
-- добавляет в контекстные опции возможность для сохранения
-- при рестарте энтити появится в том же месте, что и при сохранении
function TL.addPermasaveFeature(class,models)
	local path = PERMASENTS_DATADIR .. class .. "/" .. PERMASENTS_MAPNAME .. "/"
	models = (isstring(models) and {models}) or (istable(models) and models)

	if SERVER and !file.IsDir( path ,"DATA") then
		file.CreateDir( path )
	end

	properties.Add( class .. "SAVE", {
		MenuLabel = "Сохранить",
		Order = 999,
		MenuIcon = "icon16/bullet_disk.png",

		Filter = function( self, ent, ply )
			if ( !IsValid( ent ) ) then return false end
			if ( !canPermaSave(ply) ) then return false end
			if ent:GetClass() ~= class then return false end

			return true
		end,
		Action = function( self, ent )

			self:MsgStart()
				net.WriteEntity( ent )
			self:MsgEnd()

		end,
		Receive = function( self, length, ply )
			local ent = net.ReadEntity()
			if ( !self:Filter(ent,ply) ) then return end

			if ent.uniquePermaSentName then
				ply:ChatPrint("Эта энтити уже сохранена. Удалите и сохраните заново, если надо переместить")
				return
			end

			local dat = {
				vec    = tostring(ent:GetPos()),
				ang    = tostring(ent:GetAngles()),
				models = models,
			}

			local really_fucking_last_num
			local function makeFile(lastnum)
				lastnum = lastnum + 1
				local name = path .. lastnum .. ".txt"

				if file.Exists( name, "DATA" ) then
					makeFile(lastnum + 1)
					return
				end

				file.Write(name,util.TableToJSON(dat,true))
				ply:ChatPrint(lastnum .. " позиция установлена!")
				really_fucking_last_num = lastnum
			end
			makeFile(#file.Find(path .. "*","DATA"))

			ent:Remove()
			TL.PermaSpawnSent(class,dat,really_fucking_last_num)
		end
	} );



	properties.Add( class .. "REMOVE", {
		MenuLabel = "Удалить",
		Order = 999,
		MenuIcon = "icon16/bin_closed.png",

		Filter = function( self, ent, ply )
			if ( !IsValid( ent ) ) then return false end
			if ( !canPermaRemove(ply) ) then return false end
			if ent:GetClass() ~= class then return false end

			return true
		end,
		Action = function( self, ent )

			self:MsgStart()
				net.WriteEntity( ent )
			self:MsgEnd()

		end,
		Receive = function( self, length, ply )
			local ent = net.ReadEntity()
			if ( !self:Filter( ent, ply ) ) then return end

			if !ent.uniquePermaSentName then
				ply:ChatPrint("Похоже, что это не перманентное") -- TODO убрать опцию, если это так
				return
			end

			if file.Exists( path .. ent.uniquePermaSentName .. ".txt", "DATA" ) then
				file.Delete( path .. ent.uniquePermaSentName .. ".txt" )
				ply:ChatPrint(ent.uniquePermaSentName .. " объект удален")
				ent:Remove()
				return
			else
				ply:ChatPrint("Что-то не так #2. Удалите вручную!")
			end
		end
	} );

end

hook.Add("InitPostEntity","addPermaFeatures",function()
	for class,e in pairs( scripted_ents.GetList() ) do
		if e.t.PERMA_SUPPORT then
			local mdl = isstring(e.t.PERMA_SUPPORT) and e.t.PERMA_SUPPORT or nil
			print("Добавление перма фичи для " .. class)
			TL.addPermasaveFeature(class, mdl)
		end
	end
end)

-- local function spawnObjects()
-- 	hook.Call("PS.StartPermaSpawn")

-- 	if SERVER then
-- 		TL.spawnPermaObjects()
-- 	end

-- 	hook.Call("PS.PostPermaSpawn") -- Апдейт варов
-- end

-- hook("InitPostEntity",spawnObjects)