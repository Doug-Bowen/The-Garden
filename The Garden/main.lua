--require('mobdebug').start()
--local debugFile = io.open("Log-TheGarden.txt", "w")
local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

local shameItem = Isaac.GetItemIdByName("Shame")
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
	if player.HasCollectible(shameItem) then
		local playerPosition = Isaac.GetFreeNearPosition(player.Position, 1)
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			--if entities[i]:IsVulnerableEnemy() then
				--if entities[i]:TargetPosition() == playerPosition then				
					entities[i]:AddFear(EntityRef(player), 120)		
				--end
			--end
		end
	end
end

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect) --I believe this it an incorrect Mod Callback