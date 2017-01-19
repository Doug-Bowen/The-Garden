local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

--Debug Flag
garden.DEBUG_MODE = true

--Items
garden.COLLECTIBLE_SHAME = Isaac.GetItemIdByName("Shame")
garden.COLLECTIBLE_FORBIDDEN_FRUIT = Isaac.GetItemIdByName("Forbidden Fruit")
garden.COLLECTIBLE_DECEPTION = Isaac.GetItemIdByName("Deception")
garden.COLLECTIBLE_CREATION = Isaac.GetItemIdByName("Creation")
garden.COLLECTIBLE_GRANTED_DOMAIN = Isaac.GetItemIdByName("Granted Domain")
garden.COLLECTIBLE_THE_WILL_OF_MAN = Isaac.GetItemIdByName("The Will of Man")
garden.COLLECTIBLE_THE_FALL_OF_MAN = Isaac.GetItemIdByName("The Fall of Man")
garden.COLLECTIBLE_REBIRTH = Isaac.GetItemIdByName("Rebirth")
garden.COLLECTIBLE_EXILED = Isaac.GetItemIdByName("Exiled")
garden.COLLECTIBLE_THE_FIRST_DAY = Isaac.GetItemIdByName("The First Day")
garden.COLLECTIBLE_MY_BELOVED = Isaac.GetItemIdByName("My Beloved")

--Pool
garden.gardenPool = {}
garden.gardenPool[1] = garden.COLLECTIBLE_SHAME
garden.gardenPool[2] = garden.COLLECTIBLE_FORBIDDEN_FRUIT
garden.gardenPool[3] = garden.COLLECTIBLE_DECEPTION
garden.gardenPool[4] = garden.COLLECTIBLE_CREATION
garden.gardenPool[5] = garden.COLLECTIBLE_GRANTED_DOMAIN
garden.gardenPool[6] = garden.COLLECTIBLE_THE_WILL_OF_MAN
garden.gardenPool[7] = garden.COLLECTIBLE_THE_FALL_OF_MAN
garden.gardenPool[8] = garden.COLLECTIBLE_REBIRTH
garden.gardenPool[9] = garden.COLLECTIBLE_EXILED
garden.gardenPool[10] = garden.COLLECTIBLE_THE_FIRST_DAY
garden.gardenPool[11] = garden.COLLECTIBLE_MY_BELOVED

--Familiars
garden.ADAM_FAMILIAR_VARIANT = Isaac.GetEntityVariantByName("Adam")

--Item Flags
garden.HAS_SHAME = false
garden.HAS_FORBIDDEN_FRUIT = false
garden.HAS_DECEPTION = false
garden.HAS_CREATION = false
garden.HAS_GRANTED_DOMAIN = false
garden.HAS_THE_WILL_OF_MAN = false
garden.HAS_THE_FALL_OF_MAN = false
garden.HAS_REBIRTH = false
garden.HAS_EXILED = false
garden.HAS_THE_FIRST_DAY = false
garden.HAS_MY_BELOVED = false

--Costumes
garden.COSTUME_ID_SHAME = Isaac.GetCostumeIdByPath("gfx/characters/shame.anm2")
garden.COSTUME_ID_FORBIDDEN_FRUIT = Isaac.GetCostumeIdByPath("gfx/characters/forbidden_fruit.anm2")
garden.COSTUME_ID_DECEPTION = Isaac.GetCostumeIdByPath("gfx/characters/deception.anm2")
garden.COSTUME_ID_CREATION = Isaac.GetCostumeIdByPath("gfx/characters/creation.anm2")
garden.COSTUME_ID_GRANTED_DOMAIN = Isaac.GetCostumeIdByPath("gfx/characters/granted_domain.anm2")
garden.COSTUME_ID_THE_WILL_OF_MAN = Isaac.GetCostumeIdByPath("gfx/characters/the_will_of_man.anm2")
garden.COSTUME_ID_THE_FALL_OF_MAN = Isaac.GetCostumeIdByPath("gfx/characters/the_fall_of_man.anm2")
garden.COSTUME_ID_EXILED = Isaac.GetCostumeIdByPath("gfx/characters/exiled.anm2")
garden.COSTUME_ID_THE_FIRST_DAY = Isaac.GetCostumeIdByPath("gfx/characters/the_first_day.anm2")
garden.COSTUME_ID_MY_BELOVED = Isaac.GetCostumeIdByPath("gfx/characters/my_beloved.anm2")

