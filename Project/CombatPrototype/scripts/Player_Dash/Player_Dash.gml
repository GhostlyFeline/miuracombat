// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Dash(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
						
			sprite_index = SprPlayerIdle;
			image_index  = 0;
			image_speed  = 2;			
			
			#region Start the dash, setting the initial direction to where the player is inputting.
			
			var _moveAxisX = input_check("right") - input_check("left");
			var _moveAxisY = input_check("down")  - input_check("up");
			
			var _dashInitDir = pDashLastDir;
			if ( point_distance(0, 0, _moveAxisX, _moveAxisY) > 0.25 ) { _dashInitDir = point_direction(0, 0, _moveAxisX, _moveAxisY); }
			pMoveXspd = lengthdir_x(40, _dashInitDir);
			pMoveYspd = lengthdir_y(40, _dashInitDir);
				
			Sound_Play(enumSoundFxList.playerDash);
			
			#endregion
									
			stateLength = pDashFrames;
			
			stateNext = State_Player_Normal;
			stateNextLength = -1;
						
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			Player_Move_Tick();
			Player_Targeting_Tick();
			
			squishScl = [1.2, 0.8];
						
			pMoveSpeedMulti = 2;
			pMoveEaseMulti = 0.20;
			invincible = true;
			pLockonRotateOverride = true;
			
			#region Visual Effects
		
			with (FxHandler)
			{
				var _dir = point_direction(_self.xprevious, _self.yprevious, _self.x, _self.y);
				part_type_direction(fxType[enumFxType.pFxPlayer_dashTrail00], _dir, _dir, 0, 0);
				part_particles_create(fxSysGlobalBelow, _self.x, _self.y, fxType[enumFxType.pFxPlayer_dashTrail00], 1 );
		
				var _len = random(32);
				var _dir = random(360);
				var _lX  = lengthdir_x(_len, _dir);
				var _lY  = lengthdir_y(_len, _dir);
				part_particles_create(fxSysGlobalBelow, _self.x + _lX, _self.y + _lY, fxType[enumFxType.pFxPlayer_dashBubbles00], 1 );
		
				var _len = random(80);
				var _dir = random(360);
				var _lX  = lengthdir_x(_len, _dir);
				var _lY  = lengthdir_y(_len, _dir);
				part_particles_create(fxSysGlobalBelow, _self.x + _lX, _self.y + _lY, fxType[enumFxType.pFxPlayer_dashShine00], 1 );
			}
			if ( stateTick mod 5 == 0 ) { Character_Flash_Activate(5, 1, merge_color(c_aqua, c_white, 0.5), 0.5, true, 10); }
		
			#endregion
			
			if ( pAttackCooldownTimer  >= 0 ) { pAttackCooldownTimer--;  }
			if ( pBreakerCooldownTimer >= 0 ) { pBreakerCooldownTimer--; }
			if ( pSkillCooldownTimer   >= 0 ) { pSkillCooldownTimer--;   }
			Player_Skills_Tick();
						
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			
			#region End the dash.
			
			squishScl = [1, 1];
			
			pMoveSpeedMulti = 1;
			pMoveEaseMulti = 1;
		
			invincible = false;
			pLockonRotateOverride = false;
			#endregion
			
			pDashCooldownTimer = pDashCooldownFrames;
			#endregion
			break;
	}
}