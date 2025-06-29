// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Skills_Init()
{
	pSkillCooldownTimer  = 0;
	pSkillCooldownFrames = 60;
	pSkillEnergyCost = 20;
	pSkillCurrent = State_Player_Skill_SirenSong;
	
	pSirenSongEnergyCost = 30;
	pSirenSongTimer = 0;
	pSirenSongFrames = game_get_speed(gamespeed_fps) * 15;	
	pSirenSongHealthRegen = ( charHealthMax / 20 ) / ( game_get_speed(gamespeed_fps) * 5 ); 
	pSirenSongStacks = 0;
	pSirenSongStackMax = 2;
	
	pIceShieldEnergyCost  = 20;
	pIceShieldEnergyDrain = 0.025;	
	pIceShieldHasParried = false;
	pIceShieldParryFrames = 30;
	pIceShieldParryRecoverPercent = 0.5;	
	pIceArmorTimer = 0;
	pIceArmorFrames = game_get_speed(gamespeed_fps) * 5;
	pIceArmorMultiplier = 1;
	
	pMagmaAuraEnergyCost = 30;
	pMagmaAuraTimer = 0;
	pMagmaAuraFrames = game_get_speed(gamespeed_fps) * 5;
	pMagmaAuraStacks = 0;
	pMagmaAuraRange = 768;
	
	pPurifyEnergyCost = 30;
	pPurifyTimer = 0;
	pPurifyFrames = ( game_get_speed(gamespeed_fps) * 3 );
	pPurifyStacks = 0;
}

function Player_Skills_Tick()
{	
	var _self = id;
	
	if ( charHealth <= 0 ) return -1;
	
	switch ( pSkillCurrent )
	{
		case State_Player_Skill_SirenSong:
			pSkillEnergyCost = pSirenSongEnergyCost;
			pSkillCooldownFrames = 180;
			break;
			
		case State_Player_Skill_IceShield:
			pSkillEnergyCost = pIceShieldEnergyCost;
			pSkillCooldownFrames = 180;
			break;
			
		case State_Player_Skill_MagmaAura:
			pSkillEnergyCost = pMagmaAuraEnergyCost;
			pSkillCooldownFrames = 180;
			break;
			
		case State_Player_Skill_Purify:
			pSkillEnergyCost = pPurifyEnergyCost;
			pSkillCooldownFrames = 180;
			break;
	}
	
	if ( pSkillCooldownTimer > pSkillCooldownFrames ) { pSkillCooldownTimer = pSkillCooldownFrames; }
	
	#region Siren Song
	if ( pSirenSongTimer >= 0 && pSirenSongStacks > 0 )
	{
		charHealth = min( charHealth + ( pSirenSongHealthRegen * pSirenSongStacks ), charHealthMax );
		if ( tick mod round( 15 / _self.pSirenSongStacks) == 0 )
		{
			with (FxHandler)
			{	
				var _pos = [random_range(_self.bbox_left, _self.bbox_right), random_range(_self.bbox_top, _self.bbox_bottom)];				
				part_particles_create(fxSysGlobalAbove, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_regenCross00], 1 );
			}
		}
		
		pSirenSongTimer--;
	}
	else
	{
		pSirenSongStacks = 0;
	}
	#endregion
	
	#region Crystal Armor
	if ( pIceArmorTimer >= 0 )
	{
		pIceArmorMultiplier = 0.5;
		
		if ( pIceArmorTimer > 0 )
		{
			with (FxHandler)
			{					
				repeat(2)
				{
					var _len = random(100);
					var _dir = random(360);
					var _pos = [_self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir)];				
					part_particles_create(fxSysGlobalAbove, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_skillIceSpark00], 1 );
				}
			}
		}
		
		pIceArmorTimer--;
	}
	else
	{
		pIceArmorMultiplier = 1;
	}
	#endregion
	
	#region Magma Aura
	if ( pMagmaAuraTimer >= 0 )
	{		
		if ( pMagmaAuraTimer > 0 )
		{
			with (FxHandler)
			{
				var _len = random_range(0, 64);
				var _dir = random(360);
				var _pos = [_self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir)];				
				part_particles_create(fxSysGlobalBelow, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_skillMagmaChargeSpark00], 1 );
			}
		
			with ( ObjProjPlayer ) { magmaAuraMulti = 2.0; }		
			with ( ObjProjPlayer_Critical ) { magmaAuraMulti = 2.0; }				
		}
		
		pMagmaAuraTimer--;
	}
	else
	{
		with ( ObjProjPlayer          ) { magmaAuraMulti = 1; }
		with ( ObjProjPlayer_Critical ) { magmaAuraMulti = 1; }
		with ( ObjProjPlayer_Magma ) { if ( tick < lifetime - 30 ) { tick = lifetime - 30; } }
	}
	#endregion
}