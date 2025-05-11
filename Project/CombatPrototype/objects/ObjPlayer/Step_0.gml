/// @description Insert description here
// You can write your code in this editor

Character_Flash_Tick();
Character_Shake_Tick();
Character_Kickback_Tick();

tick++;

if ( global.hitstopActive ) { exit; }

if ( !Player_Element_Menu_Tick() )
{
	Player_Move_Tick();
	Player_Dash_Tick();
	Player_Targeting_Tick();
	Player_Breaker_Tick();
	Player_Shoot_Tick();
	Player_Energy_Tick();
}