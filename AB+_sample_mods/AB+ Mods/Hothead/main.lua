local	hothead = RegisterMod( "Hothead" );
local	pyrokinesis_item = Isaac.GetItemIdByName( "Pyrokinesis" )

function hothead:use_pyrokinesis( )
	local	player = Isaac.GetPlayer( )
	local	entities = Isaac.GetRoomEntities( )
	for i = 1, #entities do
		if entities[ i ]:IsVulnerableEnemy( ) then
			entities[ i ]:AddBurn( EntityRef( player ), 120, 1.0 )
		end
	end
end

hothead:AddCallback( ModCallbacks.MC_USE_ITEM, hothead.use_pyrokinesis, pyrokinesis_item );