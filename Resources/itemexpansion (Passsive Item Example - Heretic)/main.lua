--[[Init--]]
local itemExpansion = RegisterMod("Item Expansion", 1)
print("[ItemExpansion] Loaded!")

--[[Items--]]
local	demonHeart_item = Isaac.GetItemIdByName( "Demon Heart" )
local	heretic_item = Isaac.GetItemIdByName( "Heretic" )
local	reckoning_item = Isaac.GetItemIdByName( "Reckoning" )
local	screwdriver_item = Isaac.GetItemIdByName( "Screwdriver" )

--[[Entities--]]

--[[Conditions--]]
local hasReckoning = false
local angelKilled = 0
local stageKilled = nil

--[[Item Pools--]]
local medTierAngel = {CollectibleType.COLLECTIBLE_CELTIC_CROSS,CollectibleType.COLLECTIBLE_CENSER,CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT,CollectibleType.COLLECTIBLE_DEAD_DOVE,CollectibleType.COLLECTIBLE_HABIT,CollectibleType.COLLECTIBLE_GUARDIAN_ANGEL,CollectibleType.COLLECTIBLE_SERAPHIM,CollectibleType.COLLECTIBLE_LAZARUS_RAGS,CollectibleType.COLLECTIBLE_ROSARY,CollectibleType.COLLECTIBLE_SWORN_PROTECTOR,CollectibleType.COLLECTIBLE_RELIC,CollectibleType.COLLECTIBLE_SOUL,CollectibleType.COLLECTIBLE_HOLY_GRAIL,CollectibleType.COLLECTIBLE_HOLY_LIGHT}
local hiTierAngel = {CollectibleType.COLLECTIBLE_WAFER,CollectibleType.COLLECTIBLE_TRINITY_SHIELD,CollectibleType.COLLECTIBLE_GODHEAD,CollectibleType.COLLECTIBLE_HALO,CollectibleType.COLLECTIBLE_BODY,CollectibleType.COLLECTIBLE_SACRED_HEART,CollectibleType.COLLECTIBLE_HOLY_MANTLE}
local medTierDevil = {CollectibleType.COLLECTIBLE_ATHAME,CollectibleType.COLLECTIBLE_CONTRACT_FROM_BELOW,CollectibleType.COLLECTIBLE_BLACK_POWDER,CollectibleType.COLLECTIBLE_DARK_MATTER,CollectibleType.COLLECTIBLE_DEMON_BABY,CollectibleType.COLLECTIBLE_GIMPY,CollectibleType.COLLECTIBLE_ROTTEN_BABY,CollectibleType.COLLECTIBLE_DARK_BUM,CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON,CollectibleType.COLLECTIBLE_LORD_OF_THE_PIT,CollectibleType.COLLECTIBLE_SPIRIT_NIGHT}
local hiTierDevil = {CollectibleType.COLLECTIBLE_CEREMONIAL_ROBES,CollectibleType.COLLECTIBLE_PENTAGRAM,CollectibleType.COLLECTIBLE_SACRIFICIAL_DAGGER,CollectibleType.COLLECTIBLE_MARK,CollectibleType.COLLECTIBLE_ABADDON,CollectibleType.COLLECTIBLE_BRIMSTONE,CollectibleType.COLLECTIBLE_DEATHS_TOUCH,CollectibleType.COLLECTIBLE_LIL_BRIMSTONE,CollectibleType.COLLECTIBLE_MOMS_KNIFE,CollectibleType.COLLECTIBLE_PACT}


