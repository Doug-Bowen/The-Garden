require('mobdebug').start()

local debugFile = io.open("Log-TheGarden.txt", "w")

local theGarden = RegisterMod("TheGarden", 1)
local shame = Isaac.GetItemIdByName("Shame")
local forbiddenFruit = Isaac.GetItemIdByName("Forbidden Fruit")
local deception = Isaac.GetItemIdByName("Deception")
local grantedDomain = Isaac.GetItemIdByName("Granted Domain")
local theWillOfMan = Isaac.GetItemIdByName("The Will of Man")
local theFallOfMan = Isaac.GetItemIdByName("The Fall of Man")
local rebirth = Isaac.GetItemIdByName("Rebirth")
local exiled = Isaac.GetItemIdByName("Exiled")
local miracleGrow = Isaac.GetItemIdByName("MiracleGrow")

function myMod:PlayerInit(aConstPlayer)
end

function myMod:Text()
end

function myMod:TakeDamage(aEntity)
end

function myMod:PostUpdate()
end

function myMod:PostPerfectUpdate(aConstPlayer)
end

function myMod:NpcUpdate(aNpc)
end

function myMod:PostRender()
end

myMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, myMod.PlayerInit)
myMod:AddCallback(ModCallbacks.MC_POST_RENDER, myMod.Text)
myMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, myMod.TakeDamage)
myMod:AddCallback(ModCallbacks.MC_POST_UPDATE, myMod.PostUpdate)
myMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, myMod.PostPerfectUpdate)
myMod:AddCallback(ModCallbacks.MC_POST_RENDER, myMod.PostRender)
myMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, myMod.NpcUpdate)