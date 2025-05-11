// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Breaker_Init()
{
	pBreaker_animTimer = -1;
	pBreaker_frames = 35;
	pBreakerCooldownTimer = -1;
	pBreakerCooldownFrames = 60;
}


function Player_Breaker_Tick()
{
	//Activate the attack when Shoot is pressed.
	if ( input_check("breaker") && pAttackA_animTimer < 0 && pBreaker_animTimer < 0 && pBreakerCooldownTimer < 0 && pElementSwap_animTimer < 0 && pDashA_animTimer < 0 ) { pBreaker_animTimer = 0; pElementSwap_animTimer = -1; }
	

	if ( pBreaker_animTimer >= 0 )
	{			
		#region Play the attack animation based on the length of the attack.
		sprite_index = SprPlayerAttack;
		image_index  = (pBreaker_animTimer / pBreaker_frames) * sprite_get_number(sprite_index);
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
		
		if ( pBreaker_animTimer == round(pBreaker_frames * 0.5) )
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
	
		pBreaker_animTimer++;
		
		if ( pBreaker_animTimer > pBreaker_frames )
		{
			#region End the attack.
			pBreaker_animTimer = -1;
			sprite_index = SprPlayerIdle;
			image_index  = 0;
			image_speed  = 1;
			pBreakerCooldownTimer = pBreakerCooldownFrames;
			#endregion
		}
	}

	if ( pBreakerCooldownTimer >= 0 ) { pBreakerCooldownTimer--; }
}