--Room Flags
garden.GARDEN_HEARTS_CAN_SPAWN = true
garden.SERPENT_CAN_SPAWN = true
garden.SERPENT_HAS_SPAWNED = false
garden.SERPENT_HAS_DIED = false
garden.VISIT_NUMBER = 0
garden.ITEM_REWARDED = false
garden.GARDEN_ROOM_INDEX = -3	

--Curses
garden.CURSE_MORTALITY = Isaac.GetCurseIdByName("Curse of Mortality") 
garden.HAS_MORTALITY_CURSE = false

--Entities
garden.TREE_SHELL = nil     --This is used to spawn The Tree 
garden.TREE_ID = 1000       --This is The Effect ID
garden.TREE_VARIANT = 993     
garden.TREE_SUBTYPE = 0 
garden.TREE_LOCATION = nil
garden.TREE_VELOCITY = Vector(0,0)
garden.TREE_SPAWN_OWNER = nil			

garden.SERPENT_SHELL = nil  --This is used to spawn The Serpent 
garden.SERPENT_ID = 62      --This is Pin's ID
garden.SERPENT_VARIANT = 55 --This is the Serpent's Variant Number
garden.SERPENT_SUBTYPE = 0 
garden.SERPENT_LOCATION = nil
garden.SERPENT_VELOCITY = Vector(0,0)
garden.SERPENT_SPAWN_OWNER = nil		

--Storages
garden.CURRENT_LEVEL = nil
garden.previousPosition = nil

function garden:debugMode()
	if garden.DEBUG_MODE then
		Isaac.RenderText("Debug Mode", 50, 15, 255, 255, 255, 255)
		local currentGame = Game()
		local currentLevel = currentGame:GetLevel()		
		local currentRoom = Game():GetRoom()
		local player = Isaac.GetPlayer(0)
		--local playerPosition = player.Position		
		--Isaac.RenderText("Y:" .. playerPosition.Y, 50, 45, 255, 255, 255, 255)
		--Isaac.RenderText("Visit:" .. garden.VISIT_NUMBER, 50, 30, 255, 255, 255, 255)
		Isaac.RenderText("Type:" .. player:GetPlayerType(), 50, 30, 255, 255, 255, 255)
		if currentRoom.Subtype ~= nil then
			Isaac.RenderText("RoomSub:" .. currentRoom.Subtype, 50, 45, 255, 255, 255, 255)		
		end
		if Game():GetFrameCount() == 1 then
			local currentRoom = Game():GetRoom()
			local roomCenter = currentRoom:GetCenterPos()
			for i = 1, #garden.gardenPool do
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.gardenPool[i], currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)
			end
		end		
	end
end

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
					local fearOwner = EntityRef(player)
					local fearDuration = 5
					singleEntity:AddFear(fearOwner, fearDuration)						
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
			if singleEntity.Type == EntityType.ENTITY_TEAR then			
				local currentSprite = singleEntity:GetSprite():GetFilename() 
				if currentSprite ~= "gfx/apple_one.anm2" and currentSprite ~= "gfx/apple_two.anm2" and currentSprite ~= "gfx/apple_three.anm2" and currentSprite ~= "gfx/apple_four.anm2" then
					
					--Apply Knockback here

					local newTearSprite = singleEntity:GetSprite() 
					local randomAppleNum = math.random(4)				 
					if randomAppleNum == 1 then 
						newTearSprite:Load("gfx/apple_one.anm2", true)	
					end
					if randomAppleNum == 2 then
						newTearSprite:Load("gfx/apple_two.anm2", true)				
					end
					if randomAppleNum == 3 then
						newTearSprite:Load("gfx/apple_three.anm2", true)			
					end
					if randomAppleNum == 4 then
						newTearSprite:Load("gfx/apple_four.anm2", true)							
					end 
					newTearSprite:Play("Idle", true) --This is the name of the actual animation WITHIN the anm2 file!
				end		
			end
		end		
	end	
end

function garden:creationEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_CREATION) then		
		if not garden.HAS_CREATION then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_CREATION)
			garden.HAS_CREATION = true  
		end
	end
end

function garden:deceptionEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_DECEPTION) then		
		if not garden.HAS_DECEPTION then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_DECEPTION)
			garden.HAS_DECEPTION = true  
		end
	end
end

