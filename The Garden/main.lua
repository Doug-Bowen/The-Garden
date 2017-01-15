local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

--Debug Flag
garden.DEBUG_MODE = true

--Items
garden.COLLECTIBLE_SHAME = Isaac.GetItemIdByName("Shame")
garden.COLLECTIBLE_FORBIDDEN_FRUIT = Isaac.GetItemIdByName("Forbidden Fruit")
garden.COLLECTIBLE_DECEPTION = Isaac.GetItemIdByName("Deception")
garden.COLLECTIBLE_CREATION = Isaac.GetItemIdByName("Creation")
garden.COLLECTIBLE_GRANTED_DOMAIN = Isaac.GetItemIdByName("Granted Domain")
garden.COLLECTIBLE_THE_WILL_OF_MAN = Isaac.GetItemIdByName("The Will of Man")
garden.COLLECTIBLE_THE_FALL_OF_MAN = Isaac.GetItemIdByName("The Fall of Man")
garden.COLLECTIBLE_REBIRTH = Isaac.GetItemIdByName("Rebirth")
garden.COLLECTIBLE_EXILED = Isaac.GetItemIdByName("Exiled")
garden.COLLECTIBLE_THE_FIRST_DAY = Isaac.GetItemIdByName("The First Day")
garden.COLLECTIBLE_MIRACLE_GROW = Isaac.GetItemIdByName("Miracle Grow")

--Item Flags
garden.HAS_SHAME = false
garden.HAS_FORBIDDEN_FRUIT = false
garden.HAS_DECEPTION = false
garden.HAS_CREATION = false
garden.HAS_GRANTED_DOMAIN = false
garden.HAS_THE_WILL_OF_MAN = false
garden.HAS_THE_FALL_OF_MAN = false
garden.HAS_REBIRTH = false
garden.HAS_EXILED = false
garden.HAS_THE_FIRST_DAY = false
garden.HAS_MIRACLE_GROW = false

--Costumes
garden.COSTUME_ID_SHAME = Isaac.GetCostumeIdByPath("gfx/characters/shame.anm2")
garden.COSTUME_ID_FORBIDDEN_FRUIT = Isaac.GetCostumeIdByPath("gfx/characters/forbidden_fruit.anm2")
garden.COSTUME_ID_DECEPTION = Isaac.GetCostumeIdByPath("gfx/characters/deception.anm2")
garden.COSTUME_ID_CREATION = Isaac.GetCostumeIdByPath("gfx/characters/creation.anm2")
garden.COSTUME_ID_GRANTED_DOMAIN = Isaac.GetCostumeIdByPath("gfx/characters/granted_domain.anm2")
garden.COSTUME_ID_THE_WILL_OF_MAN = Isaac.GetCostumeIdByPath("gfx/characters/the_will_of_man.anm2")
garden.COSTUME_ID_THE_FALL_OF_MAN = Isaac.GetCostumeIdByPath("gfx/characters/the_falll_of_man.anm2")
garden.COSTUME_ID_REBIRTH = Isaac.GetCostumeIdByPath("gfx/characters/rebirth.anm2")
garden.COSTUME_ID_EXILED = Isaac.GetCostumeIdByPath("gfx/characters/exiled.anm2")
garden.COSTUME_ID_THE_FIRST_DAY = Isaac.GetCostumeIdByPath("gfx/characters/the_first_day.anm2")
garden.COSTUME_ID_MIRACLE_GROW = Isaac.GetCostumeIdByPath("gfx/characters/miracle_grow.anm2")

--Room Flags
garden.GARDEN_HEARTS_CAN_SPAWN = true
garden.SERPENT_CAN_SPAWN = true
garden.SERPENT_HAS_SPAWNED = false
garden.SERPENT_HAS_DIED = false
garden.VISIT_NUMBER = 0
garden.ITEM_REWARDED = false
garden.GARDEN_ROOM_INDEX = -3	

--Curses
garden.CURSE_MORTALITY = Isaac.GetCurseIdByName("Curse of Mortality") 
garden.HAS_MORTALITY_CURSE = false

--Entity for Tree Spawn
garden.nullSpawn = nil

function garden:debugMode()
	if garden.DEBUG_MODE then
		Isaac.RenderText("Debug Mode, VISIT NUMBER = ", 15, 50, 255, 0, 255, 0)		
		Isaac.RenderText(garden.VISIT_NUMBER, 50, 50, 255, 0, 255, 0)
		--Isaac.DebugString(RNG:GetSeed()) --Should output the seed to the log, just crashes though
		if Game():GetFrameCount() == 1 then
			local currentRoom = Game():GetRoom()
			local roomCenter = currentRoom:GetCenterPos()
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_SHAME, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_FORBIDDEN_FRUIT, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_DECEPTION, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_CREATION, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_GRANTED_DOMAIN, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_THE_WILL_OF_MAN, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_THE_FALL_OF_MAN, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_REBIRTH, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_EXILED, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_THE_FIRST_DAY, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_MIRACLE_GROW, currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
		end		
	end
