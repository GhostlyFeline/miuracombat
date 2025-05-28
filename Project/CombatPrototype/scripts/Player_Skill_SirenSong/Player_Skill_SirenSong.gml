// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Skill_SirenSong(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
						
			audio_sound_pitch(SndPlayerSirenSong, 1 + (min(pSirenSongStacks, pSirenSongStackMax - 1) * 0.12) );
			Sound_Play(enumSoundFxList.playerSirenSong);
			
			pSirenSongTimer = pSirenSongFrames;
			
			stateLength = 60;
			pSkillCooldownFrames = 180;
			pSirenSongStacks = min(pSirenSongStacks + 1, pSirenSongStackMax);
			
			pSkillCooldownTimer = pSkillCooldownFrames;
			
			
			stateNext = State_Player_Normal;
			stateNextLength = -1;
						
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			Player_Move_Tick();
			Player_Targeting_Tick();
			
			pMoveSpeedMulti = 0.33;
			pSirenSongTimer = pSirenSongFrames;
			
			if ( stateTick mod 5 == 0 )
			{
				with (FxHandler)
				{					
					repeat(3)
					{
						var _len = random_range(150, 200);
						var _dir = random(360);
						var _pos = [_self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir)];				
						part_particles_create(fxSysGlobalAbove, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_skillSirenNote00], 1 );
					}
				}
			}
			
			if ( pAttackCooldownTimer  >= 0 ) { pAttackCooldownTimer--;  }
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
			Player_Spell_Tick();
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