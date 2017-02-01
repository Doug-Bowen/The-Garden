--------------------
--Flag Controllers--
--------------------

function garden:setNewFloorFlags()
	local currentLevel = Game():GetLevel()
	if currentLevel:GetStage() ~= garden.CURRENT_LEVEL then
		garden.CURRENT_LEVEL = currentLevel:GetStage()
		garden.GARDEN_HEARTS_CAN_SPAWN = true
		garden.FIGHT_CAN_START = true		
		garden.WAVE_NUMBER = 0		
		garden.VISIT_NUMBER = 0 
		garden.ITEM_REWARDED = false	
	end	
end	

function garden:setNewRunFlags()
	garden.GARDEN_HEARTS_CAN_SPAWN = true
	garden.FIGHT_CAN_START = true	
	garden.WAVE_NUMBER = 0	
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