end

function garden:newGame()
	if Game():GetFrameCount() == 1 then
	 	garden.VISIT_NUMBER = 0
	end
end

function garden:shameEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_SHAME) then		
		if not garden.HAS_SHAME then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_SHAME)
			garden.HAS_SHAME = true
		end
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity:IsVulnerableEnemy() then		
				local playerPosition = player.Position
				local entityPosition = singleEntity.Position
				local positionalDifference = Vector(playerPosition.X-entityPosition.X, playerPosition.Y-entityPosition.Y)
				if math.abs(positionalDifference.X) < 80 and math.abs(positionalDifference.Y) < 80 then
					local fearWho = EntityRef(player)
					local fearDuration = 5
					singleEntity:AddFear(fearWho, fearDuration)						
				end
			end
		end
	end
end

function garden:forbiddenFruitEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_FORBIDDEN_FRUIT) then		
		if not garden.HAS_FORBIDDEN_FRUIT then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_FORBIDDEN_FRUIT)
			garden.HAS_FORBIDDEN_FRUIT = true  
		end
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity.Type == EntityType.ENTITY_TEAR then			
				local currentSprite = singleEntity:GetSprite():GetFilename() 
				if currentSprite ~= "gfx/apple_one.anm2" and currentSprite ~= "gfx/apple_two.anm2" and currentSprite ~= "gfx/apple_three.anm2" and currentSprite ~= "gfx/apple_four.anm2" then
					
					--singleEntity:Remove() --Remove old tear to replace it
					--I DONT HTINK I SHOULD BE DOING THIS -- local newTear = Game():GetPlayer(0):FireTear(singleEntity.Position, singleEntity.Velocity, true, true, true)
					--Add effect here
					--newTear.Target:AddConfusion(EntityRef(player),100,false)

					local newTearSprite = singleEntity:GetSprite() 
					local randomAppleNum = math.random(4)				 
					if randomAppleNum == 1 then 
						newTearSprite:Load("gfx/apple_one.anm2", true)	
					end
					if randomAppleNum == 2 then
						newTearSprite:Load("gfx/apple_two.anm2", true)				
					end
					if randomAppleNum == 3 then
						newTearSprite:Load("gfx/apple_three.anm2", true)			
					end
					if randomAppleNum == 4 then
						newTearSprite:Load("gfx/apple_four.anm2", true)							
					end 
					newTearSprite:Play("Idle", true) --This is the name of the actual animation WITHIN the anm2 file!
				end		
			end
		end		
	end	
end

function garden:creationEffect()
end

function garden:deceptionEffect()
end

function garden:grantedDomainEffect()
end

function garden:theWillOfManEffect()
end

function garden:theFallOfManEffect()
	--use GridEntityDoor:TargetRoomType to possibly see the item/boss in the next room (not sure if this is possible) --or try searching the surrounding rooms looking for items or bosses and post that info on the wall
	--use entity:AddEntityFlags(FLAG_RENDER_WALL) to attempt to apply that item/boss to a wall
end

function garden:rebirthEffect()
end

function garden:exiledEffect()
end

function garden:theFirstDayEffect()
	--might be Level:AddAngelRoomChance
end

function garden:miracleGrowEffect()
end

