local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

local gardenPool = {
	garden.COLLECTIBLE_SHAME = Isaac.GetItemIdByName("Shame")
	garden.COLLECTIBLE_FORBIDDEN_FRUIT = Isaac.GetItemIdByName("Forbidden Fruit")
	garden.COLLECTIBLE_DECEPTION = Isaac.GetItemIdByName("Deception")
	garden.COLLECTIBLE_GRANTED_DOMAIN = Isaac.GetItemIdByName("Granted Domain")
	garden.COLLECTIBLE_THE_WILL_OF_MAN = Isaac.GetItemIdByName("The Will of Man")
	garden.COLLECTIBLE_THE_FALL_OF_MAN = Isaac.GetItemIdByName("The Fall of Man")
	garden.COLLECTIBLE_REBIRTH = Isaac.GetItemIdByName("Rebirth")
	garden.COLLECTIBLE_EXILED = Isaac.GetItemIdByName("Exiled")
	garden.COLLECTIBLE_MIRACLE_GROW = Isaac.GetItemIdByName("MiracleGrow")
	garden.CHALLENGE_GENISIS = Isaac.GetChallengeIdByName("Genesis")
}

function garden:shameEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.gardenPool.COLLECTIBLE_SHAME) then
		--shameItem = Config:Item:Name("Shame")
		--Game():GetPlayer(0):AddCostume(shameItem)
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity:IsVulnerableEnemy() then		
				local playerPosition = player.Position
				local entityPosition = singleEntity.Position
				local positionalDifference = Vector(playerPosition.X-entityPosition.X, playerPosition.Y-entityPosition.Y)
				if math.abs(positionalDifference.X) < 60 and math.abs(positionalDifference.Y) < 60 then
					singleEntity:AddFear(EntityRef(player), 4)						
				end
			end
		end
	end
end

function garden:gardenRoomUpdate()
	local currentRoom = Game():GetRoom()
	--local roomType = currentRoom:GetType()	
	local currentRoomIndex = Level:GetCurrentRoomIndex()
	Isaac.RenderText(currentRoomIndex, 300, 15, 255, 255, 255, 255)		
	if currentRoomIndex == 99 then -- Player is in The Garden
		if currentRoom:isInitialized() then --Enable The Serpent fight, generate possible hearts
			--spawn a tree sprite in the middle of the room
			local serpentCanSpawn = true			
			local serpentHasSpawned = false			
			--play sfx here (Garden_Difficulty.wav)
			--play music here (Garden_Drone.wav)
			--play quieter music here (Garden_Ambience.wav)  
			local randomNum = math.random(1,4)
			if randomNum == 4 then --Spawn Eternal Hearts
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
					itemPedestal:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.gardenPool.COLLECTIBLE_EXILED, keepPrice) -- this should reroll
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

		--local doorState = currentRoom.DoorState		
	end
end

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.gardenRoomUpdate)