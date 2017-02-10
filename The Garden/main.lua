local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

--------------------
--Global Variables--
--------------------

--Debug Flag
garden.DEBUG_MODE = true

--Items
garden.COLLECTIBLE_SHAME = Isaac.GetItemIdByName("Shame")
garden.COLLECTIBLE_FORBIDDEN_FRUIT = Isaac.GetItemIdByName("Forbidden Fruit")
garden.COLLECTIBLE_DECEPTION = Isaac.GetItemIdByName("Deception")
garden.COLLECTIBLE_CREATION = Isaac.GetItemIdByName("Creation")
garden.COLLECTIBLE_GRANTED_DOMAIN = Isaac.GetItemIdByName("Granted Domain")
garden.COLLECTIBLE_THE_FALL_OF_MAN = Isaac.GetItemIdByName("The Fall of Man")
garden.COLLECTIBLE_REBIRTH = Isaac.GetItemIdByName("Rebirth")
garden.COLLECTIBLE_EXILED = Isaac.GetItemIdByName("Exiled")
garden.COLLECTIBLE_THE_FIRST_DAY = Isaac.GetItemIdByName("The First Day")
garden.COLLECTIBLE_MY_BELOVED = Isaac.GetItemIdByName("My Beloved")
garden.COLLECTIBLE_THE_HARVEST = Isaac.GetItemIdByName("The Harvest")
garden.COLLECTIBLE_CRACK_THE_EARTH = Isaac.GetItemIdByName("Crack The Earth")
garden.COLLECTIBLE_LEGION = Isaac.GetItemIdByName("Legion")

--Garden Item Pool
garden.gardenPool = {}
garden.gardenPool[1] = garden.COLLECTIBLE_SHAME
garden.gardenPool[2] = garden.COLLECTIBLE_FORBIDDEN_FRUIT
garden.gardenPool[3] = garden.COLLECTIBLE_DECEPTION
garden.gardenPool[4] = garden.COLLECTIBLE_CREATION
garden.gardenPool[5] = garden.COLLECTIBLE_GRANTED_DOMAIN
garden.gardenPool[6] = garden.COLLECTIBLE_THE_FALL_OF_MAN
garden.gardenPool[7] = garden.COLLECTIBLE_REBIRTH
garden.gardenPool[8] = garden.COLLECTIBLE_EXILED
garden.gardenPool[9] = garden.COLLECTIBLE_THE_FIRST_DAY
garden.gardenPool[10] = garden.COLLECTIBLE_MY_BELOVED
garden.gardenPool[11] = garden.COLLECTIBLE_THE_HARVEST
garden.gardenPool[12] = garden.COLLECTIBLE_CRACK_THE_EARTH
garden.gardenPool[13] = garden.COLLECTIBLE_LEGION

--Item Flags
garden.HAS_SHAME = false
garden.HAS_FORBIDDEN_FRUIT = false
garden.HAS_DECEPTION = false
garden.HAS_CREATION = false
garden.HAS_GRANTED_DOMAIN = false
garden.HAS_THE_FALL_OF_MAN = false
garden.HAS_REBIRTH = false
garden.HAS_EXILED = false
garden.HAS_THE_FIRST_DAY = false
garden.HAS_MY_BELOVED = false
garden.HAS_THE_HARVEST = false
garden.HAS_CRACK_THE_EARTH = false
garden.HAS_LEGION = false
garden.HAS_DECEIVER = false

--Costumes
garden.COSTUME_ID_SHAME = Isaac.GetCostumeIdByPath("gfx/characters/shame.anm2")
garden.COSTUME_ID_FORBIDDEN_FRUIT = Isaac.GetCostumeIdByPath("gfx/characters/forbidden_fruit.anm2")
garden.COSTUME_ID_DECEPTION = Isaac.GetCostumeIdByPath("gfx/characters/deception.anm2")
garden.COSTUME_ID_CREATION = Isaac.GetCostumeIdByPath("gfx/characters/creation.anm2")
garden.COSTUME_ID_GRANTED_DOMAIN = Isaac.GetCostumeIdByPath("gfx/characters/granted_domain.anm2")
garden.COSTUME_ID_THE_FALL_OF_MAN = Isaac.GetCostumeIdByPath("gfx/characters/the_fall_of_man.anm2")
garden.COSTUME_ID_EXILED = Isaac.GetCostumeIdByPath("gfx/characters/exiled.anm2")
garden.COSTUME_ID_THE_FIRST_DAY = Isaac.GetCostumeIdByPath("gfx/characters/the_first_day.anm2")
garden.COSTUME_ID_MY_BELOVED = Isaac.GetCostumeIdByPath("gfx/characters/my_beloved.anm2")
garden.COSTUME_ID_THE_HARVEST = Isaac.GetCostumeIdByPath("gfx/characters/the_harvest.anm2")
garden.COSTUME_ID_CRACK_THE_EARTH = Isaac.GetCostumeIdByPath("gfx/characters/crack_the_earth.anm2")
garden.COSTUME_ID_DECEIVER = Isaac.GetCostumeIdByPath("gfx/characters/deceiver.anm2")

--Storage Variabes
garden.CURRENT_LEVEL = nil
garden.PREVIOUS_POSITION = nil
garden.ROOM_FIGHT = false
garden.ROOM_DONE = false
garden.HAS_CONVERTED_HEARTS = false
garden.LEGION_IN_ROOM = false
garden.LEGION_SPAWN_POSITION = nil
garden.ENEMIES_IN_ROOM = nil
garden.BOSS_IN_ROOM = nil
TearFlags = {FLAG_POISONING = 1<<4}

