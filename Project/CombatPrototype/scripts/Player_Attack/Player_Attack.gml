// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function State_Player_Attack(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
			
			pAttackNumber = 0;
			pAttackVolleyFinished = false;
			pAttackVolleyEndTick = 0;
			
			#region Modify attack speed based on element type.
			
			switch(playerElementCurrent)
			{
				case enumProjPlayerElement.spirit: pAttackFrames = 20; break;
				case enumProjPlayerElement.light:  pAttackFrames = 15; break;
				case enumProjPlayerElement.ice:    pAttackFrames = 30; break;
				case enumProjPlayerElement.fire:   pAttackFrames = 50; break;
			}
						
			#endregion
			
			stateLength = pAttackFrames;
			
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
					if ( stateTick == 8 || stateTick == 14 )
					{
						audio_play_sound(SndPlayerShot, 10, 0);
						var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
						var _bulDir = _aimDir;
			
						var _bullet = instance_create_layer(x, y, layer, ObjProjPlayer);
						_bullet.projSpd = 50;
						_bullet.projDir = _bulDir;
						_bullet.damage = 10;
						_bullet.stunDamage = 4;
						_bullet.element = playerElementCurrent;		
					
					
						pAttackNumber++;
						if ( pAttackNumber >= 2 ) { pAttackVolleyFinished = true; }
					}
					#endregion
					break;
			
				case enumProjPlayerElement.light:
					#region Light
					if ( stateTick == 8 )
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
						if ( pAttackNumber >= 1 ) { pAttackVolleyFinished = true; }
					}
					#endregion
					break;
			
				case enumProjPlayerElement.fire:
					#region Fire
				
				
					if ( stateTick == 8 || stateTick == 16 || stateTick == 24 )
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
				
					if ( stateTick == 32 )
					{
						with ( ObjProjPlayer ) { projMovePause = false; }
						pAttackVolleyFinished = true;
					}				
				
					#endregion
					break;
			
				case enumProjPlayerElement.ice:
					#region Ice
					if ( stateTick == 8 )
					{
						audio_play_sound(SndPlayerShot, 10, 0);
						var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
						var _bulDir = _aimDir;
			
						var _bullet = instance_create_layer(x, y, layer, ObjProjPlayer);
						_bullet.projSpd = 30;
						_bullet.projDir = _bulDir;
						_bullet.projScale *= 4;
						_bullet.damage = 10;
						_bullet.stunDamage = 8;
						_bullet.element = playerElementCurrent;
					
						pAttackNumber++;
						if ( pAttackNumber >= 1 ) { pAttackVolleyFinished = true; }
					}
					#endregion
					break;
			}	
		
			#endregion
			
			if ( pAttackVolleyFinished )
			{
				if ( pAttackVolleyEndTick >= 0 )
				{
					if ( input_check("dash") && pDashCooldownTimer < 0 && pEnergy >= pDashEnergyCost )
					{
						State_Change(State_Player_Dash);
						pEnergy -= pDashEnergyCost;
					}
					else
					if ( input_check("breaker") && pBreakerCooldownTimer < 0 )
					{
						State_Change(State_Player_Breaker);
						pElementSwap_animTimer = -1;
					}
					else
					if ( input_check("skill") && pSkillCooldownTimer < 0 && pEnergy >= pSkillEnergyCost )
					{
						State_Change(State_Player_Skill_SirenSong);
						pEnergy -= pSkillEnergyCost;
						pElementSwap_animTimer = -1;
					}
				}
				pAttackVolleyEndTick++;
			}
			
			if ( pBreakerCooldownTimer >= 0 ) { pBreakerCooldownTimer--; }		
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
			if ( pSkillCooldownTimer   >= 0 ) { pSkillCooldownTimer--;   }
			Player_Energy_Tick();
			Player_Skills_Tick();
						
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			pAttackCooldownTimer = pAttackCooldownFrames;
			#endregion
			break;
	}
}