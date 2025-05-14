// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Breaker(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
									
			stateLength = pBreakerFrames;
			
			stateNext = State_Player_Normal;
			stateNextLength = -1;
						
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			Player_Move_Tick();
			Player_Targeting_Tick();			
			
			#region Play the attack animation based on the length of the attack.
			sprite_index = SprPlayerAttack;
			image_index  = ( stateTick / stateLength ) * sprite_get_number(sprite_index);
			image_speed  = 0;
			#endregion
			
			#region Rotate the character to face her target.
			var _targetPos = [x + lengthdir_x(1, image_angle), y + lengthdir_y(1, image_angle)];
			if ( instance_exists(ObjPlayerTarget.follow) )
			{
				_targetPos = [ObjPlayerTarget.x, ObjPlayerTarget.y];
				if ( !pLockonHasTarget )
				{
					#region Rotate the character based on their current direction.

					var _mDist = point_distance (x, y, _targetPos[0], _targetPos[1]);
					var _mDir  = point_direction(x, y, _targetPos[0], _targetPos[1]);

					if ( _mDist > 1 )
					{
						image_angle = _mDir;
						if ( _targetPos[0] - x > 0 )
						{
							image_xscale = 1;
							image_yscale = 1;
						}
						else if ( _targetPos[0] - x < 0 )
						{
							image_xscale = 1;
							image_yscale = -1;
						}
					}
				
					#endregion
				}
			}
			#endregion
			
			#region Shoot the bullet!
		
			if ( stateTick == round(stateLength * 0.5) )
			{
				audio_play_sound(SndPlayerBreaker, 10, 0);
				var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
				var _bulDir = _aimDir;
			
				var _len = 256;
				var _dir = _aimDir;
				var _lX  = lengthdir_x(_len, _dir);
				var _lY  = lengthdir_y(_len, _dir);
			
				var _bullet = instance_create_layer(_targetPos[0], _targetPos[1], layer, ObjProjPlayer_Critical);
				_bullet.projDir = _bulDir;
				_bullet.element = playerElementCurrent;		
			}
		
			#endregion
			
			if ( pAttackCooldownTimer  >= 0 ) { pAttackCooldownTimer--;  }	
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
			if ( pSkillCooldownTimer   >= 0 ) { pSkillCooldownTimer--;   }
			Player_Energy_Tick();
			Player_Skills_Tick();
						
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			pBreakerCooldownTimer = pBreakerCooldownFrames;
			#endregion
			break;
	}
}