--Room Flags
garden.GARDEN_HEARTS_CAN_SPAWN = true
garden.FIGHT_CAN_START = true
garden.WAVE_NUMBER = 0
garden.VISIT_NUMBER = 0
garden.ITEM_REWARDED = false	

--Curses
garden.CURSE_MORTALITY = Isaac.GetCurseIdByName("Curse of Mortality") 
garden.HAS_MORTALITY_CURSE = false

--Entity Shells
garden.TREE_SHELL = nil                                                                                  
garden.GRAIN_SHELL = nil
garden.GRASS_SHELL = nil 

--Entity Types
garden.SERPENT_TYPE = Isaac.GetEntityTypeByName("The Serpent")         
garden.SERPENT_HOLLOW_TYPE = Isaac.GetEntityTypeByName("Serpent Hollow")         
garden.SERPENT_LARRY_TYPE = Isaac.GetEntityTypeByName("Serpent Larry")                                                 
garden.GRAIN_TYPE = Isaac.GetEntityTypeByName("Grain")          
garden.GRASS_TYPE = Isaac.GetEntityTypeByName("Grass")     
garden.TREE_TYPE = Isaac.GetEntityTypeByName("The Tree")
garden.SERPENT_BABY_TYPE = Isaac.GetEntityTypeByName("Serpent Baby")
garden.LADY_BUG_TYPE = Isaac.GetEntityTypeByName("Lady Bug")

--Entity Vairants
garden.SERPENT_VARIANT = Isaac.GetEntityVariantByName("The Serpent") 
garden.TREE_VARIANT = Isaac.GetEntityVariantByName("The Tree")     
garden.SERPENT_HOLLOW_VARIANT = Isaac.GetEntityVariantByName("Serpent Hollow") 
garden.SERPENT_LARRY_VARIANT = Isaac.GetEntityVariantByName("Serpent Larry")   
garden.SERPENT_BABY_VARIANT = Isaac.GetEntityVariantByName("Serpent Baby")
garden.LADY_BUG_VARIANT = Isaac.GetEntityVariantByName("Lady Bug")
garden.GRAIN_VARIANT = Isaac.GetEntityVariantByName("Grain")  
garden.GRASS_VARIANT = Isaac.GetEntityVariantByName("Grass")  
garden.PATCH_VARIANT = Isaac.GetEntityVariantByName("The Patch")   		
garden.ADAM_FAMILIAR_VARIANT = Isaac.GetEntityVariantByName("Adam")
garden.LEGION_FAMILIAR_VARIANT = Isaac.GetEntityVariantByName("Legion")

--Entity Subtypes
garden.GRAIN_SUBTYPE = 0 
garden.GRASS_SUBTYPE = 0 
garden.SERPENT_SUBTYPE = 0
garden.TREE_SUBTYPE = 0 

--Entity Containers (Misc.)
garden.SERPENT_LOCATION = nil
garden.TREE_LOCATION = nil
garden.SERPENT_VELOCITY = Vector(0,0)
garden.TREE_VELOCITY = Vector(0,0)
garden.SERPENT_SPAWN_OWNER = nil	
garden.TREE_SPAWN_OWNER = nil
 
 
---------
--Debug--
---------

function garden:debugMode()
	if garden.DEBUG_MODE then
		Isaac.RenderText("Debug Mode", 50, 15, 255, 255, 255, 255)		
		--local currentGame = Game()
		--local currentLevel = currentGame:GetLevel()		
		--local currentRoom = Game():GetRoom()
		--local player = Isaac.GetPlayer(0)
		--local playerPosition = player.Position						
		--Isaac.RenderText("X:" .. playerPosition.X, 50, 30, 255, 255, 255, 255)
		--Isaac.RenderText("Variant:" .. player.Variant, 50, 30, 255, 255, 255, 255)
		--Isaac.RenderText("SubType:" .. player.SubType, 50, 45, 255, 255, 255, 255)
		if Game():GetFrameCount() == 1 then
			local currentRoom = Game():GetRoom()
			local roomCenter = currentRoom:GetCenterPos()
			for i = 1, #garden.gardenPool do
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, garden.gardenPool[i], currentRoom:FindFreePickupSpawnPosition(roomCenter,0,true), Vector(0,0), nil)												
			end
		end		
	end
end 
 
----------------
--Item Effects--
----------------

function garden:shameEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_SHAME) then				
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
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity.Type == EntityType.ENTITY_TEAR and singleEntity.FrameCount == 1 then			
				local currentSprite = singleEntity:GetSprite():GetFilename() 
				if currentSprite ~= "gfx/apple_one.anm2" and currentSprite ~= "gfx/apple_two.anm2" and currentSprite ~= "gfx/apple_three.anm2" and currentSprite ~= "gfx/apple_four.anm2" then
					
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

function garden:grantedDomainEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_GRANTED_DOMAIN) then		
		if garden.PREVIOUS_POSITION ~= nil then
			local positionalDifference = Vector(player.Position.X-garden.PREVIOUS_POSITION.X, player.Position.Y-garden.PREVIOUS_POSITION.Y)
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
				garden.PREVIOUS_POSITION = player.Position
			end
		else
			garden.PREVIOUS_POSITION = player.Position
		end
	end
end

