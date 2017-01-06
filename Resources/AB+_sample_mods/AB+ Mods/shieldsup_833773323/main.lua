local	MyMod = RegisterMod( "Shields Up!", 1 );
local	ShieldsUpTrinket = Isaac.GetTrinketIdByName( "Shields Up!" );

function MyMod:TriggerShield(Entity, Damage, Flags, Source, DamageCountdown)
  if Entity:ToPlayer():HasTrinket(ShieldsUpTrinket) and math.random(5) == 1 then
    Entity:ToPlayer():GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS, true)
  end
end

MyMod:AddCallback( ModCallbacks.MC_ENTITY_TAKE_DMG, MyMod.TriggerShield, EntityType.ENTITY_PLAYER );