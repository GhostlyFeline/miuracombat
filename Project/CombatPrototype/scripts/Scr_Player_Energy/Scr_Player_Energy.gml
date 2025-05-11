// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Energy_Init()
{
	pEnergyMax = 50;
	pEnergy = pEnergyMax;
	
	pEnergyRegen = 0.01;
}


function Player_Energy_Tick()
{
	pEnergy = min(pEnergy + pEnergyRegen, pEnergyMax);
}