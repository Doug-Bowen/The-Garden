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
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		local roomCenter = currentRoom:GetCenterPos()
		local positionalDifference = Vector(playerPosition.X-roomCenter.X, playerPosition.Y-roomCenter.Y)
		if math.abs(positionalDifference.X) < 20 and math.abs(positionalDifference.Y) < 20 then
			--Isaac.RenderText("YOU ARE IN THE CENTER", 50, 25, 255, 255, 255, 255)
			if(pinHasSpawned == false) then
				Isaac.Spawn(EntityType.ENTITY_PIN, 1, 1, Vector(roomCenter.X, roomCenter.Y+100), Vector(0,0), Isaac.GetPlayer(0));	
				pinHasSpawned = true
			end				
		end

		--local doorState = currentRoom.DoorState		
	end
end

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.gardenRoomUpdate)