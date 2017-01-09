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
	if currentRoomIndex == -3 then -- Player is in The Garden
		if currentRoom:IsInitialized() then --Enable The Serpent fight, generate possible hearts
			
			--First, spawn a tree sprite in the middle of the room
			--local treeSprite = Sprite() 
			--treeSprite:Load("treeSprite.png",true);
			--treeSprite:Play("Still",true);			
			--local roomCenter = currentRoom:GetCenterPos()
			--local topLeftClamp = roomCenter
			--local bottomRightClamp = roomCenter
			--voidEffect:Render(roomCenter,topLeftClamp,bottomRightClamp)

			--Second, Handle the music for the room
			--play sfx here (Garden_Difficulty.wav)
			--play music here (Garden_Drone.wav)
			--play quieter music here (Garden_Ambience.wav)  

			--Third, Deal with the serpent
			local serpentCanSpawn = true			
			local serpentHasSpawned = false						
			
			--Fourth, Handl Eternal Heart Spawning
			local randomNum = math.random(4)
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

		--Reroll any item pedestals in the room (just once though)
		local entities = Isaac.GetRoomEntities() 
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity:IsCollectible() then
				local itemPedestal = singleEntity
				if itemPedestal:CanReroll() then --If the item in the room can be rerolled
					local randomItem = 0
					local keepPrice = true
					itemPedestal:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, keepPrice) -- this should reroll
					itemPedestal.CanReroll = false --not sure if this works
				elseif not itemPedestal:CanReroll() then --else, force the item to be Exiled
					itemPedestal:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.COLLECTIBLE_EXILED, keepPrice) -- this should reroll
				end
			end
		end			

		--Check if player is activating The Serpent fight
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		local roomCenter = currentRoom:GetCenterPos()
		local positionalDifference = Vector(playerPosition.X-roomCenter.X, playerPosition.Y-roomCenter.Y)
		if math.abs(positionalDifference.X) < 20 and math.abs(positionalDifference.Y) < 20 then
			--Isaac.RenderText("YOU ARE IN THE CENTER", 50, 25, 255, 255, 255, 255)
			if(serpentCanSpawn == true and serpentHasSpawned == false) then
				--change music here (Garden_Serpent.wav)
				local serpentSpawnPosition = Vector(roomCenter.X, roomCenter.Y+100)
				local velocity = Vector(0,0)
				local spawnOwner = Isaac.GetPlayer(0)				
				Isaac.Spawn(EntityType.ENTITY_PIN, 1, 1, serpentSpawnPosition, velocity, spawnOwner)	
				serpentCanSpawn = false
				serpentHasSpawned = true
			end				
		end

		--If the player has beaten The Serpent
		if currentRoom:isClear() then 
			--play sfx here (meaty deaths 3.wav) --might not need this, pin ming play his own death sound
			--play sfx here (holy!.wav)
			--change music here (Garden_Holy.wav)
			local pickupPosition = currentRoom:FindFreePickupSpawnPosition()
			local velocity = Vector(0,0)
			local spawnOwner = nil
			local randomItem = 0
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner) 
			--might need to open the doors, but pin might do that for us automatically though
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
