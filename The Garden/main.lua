local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

--Isaac.DebugString(RNG:GetSeed()) --Should output the seed to the log

garden.COLLECTIBLE_SHAME = Isaac.GetItemIdByName("Shame")
garden.COLLECTIBLE_FORBIDDEN_FRUIT = Isaac.GetItemIdByName("Forbidden Fruit")
garden.COLLECTIBLE_DECEPTION = Isaac.GetItemIdByName("Deception")
garden.COLLECTIBLE_GRANTED_DOMAIN = Isaac.GetItemIdByName("Granted Domain")
garden.COLLECTIBLE_THE_WILL_OF_MAN = Isaac.GetItemIdByName("The Will of Man")
garden.COLLECTIBLE_THE_FALL_OF_MAN = Isaac.GetItemIdByName("The Fall of Man")
garden.COLLECTIBLE_REBIRTH = Isaac.GetItemIdByName("Rebirth")
garden.COLLECTIBLE_EXILED = Isaac.GetItemIdByName("Exiled")
garden.COLLECTIBLE_THE_FIRST_DAY = Isaac.GetItemIdByName("The First Day")
garden.COLLECTIBLE_MIRACLE_GROW = Isaac.GetItemIdByName("MiracleGrow")

garden.HAS_FORBIDDEN_FRUIT = false
garden.HAS_SHAME = false
garden.HAS_DECEPTION = false
garden.HAS_GRANTED_DOMAIN = false
garden.HAS_THE_WILL_OF_MAN = false
garden.HAS_THE_FALL_OF_MAN = false
garden.HAS_REBIRTH = false
garden.HAS_EXILED = false
garden.HAS_THE_FIRST_DAY = false
garden.HAS_MIRACLE_GROW = false

garden.COSTUME_ID_SHAME = Isaac.GetCostumeIdByPath("gfx/characters/shame.anm2")
garden.COSTUME_ID_FORBIDDEN_FRUIT = Isaac.GetCostumeIdByPath("gfx/characters/forbidden_fruit.anm2")
garden.COSTUME_ID_DECEPTION = Isaac.GetCostumeIdByPath("gfx/characters/deception.anm2")
garden.COSTUME_ID_GRANTED_DOMAIN = Isaac.GetCostumeIdByPath("gfx/characters/granted_domain.anm2")
garden.COSTUME_ID_THE_WILL_OF_MAN = Isaac.GetCostumeIdByPath("gfx/characters/the_will_of_man.anm2")
garden.COSTUME_ID_REBIRTH = Isaac.GetCostumeIdByPath("gfx/characters/rebirth.anm2")
garden.COSTUME_ID_EXILED = Isaac.GetCostumeIdByPath("gfx/characters/exiled.anm2")
garden.COSTUME_ID_THE_FIRST_DAY = Isaac.GetCostumeIdByPath("gfx/characters/the_first_day.anm2")
garden.COSTUME_ID_MIRACLE_GROW = Isaac.GetCostumeIdByPath("gfx/characters/miracle_grow.anm2")

