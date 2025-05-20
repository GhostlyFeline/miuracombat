// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Skill_MagmaAura(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
						
			Sound_Play(enumSoundFxList.playerMagmaAura);
			
			pMagmaAuraTimer = pMagmaAuraFrames;
			
			stateLength = 60;
			pSkillCooldownFrames = 60;
			
			pSkillCooldownTimer = pSkillCooldownFrames;
			
			
			stateNext = State_Player_Normal;
			stateNextLength = -1;
						
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			Player_Move_Tick();
			Player_Targeting_Tick();
			
			pMoveSpeedMulti = 0.25;
			pMagmaAuraTimer = pMagmaAuraFrames;
			
			if ( stateTick mod 5 == 0 )
			{
				with (FxHandler)
				{					
					repeat(3)
					{
						var _len = random_range(0, 128);
						var _dir = random(360);
						var _pos = [_self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir)];				
						part_particles_create(fxSysGlobalAbove, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_skillMagmaChargeSpark00], 1 );
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
			#endregion
			break;
	}
}