function garden:gardenRoomUpdate()
	local currentLevel = Game():GetLevel()	
	local currentRoomIndex = currentLevel:GetCurrentRoomIndex()
	local currentRoom = Game():GetRoom()		
	if currentRoomIndex~= nil and currentRoomIndex == garden.GARDEN_ROOM_INDEX then --Player is in a Garden
		if currentRoom:GetFrameCount() == 1 then  --Player just walked into a Garden
			if garden.VISIT_NUMBER == 0 then --Player has never been in this Garden			
				garden.SERPENT_CAN_SPAWN = true			
				garden.SERPENT_HAS_SPAWNED = false
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
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, leftHeartPosition, velocity, spawnOwner) 	
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, rightHeartPosition, velocity, spawnOwner) 
					end
				end						
			end

			garden.VISIT_NUMBER = garden.VISIT_NUMBER + 1
			--Render Tree Sprite
			local roomCenter = currentRoom:GetCenterPos()
			local rockLocation = Vector(roomCenter.X,roomCenter.Y-30)
			Isaac.GridSpawn(GridEntityType.GRID_PIT, 0, rockLocation, true)
			local treeLocation = Vector(roomCenter.X, roomCenter.Y-100)
			local velocity = Vector(0,0)
			local spawnOwner = nil
			garden.nullSpawn = Isaac.Spawn(EntityType.ENTITY_EFFECT, 0, 0, treeLocation, velocity, spawnOwner)
			garden.nullSpawn.RenderZOffset = -69999
			local treeSprite = garden.nullSpawn:GetSprite()
			treeSprite:Load("gfx/tree.anm2",true)
			treeSprite:Play("Idle", true)		

			--Handle the music for the room			
			--play music here (Garden_Drone.ogg)
			--play quieter music here (Garden_Ambience.ogg)  
		end	

		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		Isaac.RenderText(playerPosition.X, 50, 15, 255, 255, 255, 255)
		Isaac.RenderText(playerPosition.Y, 50, 30, 255, 255, 255, 255)
		if playerPosition.Y>430 then
			garden.nullSpawn.RenderZOffset = 5000000
			--treeSprite:Load("gfx/tree.anm2",true)
			--treeSprite:Play("Idle", true)		
		end


		--Check if player is activating The Serpent fight
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		local roomCenter = currentRoom:GetCenterPos()
		local positionalDifference = Vector(playerPosition.X-roomCenter.X, playerPosition.Y-roomCenter.Y)
		if math.abs(positionalDifference.X) < 20 and math.abs(positionalDifference.Y) < 20 then
			if garden.SERPENT_CAN_SPAWN and not garden.SERPENT_HAS_SPAWNED then
				--change music here (Garden_Serpent.ogg)
				local serpentSpawnPosition = Vector(roomCenter.X, roomCenter.Y+100)
				local entityVariant = 0  --Can manipulate these values to spawn a different boss
				local entitySubtype = 0  --Can manipulate these values to spawn a different boss
				local velocity = Vector(0,0)
				local spawnOwner = Isaac.GetPlayer(0)				
				Isaac.Spawn(EntityType.ENTITY_PIN, entityVariant, entitySubtype, serpentSpawnPosition, velocity, spawnOwner) --Try a different spawnOwner and maybe the visual glitch wont happen?
				garden.SERPENT_CAN_SPAWN = false
				garden.SERPENT_HAS_SPAWNED = true			
				garden.barCurrentRoomDoors()				
			end				
		end

		--Check if player has killed The Serpent
		if garden.SERPENT_HAS_SPAWNED then
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity:IsBoss() then
					if singleEntity:IsDead() then
						garden.SERPENT_HAS_DIED = true
						garden.openCurrentRoomDoors()
						garden.applyMortalityCurse()
					end
				end
			end
		end 

		--If the player has beaten The Serpent
		if garden.SERPENT_HAS_DIED and not garden.ITEM_REWARDED then
			--currentRoom:PlayMusic() doesnt seem to do anything
			--play sfx here (meaty deaths 3.wav) --might not need this, pin might play his own death sound
			--play sfx here (holy!.wav)
			--change music here (Garden_Holy.ogg)
			local roomCenter = currentRoom:GetCenterPos()
			local initialStep = 0 --Not sure what this does
			local avoidActiveEnemies = true
			local pickupPosition = currentRoom:FindFreePickupSpawnPosition(roomCenter, initialStep, avoidActiveEnemies)
			local velocity = Vector(0,0)
			local spawnOwner = nil
			local randomItem = 0 -- technically we should use Game():GetItemPool() to return an item pool, however this does not work yet.
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner)
			garden.ITEM_REWARDED = true
		end
	end
end

function garden:applyMortalityCurse()
	local currentLevel = Game():GetLevel()	
	local showCurseName = true
	--play sfx here (Curse_of_Mortality.wav)
	currentLevel:AddCurse(garden.CURSE_MORTALITY, showCurseName)
	garden.HAS_MORTALITY_CURSE = true
end

function garden:removeMortalityCurse()
	local currentLevel = Game():GetLevel()		
	currentLevel:RemoveCurse(garden.CURSE_MORTALITY)
	garden.HAS_MORTALITY_CURSE = false
	garden.VISIT_NUMBER = 0	--Reset Gardens for this floor
end

function garden:mortalityCurseEffect()
	if garden.HAS_MORTALITY_CURSE then
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity.Variant == PickupVariant.PICKUP_HEART then				
				--make a 'poof'?
				singleEntity:Remove()					
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

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.debugMode)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.newGame)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.forbiddenFruitEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.creationEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.deceptionEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.grantedDomainEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theWillOfManEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFallOfManEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.rebirthEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.exiledEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFirstDayEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.miracleGrowEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.gardenRoomUpdate)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.mortalityCurseEffect)
garden:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, garden.removeMortalityCurse)