local garden = RegisterMod("TheGarden", 1) --'1' denotes API v1.0

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
garden.COLLECTIBLE_THE_BEAST = Isaac.GetItemIdByName("The Beast")

--Pool
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
garden.gardenPool[13] = garden.COLLECTIBLE_THE_BEAST

--Familiars
garden.ADAM_FAMILIAR_VARIANT = Isaac.GetEntityVariantByName("Adam")
garden.BEAST_FAMILIAR_VARIANT = Isaac.GetEntityVariantByName("TheBeast")

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
garden.HAS_THE_BEAST = false
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


--Room Flags
garden.GARDEN_HEARTS_CAN_SPAWN = true
garden.FIGHT_CAN_START = true
garden.FIGHT_HAS_STARTED = false
garden.WAVE_NUMBER = 0
garden.WAVE_ENDED = false
garden.VISIT_NUMBER = 0
garden.ITEM_REWARDED = false	

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
garden.PATCH_VARIANT = 994   		

garden.SERPENT_SHELL = nil  --This is used to spawn The Serpent 
garden.SERPENT_ID = 62      --This is Pin's ID
garden.SERPENT_VARIANT = 55 --This is the Serpent's Variant Number
garden.SERPENT_SUBTYPE = 0 
garden.SERPENT_LOCATION = nil
garden.SERPENT_VELOCITY = Vector(0,0)
garden.SERPENT_SPAWN_OWNER = nil	
garden.SERPENT_HOLLOW_ID = 19      --This is The Hollow's ID
garden.SERPENT_HOLLOW_VARIANT = 54 --This is the Serpent's (Hollow) Variant Number
garden.SERPENT_LARRY_ID = 19      --This is Larry Jr's ID
garden.SERPENT_LARRY_VARIANT = 53 --This is the Serpent's (Hollow) Variant Number

garden.GRAIN_SHELL = nil    --This is used to spawn Grains 
garden.GRAIN_ID = 1000      --This is The Effect ID
garden.GRAIN_VARIANT = 779  --This is the Grain's Variant Number
garden.GRAIN_SUBTYPE = 0 

garden.GRASS_SHELL = nil    --This is used to spawn Grass
garden.GRASS_ID = 1000      --This is The Effect ID
garden.GRASS_VARIANT = 780  --This is the GRASS's Variant Number
garden.GRASS_SUBTYPE = 0 

--Storage Variabes
garden.CURRENT_LEVEL = nil
garden.PREVIOUS_POSITION = nil
garden.ROOM_FIGHT = false
garden.ROOM_DONE = false
garden.HAS_CONVERTED_HEARTS = false

