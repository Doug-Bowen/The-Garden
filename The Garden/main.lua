local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

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
--garden.COSTUME_ID_FORBIDDEN_FRUIT = Isaac.GetCostumeIdByPath("gfx/characters/forbidden_fruit.anm2")
--garden.COSTUME_ID_DECEPTION = Isaac.GetCostumeIdByPath("gfx/characters/deception.anm2")
--garden.COSTUME_ID_GRANTED_DOMAIN = Isaac.GetCostumeIdByPath("gfx/characters/granted_domain.anm2")
--garden.COSTUME_ID_THE_WILL_OF_MAN = Isaac.GetCostumeIdByPath("gfx/characters/the_will_of_man.anm2")
--garden.COSTUME_ID_REBIRTH = Isaac.GetCostumeIdByPath("gfx/characters/rebirth.anm2")
--garden.COSTUME_ID_EXILED = Isaac.GetCostumeIdByPath("gfx/characters/exiled.anm2")
--garden.COSTUME_ID_THE_FIRST_DAY = Isaac.GetCostumeIdByPath("gfx/characters/the_first_day.anm2")
--garden.COSTUME_ID_MIRACLE_GROW = Isaac.GetCostumeIdByPath("gfx/characters/miracle_grow.anm2")

garden.HEARTS_CAN_SPAWN = true
garden.SERPENT_CAN_SPAWN = true
garden.SERPENT_HAS_SPAWNED = true
garden.VISIT_NUMBER = 0
garden.ROOM_WILL_REROLL = true

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
				if math.abs(positionalDifference.X) < 60 and math.abs(positionalDifference.Y) < 60 then
					local fearWho = EntityRef(player)
					local fearDuration = 4
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
end

function garden:rebirthEffect()
end

function garden:exiledEffect()
end

function garden:theFirstDayEffect()
end

function garden:miracleGrowEffect()
end

function garden:gardenRoomUpdate()
	local currentLevel = Game():GetLevel()	
	local currentRoomIndex = currentLevel:GetCurrentRoomIndex()
	local currentRoom = Game():GetRoom()
	--Isaac.RenderText(currentRoomIndex, 50, 15, 255, 255, 255, 255)		
	if currentRoomIndex == -3 then -- Player is in a Garden
		if currentRoom:GetFrameCount() == 1 then --Player just walked into a Garden
			if garden.VISIT_NUMBER == 0 --Player has never been in this Garden			
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

			garden.VISIT_NUMBER++
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

			--Force items to be exiled on 3rd visit
			if not garden.ROOM_WILL_REROLL then
				local keepPrice = true
				itemPedestal:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_EXILED, keepPrice) -- this should reroll (might need to destry and respawn)			
			end

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
			Isaac.RenderText("SERPENT SPAWNED!", 50, 25, 255, 255, 255, 255)
			if(serpentCanSpawn == true and serpentHasSpawned == false) then
				--change music here (Garden_Serpent.ogg)
				local serpentSpawnPosition = Vector(roomCenter.X, roomCenter.Y+100)
				local velocity = Vector(0,0)
				local spawnOwner = Isaac.GetPlayer(0)				
				Isaac.Spawn(EntityType.ENTITY_PIN, 1, 1, serpentSpawnPosition, velocity, spawnOwner)	
				garden.SERPENT_CAN_SPAWN = false
				garden.SERPENT_HAS_SPAWNED = true
			end				
		end

		--If the player has beaten The Serpent
		if currentRoom:isClear() and not garden.SERPENT_CAN_SPAWN then 
			--play sfx here (meaty deaths 3.wav) --might not need this, pin ming play his own death sound
			--play sfx here (holy!.wav)
			--change music here (Garden_Holy.ogg)
			local pickupPosition = currentRoom:FindFreePickupSpawnPosition()
			local velocity = Vector(0,0)
			local spawnOwner = nil
			local randomItem = 0
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner)
			--might need to open the doors, but the serpent fight might do that for us automatically though
		end
	end

	--The player just left a Garden
	if currentRoomIndex ~= -3 and currentRoom:GetFrameCount() == 1 then
		local previousRoomIndex = currentLevel:GetPreviousRoomIndex() --THis might return nil
		if previousRoomIndex == -3 then 
			if garden.ROOM_WILL_REROLL == false then --This flag should only be false after 2 visits to a Garden
				garden.SERPENT_CAN_SPAWN = true
				garden.SERPENT_HAS_SPAWNED = false
				garden.HEARTS_CAN_SPAWN = true 
				-- Get the doors in the previous room
				-- Lock the doors in the previous room
				garden.VISIT_NUMBER = 0 --Reset this for future gardens
			end
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
