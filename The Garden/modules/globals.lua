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