TearFlags = {
	FLAG_NO_EFFECT = 0,
	FLAG_SPECTRAL = 1,
	FLAG_PIERCING = 1<<1,
	FLAG_HOMING = 1<<2,
	FLAG_SLOWING = 1<<3,
	FLAG_POISONING = 1<<4,
	FLAG_FREEZING = 1<<5,
	FLAG_COAL = 1<<6,
	FLAG_PARASITE = 1<<7,
	FLAG_MAGIC_MIRROR = 1<<8,
	FLAG_POLYPHEMUS = 1<<9,
	FLAG_WIGGLE_WORM = 1<<10,
	FLAG_UNK1 = 1<<11, --No noticeable effect
	FLAG_IPECAC = 1<<12,
	FLAG_CHARMING = 1<<13,
	FLAG_CONFUSING = 1<<14,
	FLAG_ENEMIES_DROP_HEARTS = 1<<15,
	FLAG_TINY_PLANET = 1<<16,
	FLAG_ANTI_GRAVITY = 1<<17,
	FLAG_CRICKETS_BODY = 1<<18,
	FLAG_RUBBER_CEMENT = 1<<19,
	FLAG_FEAR = 1<<20,
	FLAG_PROPTOSIS = 1<<21,
	FLAG_FIRE = 1<<22,
	FLAG_STRANGE_ATTRACTOR = 1<<23,
	FLAG_UNK2 = 1<<24, --Possible worm?
	FLAG_PULSE_WORM = 1<<25,
	FLAG_RING_WORM = 1<<26,
	FLAG_FLAT_WORM = 1<<27,
	FLAG_UNK3 = 1<<28, --Possible worm?
	FLAG_UNK4 = 1<<29, --Possible worm?
	FLAG_UNK5 = 1<<30, --Possible worm?
	FLAG_HOOK_WORM = 1<<31,
	FLAG_GODHEAD = 1<<32,
	FLAG_UNK6 = 1<<33, --No noticeable effect
	FLAG_UNK7 = 1<<34, --No noticeable effect
	FLAG_EXPLOSIVO = 1<<35,
	FLAG_MULTIDIMENSIONAL = 1<<36,
	FLAG_HOLY_LIGHT = 1<<37,
	FLAG_KEEPER_HEAD = 1<<38,
	FLAG_ENEMIES_DROP_BLACK_HEARTS = 1<<39,
	FLAG_ENEMIES_DROP_BLACK_HEARTS2 = 1<<40,
	FLAG_GODS_FLESH = 1<<41,
	FLAG_UNK8 = 1<<42, --No noticeable effect
	FLAG_TOXIC_LIQUID = 1<<43,
	FLAG_OUROBOROS_WORM = 1<<44,
	FLAG_GLAUCOMA = 1<<45,
	FLAG_BOOGERS = 1<<46,
	FLAG_PARASITOID = 1<<47,
	FLAG_UNK9 = 1<<48, --No noticeable effect
	FLAG_SPLIT = 1<<49,
	FLAG_DEADSHOT = 1<<50,
	FLAG_MIDAS = 1<<51,
	FLAG_EUTHANASIA = 1<<52,
	FLAG_JACOBS_LADDER = 1<<53,
	FLAG_LITTLE_HORN = 1<<54,
	FLAG_GHOST_PEPPER = 1<<55
}

function garden:debugMode()
	if garden.DEBUG_MODE then
		Isaac.RenderText("Debug Mode", 50, 15, 255, 255, 255, 255)
		--local currentGame = Game()
		--local currentLevel = currentGame:GetLevel()		
		--local currentRoom = Game():GetRoom()
		--local player = Isaac.GetPlayer(0)
		--local playerPosition = player.Position						
		--Isaac.RenderText("X:" .. playerPosition.X, 50, 30, 255, 255, 255, 255)
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
			local randomNum = math.random(100)  --3% chance			
			if randomNum <= 3 then
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
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_ID, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)			
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("North East", true) 
				end				
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X,pickupPosition.Y-30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_ID, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("North", true) 				
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X-30,pickupPosition.Y-30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_ID, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("North West", true) 
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X-30,pickupPosition.Y)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_ID, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("West", true) 
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X-30,pickupPosition.Y+30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_ID, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("South West", true) 
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X,pickupPosition.Y+30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_ID, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("South", true)
				end
				showGrain = math.random(2)
				if showGrain == 1 then
					position = Vector(pickupPosition.X+30,pickupPosition.Y+30)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_ID, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
					grainSprite = garden.GRAIN_SHELL:GetSprite() 
					grainSprite:Load("gfx/grain.anm2", true)							
					grainSprite:Play("South East", true)
				end
				showGrain = math.random(2)
				if showGrain == 1 then  
					position = Vector(pickupPosition.X+30,pickupPosition.Y)
					garden.GRAIN_SHELL = Isaac.Spawn(garden.GRAIN_ID, garden.GRAIN_VARIANT, garden.GRAIN_SUBTYPE, position, velocity, spawnOwner)								
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

function garden:theFirstDayEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_THE_FIRST_DAY) then		
		local currentGame = Game()
		local currentLevel = currentGame:GetLevel()		
		local currentRoom = Game():GetRoom()	
		local currentChance = currentLevel:GetAngelRoomChance()		
		local difference = 100.00-currentChance
		currentLevel:AddAngelRoomChance(difference)
	end		
end

