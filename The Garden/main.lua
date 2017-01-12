local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

--Isaac.DebugString(RNG:GetSeed()) --Should output the seed to the log, just crashes though

--Items
garden.COLLECTIBLE_SHAME = Isaac.GetItemIdByName("Shame")
garden.COLLECTIBLE_FORBIDDEN_FRUIT = Isaac.GetItemIdByName("Forbidden Fruit")
garden.COLLECTIBLE_DECEPTION = Isaac.GetItemIdByName("Deception")
garden.COLLECTIBLE_GRANTED_DOMAIN = Isaac.GetItemIdByName("Granted Domain")
garden.COLLECTIBLE_THE_WILL_OF_MAN = Isaac.GetItemIdByName("The Will of Man")
garden.COLLECTIBLE_THE_FALL_OF_MAN = Isaac.GetItemIdByName("The Fall of Man")
garden.COLLECTIBLE_REBIRTH = Isaac.GetItemIdByName("Rebirth")
garden.COLLECTIBLE_EXILED = Isaac.GetItemIdByName("Exiled")
garden.COLLECTIBLE_THE_FIRST_DAY = Isaac.GetItemIdByName("The First Day")
garden.COLLECTIBLE_MIRACLE_GROW = Isaac.GetItemIdByName("MiracleGrow")

--Item Flags
garden.HAS_FORBIDDEN_FRUIT = false
garden.HAS_SHAME = false
garden.HAS_DECEPTION = false
garden.HAS_GRANTED_DOMAIN = false
garden.HAS_THE_WILL_OF_MAN = false
garden.HAS_THE_FALL_OF_MAN = false
garden.HAS_REBIRTH = false
garden.HAS_EXILED = false
garden.HAS_THE_FIRST_DAY = false
garden.HAS_MIRACLE_GROW = false

--Costumes
garden.COSTUME_ID_SHAME = Isaac.GetCostumeIdByPath("gfx/characters/shame.anm2")
garden.COSTUME_ID_FORBIDDEN_FRUIT = Isaac.GetCostumeIdByPath("gfx/characters/forbidden_fruit.anm2")
garden.COSTUME_ID_DECEPTION = Isaac.GetCostumeIdByPath("gfx/characters/deception.anm2")
garden.COSTUME_ID_GRANTED_DOMAIN = Isaac.GetCostumeIdByPath("gfx/characters/granted_domain.anm2")
garden.COSTUME_ID_THE_WILL_OF_MAN = Isaac.GetCostumeIdByPath("gfx/characters/the_will_of_man.anm2")
garden.COSTUME_ID_REBIRTH = Isaac.GetCostumeIdByPath("gfx/characters/rebirth.anm2")
garden.COSTUME_ID_EXILED = Isaac.GetCostumeIdByPath("gfx/characters/exiled.anm2")
garden.COSTUME_ID_THE_FIRST_DAY = Isaac.GetCostumeIdByPath("gfx/characters/the_first_day.anm2")
garden.COSTUME_ID_MIRACLE_GROW = Isaac.GetCostumeIdByPath("gfx/characters/miracle_grow.anm2")

--Room Flags
garden.GARDEN_HEARTS_CAN_SPAWN = true
garden.SERPENT_CAN_SPAWN = true
garden.SERPENT_HAS_SPAWNED = false
garden.SERPENT_HAS_DIED = false
garden.VISIT_NUMBER = 0
garden.ITEM_REWARDED = false

--Curses
garden.CURSE_MORTALITY = Isaac.GetCurseIdByName("Curse of Motality") 
garden.HAS_MORTALITY_CURSE = false

--Sprites
garden.treeSprite = Isaac.GetEntityTypeByName("The Tree")

function garden:shameEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_SHAME) then		
		if not garden.HAS_SHAME then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_SHAME)
			garden.HAS_SHAME = true
		end
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity:IsVulnerableEnemy() then		
				local playerPosition = player.Position
				local entityPosition = singleEntity.Position
				local positionalDifference = Vector(playerPosition.X-entityPosition.X, playerPosition.Y-entityPosition.Y)
				if math.abs(positionalDifference.X) < 80 and math.abs(positionalDifference.Y) < 80 then
					local fearWho = EntityRef(player)
					local fearDuration = 5
					singleEntity:AddFear(fearWho, fearDuration)						
				end
			end
		end
	end
end

