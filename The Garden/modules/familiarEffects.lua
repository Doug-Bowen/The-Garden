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