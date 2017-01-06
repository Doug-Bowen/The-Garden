require('mobdebug').start()

local myMod = RegisterMod("The-Garden", 1)

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