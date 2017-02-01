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
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.theFirstDayEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.myBelovedEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.harvestEffect)
garden:AddCallback(ModCallbacks.MC_POST_UPDATE, garden.crackTheEarthEffect)
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
garden:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, garden.updateFamiliar, garden.BEAST_FAMILIAR_VARIANT)