function garden:exiledEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_EXILED) then		
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity.Type == EntityType.ENTITY_PICKUP and singleEntity.Variant == PickupVariant.PICKUP_HEART and singleEntity.SubType ~= HeartSubType.HEART_BLACK then								
				singleEntity:Remove()										
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, singleEntity.Position, Vector(0,0), nil)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, singleEntity.Position, Vector(0,0), nil)				
			end						
		end 
	end
end

function garden:harvestEffect()
	local player = Isaac.GetPlayer(0)	
	if player:HasCollectible(garden.COLLECTIBLE_THE_HARVEST) then		
		local currentRoom = Game():GetRoom()
		if currentRoom:GetFrameCount() == 1 then
			garden.ROOM_FIGHT = false
			garden.ROOM_DONE = false
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do 
				local singleEntity = entities[i]
				if singleEntity:IsVulnerableEnemy() then --Check if enemies are in the room		
					garden.ROOM_FIGHT = true
				end
				
				for i = 0, DoorSlot.NUM_DOOR_SLOTS-1 do --Check if doors are open in the room
					local door = currentRoom:GetDoor(i)
					if door ~= nil and door.DoorState == DoorState.STATE_OPEN then
    					garden.ROOM_FIGHT = false
					end	
				end				
			end
		elseif currentRoom:IsClear() and garden.ROOM_FIGHT and not garden.ROOM_DONE then				
			local randomNum = math.random(100)  --Luck-based chance (4% per luck)			
			if randomNum <= ((player.Luck + 1) * 4) then
				local roomCenter = currentRoom:GetCenterPos()
				local initialStep = 0 --Not sure what this does
				local avoidActiveEnemies = true
				local startingPosition = Vector(roomCenter.X,roomCenter.Y)
				local pickupPosition = currentRoom:FindFreePickupSpawnPosition(startingPosition, initialStep, avoidActiveEnemies)
				local velocity = Vector(0,0)
				local spawnOwner = nil
				local randomItem = 0 
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickupPosition, velocity, spawnOwner)				
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner)

				--Render grains
				local position = nil
				local grainSprite = nil
				
				local showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X+30,pickupPosition.Y-30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_TYPE, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)			
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("North East", true) 
				end				
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X,pickupPosition.Y-30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_TYPE, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("North", true) 				
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X-30,pickupPosition.Y-30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_TYPE, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("North West", true) 
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X-30,pickupPosition.Y)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_TYPE, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("West", true) 
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X-30,pickupPosition.Y+30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_TYPE, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("South West", true) 
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X,pickupPosition.Y+30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_TYPE, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("South", true)
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X+30,pickupPosition.Y+30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_TYPE, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("South East", true)
				end
				showGrain = math.random(2)
				if showGrain == 1 then  
					position = Vector(pickupPosition.X+30,pickupPosition.Y)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_TYPE, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("East", true) 
				end
				garden.ROOM_DONE = true
			else 
				garden.ROOM_DONE = true
			end									
		end
	end
end

function garden:crackTheEarthEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_CRACK_THE_EARTH) then		
		local currentRoom = Game():GetRoom()	
		if currentRoom:GetFrameCount() % 50 == 0 then -- Only every 50th frame
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local randomNum = math.random(100) -- 5% chance per luck
				if randomNum <= ((player.Luck + 1) * 5) then
					local singleEntity = entities[i]
					if singleEntity:IsVulnerableEnemy() and not singleEntity:IsFlying() and not singleEntity:IsBoss() then		
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ROCK_EXPLOSION, 0, singleEntity.Position, Vector(0,0), nil)
						singleEntity:TakeDamage(10.0,0,EntityRef(player),0)
						SFXManager():Play(SoundEffect.SOUND_ROCK_CRUMBLE, 2, 0, false, 1)
					end	
				end				
			end
		end
	end
end

function garden:myBelovedEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_MY_BELOVED) then		
		local entities = Isaac.GetRoomEntities()
		for i = 1, #entities do
			local singleEntity = entities[i]
			if singleEntity.Type == EntityType.ENTITY_PICKUP and singleEntity.Variant == PickupVariant.PICKUP_HEART and singleEntity.SubType ~= nil then		
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
			end
		end
	end
end

function garden:deceiverEffect(target, amount, flags, source, cooldown)
	if garden.HAS_DECEIVER then
		if target:IsVulnerableEnemy() and target.HitPoints-amount <= 0 then
			local randomNum = math.random(100) --5% chance
			if randomNum <= 5 then 				
				local player = Isaac.GetPlayer(0)
				if not player:HasFullHearts() then
					player:AddHearts(1)  --Lifesteal			
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP, 2, 0, false, 1)
				end
			end
		end
	end
end

