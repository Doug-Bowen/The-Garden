--------------------
--Room Controllers--
--------------------

function garden:gardenRoomUpdate()
	local currentLevel = Game():GetLevel()	
	local roomDesc = currentLevel:GetCurrentRoomDesc()	
	local currentRoom = Game():GetRoom()	
	if roomDesc.Data.Name == "The_Garden" then  --Player is in a Garden
		if currentRoom:GetFrameCount() == 1 then  --Player just walked into a Garden					
			MusicManager():Play(42,0.6)  --Play Garden_Drone.ogg
			SFXManager():Play("173", 0.4, 0, true, 1) -- loop soft ambience
			if garden.VISIT_NUMBER == 0 then      --Player has never been in this Garden			
				garden.FIGHT_CAN_START = true							
				garden.GARDEN_HEARTS_CAN_SPAWN = true

				--Handle Heart Spawning
				if garden.GARDEN_HEARTS_CAN_SPAWN then
					garden.GARDEN_HEARTS_CAN_SPAWN = false
					if math.random(4) == 1 then  --Spawn Hearts (25% chance)
						local roomCenter = currentRoom:GetCenterPos()
						local leftHeartPosition = Vector(roomCenter.X-100, roomCenter.Y)
						local rightHeartPosition = Vector(roomCenter.X+100, roomCenter.Y)
						local velocity = Vector(0,0)
						local spawnOwner = Isaac.GetPlayer(0)
						local leftHeart = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, leftHeartPosition, velocity, spawnOwner) 	
						local rightHeart = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, rightHeartPosition, velocity, spawnOwner) 
						leftHeart.RenderZOffset = -5000 --This should be below characters in the room
						rightHeart.RenderZOffset = -5000
					end
				end						
			end

			garden.VISIT_NUMBER = garden.VISIT_NUMBER + 1

			--Render Tree Sprite
			local roomCenter = currentRoom:GetCenterPos()			
			Isaac.GridSpawn(GridEntityType.GRID_PIT, 0, roomCenter, true)
			garden.TREE_LOCATION = Vector(roomCenter.X, roomCenter.Y+10)			
			garden.TREE_SHELL = Isaac.Spawn(garden.TREE_TYPE, garden.TREE_VARIANT, garden.TREE_SUBTYPE, garden.TREE_LOCATION, garden.TREE_VELOCITY, garden.TREE_SPAWN_OWNER)
			local patch = Isaac.Spawn(garden.TREE_TYPE, garden.PATCH_VARIANT, garden.TREE_SUBTYPE, garden.TREE_LOCATION, garden.TREE_VELOCITY, garden.TREE_SPAWN_OWNER)
			patch.RenderZOffset = -5000

			--Render grass
			local position = nil
			local grassSprite = nil
			local velocity = Vector(0,0)
			local spawnOwner = nil
			for i = 1, math.random(13) do
				position = currentRoom:GetRandomPosition(0)
				garden.GRASS_SHELL = Isaac.Spawn(garden.GRASS_TYPE, garden.GRASS_VARIANT, garden.GRASS_SUBTYPE, position, velocity, spawnOwner)
				garden.GRASS_SHELL.RenderZOffset = -5000			
				grassSprite = garden.GRASS_SHELL:GetSprite() 
				grassSprite:Load("gfx/grass.anm2", true)
				local randomGrass = math.random(13)
				if randomGrass == 1 then							
					grassSprite:Play("GrassA", true)
				elseif randomGrass == 2 then
					grassSprite:Play("GrassB", true)
				elseif randomGrass == 3 then
					grassSprite:Play("GrassC", true)
				elseif randomGrass == 4 then
					grassSprite:Play("GrassD", true)
				elseif randomGrass == 5 then
					grassSprite:Play("GrassE", true)
				elseif randomGrass == 6 then
					grassSprite:Play("GrassF", true)
				elseif randomGrass == 7 then
					grassSprite:Play("GrassG", true)
				elseif randomGrass == 8 then
					grassSprite:Play("GrassH", true)
				elseif randomGrass == 9 then
					grassSprite:Play("GrassI", true)
				elseif randomGrass == 10 then
					grassSprite:Play("GrassJ", true)
				elseif randomGrass == 11 then
					grassSprite:Play("GrassK", true)
				elseif randomGrass == 12 then
					grassSprite:Play("GrassL", true)
				elseif randomGrass == 13 then
					grassSprite:Play("GrassM", true)
				end
			end
		end	

		--Checks before Wave 1
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		local roomCenter = currentRoom:GetCenterPos()
		local positionalDifference = Vector(playerPosition.X-roomCenter.X, playerPosition.Y-roomCenter.Y)
		if math.abs(positionalDifference.X) < 75 and math.abs(positionalDifference.Y) < 40 then
			if garden.FIGHT_CAN_START then
				
				MusicManager():Play(43,0.3) --Play Garden_Serpent.ogg				
				garden.SERPENT_LOCATION = Vector(roomCenter.X, roomCenter.Y+100)				
				Game():ShakeScreen(12)
				
				--Spawn Wave 1 (Pin)				
				Isaac.Spawn(garden.SERPENT_TYPE, garden.SERPENT_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								

				--play sfx here (Curse_of_Mortality.wav)
				SFXManager():Play("172", 8, 0, false, 1)  
				
				garden.WAVE_NUMBER = 1
				garden.FIGHT_CAN_START = false												
				garden.barCurrentRoomDoors()				
			end				
		end

		
		--Checks during Wave 1
		local bossAlive = false
		if garden.WAVE_NUMBER == 1 then
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity.Type == garden.SERPENT_TYPE then	
					bossAlive = true
				end
			end

			if not bossAlive then
				garden.SERPENT_LOCATION = Vector(roomCenter.X, roomCenter.Y+100)		
				local randomNum = math.random(5,12)
				for i=1, randomNum do
					Isaac.Spawn(garden.SERPENT_HOLLOW_TYPE, garden.SERPENT_HOLLOW_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
				end
				local babySnakeLeftPosition = Vector(roomCenter.X+100,roomCenter.Y)
				local babySnakeRightPosition = Vector(roomCenter.X-100,roomCenter.Y)
				Isaac.Spawn(garden.SERPENT_BABY_TYPE, garden.SERPENT_BABY_VARIANT, 0, babySnakeLeftPosition, Vector(0,0), nil)								
				Isaac.Spawn(garden.SERPENT_BABY_TYPE, garden.SERPENT_BABY_VARIANT, 0, babySnakeRightPosition, Vector(0,0), nil)								
				SFXManager():Stop("173") -- Stop jungle sounds
				SFXManager():Play("172", 8, 0, false, 1)  
				garden.WAVE_NUMBER = 2																	
			end
		end		

		--Checks during Wave 2
		bossAlive = false
		if garden.WAVE_NUMBER == 2 then
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity.Type == garden.SERPENT_HOLLOW_TYPE then	
					bossAlive = true
				end
			end

			if not bossAlive then
				garden.SERPENT_LOCATION = Vector(roomCenter.X, roomCenter.Y+100)		
				local randomNum = math.random(5,12)
				for i=1, randomNum do					
					Isaac.Spawn(garden.SERPENT_LARRY_TYPE, garden.SERPENT_LARRY_VARIANT, 1, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
				end
				local ladyBugLeftPosition = Vector(roomCenter.X+100,roomCenter.Y)
				local ladyBugRightPosition = Vector(roomCenter.X-100,roomCenter.Y)
				Isaac.Spawn(garden.LADY_BUG_TYPE, garden.LADY_BUG_VARIANT, 0, ladyBugLeftPosition, Vector(0,0), nil)								
				Isaac.Spawn(garden.LADY_BUG_TYPE, garden.LADY_BUG_VARIANT, 0, ladyBugRightPosition, Vector(0,0), nil)								
				SFXManager():Play("172", 8, 0, false, 1) 
				garden.WAVE_NUMBER = 3																	
			end
		end		

		--Checks during Wave 3
		bossAlive = false
		if garden.WAVE_NUMBER == 3 then 
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity.Type == garden.SERPENT_LARRY_TYPE then	
					bossAlive = true
				end
			end

			if not bossAlive and not garden.ITEM_REWARDED then
				garden.openCurrentRoomDoors()						 
				garden.applyMortalityCurse()
				
				SFXManager():Play(SoundEffect.SOUND_HOLY, 8, 0, false, 1) 
				MusicManager():Play(44,0.3) --Play Garden_Holy.ogg
				
				local roomCenter = currentRoom:GetCenterPos()
				local initialStep = 0 --Not sure what this does
				local avoidActiveEnemies = true
				local startingPosition = Vector(roomCenter.X,roomCenter.Y+90)
				local pickupPosition = currentRoom:FindFreePickupSpawnPosition(startingPosition, initialStep, avoidActiveEnemies)
				local velocity = Vector(0,0)
				local spawnOwner = nil
				local randomNumber = math.random(13) 
				local randomItem = garden.gardenPool[randomNumber]			
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner)
				garden.ITEM_REWARDED = true
				table.remove(garden.gardenPool,randomNumber) --Remove the item from the pool																				
			end
		end
	end
end

function garden:openCurrentRoomDoors()
	local currentRoom = Game():GetRoom()
	for i = 0, DoorSlot.NUM_DOOR_SLOTS-1 do
	local door = currentRoom:GetDoor(i)
		if door ~= nil then
	    	door:Open() 
		end
	end
end

function garden:barCurrentRoomDoors()
	local currentRoom = Game():GetRoom()
	for i = 0, DoorSlot.NUM_DOOR_SLOTS-1 do
	local door = currentRoom:GetDoor(i)
		if door ~= nil then
	    	door:Bar() 
		end
	end
end