--[[Update--]]
function itemExpansion:check( )
    local player = Isaac.GetPlayer(0)
    local game = Game()
    local room = game:GetRoom()
    local entities = Isaac.GetRoomEntities()
    
    --[[Item: Demon Heart--]]
    if player.HasCollectible(player, demonHeart_item) then
      player.TearColor = Color(1, 0, 0, 1, 0, 0, 0)
    end
    --[[Item: Heretic--]]
    if player.HasCollectible(player, heretic_item) then
      if room:GetType() == RoomType.ROOM_DEVIL and angelKilled == 0 then
        for i = 1, #entities do
          if entities[i]:IsVulnerableEnemy( ) then
            entities[i]:Kill()
          end
        end
        Isaac.Spawn(EntityType.ENTITY_URIEL , 0, 0, room:GetCenterPos(), Vector(0,0), player)
        stageKilled = Game():GetLevel():GetStage()
        angelKilled = 1
      end
      if room:GetType() == RoomType.ROOM_DEVIL and angelKilled == 1 and stageKilled ~= Game():GetLevel():GetStage() then
        for i = 1, #entities do
          if entities[i]:IsVulnerableEnemy( ) then
            entities[i]:Kill()
          end
        end
        Isaac.Spawn(EntityType.ENTITY_GABRIEL , 0, 0, room:GetCenterPos(), Vector(0,0), player)
        angelKilled = 2
        stageKilled = nil
      end
    end
    --[[Item: Reckoning--]]
    if hasReckoning == false and player.HasCollectible(player, reckoning_item) then
      player.RemoveCollectible(reckoning_item)
      hasReckoning = true
      print("[ItemExpansion] Reckoning aquired!")
      if Game():GetDevilRoomDeals() == 0 then
        Game():Darken(-1, 17)
        print("[ItemExpansion] Angel Reckoning!")
        if math.random() > 0.5 then
          player:AddCollectible(medTierAngel[math.random(13)], 1, false)
          player:AddCollectible(medTierAngel[math.random(13)], 1, false)
        else
          player:AddCollectible(hiTierAngel[math.random(8)], 1, false)
        end
      else
        Game():Darken(1, 17)
        print("[ItemExpansion] Devil Reckoning!")
        if math.random() > 0.5 then
          player:AddCollectible(medTierDevil[math.random(11)], 1, false)
          player:AddCollectible(medTierDevil[math.random(11)], 1, false)
        else
          player:AddCollectible(hiTierDevil[math.random(10)], 1, false)
        end
      end
    end
    
    if player.HasCollectible(player, screwdriver_item) then
      --[[Effect--]]
      if player:GetFireDirection() ~= -1 then
        if player.FrameCount % player.FireDelay == 0 then
          if player.Luck < 5 then
            if math.random(6-player.Luck) == 1 then
              player:FireTear(player.Position, player:GetAimDirection () * 12, false, false, false)
              if player.HasCollectible(CollectibleType.COLLECTIBLE_SCREW) then
                player:FireTear(player.Position, player:GetAimDirection () * 12, false, false, false)
                player:FireTear(player.Position, player:GetAimDirection () * 12, false, false, false)
              end
            end
          elseif math.random(2) == 1 then
            player:FireTear(player.Position, player:GetAimDirection () * 12, false, false, false)
            player:FireTear(player.Position, player:GetAimDirection () * 12, false, false, false)
          end
        end
      end
    end
end

--[[New Run--]]
function itemExpansion:newRun( )
  local player = Isaac.GetPlayer(0)
  
  print("[ItemExpansion] New Run Detected!")
  hasReckoning = false
  angelKilled = 0
  stageKilled = nil
end

--[[Stats--]]
function itemExpansion:cache(p, flag)
  local player = Isaac.GetPlayer(0)
  --[[Item: Screwdriver--]]
  if player.HasCollectible(player, screwdriver_item) and flag == CacheFlag.CACHE_FIREDELAY then
    player.FireDelay = player.FireDelay - 1
    print("[ItemExpansion] Screwdriver Status Applied")
  end
  --[[Item: Demon Heart--]]
  if player.HasCollectible(player, demonHeart_item) and flag == CacheFlag.CACHE_DAMAGE then
      player.Damage = 1.5 + player.Damage
      print("[ItemExpansion] Demon Heart Status Applied")
  end   
  --[[Item: Heretic--]]
  if player.HasCollectible(player, heretic_item) and flag == CacheFlag.CACHE_DAMAGE then
      player.Damage = 1 + player.Damage
      print("[ItemExpansion] Heretic Status Applied")
  end
end




--[[Callbacks--]]
itemExpansion:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT , itemExpansion.newRun)
itemExpansion:AddCallback(ModCallbacks.MC_POST_UPDATE, itemExpansion.check);
itemExpansion:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, itemExpansion.cache);

