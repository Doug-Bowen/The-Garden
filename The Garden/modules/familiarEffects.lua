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

	if familiar.Variant == garden.LEGION_FAMILIAR_VARIANT then
		if garden.HAS_LEGION then
			local currentRoom = Game():GetRoom()
			if currentRoom:GetFrameCount() == 1 then --Prepare to move to room center
				garden.LEGION_MOVE = true
				familiar.Velocity = Vector(0,0) --Ensures that if incorrect velocity is ever applied to The LEGION in a room, velocity is reset on new room.
			end

			--Move to room's center
			local roomCenter = currentRoom:GetCenterPos()
			local familiarPosition = familiar.Position
			local positionalDifference = Vector(roomCenter.X-familiarPosition.X, roomCenter.Y-familiarPosition.Y)
			if garden.LEGION_MOVE then
				if math.abs(roomCenter.X) ~= math.abs(familiarPosition.X) or math.abs(roomCenter.Y) ~= math.abs(familiarPosition.Y) then 
					familiar:MultiplyFriction(0.02) --Slow that sucker down
					if positionalDifference.X > 0 then
						familiar:AddVelocity(Vector(0.2,0))
					end
					if positionalDifference.X < 0 then
						familiar:AddVelocity(Vector(-0.2,0))
					end
					if positionalDifference.Y > 0 then
						familiar:AddVelocity(Vector(0,0.2))
					end
					if positionalDifference.Y < 0 then
						familiar:AddVelocity(Vector(0,-0.2))
					end	
				else
					garden.LEGION_MOVE = false
				end	
			end
			
			--Stop moving if room is clear
			if currentRoom:IsClear() then
				garden.LEGION_MOVE = false
				familiar.Velocity = Vector(0,0)
			end

			Isaac.RenderText("X:" .. positionalDifference.X, 50, 30, 255, 255, 255, 255)
			Isaac.RenderText("X:" .. positionalDifference.Y, 50, 45, 255, 255, 255, 255)

			--Room center effect
			if math.abs(positionalDifference.X) < 1 and math.abs(positionalDifference.Y) < 1 and not garden.LEGION_MOVE then 
				local player = Isaac.GetPlayer(0)	
				familiarSprite = familiar:GetSprite() 
				familiarSprite:Play("FloatUp", true)
				local randomNum = math.random(100)
				if randomNum <= player.Luck then --Luck-based frequency
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SHOCKWAVE, 0, familiar.Position, Vector(0,0), nil)
					local soundShell = Isaac.Spawn(EntityType.ENTITY_NULL, 0, 0, Vector(0,0), Vector(0,0), player) --Spawn a null entity			
					local volume = 30
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