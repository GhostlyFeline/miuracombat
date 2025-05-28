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
				case enumProjPlayerElement.spirit: pAttackFrames = 20; pAttackCooldownFrames = 10; break;
				case enumProjPlayerElement.light:  pAttackFrames = 15; pAttackCooldownFrames =  5; break;
				case enumProjPlayerElement.ice:    pAttackFrames = 10; pAttackCooldownFrames =  5;  break;
				case enumProjPlayerElement.fire:   pAttackFrames = 45; pAttackCooldownFrames = 15; break;
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
				
				var _targetDist = point_distance (x, y, ObjPlayerTarget.x, ObjPlayerTarget.y);
				
				var _leadDir = point_direction(ObjPlayerTarget.xprevious, ObjPlayerTarget.yprevious, ObjPlayerTarget.x, ObjPlayerTarget.y);
				var _leadLen = point_distance (ObjPlayerTarget.xprevious, ObjPlayerTarget.yprevious, ObjPlayerTarget.x, ObjPlayerTarget.y);
				
				if ( _leadLen > 0 )
				{
					_targetPos[0] += lengthdir_x(_leadLen, _leadDir) * ( ( _targetDist / _leadLen ) + 1 );
					_targetPos[1] += lengthdir_y(_leadLen, _leadDir) * ( ( _targetDist / _leadLen ) + 1 );
				}
				
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
						Sound_Play(enumSoundFxList.playerShot00);
						var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
			
						var _bullet = instance_create_layer(x, y, layer, ObjProjPlayer);
						_bullet.projSpd = 90;
						_bullet.projDir = _aimDir;
						_bullet.damage = 10;
						_bullet.stunDamage = 4;
						_bullet.element = playerElementCurrent;		
						_bullet.projTarget = ObjPlayerTarget.follow;
					
					
						pAttackNumber++;
						if ( pAttackNumber >= 2 ) { pAttackVolleyFinished = true; }
					}
					#endregion
					break;
			
				case enumProjPlayerElement.light:
					#region Light
					if ( stateTick == 8 )
					{
						Sound_Play(enumSoundFxList.playerShot00);
						var _bulletNum = 3;
		
						for (var i = 0; i < _bulletNum; i++;)
						{
							var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
							var _bulDir = _aimDir + lerp(-10, 10, i / (_bulletNum - 1) );
			
							var _bullet = instance_create_layer(x, y, layer, ObjProjPlayer);
							_bullet.projSpd = 90;
							_bullet.projDir = _bulDir;
							_bullet.projScale *= 2.0;
							_bullet.damage = 5;
							_bullet.stunDamage = 4;
							_bullet.element = playerElementCurrent;
							_bullet.penetrate = true;
							_bullet.projHomingDisable = true;
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
						Sound_Play(enumSoundFxList.playerShot00);
										
						var _len = 128;
						var _dir = ( (360 / 3) * pAttackNumber ) + point_direction(x, y, _targetPos[0], _targetPos[1]);
						var _lX  = lengthdir_x(_len, _dir);
						var _lY  = lengthdir_y(_len, _dir);
					
						var _bullet = instance_create_layer(x + _lX, y + _lY, layer, ObjProjPlayer);
						var _aimDir = point_direction(_bullet.x, _bullet.y, _targetPos[0], _targetPos[1]);
						_bullet.projSpd = 80;
						_bullet.projDir = _aimDir;
						_bullet.projScale *= 3.0;
						_bullet.damage = 15;
						_bullet.stunDamage = 8;
						_bullet.element = playerElementCurrent;			
						_bullet.projMovePause = true;
						_bullet.projTarget = ObjPlayerTarget.follow;
					
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
						Sound_Play(enumSoundFxList.playerShot00);
						var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
			
						var _bullet = instance_create_layer(x, y, layer, ObjProjPlayer);
						_bullet.projSpd = 20;
						_bullet.projDir = _aimDir;
						_bullet.projScale *= 2;
						_bullet.damage = 5;
						_bullet.stunDamage = 4;
						_bullet.element = playerElementCurrent;
						_bullet.projTarget = ObjPlayerTarget.follow;
						_bullet.projHomingRotate = 0.25;
					
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
					if ( ( input_check("breaker") || input_check("spell1") ) && pBreakerCooldownTimer < 0 && pEnergy >= pBreakerEnergyCost )
					{
						State_Change(State_Player_Breaker);				
						pEnergy -= pBreakerEnergyCost;
						pElementSwap_animTimer = -1;
					}
					else
					if ( input_check("skill") && pSkillCooldownTimer < 0 && pEnergy >= pSkillEnergyCost )
					{
						var _canSkill = true;
						if ( pSkillCurrent == State_Player_Skill_SirenSong && pSirenSongStacks >= pSirenSongStackMax ) { _canSkill = false; }
						if ( pSkillCurrent == State_Player_Skill_MagmaAura && pMagmaAuraTimer > 0  ) { _canSkill = false; }
						if ( _canSkill )
						{
							State_Change(pSkillCurrent);
							pEnergy -= pSkillEnergyCost;
							pElementSwap_animTimer = -1;
						}
					}
				}
				pAttackVolleyEndTick++;
			}
				
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
			if ( pSkillCooldownTimer   >= 0 ) { pSkillCooldownTimer--;   }
			Player_Spell_Tick();
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