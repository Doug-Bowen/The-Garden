StartDebug()
--local debugFile = io.open("Log-TheGarden.txt", "w")
local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

local forbiddenFruitItem = Isaac.GetItemIdByName("Forbidden Fruit")
local deceptionItem = Isaac.GetItemIdByName("Deception")
local grantedDomainItem = Isaac.GetItemIdByName("Granted Domain")
local theWillOfManItem = Isaac.GetItemIdByName("The Will of Man")
local theFallOfManItem = Isaac.GetItemIdByName("The Fall of Man")
local rebirthItem = Isaac.GetItemIdByName("Rebirth")
local exiledItem = Isaac.GetItemIdByName("Exiled")
local miracleGrowItem = Isaac.GetItemIdByName("MiracleGrow")
local genesisChallengeId = Isaac.GetChallengeIdByName("Genesis")

function garden:shameEffect()
	local player = Isaac.GetPlayer(0)
	local shameItem = Isaac.GetItemIdByName("Shame")
	if player:HasCollectible(shameItem) then
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity:IsVulnerableEnemy() then
				--Isaac.RenderText("Testing Shame", 50, 15, 255, 255, 255, 255)
				local playerPosition = player.Position
				local entityPosition = singleEntity.Position
				local playerXCoord = playerPosition.X
				local playerYCoord = playerPosition.Y
				local entityXCoord = entityPosition.X
				local entityYCoord = entityPosition.Y
				local positionalDifference = Vector(playerXCoord-entityXCoord,playerYCoord-entityYCoord)
				if math.abs(positionalDifference.X) < 60 and math.abs(positionalDifference.Y) < 60 then
					singleEntity:AddFear(EntityRef(player), 4)		
				end
			end
		end
	end
end

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect) --This callback is for checking per frame