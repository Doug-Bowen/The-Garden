require("mobdebug").start()

-- Register mod
local PoopingMod = RegisterMod("PoopingMod");

-- Filtered callback for NPCUpdate
function PoopingMod:NPCUpdate( npc )
  -- Random poop attack
  if npc.State == NpcState.STATE_IDLE and math.random(5) == 1 then
    npc.State = NpcState.STATE_ATTACK2
  elseif npc.State == NpcState.STATE_ATTACK2 then
    -- Plant a poop each 5 frames
    if npc.StateFrame % 5 == 0 then
      local pos = Isaac.GetFreeNearPosition(npc.Position, 80.0)
      Isaac.GridSpawn(GridEntityType.GRID_POOP, 0, pos, false)
    end
    npc.StateFrame = npc.StateFrame + 1
    -- Back to idle, clear the StateFrame
    if npc.StateFrame > 30 then
      npc.State = NpcState.STATE_IDLE
      npc.StateFrame = 0
    end
  end
    
end

-- Register the callback
PoopingMod:AddCallback( ModCallbacks.MC_NPC_UPDATE, PoopingMod.NPCUpdate, EntityType.ENTITY_MONSTRO);