function garden:legionEffect()
	if garden.HAS_LEGION then			
		local player = Isaac.GetPlayer(0)			
		local currentRoom = Game():GetRoom()
		local roomCenter = currentRoom:GetCenterPos()			
	
		if currentRoom:IsClear() and garden.LEGION_IN_ROOM then --Remove Legion from the room on clear
			local entities = Isaac.GetRoomEntities() 
			for i = 1, #entities do				
				local singleEntity = entities[i]
				if singleEntity.Type == EntityType.ENTITY_FAMILIAR and singleEntity.Variant == garden.LEGION_FAMILIAR_VARIANT and singleEntity.SubType == 0 then
					singleEntity:Remove()						
					garden.LEGION_IN_ROOM = false
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, singleEntity.Position, Vector(0,0), nil)				
					SFXManager():Play("174", 3, 0, false, 1)
				end				
			end				
		end
	
		if currentRoom:GetFrameCount() == 1 then --Remove Legion from the room on entry (failsafe)			
			--Spawn Legion
			garden.ENEMIES_IN_ROOM = false
			garden.BOSS_IN_ROOM = false
			local entities = Isaac.GetRoomEntities() 
			for i = 1, #entities do				
				local singleEntity = entities[i]
				if singleEntity:IsVulnerableEnemy() then
					garden.ENEMIES_IN_ROOM = true
				end
				--Ignore Boss Rooms
				if singleEntity:IsBoss() then
					garden.BOSS_IN_ROOM = true
				end				
				--Remove Legion from the room if somehow he's already there (this is a failsafe)
				if singleEntity.Type == EntityType.ENTITY_FAMILIAR and singleEntity.Variant == garden.LEGION_FAMILIAR_VARIANT and singleEntity.SubType == 0 then
					singleEntity:Remove()							
				end				
			end			
			local randomNum = math.random(100)
			if randomNum <= 20 and garden.ENEMIES_IN_ROOM and not garden.BOSS_IN_ROOM then --20% chance to spawn Legion
				garden.LEGION_IN_ROOM = true
				garden.LEGION_SPAWN_POSITION = currentRoom:FindFreePickupSpawnPosition(roomCenter, 0, true)
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, garden.LEGION_SPAWN_POSITION, Vector(0,0), nil)				
				Isaac.Spawn(EntityType.ENTITY_FAMILIAR, garden.LEGION_FAMILIAR_VARIANT, 0, garden.LEGION_SPAWN_POSITION, Vector(0,0), player)
				Game():ShakeScreen(12)
				SFXManager():Play("177", 3, 0, false, 1)	
			end
		end
		
		--Fire Brimstone
		if garden.LEGION_IN_ROOM and currentRoom:GetFrameCount() % 40 == 0 then --Every 40 frames
			local brimstoneEndPosition
			local brimstoneStartPosition				
			local legionFamiliar
			local chosenEnemy				

			local entities = Isaac.GetRoomEntities() 
			for i = 1, #entities do				
				local singleEntity = entities[i]
				if singleEntity:IsVulnerableEnemy() then 
					chosenEnemy = singleEntity --Find an enemy in the room
				end						
				if singleEntity.Type == EntityType.ENTITY_FAMILIAR and singleEntity.Variant == garden.LEGION_FAMILIAR_VARIANT and singleEntity.SubType == 0 then 
					legionFamiliar = singleEntity --Find Legion familiar						
				end														
			end				

			if chosenEnemy ~= nil then --This is a failsafe
				local direction = Vector(chosenEnemy.Position.X-legionFamiliar.Position.X, chosenEnemy.Position.Y-legionFamiliar.Position.Y)								
				local xDistance = chosenEnemy.Position.X-legionFamiliar.Position.X
				local yDistance = chosenEnemy.Position.Y-legionFamiliar.Position.Y
				local distance = math.abs(math.sqrt(xDistance^2 + yDistance^2)) --Look ma! I used the distance formula! Thanks, Algebra II :)
				local legionData = legionFamiliar:GetData()				
				legionData.Laser = player:FireBrimstone(direction)
				legionData.Laser.Parent = legionFamiliar
				legionData.Laser.Position = garden.LEGION_SPAWN_POSITION								
				local black = Color(0, 0, 0, 255, 0, 0, 0)
				legionData.Laser.Color = black
				legionData.Laser.Timeout = 1
				legionData.Laser.RenderZOffset = -59999 --Below characters
				legionData.Laser.MaxDistance = distance
				legionData.Laser.OneHit = false  --Greatly strengthens the brimstone shot

				--Update Legion Animation right before firing
				local legionSprite = legionFamiliar:GetSprite()
				local xDiff = chosenEnemy.Position.X-legionFamiliar.Position.X
				local yDiff = chosenEnemy.Position.Y-legionFamiliar.Position.Y				
				if xDiff > 0 then --Right side of Legion 
					legionSprite:Play("ShootRight", true)
				end
				if xDiff < 0 then --Left side of Legion
					legionSprite:Play("ShootLeft", true)
				end

				if xDiff == 0 and yDiff > 0 then --Above Legion 
					legionSprite:Play("ShootUp", true)
				end
				if xDiff == 0 and yDiff < 0 then --Below of Legion
					legionSprite:Play("ShootDown", true)
				end

				legionData.FireDirection = direction --Fires the laser				
			end
		end
	end
end 
 
--------------------
--Room Controllers--
--------------------