function garden:grantedDomainEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_GRANTED_DOMAIN) then		
		if not garden.HAS_GRANTED_DOMAIN then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_GRANTED_DOMAIN)
			garden.HAS_GRANTED_DOMAIN = true  
		end
		if garden.previousPosition ~= nil then
			local positionalDifference = Vector(player.Position.X-garden.previousPosition.X, player.Position.Y-garden.previousPosition.Y)
			if math.abs(positionalDifference.X) == 0 and math.abs(positionalDifference.Y) == 0 then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY , 0, player.Position, Vector(0,0), player)
				local entities = Isaac.GetRoomEntities()
				for i = 1, #entities do
					local singleEntity = entities[i]
					if singleEntity:IsVulnerableEnemy() then		
						local freezeOwner = EntityRef(player)
						local freezeDuration = -5
						singleEntity:AddFreeze(freezeOwner, freezeDuration)
					end
				end	
			else
				garden.previousPosition = player.Position
			end
		else
			garden.previousPosition = player.Position
		end
	end
end

function garden:theWillOfManEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_THE_WILL_OF_MAN) then		
		if not garden.HAS_THE_WILL_OF_MAN then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_THE_WILL_OF_MAN)
			garden.HAS_THE_WILL_OF_MAN = true  
		end
	end
end

function garden:theFallOfManEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_THE_FALL_OF_MAN) then		
		if not garden.HAS_THE_FALL_OF_MAN then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_THE_FALL_OF_MAN)
			garden.HAS_THE_FALL_OF_MAN = true  
		end
	end
	--use GridEntityDoor:TargetRoomType to possibly see the item/boss in the next room (not sure if this is possible) --or try searching the surrounding rooms looking for items or bosses and post that info on the wall
	--use entity:AddEntityFlags(FLAG_RENDER_WALL) to attempt to apply that item/boss to a wall
end

function garden:rebirthEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_REBIRTH) then				
		if not garden.HAS_REBIRTH then
			local player = Isaac.GetPlayer(0)
			local playerPosition = player.Position			
			Isaac.Spawn(EntityType.ENTITY_FAMILIAR, garden.ADAM_FAMILIAR_VARIANT, 0, playerPosition, Vector(0,0), player)
			local character = player:GetPlayerType()
			if not character == PlayerType.PLAYER_EVE then
				player.PlayerType = PlayerType.PLAYER_EVE				
			end
			garden.HAS_REBIRTH = true  
		end	
	end
end

function garden:exiledEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_EXILED) then		
		if not garden.HAS_EXILED then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_EXILED)
			garden.HAS_EXILED = true 
			--local currentGame = Game()
			--local addChampionBeltCostume = true
			--currentGame:AddCollectibleEffect(CollectibleType.COLLECTIBLE_CHAMPION_BELT, addChampionBeltCostume) 
		end
	end
end

function garden:theFirstDayEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_THE_FIRST_DAY) then		
		if not garden.HAS_THE_FIRST_DAY then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_THE_FIRST_DAY)
			garden.HAS_THE_FIRST_DAY = true  
		end
		
		--NOT WORKING
		--local currentGame = Game()
		--local currentLevel = currentGame:GetLevel()		
		--currentGame:AddDevilRoomDeal()
		--local currentChance = currentLevel:GetAngelRoomChance()		
		--local difference = 100.00-currentChance
		--currentLevel:AddAngelRoomChance(difference)		
	end	
end

function garden:myBelovedEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_MY_BELOVED) then		
		if not garden.HAS_MY_BELOVED then			
			Game():GetPlayer(0):AddNullCostume(garden.COSTUME_ID_MY_BELOVED)
			local ignoreKeeper = false
			player:AddMaxHearts(2, ignoreKeeper)
			player:AddHearts(2)
			garden.HAS_MY_BELOVED = true  
		end
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity.Variant == PickupVariant.PICKUP_HEART then			
				local playerPosition = player.Position
				local entityPosition = singleEntity.Position
				local positionalDifference = Vector(playerPosition.X-entityPosition.X, playerPosition.Y-entityPosition.Y)
				if positionalDifference.X > 0 then
					singleEntity:AddVelocity(Vector(1,0))
				end
				if positionalDifference.X < 0 then
					singleEntity:AddVelocity(Vector(-1,0))
				end
				if positionalDifference.Y > 0 then
					singleEntity:AddVelocity(Vector(0,1))
				end
				if positionalDifference.Y < 0 then
					singleEntity:AddVelocity(Vector(0,-1))
				end
				if positionalDifference.X ==0 and positionalDifference.Y == 0 then
					singleEntity:Remove()
				end
			end
		end
	end
