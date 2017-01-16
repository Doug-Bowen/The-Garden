local   fartboy = RegisterMod( "fart_boy", 1 );
local   challenge_id = Isaac.GetChallengeIdByName( "Fart Boy" );

function fartboy:Update( )
    if Isaac.GetChallenge( ) ~= challenge_id then
        return;
    end
    local   player = Isaac.GetPlayer( 0 );
    if Isaac.GetFrameCount( ) % ( player:GetMaxFireDelay( ) * 4 ) == 0 then
        local Entities = Isaac.GetRoomEntities( )
        local EnemiesRemaining = false
        for i = 1, #Entities do
            if Entities[ i ]:IsVulnerableEnemy( ) then
                EnemiesRemaining = true;
                break;
            end
        end
        if EnemiesRemaining then
            Isaac.Spawn( EntityType.ENTITY_BOMBDROP, player:GetBombVariant( 0, 0 ), 10, player.Position, Vector( 0.0, 0.0 ), player );
            Isaac.Spawn( EntityType.ENTITY_EFFECT, 34, 0, player.Position, Vector( 0.0, 0.0 ), player );
        end
    end
end

fartboy:AddCallback( ModCallbacks.MC_POST_UPDATE, fartboy.Update );