function garden:gardenRoomUpdate()
	local currentLevel = Game():GetLevel()	
	local roomDesc = currentLevel:GetCurrentRoomDesc()	
	local currentRoom = Game():GetRoom()	
	if roomDesc.Data.Name == "The_Garden" then  --Player is in a Garden
		--[[DEBUG--
		local backDrop = currentRoom:GetBackdropType()
		if backDrop ~= nil then
			Isaac.RenderText(backDrop, 50, 30, 255, 255, 255, 255)
		else
			Isaac.RenderText("Nil", 50, 30, 255, 255, 255, 255)
		end
		--------]]
		if currentRoom:GetFrameCount() == 1 then  --Player just walked into a Garden					
			MusicManager():Play(42,0.6)  --Play Garden_Drone.ogg
			SFXManager():Play("173", 0.4, 0, true, 1) -- loop soft ambience
			if garden.VISIT_NUMBER == 0 then      --Player has never been in this Garden			
				garden.FIGHT_CAN_START = true							
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
						leftHeart.RenderZOffset = -5000 --This should be below characters in the room
						rightHeart.RenderZOffset = -5000
					end
				end						
			end

			garden.VISIT_NUMBER = garden.VISIT_NUMBER + 1

			--Render Tree Sprite
			local roomCenter = currentRoom:GetCenterPos()			
			Isaac.GridSpawn(GridEntityType.GRID_PIT, 0, roomCenter, true)
			garden.TREE_LOCATION = Vector(roomCenter.X, roomCenter.Y+10)			
			garden.TREE_SHELL = Isaac.Spawn(garden.TREE_TYPE, garden.TREE_VARIANT, garden.TREE_SUBTYPE, garden.TREE_LOCATION, garden.TREE_VELOCITY, garden.TREE_SPAWN_OWNER)
			local patch = Isaac.Spawn(garden.TREE_TYPE, garden.PATCH_VARIANT, garden.TREE_SUBTYPE, garden.TREE_LOCATION, garden.TREE_VELOCITY, garden.TREE_SPAWN_OWNER)
			patch.RenderZOffset = -5000

			--Render grass
			local position = nil
			local grassSprite = nil
			local velocity = Vector(0,0)
			local spawnOwner = nil
			for i = 1, math.random(13) do
				position = currentRoom:GetRandomPosition(0)
				garden.GRASS_SHELL = Isaac.Spawn(garden.GRASS_TYPE, garden.GRASS_VARIANT, garden.GRASS_SUBTYPE, position, velocity, spawnOwner)
				garden.GRASS_SHELL.RenderZOffset = -5000			
				grassSprite = garden.GRASS_SHELL:GetSprite() 
				grassSprite:Load("gfx/grass.anm2", true)
				local randomGrass = math.random(13)
				if randomGrass == 1 then							
					grassSprite:Play("GrassA", true)
				elseif randomGrass == 2 then
					grassSprite:Play("GrassB", true)
				elseif randomGrass == 3 then
					grassSprite:Play("GrassC", true)
				elseif randomGrass == 4 then
					grassSprite:Play("GrassD", true)
				elseif randomGrass == 5 then
					grassSprite:Play("GrassE", true)
				elseif randomGrass == 6 then
					grassSprite:Play("GrassF", true)
				elseif randomGrass == 7 then
					grassSprite:Play("GrassG", true)
				elseif randomGrass == 8 then
					grassSprite:Play("GrassH", true)
				elseif randomGrass == 9 then
					grassSprite:Play("GrassI", true)
				elseif randomGrass == 10 then
					grassSprite:Play("GrassJ", true)
				elseif randomGrass == 11 then
					grassSprite:Play("GrassK", true)
				elseif randomGrass == 12 then
					grassSprite:Play("GrassL", true)
				elseif randomGrass == 13 then
					grassSprite:Play("GrassM", true)
				end
			end
		end	

		--Checks before Wave 1
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		local roomCenter = currentRoom:GetCenterPos()
		local positionalDifference = Vector(playerPosition.X-roomCenter.X, playerPosition.Y-roomCenter.Y)
		if math.abs(positionalDifference.X) < 75 and math.abs(positionalDifference.Y) < 40 then
			if garden.FIGHT_CAN_START then
				
				MusicManager():Play(43,0.3) --Play Garden_Serpent.ogg				
				garden.SERPENT_LOCATION = Vector(roomCenter.X, roomCenter.Y+100)				
				Game():ShakeScreen(12)
				
				--Spawn Wave 1 (Pin)				
				Isaac.Spawn(garden.SERPENT_TYPE, garden.SERPENT_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								

				--play sfx here (Curse_of_Mortality.wav)
				SFXManager():Play("172", 8, 0, false, 1)  
				
				garden.WAVE_NUMBER = 1
				garden.FIGHT_CAN_START = false												
				garden.barCurrentRoomDoors()				
			end				
		end

		
		--Checks during Wave 1
		local bossAlive = false
		if garden.WAVE_NUMBER == 1 then
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity.Type == garden.SERPENT_TYPE then	
					bossAlive = true
				end
			end

			if not bossAlive then
				garden.SERPENT_LOCATION = Vector(roomCenter.X, roomCenter.Y+100)		
				local randomNum = math.random(5,12)
				for i=1, randomNum do
					Isaac.Spawn(garden.SERPENT_HOLLOW_TYPE, garden.SERPENT_HOLLOW_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
				end
				local babySnakeLeftPosition = Vector(roomCenter.X+100,roomCenter.Y)
				local babySnakeRightPosition = Vector(roomCenter.X-100,roomCenter.Y)
				Isaac.Spawn(garden.SERPENT_BABY_TYPE, garden.SERPENT_BABY_VARIANT, 0, babySnakeLeftPosition, Vector(0,0), nil)								
				Isaac.Spawn(garden.SERPENT_BABY_TYPE, garden.SERPENT_BABY_VARIANT, 0, babySnakeRightPosition, Vector(0,0), nil)								
				SFXManager():Stop("173") -- Stop jungle sounds
				SFXManager():Play("172", 8, 0, false, 1)  
				garden.WAVE_NUMBER = 2																	
			end
		end		

		--Checks during Wave 2
		bossAlive = false
		if garden.WAVE_NUMBER == 2 then
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity.Type == garden.SERPENT_HOLLOW_TYPE then	
					bossAlive = true
				end
			end

			if not bossAlive then
				garden.SERPENT_LOCATION = Vector(roomCenter.X, roomCenter.Y+100)		
				local randomNum = math.random(5,12)
				for i=1, randomNum do					
					Isaac.Spawn(garden.SERPENT_LARRY_TYPE, garden.SERPENT_LARRY_VARIANT, 1, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
				end
				local ladyBugLeftPosition = Vector(roomCenter.X+100,roomCenter.Y)
				local ladyBugRightPosition = Vector(roomCenter.X-100,roomCenter.Y)
				Isaac.Spawn(garden.LADY_BUG_TYPE, garden.LADY_BUG_VARIANT, 0, ladyBugLeftPosition, Vector(0,0), nil)								
				Isaac.Spawn(garden.LADY_BUG_TYPE, garden.LADY_BUG_VARIANT, 0, ladyBugRightPosition, Vector(0,0), nil)								
				SFXManager():Play("172", 8, 0, false, 1) 
				garden.WAVE_NUMBER = 3																	
			end
		end		

		--Checks during Wave 3
		bossAlive = false
		if garden.WAVE_NUMBER == 3 then 
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity.Type == garden.SERPENT_LARRY_TYPE then	
					bossAlive = true
				end
			end

			if not bossAlive and not garden.ITEM_REWARDED then
				garden.openCurrentRoomDoors()						 
				garden.applyMortalityCurse()
				
				SFXManager():Play(SoundEffect.SOUND_HOLY, 8, 0, false, 1) 
				MusicManager():Play(44,0.3) --Play Garden_Holy.ogg
				
				local roomCenter = currentRoom:GetCenterPos()
				local initialStep = 0 --Not sure what this does
				local avoidActiveEnemies = true
				local startingPosition = Vector(roomCenter.X,roomCenter.Y+90)
				local pickupPosition = currentRoom:FindFreePickupSpawnPosition(startingPosition, initialStep, avoidActiveEnemies)
				local velocity = Vector(0,0)
				local spawnOwner = nil
				local randomNumber = math.random(13) 
				local randomItem = garden.gardenPool[randomNumber]			
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner)
				garden.ITEM_REWARDED = true
				table.remove(garden.gardenPool,randomNumber) --Remove the item from the pool																				
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
 
---------------------
--Curse Controllers--
---------------------

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
 
--------------------
--Flag Controllers--
--------------------

function garden:setNewFloorFlags()
	local currentLevel = Game():GetLevel()
	if currentLevel:GetStage() ~= garden.CURRENT_LEVEL then
		garden.CURRENT_LEVEL = currentLevel:GetStage()
		
		--Room Flags
		garden.GARDEN_HEARTS_CAN_SPAWN = true
		garden.FIGHT_CAN_START = true
		garden.WAVE_NUMBER = 0
		garden.VISIT_NUMBER = 0
		garden.ITEM_REWARDED = false

		--Curses
		garden.HAS_MORTALITY_CURSE = false			
	end	
end	

function garden:setNewRunFlags()
	--Garden Item Pool
	garden.gardenPool = {}
	garden.gardenPool[1] = garden.COLLECTIBLE_SHAME
	garden.gardenPool[2] = garden.COLLECTIBLE_FORBIDDEN_FRUIT
	garden.gardenPool[3] = garden.COLLECTIBLE_DECEPTION
	garden.gardenPool[4] = garden.COLLECTIBLE_CREATION
	garden.gardenPool[5] = garden.COLLECTIBLE_GRANTED_DOMAIN
	garden.gardenPool[6] = garden.COLLECTIBLE_THE_FALL_OF_MAN
	garden.gardenPool[7] = garden.COLLECTIBLE_REBIRTH
	garden.gardenPool[8] = garden.COLLECTIBLE_EXILED
	garden.gardenPool[9] = garden.COLLECTIBLE_THE_FIRST_DAY
	garden.gardenPool[10] = garden.COLLECTIBLE_MY_BELOVED
	garden.gardenPool[11] = garden.COLLECTIBLE_THE_HARVEST
	garden.gardenPool[12] = garden.COLLECTIBLE_CRACK_THE_EARTH
	garden.gardenPool[13] = garden.COLLECTIBLE_LEGION

	--Item Flags
	garden.HAS_SHAME = false
	garden.HAS_FORBIDDEN_FRUIT = false
	garden.HAS_DECEPTION = false
	garden.HAS_CREATION = false
	garden.HAS_GRANTED_DOMAIN = false
	garden.HAS_THE_FALL_OF_MAN = false
	garden.HAS_REBIRTH = false
	garden.HAS_EXILED = false
	garden.HAS_THE_FIRST_DAY = false
	garden.HAS_MY_BELOVED = false
	garden.HAS_THE_HARVEST = false
	garden.HAS_CRACK_THE_EARTH = false
	garden.HAS_LEGION = false
	garden.HAS_DECEIVER = false

	--Storage Variables
	garden.CURRENT_LEVEL = nil
	garden.PREVIOUS_POSITION = nil
	garden.ROOM_FIGHT = false
	garden.ROOM_DONE = false
	garden.HAS_CONVERTED_HEARTS = false
	garden.LEGION_IN_ROOM = false
	garden.LEGION_SPAWN_POSITION = nil
	garden.ENEMIES_IN_ROOM = nil
	garden.BOSS_IN_ROOM = nil
	TearFlags = {FLAG_POISONING = 1<<4}

	--Room Flags
	garden.GARDEN_HEARTS_CAN_SPAWN = true
	garden.FIGHT_CAN_START = true
	garden.WAVE_NUMBER = 0
	garden.VISIT_NUMBER = 0
	garden.ITEM_REWARDED = false	

	--Curses
	garden.HAS_MORTALITY_CURSE = false

	--Entity Shells
	garden.TREE_SHELL = nil                                        
	garden.SERPENT_SHELL = nil                                           
	garden.GRAIN_SHELL = nil
	garden.GRASS_SHELL = nil 
end	 
 
--------------------
--Familiar Effects--
--------------------

function garden:updateFamiliar(familiar)
	if familiar.Variant == garden.ADAM_FAMILIAR_VARIANT then
		if garden.HAS_REBIRTH then
			local player = Isaac.GetPlayer(0)
			familiar.OrbitDistance = Vector(35, 35)
			familiar.OrbitLayer = 98
			familiar.OrbitSpeed = 0.07
			familiar.Velocity = familiar:GetOrbitPosition(player.Position + player.Velocity) - familiar.Position
			familiar.GridCollisionClass = 0
			familiar.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ENEMIES
		end
	end	
end 
 
----------------
--Item Pickups--
----------------

function garden:itemPickedUp(player, statFromXML)
	local player = Isaac.GetPlayer(0)	
	
	if player:HasCollectible(garden.COLLECTIBLE_CREATION) and not garden.HAS_CREATION then
		garden.HAS_CREATION = true
		player:AddNullCostume(garden.COSTUME_ID_CREATION)	
	
		Game().TimeCounter = 0
		SFXManager():Play(SoundEffect.SOUND_GOLDENKEY, 4, 0, false, 1)           													 
	end

	if player:HasCollectible(garden.COLLECTIBLE_THE_FALL_OF_MAN) and not garden.HAS_THE_FALL_OF_MAN then		
		garden.HAS_THE_FALL_OF_MAN = true
		player:AddNullCostume(garden.COSTUME_ID_THE_FALL_OF_MAN)
        
        local totalHearts = player:GetMaxHearts()			
		local ignoreKeeper = true
		player:AddBlackHearts(4, ignoreKeeper)
		player:AddMaxHearts(totalHearts*-1, ignoreKeeper)

		for i = 1, totalHearts/2 do
			player.Damage = player.Damage + 0.5
		end		
	end	


	if player:HasCollectible(garden.COLLECTIBLE_MY_BELOVED) and not garden.HAS_MY_BELOVED then			
		garden.HAS_MY_BELOVED = true
		player:AddNullCostume(garden.COSTUME_ID_MY_BELOVED)
		local ignoreKeeper = false
		player:AddMaxHearts(2, ignoreKeeper)
		player:AddHearts(2)
		player.Luck = player.Luck + 1.0		
	end

	if player:HasCollectible(garden.COLLECTIBLE_SHAME) and not garden.HAS_SHAME then									
		garden.HAS_SHAME = true
		player:AddNullCostume(garden.COSTUME_ID_SHAME)				
	end

	if player:HasCollectible(garden.COLLECTIBLE_FORBIDDEN_FRUIT) and not garden.HAS_FORBIDDEN_FRUIT then			
		garden.HAS_FORBIDDEN_FRUIT = true 
		player:AddNullCostume(garden.COSTUME_ID_FORBIDDEN_FRUIT)
		player.ShotSpeed = player.ShotSpeed + 0.6		 
	end

	if player:HasCollectible(garden.COLLECTIBLE_THE_FIRST_DAY) and not garden.HAS_THE_FIRST_DAY then			
		garden.HAS_THE_FIRST_DAY = true
		player:AddNullCostume(garden.COSTUME_ID_THE_FIRST_DAY)		  

		player.Damage = player.Damage + 0.51		
		player.MoveSpeed = player.MoveSpeed + 0.1
		player.ShotSpeed = player.ShotSpeed + 0.1

		local white = Color(255, 255, 255, 255, 0, 0, 0)
		player.TearColor = white	
	end

	if player:HasCollectible(garden.COLLECTIBLE_DECEPTION) and not garden.HAS_DECEPTION then			
		garden.HAS_DECEPTION = true  
		player:AddNullCostume(garden.COSTUME_ID_DECEPTION)

		--Shuffle consumables
		for i = 1, 3 do
			local posOrNeg = math.random(10)
			local consumableOffset = math.random(15)
			if posOrNeg <= 4 then
				consumableOffset = consumableOffset*-1
			end
			local shuffleWhichConsumable = math.random(3)
			if shuffleWhichConsumable == 1 then
				player:AddCoins(consumableOffset)
			elseif shuffleWhichConsumable == 2 then
				player:AddKeys(consumableOffset)
			elseif shuffleWhichConsumable == 3 then
				player:AddBombs(consumableOffset)
			end
		end
	end

	if player:HasCollectible(garden.COLLECTIBLE_GRANTED_DOMAIN) and not garden.HAS_GRANTED_DOMAIN then			
		garden.HAS_GRANTED_DOMAIN = true  
		player:AddNullCostume(garden.COSTUME_ID_GRANTED_DOMAIN)		
	end

	if player:HasCollectible(garden.COLLECTIBLE_THE_HARVEST) and not garden.HAS_THE_HARVEST then			
		garden.HAS_THE_HARVEST = true  
		player:AddNullCostume(garden.COSTUME_ID_THE_HARVEST)		
	end

	if player:HasCollectible(garden.COLLECTIBLE_EXILED) and not garden.HAS_EXILED then			
		garden.HAS_EXILED = true 
		player:AddNullCostume(garden.COSTUME_ID_EXILED)
		
		local player = Isaac.GetPlayer(0)
		local totalHearts = player:GetMaxHearts()			
		local ignoreKeeper = true
		player:AddMaxHearts(4, ignoreKeeper)		
	end

	if player:HasCollectible(garden.COLLECTIBLE_REBIRTH) and not garden.HAS_REBIRTH then			
		garden.HAS_REBIRTH = true
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position			
		Isaac.Spawn(EntityType.ENTITY_FAMILIAR, garden.ADAM_FAMILIAR_VARIANT, 0, playerPosition, Vector(0,0), player)		

		local redHearts = player:GetMaxHearts()
		local soulHearts = player:GetSoulHearts()
		local blackHearts = player:GetBlackHearts()
		while player:GetPlayerType() ~= PlayerType.PLAYER_EVE do
			player:UseActiveItem(CollectibleType.COLLECTIBLE_CLICKER, false, false, false, false) --Change to Eve
		end			

		player:AddCollectible(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON , 0, true) -- Give Whore of Babylon

		local diff
		if player:GetMaxHearts() ~= redHearts then --Restore red heart containers
			diff = redHearts - player:GetMaxHearts()
			player:AddMaxHearts(diff, false)
		end
		if player:GetSoulHearts() ~= soulHearts then --Restore Soul Hearts
			diff = soulHearts - player:GetSoulHearts()
			player:AddSoulHearts(diff, false)
		end
		if player:GetBlackHearts() ~= blackHearts then --Restore Black Hearts
			diff = blackHearts - player:GetBlackHearts()
			player:AddBlackHearts(diff)
		end
		if player:GetHearts() > 1 then --Remove health for Whore of Babylon state
			diff = player:GetMaxHearts() - player:GetHearts()
			diff = diff * -1			
			player:AddHearts(diff + 1)
		end
		player:EvaluateItems() --Activate Whore of Babylon		
	end

	if player:HasCollectible(garden.COLLECTIBLE_CRACK_THE_EARTH) and not garden.HAS_CRACK_THE_EARTH then			
		garden.HAS_CRACK_THE_EARTH = true  
		player:AddNullCostume(garden.COSTUME_ID_CRACK_THE_EARTH)		
	end

	if player:HasCollectible(garden.COLLECTIBLE_LEGION) and not garden.HAS_LEGION then			
		garden.HAS_LEGION = true
		Game():ShakeScreen(12)
		SFXManager():Play("177", 3, 0, false, 1)
	end

	--Deceiver Tansformation
	if not garden.HAS_DECEIVER then
	    local shame = Isaac.GetItemIdByName("Shame")
	    local forbiddenFruit = Isaac.GetItemIdByName("Forbidden Fruit")
	    local deception = Isaac.GetItemIdByName("Deception")
	    local creation = Isaac.GetItemIdByName("Creation")	    
	    local grantedDomain = Isaac.GetItemIdByName("Granted Domain")
	    local fallOfMan = Isaac.GetItemIdByName("The Fall of Man")
	    local rebirth = Isaac.GetItemIdByName("Rebirth")
	    local exiled = Isaac.GetItemIdByName("Exiled")
	    local firstDay = Isaac.GetItemIdByName("The First Day")
	    local beloved = Isaac.GetItemIdByName("My Beloved")
	    local harvest = Isaac.GetItemIdByName("The Harvest")	    
	    local crackTheEarth = Isaac.GetItemIdByName("Crack The Earth")
	    local legion = Isaac.GetItemIdByName("Legion")
		local possibleItems = {shame, forbiddenFruit, deception, creation, grantedDomain, fallOfMan, rebirth, exiled, firstDay, beloved, harvest, crackTheEarth, legion}
        local itemCount = 0        
        for k,v in pairs(possibleItems) do        
          if player:HasCollectible(v) then
            itemCount = itemCount + 1
          end
        end 
        
        if itemCount >= 2 then
            garden.HAS_DECEIVER = true 
            player.TearFlags = player.TearFlags | TearFlags.FLAG_POISONING
            local green = Color(0, 255, 0, 255, 0, 0, 0)
			player.TearColor = green		            
            player:AddNullCostume(garden.COSTUME_ID_DECEIVER)            
			local pillText = Isaac.GetPillEffectByName("Deceiver!")
			player:UsePill(pillText,PillColor.PILL_BLUE_BLUE)
			player:StopExtraAnimation() 
			SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER, 0.9, 0, false, 1)           											
        end
	end
end
 
 
-----------------
--Mod Callbacks--
-----------------

--Admin Callbacks
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.debugMode)

--Item Callbacks
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.forbiddenFruitEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.grantedDomainEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.exiledEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.myBelovedEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.harvestEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.crackTheEarthEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.legionEffect)
garden:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, garden.deceiverEffect)
garden:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, garden.itemPickedUp)

--Room Callbacks
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.gardenRoomUpdate)

--Curse Callbacks
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.mortalityCurseEffect)
garden:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, garden.removeMortalityCurse)

--Flag Callbacks
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.setNewFloorFlags)
garden:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, garden.setNewRunFlags)

--Familiar Callbacks
garden:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, garden.updateFamiliar, garden.ADAM_FAMILIAR_VARIANT)