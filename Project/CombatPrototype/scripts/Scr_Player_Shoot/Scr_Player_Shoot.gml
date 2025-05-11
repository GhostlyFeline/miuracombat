// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Shoot_Init()
{
	pAttackA_animTimer = -1;
	pAttackA_frames = 30;
	pAttackCooldownTimer = -1;
	pAttackCooldownFrames = 10;
	
	pAttackNumber = 0;
}


function Player_Shoot_Tick()
{
	//Activate the attack when Shoot is pressed.
	if ( input_check("shoot") && pAttackA_animTimer < 0 && pBreaker_animTimer < 0 && pAttackCooldownTimer < 0 && pElementSwap_animTimer < 0 && pDashA_animTimer < 0 ) { pAttackA_animTimer = 0; pElementSwap_animTimer = -1; }
	
	#region Modify attack speed based on element type.
	switch(playerElementCurrent)
	{
		case enumProjPlayerElement.spirit: pAttackA_frames = 20; break;
		case enumProjPlayerElement.light: pAttackA_frames = 10; break;
		case enumProjPlayerElement.ice:   pAttackA_frames = 30; break;
		case enumProjPlayerElement.fire:  pAttackA_frames = 50; break;
	}
	#endregion

	if ( pAttackA_animTimer >= 0 )
	{			
		#region Play the attack animation based on the length of the attack.
		sprite_index = SprPlayerAttack;
		image_index  = (pAttackA_animTimer / pAttackA_frames) * sprite_get_number(sprite_index);
		image_speed  = 0;
		#endregion
		
		#region Rotate the character to face her target.
		var _targetPos = [x + lengthdir_x(1024, image_angle), y + lengthdir_y(1024, image_angle)];
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
		
		switch(playerElementCurrent)
		{
			default:
			case enumProjPlayerElement.spirit:
				#region Spirit
				if ( pAttackA_animTimer == 8 || pAttackA_animTimer == 11 || pAttackA_animTimer == 14 )
				{
					audio_play_sound(SndPlayerShot, 10, 0);
					var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
					var _bulDir = _aimDir;
			
					var _bullet = instance_create_layer(x, y, layer, ObjProjPlayer);
					_bullet.projSpd = 50;
					_bullet.projDir = _bulDir;
					_bullet.damage = 5;
					_bullet.stunDamage = 4;
					_bullet.element = playerElementCurrent;		
					
					
					pAttackNumber++;
				}
				#endregion
				break;
			
			case enumProjPlayerElement.light:
				#region Light
				if ( pAttackA_animTimer == 8 )
				{
					audio_play_sound(SndPlayerShot, 10, 0);
					var _bulletNum = 3;
		
					for (var i = 0; i < _bulletNum; i++;)
					{
						var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
						var _bulDir = _aimDir + lerp(-10, 10, i / (_bulletNum - 1) );
			
						var _bullet = instance_create_layer(x, y, layer, ObjProjPlayer);
						_bullet.projSpd = 60;
						_bullet.projDir = _bulDir;
						_bullet.projScale *= 2.0;
						_bullet.damage = 5;
						_bullet.stunDamage = 4;
						_bullet.element = playerElementCurrent;
						_bullet.penetrate = true;
					}
					
					
					pAttackNumber++;
				}
				#endregion
				break;
			
			case enumProjPlayerElement.fire:
				#region Fire
				
				
				if ( pAttackA_animTimer == 8 || pAttackA_animTimer == 16 || pAttackA_animTimer == 24 )
				{
					audio_play_sound(SndPlayerShot, 10, 0);
										
					var _len = 128;
					var _dir = ( (360 / 3) * pAttackNumber ) + point_direction(x, y, _targetPos[0], _targetPos[1]);
					var _lX  = lengthdir_x(_len, _dir);
					var _lY  = lengthdir_y(_len, _dir);
					
					var _bullet = instance_create_layer(x + _lX, y + _lY, layer, ObjProjPlayer);
					var _aimDir = point_direction(_bullet.x, _bullet.y, _targetPos[0], _targetPos[1]);
					_bullet.projSpd = 40;
					_bullet.projDir = _aimDir;
					_bullet.projScale *= 3.0;
					_bullet.damage = 15;
					_bullet.stunDamage = 12;
					_bullet.element = playerElementCurrent;			
					_bullet.projMovePause = true;
					
					pAttackNumber++;
				}
				
				with ( ObjProjPlayer ) { if ( projMovePause ) { projDir = point_direction(x, y, _targetPos[0], _targetPos[1]); } }
				
				if ( pAttackA_animTimer == 32 ) { with ( ObjProjPlayer ) { projMovePause = false; } }				
				
				#endregion
				break;
			
			case enumProjPlayerElement.ice:
				#region Ice
				if ( pAttackA_animTimer == 8 )
				{
					audio_play_sound(SndPlayerShot, 10, 0);
					var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
					var _bulDir = _aimDir;
			
					var _bullet = instance_create_layer(x, y, layer, ObjProjPlayer);
					_bullet.projSpd = 30;
					_bullet.projDir = _bulDir;
					_bullet.projScale *= 2;
					_bullet.damage = 10;
					_bullet.stunDamage = 8;
					_bullet.element = playerElementCurrent;
					
					pAttackNumber++;
				}
				#endregion
				break;
		}	
		
		#endregion
	
		pAttackA_animTimer++;
		
		if ( pAttackA_animTimer > pAttackA_frames )
		{
			#region End the attack.
			pAttackA_animTimer = -1;
			sprite_index = SprPlayerIdle;
			image_index  = 0;
			image_speed  = 1;
			pAttackCooldownTimer = pAttackCooldownFrames;
			#endregion
		}
	}
	else
	{
		pAttackNumber = 0;
	}

	if ( pAttackCooldownTimer >= 0 ) { pAttackCooldownTimer--; }
}