function garden:crackTheEarthEffect()
	local player = Isaac.GetPlayer(0)
	if player:HasCollectible(garden.COLLECTIBLE_CRACK_THE_EARTH) then		
		local currentRoom = Game():GetRoom()	
		if currentRoom:GetFrameCount() % 10 == 0 then -- try only every 10th frame
			local randomNum = math.random(100) -- 1% chance
			if randomNum == 5 then
				local entities = Isaac.GetRoomEntities()
				for i = 1, #entities do
					local singleEntity = entities[i]
					if singleEntity:IsVulnerableEnemy() then		
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SHOCKWAVE, 0, singleEntity.Position, Vector(0,0), nil)
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ROCK_EXPLOSION, 0, singleEntity.Position, Vector(0,0), nil)
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
			local randomNum = math.random(1) --5% chance
			if randomNum == 1 then 				
				local player = Isaac.GetPlayer(0)
				if not player:HasFullHearts() then
					player:AddHearts(1)  --Lifesteal
					local soundShell = Isaac.Spawn(EntityType.ENTITY_NULL, 0, 0, Vector(0,0), Vector(0,0), player) --Spawn a null entity			
					local volume = 100
					local frameDelay = 0
					local loop = false
					local pitch = 1
					soundShell:ToNPC():PlaySound(SoundEffect.SOUND_VAMP_GULP, volume, frameDelay, loop, pitch)	--Make it a sound
					soundShell:Remove()	
				end
			end
		end
	end
end

