local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

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

function garden:shameEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_SHAME) then
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity:IsVulnerableEnemy() then
				--Isaac.RenderText("Testing Shame", 50, 15, 255, 255, 255, 255)
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

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect) --This callback is for checking per frame