end

function garden:itemPickedUp(player, statFromXML)
	local player = Isaac.GetPlayer(0)	
	
	if player:HasCollectible(garden.COLLECTIBLE_CREATION) then
		player.Damage = player.Damage+.51		
		player.MoveSpeed = player.MoveSpeed+.1
		player.ShotSpeed = player.ShotSpeed+.1
		local white = Color(255, 255, 255, 255, 0, 0, 0)
		player.TearColor = white
	end			
end

function garden:gardenRoomUpdate()
	local currentLevel = Game():GetLevel()	
	local currentRoomIndex = currentLevel:GetCurrentRoomIndex()
	local currentRoom = Game():GetRoom()	
	local currentRoomType = currentRoom:GetType()	
	if currentRoomType == RoomType.ROOM_LIBRARY and currentRoomIndex == garden.GARDEN_ROOM_INDEX then --Player is in a Garden
		if currentRoom:GetFrameCount() == 1 then  --Player just walked into a Garden
			if garden.VISIT_NUMBER == 0 then      --Player has never been in this Garden			
				garden.SERPENT_CAN_SPAWN = true			
				garden.SERPENT_HAS_SPAWNED = false
				garden.GARDEN_HEARTS_CAN_SPAWN = true

				--Handle Heart Spawning
				if garden.GARDEN_HEARTS_CAN_SPAWN then
					garden.GARDEN_HEARTS_CAN_SPAWN = false
					if math.random(4) == 1 then  --Spawn Hearts (25% chance)
						local roomCenter = currentRoom:GetCenterPos()
						local leftHeartPosition = Vector(roomCenter.X-100, roomCenter.Y)
						local rightHeartPosition = Vector(roomCenter.X+100, roomCenter.Y)
						local velocity = Vector(0,0)
						local spawnOwner = Isaac.GetPlayer(0)
						local leftHeart = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, leftHeartPosition, velocity, spawnOwner) 	
						local rightHeart = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, rightHeartPosition, velocity, spawnOwner) 
						leftHeart.RenderZOffset = -699999 --This should be below characters in the room
						rightHeart.RenderZOffset = -699999
					end
				end						
			end

			garden.VISIT_NUMBER = garden.VISIT_NUMBER + 1

			--Render Tree Sprite
			local roomCenter = currentRoom:GetCenterPos()			
			Isaac.GridSpawn(GridEntityType.GRID_PIT, 0, roomCenter, true)
			garden.TREE_LOCATION = Vector(roomCenter.X, roomCenter.Y+10)			
			garden.TREE_SHELL = Isaac.Spawn(garden.TREE_ID, garden.TREE_VARIANT, garden.TREE_SUBTYPE, garden.TREE_LOCATION, garden.TREE_VELOCITY, garden.TREE_SPAWN_OWNER)			

			--Render Floor and Walls
			--local backdrop = currentRoom:GetBackdropType()

			--Handle the music for the room			
			--play music here (Garden_Drone.ogg)
			--play quieter music here (Garden_Ambience.ogg)  
		end	

		--Check if player is activating The Serpent fight
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		local roomCenter = currentRoom:GetCenterPos()
		local positionalDifference = Vector(playerPosition.X-roomCenter.X, playerPosition.Y-roomCenter.Y)
		if math.abs(positionalDifference.X) < 35 and math.abs(positionalDifference.Y) < 35 then
			if garden.SERPENT_CAN_SPAWN and not garden.SERPENT_HAS_SPAWNED then
				--change music here (Garden_Serpent.ogg)				
				garden.SERPENT_LOCATION = Vector(roomCenter.X, roomCenter.Y+100)				
				Game():ShakeScreen(12)
				garden.SERPENT_SHELL = Isaac.Spawn(garden.SERPENT_ID, garden.SERPENT_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)
				
				--play sfx here (Curse_of_Mortality.wav)
				local volume = 100
				local frameDelay = 0
				local loop = false
				local pitch = 1
				garden.SERPENT_SHELL:ToNPC():PlaySound("172", volume, frameDelay, loop, pitch)	

				garden.SERPENT_CAN_SPAWN = false
				garden.SERPENT_HAS_SPAWNED = true			
				garden.barCurrentRoomDoors()				
			end				
		end

		--Checks during TheSerpent fight
		if garden.SERPENT_HAS_SPAWNED then
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity:IsBoss() and singleEntity:IsDead() then					
					garden.SERPENT_HAS_DIED = true						
					if not garden.ITEM_REWARDED then
						garden.openCurrentRoomDoors()						 
						garden.applyMortalityCurse()
						
						local volume = 100
						local frameDelay = 0
						local loop = false
						local pitch = 1
						garden.SERPENT_SHELL:ToNPC():PlaySound(SoundEffect.SOUND_HOLY, volume, frameDelay, loop, pitch)	
						
						--currentRoom:PlayMusic() doesnt seem to do anything			
						--change music here (Garden_Holy.ogg)
						local roomCenter = currentRoom:GetCenterPos()
						local initialStep = 0 --Not sure what this does
						local avoidActiveEnemies = true
						local startingPosition = Vector(roomCenter.X,roomCenter.Y+20)
						local pickupPosition = currentRoom:FindFreePickupSpawnPosition(startingPosition, initialStep, avoidActiveEnemies)
						local velocity = Vector(0,0)
						local spawnOwner = nil
						local randomNumber = math.random(11)
						local randomItem = garden.gardenPool[randomNumber]			
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner)
						garden.ITEM_REWARDED = true
						--table.Remove(garden.gardenPool, randomNumber) -- We're not removing the item spawned from the garden pool currently as this call doesnt work											
					end
				end
			end
		end
	end
