require('mobdebug').start()

local debugFile = io.open("Log-TheGarden.txt", "w")

local theGardenMod = RegisterMod("TheGarden", 1)
local shameItem = Isaac.GetItemIdByName("Shame")
local forbiddenFruitItem = Isaac.GetItemIdByName("Forbidden Fruit")
local deceptionItem = Isaac.GetItemIdByName("Deception")
local grantedDomainItem = Isaac.GetItemIdByName("Granted Domain")
local theWillOfManItem = Isaac.GetItemIdByName("The Will of Man")
local theFallOfManItem = Isaac.GetItemIdByName("The Fall of Man")
local rebirthItem = Isaac.GetItemIdByName("Rebirth")
local exiledItem = Isaac.GetItemIdByName("Exiled")
local miracleGrowItem = Isaac.GetItemIdByName("MiracleGrow")
local genesisChallengeId = Isaac.GetChallengeIdByName("Genesis");

function useShameItem()
--Placeholder code
	local player = Isaac.GetPlayer(0);	
	local pos = Isaac.GetFreeNearPosition(player.Position, 1);
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, debuggingItem, pos, pos, player);
	Isaac.DebugString("[DEBUG FLAG] You used Shame")	
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, useShameItem, shameItem);