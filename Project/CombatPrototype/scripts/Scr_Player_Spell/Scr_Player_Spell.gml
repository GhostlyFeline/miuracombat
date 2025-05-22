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
	pBreakerCooldownFrames = 60;
	pBreakerEnergyCost = 10;
	
	pMagicFrames = 35;
	pMagicCooldownTimer = -1;
	pMagicCooldownFrames = 60;
	pMagicEnergyCost = 20;
	
	pUltFrames = 35;
	pUltCooldownTimer = -1;
	pUltCooldownFrames = 60;
	pUltEnergyCost = 40;
	
	pSpellChargeCosts = [ pBreakerEnergyCost, pMagicEnergyCost, pUltEnergyCost ];
}