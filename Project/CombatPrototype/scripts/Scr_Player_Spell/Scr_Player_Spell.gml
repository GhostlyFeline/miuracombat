// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Spell_Init()
{	
	pSpellCharges = 0;
	pSpellChargeMax = 2;
	pSpellChargeTimer = 0;
	pSpellChargeFrames = 30;
	pSpellChargeCircleRot = 0;
	
	pBreakerFrames = 35;
	pBreakerCooldownTimer = -1;
	pBreakerCooldownFrames = ( game_get_speed(gamespeed_fps) * 3 );
	pBreakerEnergyCost = 10;
	
	pMagicFrames = 35;
	pMagicCooldownTimer = -1;
	pMagicCooldownFrames = ( game_get_speed(gamespeed_fps) * 5 );
	pMagicEnergyCost = 20;
	
	pUltFrames = 35;
	pUltCooldownTimer = -1;
	pUltCooldownFrames = ( game_get_speed(gamespeed_fps) * 10 );
	pUltEnergyCost = 40;
	
	pSpellChargeCosts = [ pBreakerEnergyCost, pMagicEnergyCost, pUltEnergyCost ];
}

function Player_Spell_Tick()
{
	if ( pBreakerCooldownTimer >= 0 )
	{
		if ( pBreakerCooldownTimer == 0 ) { drawSpellFinishTimer[0] = drawSpellFinishFrames[0]; }
		pBreakerCooldownTimer--;
	}	
	
	if (pMagicCooldownTimer >= 0 )
	{
		if ( pMagicCooldownTimer == 0 ) { drawSpellFinishTimer[1] = drawSpellFinishFrames[1]; }
		pMagicCooldownTimer--;
	}	
	
	if ( pUltCooldownTimer >= 0 )
	{
		if ( pUltCooldownTimer == 0 ) { drawSpellFinishTimer[2] = drawSpellFinishFrames[2]; }
		pUltCooldownTimer--;
	}	
}