function garden:gardenRoomUpdate()
	local currentLevel = Game():GetLevel()	
	local currentRoom = Game():GetRoom()	
	local currentRoomType = currentRoom:GetType()	
	if currentRoomType == RoomType.ROOM_LIBRARY then --Player is in a Garden
		if currentRoom:GetFrameCount() == 1 then  --Player just walked into a Garden
			if garden.VISIT_NUMBER == 0 then      --Player has never been in this Garden			
				garden.FIGHT_CAN_START = true			
				garden.FIGHT_HAS_STARTED = false
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
			garden.TREE_SHELL = Isaac.Spawn(garden.TREE_ID, garden.TREE_VARIANT, garden.TREE_SUBTYPE, garden.TREE_LOCATION, garden.TREE_VELOCITY, garden.TREE_SPAWN_OWNER)
			local patch = Isaac.Spawn(garden.TREE_ID, garden.PATCH_VARIANT, garden.TREE_SUBTYPE, garden.TREE_LOCATION, garden.TREE_VELOCITY, garden.TREE_SPAWN_OWNER)
			patch.RenderZOffset = -5000

			--Render grass
			local position = nil
			local grassSprite = nil
			local velocity = Vector(0,0)
			local spawnOwner = nil
			for i = 1, math.random(13) do
				position = currentRoom:GetRandomPosition(0)
				garden.GRASS_SHELL = Isaac.Spawn(garden.GRASS_ID, garden.GRASS_VARIANT, garden.GRASS_SUBTYPE, position, velocity, spawnOwner)
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

		--Check if player is activating the fight
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position
		local roomCenter = currentRoom:GetCenterPos()
		local positionalDifference = Vector(playerPosition.X-roomCenter.X, playerPosition.Y-roomCenter.Y)
		if math.abs(positionalDifference.X) < 75 and math.abs(positionalDifference.Y) < 45 then
			if garden.FIGHT_CAN_START and not garden.FIGHT_HAS_STARTED then
				
				--change music here (Garden_Serpent.ogg)				
				garden.SERPENT_LOCATION = Vector(roomCenter.X, roomCenter.Y+100)				
				Game():ShakeScreen(12)
				
				--Spawn Wave 1 (Pin)				
				garden.SERPENT_SHELL = Isaac.Spawn(garden.SERPENT_ID, garden.SERPENT_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								

				--play sfx here (Curse_of_Mortality.wav)
				local volume = 100
				local frameDelay = 0
				local loop = false
				local pitch = 1
				garden.SERPENT_SHELL:ToNPC():PlaySound("172", volume, frameDelay, loop, pitch)	

				garden.FIGHT_CAN_START = false												
				garden.barCurrentRoomDoors()				
			end				
		end

		--Checks during TheSerpent fight
		if not FIGHT_CAN_START then 
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local singleEntity = entities[i]
				if singleEntity:IsBoss() and singleEntity:IsDead() then	
					if singleEntity.Type == garden.SERPENT_ID and singleEntity.Variant == garden.SERPENT_VARIANT and singleEntity.Subtype == garden.SERPENT_SUBTYPE then						
						garden.SERPENT_LOCATION = Vector(roomCenter.X+100, roomCenter.Y)		
						garden.SERPENT_SHELL = Isaac.Spawn(garden.SERPENT_HOLLOW_ID, garden.SERPENT_HOLLOW_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
						garden.SERPENT_SHELL = Isaac.Spawn(garden.SERPENT_HOLLOW_ID, garden.SERPENT_HOLLOW_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
						garden.SERPENT_SHELL = Isaac.Spawn(garden.SERPENT_HOLLOW_ID, garden.SERPENT_HOLLOW_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
						garden.SERPENT_SHELL:ToNPC():PlaySound("172", 100, 0, false, 1)							
					elseif singleEntity.Type == garden.SERPENT_HOLLOW_ID and singleEntity.Variant == garden.SERPENT_HOLLOW_VARIANT and singleEntity.Subtype == garden.SERPENT_SUBTYPE then						
						garden.SERPENT_LOCATION = Vector(roomCenter.X-100, roomCenter.Y)		
						garden.SERPENT_SHELL = Isaac.Spawn(garden.SERPENT_LARRY_ID, garden.SERPENT_LARRY_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
						garden.SERPENT_SHELL = Isaac.Spawn(garden.SERPENT_LARRY_ID, garden.SERPENT_LARRY_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
						garden.SERPENT_SHELL = Isaac.Spawn(garden.SERPENT_LARRY_ID, garden.SERPENT_LARRY_VARIANT, garden.SERPENT_SUBTYPE, garden.SERPENT_LOCATION, garden.SERPENT_VELOCITY, garden.SERPENT_SPAWN_OWNER)								
						garden.SERPENT_SHELL:ToNPC():PlaySound("172", 100, 0, false, 1)					
					elseif singleEntity.Type == garden.SERPENT_LARRY_ID and singleEntity.Variant == garden.SERPENT_LARRY_VARIANT and singleEntity.Subtype == garden.SERPENT_SUBTYPE and not garden.ITEM_REWARDED then
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
						local startingPosition = Vector(roomCenter.X,roomCenter.Y+90)
						local pickupPosition = currentRoom:FindFreePickupSpawnPosition(startingPosition, initialStep, avoidActiveEnemies)
						local velocity = Vector(0,0)
						local spawnOwner = nil
						local randomNumber = math.random(#garden.gardenPool) 
						local randomItem = garden.gardenPool[randomNumber]			
						Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, randomItem, pickupPosition, velocity, spawnOwner)
						garden.ITEM_REWARDED = true
						table.remove(garden.gardenPool,randomNumber) --Remove the item from the pool																
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
		garden.FIGHT_CAN_START = true
		garden.FIGHT_HAS_STARTED = false
		garden.WAVE_NUMBER = 0
		garden.WAVE_ENDED = false
		garden.VISIT_NUMBER = 0 
		garden.ITEM_REWARDED = false	
	end	
end	

function garden:checkForNewRun() --Reset Flags on a new run
	garden.GARDEN_HEARTS_CAN_SPAWN = true
	garden.FIGHT_CAN_START = true
	garden.FIGHT_HAS_STARTED = false
	garden.WAVE_NUMBER = 0
	garden.WAVE_ENDED = false
	garden.VISIT_NUMBER = 0 
	garden.ITEM_REWARDED = false	

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
	garden.HAS_THE_BEAST = false
	garden.HAS_DECEIVER = false
end	

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

	if familiar.Variant == garden.BEAST_FAMILIAR_VARIANT then
		if garden.HAS_THE_BEAST then
		end
	end
end

function garden:itemPickedUp(player, statFromXML)
	local player = Isaac.GetPlayer(0)	
	
	if player:HasCollectible(garden.COLLECTIBLE_CREATION) and not garden.HAS_CREATION then
		garden.HAS_CREATION = true
		player:AddNullCostume(garden.COSTUME_ID_CREATION)	
		player.Damage = player.Damage+.51		
		player.MoveSpeed = player.MoveSpeed+.1
		player.ShotSpeed = player.ShotSpeed+.1
		local white = Color(255, 255, 255, 255, 0, 0, 0)
		player.TearColor = white		
	end


	if player:HasCollectible(garden.COLLECTIBLE_THE_FALL_OF_MAN) and not garden.HAS_THE_FALL_OF_MAN then		
		garden.HAS_THE_FALL_OF_MAN = true
		player:AddNullCostume(garden.COSTUME_ID_THE_FALL_OF_MAN)
        
        local totalHearts = player:GetMaxHearts()			
		local ignoreKeeper = true
		player:AddBlackHearts(4, ignoreKeeper)
		player:AddMaxHearts(totalHearts*-1, ignoreKeeper)

		for i = 1, totalHearts/2 do
			player.Damage = player.Damage+.5
		end		
	end	


	if player:HasCollectible(garden.COLLECTIBLE_MY_BELOVED) and not garden.HAS_MY_BELOVED then			
		garden.HAS_MY_BELOVED = true
		player:AddNullCostume(garden.COSTUME_ID_MY_BELOVED)
		local ignoreKeeper = false
		player:AddMaxHearts(2, ignoreKeeper)
		player:AddHearts(2)
		player.Luck = player.Luck+1.0		
	end

	if player:HasCollectible(garden.COLLECTIBLE_SHAME) and not garden.HAS_SHAME then									
		garden.HAS_SHAME = true
		player:AddNullCostume(garden.COSTUME_ID_SHAME)				
	end

	if player:HasCollectible(garden.COLLECTIBLE_FORBIDDEN_FRUIT) and not garden.HAS_FORBIDDEN_FRUIT then			
		garden.HAS_FORBIDDEN_FRUIT = true 
		player:AddNullCostume(garden.COSTUME_ID_FORBIDDEN_FRUIT)
		player.ShotSpeed = player.ShotSpeed+.6		 
	end

	if player:HasCollectible(garden.COLLECTIBLE_THE_FIRST_DAY) and not garden.HAS_THE_FIRST_DAY then			
		garden.HAS_THE_FIRST_DAY = true
		player:AddNullCostume(garden.COSTUME_ID_THE_FIRST_DAY)		  
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
	end

	if player:HasCollectible(garden.COLLECTIBLE_CRACK_THE_EARTH) and not garden.HAS_CRACK_THE_EARTH then			
		garden.HAS_CRACK_THE_EARTH = true  
		player:AddNullCostume(garden.COSTUME_ID_CRACK_THE_EARTH)		
	end

	if player:HasCollectible(garden.COLLECTIBLE_THE_BEAST) and not garden.HAS_THE_BEAST then			
		garden.HAS_THE_BEAST = true  
	end

	--Deceiver Tansformation
	if not garden.HAS_DECEIVER then
	    local tb = Isaac.GetItemIdByName("The Bible")
	    local bor = Isaac.GetItemIdByName("Book of Revelations")
	    local d = Isaac.GetItemIdByName("Deception")
		local fom = Isaac.GetItemIdByName("The Fall of Man")
		local possibleItems = {tb,bor,d,fom}
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
            local volume = 100
			local frameDelay = 0
			local loop = false
			local pitch = 1
			local pillText = Isaac.GetPillEffectByName("Deceiver!")
			player:UsePill(pillText,PillColor.PILL_BLUE_BLUE)
			player:StopExtraAnimation()            			
			local soundShell = Isaac.Spawn(EntityType.ENTITY_NULL, 0, 0, Vector(0,0), Vector(0,0), player) --Spawn a null entity			
			soundShell:ToNPC():PlaySound(SoundEffect.SOUND_POWERUP_SPEWER, volume, frameDelay, loop, pitch)	--Make it a sound
			soundShell:Remove()									
        end
	end
end


garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.debugMode)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.shameEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.forbiddenFruitEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.grantedDomainEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.exiledEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFirstDayEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.myBelovedEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.harvestEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.crackTheEarthEffect)

garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.gardenRoomUpdate)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.mortalityCurseEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.checkForNewLevel)
garden:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, garden.checkForNewRun)

garden:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, garden.removeMortalityCurse)
garden:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, garden.itemPickedUp)
garden:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, garden.updateFamiliar, garden.ADAM_FAMILIAR_VARIANT)
garden:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, garden.updateFamiliar, garden.BEAST_FAMILIAR_VARIANT)
garden:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, garden.deceiverEffect)