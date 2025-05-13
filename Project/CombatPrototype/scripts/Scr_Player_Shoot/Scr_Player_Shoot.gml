// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Shoot_Init()
{
	pAttackFrames = 30;
	pAttackCooldownTimer = -1;
	pAttackCooldownFrames = 10;
	
	pAttackNumber = 0;
	pAttackVolleyFinished = false;
	pAttackVolleyEndTick = 0;
}