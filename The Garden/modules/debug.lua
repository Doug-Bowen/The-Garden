---------
--Debug--
---------

function garden:debugMode()
	if garden.DEBUG_MODE then
		Isaac.RenderText("Debug Mode", 50, 15, 255, 255, 255, 255)		
		local currentGame = Game()
		--local currentLevel = currentGame:GetLevel()		
		local currentRoom = Game():GetRoom()
		--local player = Isaac.GetPlayer(0)
		--local playerPosition = player.Position						
		--Isaac.RenderText("X:" .. playerPosition.X, 50, 30, 255, 255, 255, 255)
		--Isaac.RenderText("Variant:" .. player.Variant, 50, 30, 255, 255, 255, 255)
		--Isaac.RenderText("SubType:" .. player.SubType, 50, 45, 255, 255, 255, 255)
		local backDrop = currentRoom:GetBackdropType()
		if backDrop ~= nil then
			Isaac.RenderText("Backdrop:" .. backDrop, 50, 30, 255, 255, 255, 255)
		else
			Isaac.RenderText("Backdrop: nil", 50, 30, 255, 255, 255, 255)
		end
		
		if Game():GetFrameCount() == 1 then
			local currentRoom = Game():GetRoom()
			local roomCenter = currentRoom:GetCenterPos()
			for i = 1, #garden.gardenPool do
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.gardenPool[i], currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)												
			end
		end		
	end
end