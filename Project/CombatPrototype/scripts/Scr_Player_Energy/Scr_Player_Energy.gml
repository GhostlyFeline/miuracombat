// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Energy_Init()
{
	pEnergyMax = 100;
	pEnergy = pEnergyMax;
	
	pEnergyRegen = 10 / ( game_get_speed(gamespeed_fps) * 5 );
}


function Player_Energy_Tick()
{
	pEnergy = clamp(pEnergy + pEnergyRegen, 0, pEnergyMax);
}