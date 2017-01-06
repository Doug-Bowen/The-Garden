-- To test our pill:
-- start a run with the mod enabled in the mods menu
-- open the debug console
-- Type "giveitem p47" for example
-- You will need to find the pill id by trial and error if you have other pill mods installed or if pills were added to the base game.
-- "g" works as a shorthand for "giveitem"
-- type "spawn 33"
-- close the debug console (hit enter without typing anything)
-- use the pill

-- get creative with "giveitem Placebo" (make sure you type a capital P) and "debug 8" for some real fun


-- This line allows us to use ZeroBrane Studio to attach a debugger and step through the code line by line after launching AB+
-- Note that the debugger is only available if AB+ was launched with the --luadebug option. In Steam: isaac properties > set launch options
require('mobdebug').start()

-- RegisterMod gives us an object that manages the mod's callbacks and save data. The name doesn't have to match your mod name, it's just there in case you need to identify it in a script.
local myMod = RegisterMod("Really Bad Gas", 1);

function ExplodeEntity(entity)
  -- Spawn an explosion at each fireplace's position. 
  -- Set the fireplace as the spawner so the death portrait a fire in case the player dies in the explosion.
  Isaac.Explode(entity.Position, entity, 40.0);
  
  -- We need to damage the entity manually since entities are immune to explosion damage where they are the source.
  local dmgref = EntityRef(entity);
  entity:TakeDamage(40, DamageFlag.DAMAGE_EXPLOSION, dmgref, 30);
end

function myMod:PillCallback(pillId)
  -- Get the main player (ignore co-op players)
  local player = Isaac.GetPlayer(0);

  -- Spawn a single fart at the player's position
  local fart = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FART, 0, player.Position, Vector(0, 0), player);
  
  local entities = Isaac.GetRoomEntities();

  for i = 1, #entities do
    -- We need to cast the entity to an Entity_NPC to access its AI state
    local npc = entities[i]:ToNPC();
    
    -- Make sure the cast to NPC was successful
    if npc then
      if npc.Type == EntityType.ENTITY_FIREPLACE then

        -- All fireplaces will explode --------------------------------------
        
        -- For most entities, "not npc:IsDead()" would work here.
        -- Fireplaces are an odd case where they don't die, they just check their hit points and change their state.
        -- alive: NpcState.STATE_ATTACK; dead: NpcState.STATE_IDLE
        local fireplaceAlive = not (npc.State == NpcState.STATE_IDLE);
        
        -- Alive and dead fireplace states were determined using this line:
        -- Isaac.DebugString("Fireplace state: " .. tostring(npc.State));
        
        if fireplaceAlive then
          ExplodeEntity(npc);
        end
      elseif npc:HasEntityFlags(EntityFlag.FLAG_BURN) then

        -- Entities that have the 'on fire' status effect also explode --------------------------------------

        ExplodeEntity(npc);
      elseif (npc.Type == EntityType.ENTITY_GAPER         and npc.Variant == 2) or
             (npc.Type == EntityType.ENTITY_FLAMINGHOPPER and npc.Variant == 0) or
             (npc.Type == EntityType.ENTITY_FATTY         and npc.Variant == 2)
      then
        -- A few special cases for "flaming" versions of enemies from burning basement. --------------------------------------
        ExplodeEntity(npc);
      end
    elseif entities[i].Type == EntityType.ENTITY_EFFECT then
      local effect = entities[i];

      -- More special cases for fire-based effect entities --------------------------------------

      if effect.Variant == EffectVariant.BLUE_FLAME or 
         effect.Variant == EffectVariant.HOT_BOMB_FIRE or 
         effect.Variant == EffectVariant.RED_CANDLE_FLAME 
      then
        ExplodeEntity(effect);
        -- Remove the effect after exploding it since taking damage doesn't kill effect entities
        effect:Remove();
      end
    elseif entities[i].Type == EntityType.ENTITY_PROJECTILE and entities[i].Variant == 2 then

      -- A few enemies can shoot Fire projectiles, such as The Gate and Mega Stan! --------------------------------------

      ExplodeEntity(entities[i]);
      entities[i]:Remove();
    end
  end
end

-- Tell the game to call our callback when the "Really Bad Gas" pill (as specified in pocketitems.xml) is used
myMod:AddCallback(ModCallbacks.MC_USE_PILL, myMod.PillCallback, Isaac.GetPillEffectByName("Really Bad Gas"));
