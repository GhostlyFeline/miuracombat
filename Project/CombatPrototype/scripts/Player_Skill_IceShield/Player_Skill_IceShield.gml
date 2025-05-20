// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Skill_IceShield(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
						
			Sound_Play(enumSoundFxList.playerIceShield);
						
			stateLength = -1;			
			
			pSkillCooldownFrames = 60;
			pSkillCooldownTimer = pSkillCooldownFrames;
			
			invincible = true;
			
			pIceShieldHasParried = false;
			
			stateNext = State_Player_Normal;
			stateNextLength = -1;
						
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			Player_Move_Tick();
			Player_Targeting_Tick();
			
			pMoveSpeedMulti = 0.25;	
			
			
			if ( stateTick <= pIceShieldParryFrames )
			{
				if ( stateTick == 1 ) { Character_Flash_Activate(pIceShieldParryFrames, 1, merge_color(c_aqua, c_white, 0.5), 1.0, true, 10); }
				if ( graze )
				{
					if ( !pIceShieldHasParried )
					{
						pEnergy += ( pIceShieldEnergyCost * pIceShieldParryRecoverPercent );
						pIceShieldHasParried = true;
						global.hitstopTimer = 5;
						Sound_Play(enumSoundFxList.playerIceParry);
						
						with (FxHandler)
						{					
							repeat(5)
							{
								var _len = 0;
								var _dir = random(360);
								var _pos = [_self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir)];				
								part_particles_create(fxSysGlobalAbove, _pos[0], _pos[1], fxType[enumFxType.pFxProj_iceHitSpark00], 1 );
							}
						}
					}
					
					graze = false;
				}
			}
			else
			{
				if ( pEnergy <= 0 || !input_check("skill") )
				{
					State_Change(State_Player_Normal);
				}
				else
				{
					if ( stateTick mod 3 == 0 ) { Character_Flash_Activate(3, 1, merge_color(c_aqua, c_white, 0.5), 0.25, true, 10); }
					pEnergy = max( pEnergy - pIceShieldEnergyDrain, 0);
				}
			}					
			
			if ( stateTick mod 5 == 0 )
			{
				with (FxHandler)
				{					
					repeat(3)
					{
						var _len = random(100);
						var _dir = random(360);
						var _pos = [_self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir)];				
						part_particles_create(fxSysGlobalAbove, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_skillIceSpark00], 1 );
					}
				}
			}
			
			
			if ( pAttackCooldownTimer  >= 0 ) { pAttackCooldownTimer--;  }
			if ( pBreakerCooldownTimer >= 0 ) { pBreakerCooldownTimer--; }		
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
			Player_Skills_Tick();
						
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			pMoveSpeedMulti = 1;
			invincible = false;
			#endregion
			break;
	}
}