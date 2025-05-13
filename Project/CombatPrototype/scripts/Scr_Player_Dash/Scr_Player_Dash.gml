// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Dash_Init()
{
	pDashFrames = 24;
	pDashCooldownTimer = -1;
	pDashCooldownFrames = 40;
	pDashLastDir = 0;
	pDashEnergyCost = 10;
}