garden.HEARTS_CAN_SPAWN = true
garden.SERPENT_CAN_SPAWN = true
garden.SERPENT_HAS_SPAWNED = false
garden.SERPENT_HAS_DIED = false
garden.VISIT_NUMBER = 0
garden.ROOM_WILL_REROLL = true
garden.ITEM_REWARDED = false

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
	local gardenRoomIndex = -3
	--Isaac.RenderText(garden.VISIT_NUMBER, 50, 15, 255, 255, 255, 255)		
	if currentRoomIndex~= nil and currentRoomIndex == gardenRoomIndex then -- Player is in a Garden
		if currentRoom:GetFrameCount() == 1 then --Player just walked into a Garden
			--Force items to be exiled on 3rd visit
			if not garden.ROOM_WILL_REROLL then
				local keepPrice = true
				itemPedestal:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_EXILED, keepPrice) -- this should reroll (might need to destry and respawn)			
			end

			if garden.VISIT_NUMBER == 0 then --Player has never been in this Garden			
				garden.ROOM_WILL_REROLL = true
				local SERPENT_CAN_SPAWN = true			
				local SERPENT_HAS_SPAWNED = false

				--Handle Eternal Heart Spawning
				if garden.HEARTS_CAN_SPAWN then
					local randomNum = math.random(4)
					garden.HEARTS_CAN_SPAWN = false
					if randomNum == 1 then --Spawn Eternal Hearts (25% chance)
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
			--Spawn a tree sprite in the middle of the room
			--local treeSprite = Sprite() 
			--treeSprite:Load("gfx/effects/treeSprite.png",true)
			--treeSprite:Play("Still",true)		
			--local roomCenter = currentRoom:GetCenterPos()
			--local topLeftClamp = roomCenter
			--local bottomRightClamp = roomCenter
			--treeSprite:Render(roomCenter, topLeftClamp, bottomRightClamp)

			--Handle the music for the room
			--play sfx here (Garden_Difficulty.wav)
			--play music here (Garden_Drone.ogg)
			--play quieter music here (Garden_Ambience.ogg)  

			--Reroll item pedestals in the room right when you walk in (visit 1 and 2)
			if garden.ROOM_WILL_REROLL and garden.VISIT_NUMBER <=2 then
				local entities = Isaac.GetRoomEntities() 
				for i = 1, #entities do
					local singleEntity = entities[i]
		 			if singleEntity.SubType == PickupVariant.PICKUP_COLLECTIBLE then
						local itemPedestal = singleEntity
						local randomItem = 0
						local keepPrice = true
						itemPedestal:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, keepPrice) -- this should reroll (might need to destry and respawn)
						if garden.VISIT_NUMBER == 2 then
							garden.ROOM_WILL_REROLL = false 
						end					
					end
				end
			end				
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
				local velocity = Vector(0,0)
				local spawnOwner = Isaac.GetPlayer(0)				
				Isaac.Spawn(EntityType.ENTITY_PIN, 0, 0, serpentSpawnPosition, velocity, spawnOwner)	
				garden.SERPENT_CAN_SPAWN = false
				garden.SERPENT_HAS_SPAWNED = true
				garden.closeCurrentRoomDoors()
			end				
		end

		if garden.SERPENT_HAS_SPAWNED then
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity:IsBoss() then
					if singleEntity:IsDead() then
						garden.SERPENT_HAS_DIED = true
						garden.openCurrentRoomDoors()
					end
				end
			end
		end

		--If the player has beaten The Serpent
		if garden.SERPENT_HAS_DIED and not garden.ITEM_REWARDED then
			--play sfx here (meaty deaths 3.wav) --might not need this, pin ming play his own death sound
			--play sfx here (holy!.wav)
			--change music here (Garden_Holy.ogg)
			local pickupPosition = currentRoom:GetCenterPos()
			local velocity = Vector(0,0)
			local spawnOwner = nil
			local randomItem = 0
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner)
			garden.ITEM_REWARDED = true
		end
	end

	if not garden.ROOM_WILL_REROLL then
		Isaac.RenderText("Will not reroll", 15, 25, 255, 255, 255, 255)
	end

	if garden.ROOM_WILL_REROLL then
		Isaac.RenderText("Will reroll", 15, 25, 255, 255, 255, 255)
	end

	--The player has left a Garden
	if currentRoomIndex ~= gardenRoomIndex and currentRoom:GetFrameCount() == 1 then
		local previousRoomIndex = currentLevel:GetPreviousRoomIndex()
		if previousRoomIndex~= nil and previousRoomIndex == gardenRoomIndex then 
			if garden.ROOM_WILL_REROLL == false then --This flag should only be false after 2 visits to a Garden
				local previousRoom = currentLevel:GetRoomByIdx(previousRoomIndex)
				local doors = previousRoom:GetDoor() --Might need a for() loop to close all doors -- might need GridEntityType.GRID_DOOR
				if not doors:IsOpen() then
					local forceClose = true
					doors:Close(forceClose)
					doors:CloseAnimation()					
				end				
				if not doors:IsLocked() then
					local locked = true
					doors:SetLocked(locked)
					doors:LockedAnimation()
					doors:Bar() --Not sure what this does
				end				
				
				--Reset flags for future Garden Rooms
				garden.SERPENT_CAN_SPAWN = true
				garden.SERPENT_HAS_SPAWNED = false
				garden.HEARTS_CAN_SPAWN = true 
				garden.VISIT_NUMBER = 0 
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

function garden:closeCurrentRoomDoors()
	local currentRoom = Game():GetRoom()
	for i = 0, DoorSlot.NUM_DOOR_SLOTS-1 do
	local door = currentRoom:GetDoor(i)
		if door ~= nil then
	    	door:Close() 
		end
	end
end

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.forbiddenFruitEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.deceptionEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.grantedDomainEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theWillOfManEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFallOfManEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.rebirthEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.exiledEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFirstDayEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.miracleGrowEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.gardenRoomUpdate)
