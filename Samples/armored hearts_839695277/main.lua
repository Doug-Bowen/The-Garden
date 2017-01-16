local ArmoredHearts = RegisterMod("Armored Hearts", 1)

local ArmoredFullVariant = Isaac.GetEntityVariantByName("Armored Heart")

local ArmorFullUI = Sprite()
local ArmorHalfUI = Sprite()

ArmorFullUI:Load("gfx/ui/armoredheartfull.anm2", true)
ArmorFullUI:Play("ArmoredHeartFull", false)

ArmorHalfUI:Load("gfx/ui/halfarmoredheart.anm2", true)
ArmorHalfUI:Play("HalfArmoredHeart", false)

local ArmoredHeartCount = 0.0
local ArmoredHeartMax

local damageCooldown = -1

local function CheckIsNewGame()
	local level = Game():GetLevel()
	return Game():GetVictoryLap() == 0 and level:GetCurrentRoomIndex() == level:GetStartingRoomIndex() and level:GetCurrentRoom():IsFirstVisit() and level.EnterDoor == -1
end

local FirstLoad = false
local SaveData = false

function ArmoredHearts:OnUpdate()
	local player = Isaac.GetPlayer(0)
	local entities = Isaac.GetRoomEntities()
	
	if(damageCooldown > 0) then
		damageCooldown = damageCooldown - 1
	end
	
	if FirstLoad then
		FirstLoad = false
		if CheckIsNewGame() then
			ArmoredHeartCount = 0.0
			SaveData = true
		else
			ArmoredHeartCount = tonumber(Isaac.LoadModData(ArmoredHearts))
		end
	end
	
	if SaveData and player:IsFrame(30, 0) then
		Isaac.SaveModData(ArmoredHearts, tostring(ArmoredHeartCount))
		SaveData = false
	end
	
	if Game():GetLevel():GetCurrentRoom():IsFirstVisit() then
		if(math.random(100) == 15) then
			Game():Spawn(EntityType_ENTITY_PICKUP, ArmoredFullVariant, Game():GetRoom():GetRandomPosition(10), Vector(0,0), player, 1, Game():GetLevel():GetDungeonPlacementSeed())
		end
	end
	
	for i = 1, #entities do
		local e = entities[i]
		
		if(e.Type == EntityType.ENTITY_PICKUP and e.Variant == ArmoredFullVariant) then
			if(e.FrameCount > 33) then
				local posHeart = e.Position
				local posPlayer = player.Position
			
				local distBetween = posHeart.Distance(posHeart, posPlayer)
			
				if(distBetween <= 26 and not e:IsDead()) then
					e:GetSprite():Play("Collect", false)
					e:Die()
					
					local IsaacHearts = (player:GetMaxHearts() + player:GetSoulHearts()) / 2
					
					if(ArmoredHeartCount < IsaacHearts) then
						if(IsaacHearts == ArmoredHeartCount + 0.5) then
							ArmoredHeartCount = IsaacHearts
							
							SaveData = true
						else
							ArmoredHeartCount = ArmoredHeartCount + 1.0
							
							SaveData = true
						end
					end
				end
			end
		end
	end
end

function ArmoredHearts:OnRender()
	ArmorFullUI:SetOverlayRenderPriority(true)
	
	local player = Isaac.GetPlayer(0)
	
	local ZeroVector = Vector(0, 0)
	
	local yOffset = 0
	
	local HeartFull = math.floor(ArmoredHeartCount)
	local HeartHalf = ArmoredHeartCount - HeartFull
	
	if(((player:GetMaxHearts() + player:GetSoulHearts()) / 2) > 6) then
		yOffset = yOffset + 10
	end
	
	if not(Game():GetLevel():GetCurses() == LevelCurse.CURSE_OF_THE_UNKNOWN) then
		if(HeartFull > 0) then
			for i = 1, HeartFull, 1 do
				if(i < 7) then
					local TopVector = Vector(36 + (i * 12), 22 + yOffset)
		
					ArmorFullUI:Render(TopVector, ZeroVector, ZeroVector)
				else
					local TopVector = Vector(36 + ((i - 6) * 12), 32 + yOffset)
		
					ArmorFullUI:Render(TopVector, ZeroVector, ZeroVector)
				end
			end
		end
	
		if(HeartHalf > 0) then
			if(HeartFull < 7) then
				local TopVector = Vector(36 + ((HeartFull + 1) * 12), 22 + yOffset)
		
				ArmorHalfUI:Render(TopVector, ZeroVector, ZeroVector)
			else
				local TopVector = Vector(36 + (((HeartFull + 1) - 6) * 12), 32 + yOffset)
				
				ArmorHalfUI:Render(TopVector, ZeroVector, ZeroVector)
			end
		end
	end
end

function ArmoredHearts:OnDamageTaken(damageTaker, damageAmnt, damageFlag, damageSource, damageCountdown)
	if(ArmoredHeartCount > 0. and damageCooldown <= 0) then
		damageTaker:TakeDamage(0.0, DamageFlag.DAMAGE_FAKE, EntityRef(EntityType_ENTITY_LASER), damageCountdown * 60)
		damageCooldown = damageCountdown
		
		ArmoredHeartCount = ArmoredHeartCount - (damageAmnt * 0.5)
		if(ArmoredHeartCount <= 0.0) then
			ArmoredHeartCount = 0.0
			
			SaveData = true
			return false
		else
			
			SaveData = true
			return false
		end
	elseif(damageCooldown > 0) then
		return false
	else
		return true
	end
end

local function onPlayerInit()
	FirstLoad = true
end

ArmoredHearts:AddCallback(ModCallbacks.MC_POST_UPDATE, ArmoredHearts.OnUpdate)
ArmoredHearts:AddCallback(ModCallbacks.MC_POST_RENDER, ArmoredHearts.OnRender)
ArmoredHearts:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, ArmoredHearts.OnDamageTaken, EntityType.ENTITY_PLAYER)
ArmoredHearts:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, onPlayerInit)