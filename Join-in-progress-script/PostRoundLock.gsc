#include maps\mp_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm_hud_util;
#include maps\mp\gametypes_zm_hud_message;

init()
{
    SetDvar( "password", "" );
    SetDvar( "g_password", "" );
    level thread SetPasswordsOnRound( 10 );
}

setPasswordsOnRound( roundNumber )
{
    self endon( "disconnect" );
    while( true ) 
    {
        level waittill( "between_round_over");
        if( level.round_number >= roundNumber )
        {
            pin = generateString();
            setDvar( "g_password", pin );
            level thread messageRepeat( ( "Server is now locked. Use password ^5" + pin + " ^7to rejoin." ) );
            break;
        }
    }
}

messageRepeat( message )
{
    self endon( "disconnect" );
    while( true )
    {
        iPrintLn( message );
        level waittill( "between_round_over");
    }
}

generateString()
{
    str = "";

    for( i = 0; i < 4; i++ )
    {
        str = str + randomInt( 10 );
    }

    return str;
}
