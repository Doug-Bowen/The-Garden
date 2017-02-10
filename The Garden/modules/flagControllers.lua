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
	garden.gardenPool[7] = garden.COLLECTIBLE_MANKIND
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
	garden.HAS_MANKIND = false
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