function garden:forbiddenFruitEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_FORBIDDEN_FRUIT) then		
		if not garden.HAS_FORBIDDEN_FRUIT then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_FORBIDDEN_FRUIT)
			garden.HAS_FORBIDDEN_FRUIT = true  
		end
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity.EntityType == EntityType.ENTITY_TEAR then			
				local knockBackAmount = math.random(15)				
				singleEntity:SetKnockbackMultiplier(knockBackAmount) --Grant random amount of knockback

				local appleSprite = Sprite() --Render a sprite over the tear (this may be a hack, not sure)
				local randomAppleNum = math.random(4)				 
				if randomAppleNum == 1 then 
					appleSprite:Load("gfx/effects/apple_one.png", true)			
				elseif randomAppleNum == 2 then
					appleSprite:Load("gfx/effects/apple_two.png", true)			
				elseif randomAppleNum == 3 then
					appleSprite:Load("gfx/effects/apple_three.png", true)			
				elseif randomAppleNum == 4 then
					appleSprite:Load("gfx/effects/apple_four.png", true)							
				end 

				--local tearPosition = singleEntity.Position 
				--local topLeftClamp = Vector(tearPosition.X-10,tearPosition.Y-10)      --I'm not currently sure what clamps do (might want to manipulate these values)
				--local bottomRightClamp = Vector(tearPosition.X+10,tearPosition.Y+10)  --I'm not currently sure what clamps do (might want to manipulate these values)
				--appleSprite:Render(tearPosition, topLeftClamp, bottomRightClamp)				
			end
		end		
	end	
end

function garden:deceptionEffect()
end

function garden:grantedDomainEffect()
end

function garden:theWillOfManEffect()
end

function garden:theFallOfManEffect()
	--use GridEntityDoor:TargetRoomType to possibly see the item/boss in the next room (not sure if this is possible) --or try searching the surrounding rooms looking for items or bosses and post that info on the wall
	--use entity:AddEntityFlags(FLAG_RENDER_WALL) to attempt to apply that item/boss to a wall
end

function garden:rebirthEffect()
end

function garden:exiledEffect()
end

function garden:theFirstDayEffect()
	--might be Level:AddAngelRoomChance
end

function garden:miracleGrowEffect()
end

function garden:gardenRoomUpdate()
	local currentLevel = Game():GetLevel()	
	local currentRoomIndex = currentLevel:GetCurrentRoomIndex()
	local currentRoom = Game():GetRoom()
	local gardenRoomIndex = -3	
	Isaac.RenderText(garden.VISIT_NUMBER, 100, 100, 255, 0, 0, 255)
	if currentRoomIndex~= nil and currentRoomIndex == gardenRoomIndex then -- Player is in a Garden
		garden.openCurrentRoomDoors() --This ensures teleportation into this room doesnt lock you in
		if currentRoom:GetFrameCount() == 1 then --Player just walked into a Garden
			if garden.VISIT_NUMBER == 0 then --Player has never been in this Garden			
				local SERPENT_CAN_SPAWN = true			
				local SERPENT_HAS_SPAWNED = false

				--Handle Eternal Heart Spawning
				if garden.GARDEN_HEARTS_CAN_SPAWN then
					local randomNum = math.random(4)
					garden.GARDEN_HEARTS_CAN_SPAWN = false
					if randomNum == 1 then  --Spawn Eternal Hearts (25% chance)
						local roomCenter = currentRoom:GetCenterPos()
						local leftHeartPosition = Vector(roomCenter.X-100, roomCenter.Y)
						local rightHeartPosition = Vector(roomCenter.X+100, roomCenter.Y)
						local velocity = Vector(0,0)
						local spawnOwner = Isaac.GetPlayer(0)				
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, leftHeartPosition, velocity, spawnOwner) 	
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, rightHeartPosition, velocity, spawnOwner) 	
					end
				end						
			end

			garden.VISIT_NUMBER = garden.VISIT_NUMBER + 1
			--Build Tree Sprite
			local tree = treeSprite:GetSprite() 
			local animationName = "treeIdle"
			if not tree:IsPlaying(animationName) then
				local forcePlay = true
				tree:Play(animationName, forcePlay)
			end
			local entityVariant = 0
			local entitySubtype = 0
			local roomCenter = currentRoom:GetCenterPos()
			local velocity = Vector(0,0)
			local spawnOwner = Isaac.GetPlayer(0)				
			Isaac.Spawn(garden.treeSprite, entityVariant, entitySubtype, roomCenter, velocity, spawnOwner)

			--Handle the music for the room
			--play sfx here (Garden_Difficulty.wav)
			--play music here (Garden_Drone.ogg)
			--play quieter music here (Garden_Ambience.ogg)  
		end		

		--Check if player is activating The Serpent fight
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		local roomCenter = currentRoom:GetCenterPos()
		local positionalDifference = Vector(playerPosition.X-roomCenter.X, playerPosition.Y-roomCenter.Y)
		if math.abs(positionalDifference.X) < 20 and math.abs(positionalDifference.Y) < 20 then
			if garden.SERPENT_CAN_SPAWN and not garden.SERPENT_HAS_SPAWNED then
				--change music here (Garden_Serpent.ogg)
				local serpentSpawnPosition = Vector(roomCenter.X, roomCenter.Y+100)
				local entityVariant = 0  --should manipulate these values to spawn a different boss
				local entitySubtype = 0  --should manipulate these values to spawn a different boss
				local velocity = Vector(0,0)
				local spawnOwner = Isaac.GetPlayer(0)				
				Isaac.Spawn(EntityType.ENTITY_PIN, entityVariant, entitySubtype, serpentSpawnPosition, velocity, spawnOwner) --Try a different spawnOwner and maybe the visual glitch wont happen?
				garden.SERPENT_CAN_SPAWN = false
				garden.SERPENT_HAS_SPAWNED = true				
				garden.barCurrentRoomDoors()				
			end				
		end

		--Check if player has killed The Serpent
		if garden.SERPENT_HAS_SPAWNED then
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity:IsBoss() then
					if singleEntity:IsDead() then
						garden.SERPENT_HAS_DIED = true
						garden.openCurrentRoomDoors()
						garden.giveMortalityCurse()
					end
				end
			end
		end

		--If the player has beaten The Serpent
		if garden.SERPENT_HAS_DIED and not garden.ITEM_REWARDED then
			--play sfx here (meaty deaths 3.wav) --might not need this, pin ming play his own death sound
			--play sfx here (holy!.wav)
			--change music here (Garden_Holy.ogg)
			local pickupPosition = currentRoom:GetCenterPos()
			local velocity = Vector(0,0)
			local spawnOwner = nil
			local randomItem = 0
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner)
			garden.ITEM_REWARDED = true
		end
	end

	--The player has left a Garden
	if currentRoomIndex ~= gardenRoomIndex and currentRoom:GetFrameCount() == 1 then
		local previousRoomIndex = currentLevel:GetPreviousRoomIndex()
		if previousRoomIndex~= nil and previousRoomIndex == gardenRoomIndex then 
			local currentRoom = Game():GetRoom()
			for i = 1, DoorSlot.NUM_DOOR_SLOTS do
			local door = currentRoom:GetDoor(i) 
				if door ~= nil and door:IsOpen() and door.TargetRoomIndex == -3 then --This is the door that leads to the Garden
			    	door:Bar()	 
			    	garden.VISIT_NUMBER = 0 
				end
			end
			--Reset flags for future Garden Rooms
			garden.SERPENT_CAN_SPAWN = true
			garden.SERPENT_HAS_SPAWNED = false
			garden.GARDEN_HEARTS_CAN_SPAWN = true  
		end
	end	
