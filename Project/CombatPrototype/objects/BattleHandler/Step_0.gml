/// @description Insert description here
// You can write your code in this editor

var _self = id;

if ( battleActive )
{
	if ( !battleWon )
	{
		if ( instance_number(ParEnemy) == 0 )
		{
			if ( battleRound < battleRoundMax )
			{
				with (ObjProjEnemy) { BulletHit(); }
				battleRoundStartTimer = battleRoundStartFrames;
				battleRound++;				
				battleRoundArray[battleRound-1]();
			}
			else
			{
				with (ObjProjEnemy) { BulletHit(); }
				show_debug_message("VICTORY!");
				battleWon = true;
			}
		}
	}
	else
	{
		if ( battleFinalHitTimer <= battleFinalHitFrames )
		{
			if ( battleFinalHitTimer == 0 )
			{
				with (FxHandler)
				{		
					part_type_life(fxType[enumFxType.eFxEnemy_lastHitShine00], _self.battleFinalHitFrames * 0.75, _self.battleFinalHitFrames * 0.75);
					part_type_life(fxType[enumFxType.eFxEnemy_lastHitFlash00], _self.battleFinalHitFrames * 1.00, _self.battleFinalHitFrames * 1.00);
					
					repeat(4)
					{
						var _angleRot = random(360);
						for ( var i = 0; i < 4; i++; )
						{
							var _dir = ( i * (360 / 4) ) + _angleRot;
							part_type_orientation(fxType[enumFxType.eFxEnemy_lastHitShine00], _dir, _dir, 0, 0, 0);
							part_particles_create(fxSysGlobalBelow, _self.battleFinalHitPos[0], _self.battleFinalHitPos[1], fxType[enumFxType.eFxEnemy_lastHitShine00], 1 );
						}
					}
					
					part_particles_create(fxSysGlobalBelow, _self.battleFinalHitPos[0], _self.battleFinalHitPos[1], fxType[enumFxType.eFxEnemy_lastHitFlash00], 3 );					
				}
			}
			
			if ( battleFinalHitTimer > 0 ) { game_set_speed(45, gamespeed_fps); }
			if ( battleFinalHitTimer == battleFinalHitFrames ) { game_set_speed(60, gamespeed_fps); }
			battleFinalHitTimer++;
		}
		else
		{
			if ( ObjPlayer.stateCurrent != State_Player_Victory ) { with (ObjPlayer) { State_Change(State_Player_Victory, -1); } }
			
			battleVictoryTimer++;
			if ( battleVictoryTimer >= battleVictoryFrames )
			{
				with ( ObjPlayer ) { State_Change(State_Player_Normal, -1); }
				battleActive = false;
				battleWon = false;
				battleFinalHitTimer = 0;
				battleVictoryTimer = 0;
			}
		}
	}
	
	if ( !battleLost )
	{
		if ( ObjPlayer.stateCurrent == State_Player_Dead ) { battleLost = true; }
	}
	else
	{
		battleGameOverTimer++;
		if ( battleGameOverTimer >= battleGameOverFrames )
		{
			battleGameOverTimer = 0;
			room_restart();
		}
	}
}

if ( battleRoundStartTimer >= 0 ) { battleRoundStartTimer--; }