end

function garden:applyMortalityCurse()
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
			if singleEntity.Variant == PickupVariant.PICKUP_HEART then				
				singleEntity:Remove()					
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, singleEntity.Position, Vector(0,0), nil)				
			end
		end
	end
end

function garden:openCurrentRoomDoors()
	local currentRoom = Game():GetRoom()
	for i = 0, DoorSlot.NUM_DOOR_SLOTS-1 do
	local door = currentRoom:GetDoor(i)
		if door ~= nil then
	    	door:Open() 
		end
	end
end

function garden:barCurrentRoomDoors()
	local currentRoom = Game():GetRoom()
	for i = 0, DoorSlot.NUM_DOOR_SLOTS-1 do
	local door = currentRoom:GetDoor(i)
		if door ~= nil then
	    	door:Bar() 
		end
	end
end

function garden:checkForNewLevel() --Reset Flags on a new floor
	local currentLevel = Game():GetLevel()
	if currentLevel:GetStage() ~= garden.CURRENT_LEVEL then
		garden.CURRENT_LEVEL = currentLevel:GetStage()
		garden.GARDEN_HEARTS_CAN_SPAWN = true
		garden.SERPENT_CAN_SPAWN = true
		garden.SERPENT_HAS_SPAWNED = false
		garden.SERPENT_HAS_DIED = false
		garden.VISIT_NUMBER = 0
		garden.ITEM_REWARDED = false		
	end	
end	

function garden:checkForNewRun() --Reset Flags on a new run
	garden.GARDEN_HEARTS_CAN_SPAWN = true
	garden.SERPENT_CAN_SPAWN = true
	garden.SERPENT_HAS_SPAWNED = false
	garden.SERPENT_HAS_DIED = false
	garden.VISIT_NUMBER = 0
	garden.ITEM_REWARDED = false	

	garden.HAS_SHAME = false
	garden.HAS_FORBIDDEN_FRUIT = false
	garden.HAS_DECEPTION = false
	garden.HAS_CREATION = false
	garden.HAS_GRANTED_DOMAIN = false
	garden.HAS_THE_WILL_OF_MAN = false
	garden.HAS_THE_FALL_OF_MAN = false
	garden.HAS_REBIRTH = false
	garden.HAS_EXILED = false
	garden.HAS_THE_FIRST_DAY = false
	garden.HAS_MY_BELOVED = false
end	

function garden:updateFamiliar(familiar)
	if garden.HAS_REBIRTH then
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		familiar:FollowPosition(playerPosition)
	end
end

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.debugMode)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.forbiddenFruitEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.creationEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.deceptionEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.grantedDomainEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theWillOfManEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFallOfManEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.rebirthEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.exiledEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFirstDayEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.myBelovedEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.gardenRoomUpdate)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.mortalityCurseEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.checkForNewLevel)
garden:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, garden.checkForNewRun)
garden:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, garden.removeMortalityCurse)
garden:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, garden.itemPickedUp)
garden:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, garden.updateFamiliar, garden.ADAM_FAMILIAR_VARIANT)