end

function garden:giveMortalityCurse()
	local currentLevel = Game():GetLevel()	
	local showCurseName = true
	currentLevel:AddCurse(garden.CURSE_MORTALITY, showCurseName)
	garden.HAS_MORTALITY_CURSE = true
end

function garden:removeMortalityCurse()
	local currentLevel = Game():GetLevel()		
	currentLevel:RemoveCurse(garden.CURSE_MORTALITY)
	garden.HAS_MORTALITY_CURSE = false
end

function garden:mortalityCurseEffect()
	if garden.HAS_MORTALITY_CURSE then
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity.EntityType == EntityType.ENTITY_PICKUP and singleEntity.PickupVariant == PickupVariant.PICKUP_HEART then				
				singleEntity:Remove()					
			end
		end
	end
end

function garden:openCurrentRoomDoors()
	local currentRoom = Game():GetRoom()
	for i = 1, DoorSlot.NUM_DOOR_SLOTS do
	local door = currentRoom:GetDoor(i)
		if door ~= nil then
	    	door:Open() 
		end
	end
end

function garden:closeCurrentRoomDoors()
	local currentRoom = Game():GetRoom()
	for i = 1, DoorSlot.NUM_DOOR_SLOTS do
	local door = currentRoom:GetDoor(i)
		if door ~= nil then
	    	door:Close() 
		end
	end
end

function garden:barCurrentRoomDoors()
	local currentRoom = Game():GetRoom()
	for i = 1, DoorSlot.NUM_DOOR_SLOTS do
	local door = currentRoom:GetDoor(i)
		if door ~= nil then
	    	door:Bar() 
		end
	end
end

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.forbiddenFruitEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.deceptionEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.grantedDomainEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theWillOfManEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFallOfManEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.rebirthEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.exiledEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFirstDayEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.miracleGrowEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.gardenRoomUpdate)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.mortalityCurseEffect)
garden:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, garden.removeMortalityCurse)
