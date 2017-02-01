--------------------
--Familiar Effects--
--------------------

function garden:updateFamiliar(familiar)
	if familiar.Variant == garden.ADAM_FAMILIAR_VARIANT then
		if garden.HAS_REBIRTH then
			local player = Isaac.GetPlayer(0)
			familiar.OrbitDistance = Vector(35, 35)
			familiar.OrbitLayer = 98
			familiar.OrbitSpeed = 0.07
			familiar.Velocity = familiar:GetOrbitPosition(player.Position + player.Velocity) - familiar.Position
			familiar.GridCollisionClass = 0
			familiar.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ENEMIES
		end
	end

	if familiar.Variant == garden.LEGION_FAMILIAR_VARIANT then
		if garden.HAS_LEGION then			
			local player = Isaac.GetPlayer(0)			
			local currentRoom = Game():GetRoom()
			local roomCenter = currentRoom:GetCenterPos()			
		
			if currentRoom:IsClear() then --Remove Legion from the room on clear
				local entities = Isaac.GetRoomEntities() 
				for i = 1, #entities do				
					local singleEntity = entities[i]
					if singleEntity.Type == EntityType.ENTITY_FAMILIAR and singleEntity.Variant == garden.LEGION_FAMILIAR_VARIANT and singleEntity.SubType == 0 then
						singleEntity:Remove()						
						garden.LEGION_IN_ROOM = false
						local soundShell = Isaac.Spawn(EntityType.ENTITY_NULL, 0, 0, Vector(0,0), Vector(0,0), player) --Spawn a null entity			
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, singleEntity.Position, Vector(0,0), nil)				
						local volume = 5
						local frameDelay = 0
						local loop = false
						local pitch = 1
						soundShell:ToNPC():PlaySound("176", volume, frameDelay, loop, pitch)	--Make it a sound
						soundShell:Remove()	
					end				
				end				
			end

			if currentRoom:GetFrameCount() == 0 then --Remove Legion from the room on entry (failsafe)			
				--Remove Legion from the room
				local entities = Isaac.GetRoomEntities() 
				for i = 1, #entities do				
					local singleEntity = entities[i]
					if singleEntity.Type == EntityType.ENTITY_FAMILIAR and singleEntity.Variant == garden.LEGION_FAMILIAR_VARIANT and singleEntity.SubType == 0 then
						singleEntity:Remove()							
					end				
				end			

				--Spawn Legion
				local enemiesInRoom = false
				local bossInRoom = false
				local entities = Isaac.GetRoomEntities() 
				for i = 1, #entities do				
					local singleEntity = entities[i]
					if singleEntity:IsVulnerableEnemy() then
						enemiesInRoom = true
						if singleEntity:IsBoss() then
							bossInRoom = true
						end
					end				
				end	
				local randomNum = math.random(100)
				if randomNum <= 20 and enemiesInRoom and not bossInRoom then --20% chance to spawn Legion
					garden.LEGION_SPAWN_POSITION = currentRoom:FindFreePickupSpawnPosition(roomCenter, 0, true)
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, garden.LEGION_SPAWN_POSITION, Vector(0,0), nil)				
					Isaac.Spawn(EntityType.ENTITY_FAMILIAR, garden.LEGION_FAMILIAR_VARIANT, 0, garden.LEGION_SPAWN_POSITION, Vector(0,0), player)
					garden.LEGION_IN_ROOM = true

					local soundShell = Isaac.Spawn(EntityType.ENTITY_NULL, 0, 0, Vector(0,0), Vector(0,0), player) --Spawn a null entity			
					local volume = 5
					local frameDelay = 0
					local loop = false
					local pitch = 1
					soundShell:ToNPC():PlaySound("174", volume, frameDelay, loop, pitch)	--Make it a sound
					soundShell:Remove()	
				end
			end

			--Fire Brimstone
			if garden.LEGION_IN_ROOM and currentRoom:GetFrameCount() % 150 == 0 then --Every 150 frames
				local brimstoneEndPosition
				local brimstoneStartPosition				
				local legionFamiliar
				local chosenEnemy				

				local entities = Isaac.GetRoomEntities() 
				for i = 1, #entities do				
					local singleEntity = entities[i]
					if singleEntity:IsVulnerableEnemy() then 
						chosenEnemy = singleEntity --Find an enemy in the room
					end						
					if singleEntity.Type == EntityType.ENTITY_FAMILIAR and singleEntity.Variant == garden.LEGION_FAMILIAR_VARIANT and singleEntity.SubType == 0 then 
						legionFamiliar = singleEntity --Find Legion familiar						
					end														
				end				

				--Firin' ma lazar
				local direction = Vector(chosenEnemy.Position.X-legionFamiliar.Position.X, chosenEnemy.Position.Y-legionFamiliar.Position.Y)								
				local xDistance = chosenEnemy.Position.X-legionFamiliar.Position.X
				local yDistance = chosenEnemy.Position.Y-legionFamiliar.Position.Y
				local distance = math.abs(math.sqrt(xDistance^2 + yDistance^2)) --Look ma! I used the distance formula! Thanks, Algebra II :)
				local legionData = familiar:GetData()				
				legionData.Laser = player:FireBrimstone(direction)
				legionData.Laser.Parent = legionFamiliar
				legionData.Laser.Position = garden.LEGION_SPAWN_POSITION								
				local black = Color(0, 0, 0, 255, 0, 0, 0)
				legionData.Laser.Color = black
				legionData.Laser.Timeout = 1
				legionData.Laser.RenderZOffset = -5000 --Below characters
				legionData.Laser.MaxDistance = distance
				legionData.Laser.OneHit = true  --Weakens the brimstone significantly
				legionData.FireDirection = direction --Fires the laser				
			end
		end
	end
end
