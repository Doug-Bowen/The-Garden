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
		if currentRoom:GetFrameCount() % 50 == 0 then -- Only every 50th frame
			local entities = Isaac.GetRoomEntities()
			for i = 1, #entities do
				local randomNum = math.random(100) -- 5% chance per luck
				if randomNum <= ((player.Luck + 1) * 5) then
					local singleEntity = entities[i]
					if singleEntity:IsVulnerableEnemy() and not singleEntity:IsFlying() and not singleEntity:IsBoss() then		
						Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ROCK_EXPLOSION, 0, singleEntity.Position, Vector(0,0), nil)
						singleEntity:TakeDamage(10.0,0,EntityRef(player),0)
						local soundShell = Isaac.Spawn(EntityType.ENTITY_NULL, 0, 0, Vector(0,0), Vector(0,0), player) --Spawn a null entity			
						local volume = 3
						local frameDelay = 0
						local loop = false
						local pitch = 1
						soundShell:ToNPC():PlaySound(SoundEffect.SOUND_ROCK_CRUMBLE, volume, frameDelay, loop, pitch)	--Make it a sound
						soundShell:Remove()	
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
					local volume = 5
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
					local soundShell = Isaac.Spawn(EntityType.ENTITY_NULL, 0, 0, Vector(0,0), Vector(0,0), player) --Spawn a null entity			
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, singleEntity.Position, Vector(0,0), nil)				
					local volume = 3
					local frameDelay = 0
					local loop = false
					local pitch = 1
					soundShell:ToNPC():PlaySound("174", volume, frameDelay, loop, pitch)	--Make it a sound
					soundShell:Remove()	
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
								
				local soundShell = Isaac.Spawn(EntityType.ENTITY_NULL, 0, 0, Vector(0,0), Vector(0,0), player) --Spawn a null entity			
				local volume = 3
				local frameDelay = 0
				local loop = false
				local pitch = 1
				soundShell:ToNPC():PlaySound("177", volume, frameDelay, loop, pitch)	--Make it a sound
				soundShell:Remove()	
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
				legionData.Laser.RenderZOffset = -5000 --Below characters
				legionData.Laser.MaxDistance = distance
				legionData.Laser.OneHit = false  --Greatly strengthens the brimstone shot
				legionData.FireDirection = direction --Fires the laser				
			end
		end
	end
end