/// @description Insert description here
// You can write your code in this editor


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
		if ( ObjPlayer.stateCurrent != State_Player_Victory ) { with (ObjPlayer) { State_Change(State_Player_Victory, -1); } }
		battleVictoryTimer++;
		if ( battleVictoryTimer >= battleVictoryFrames )
		{
			with ( ObjPlayer ) { State_Change(State_Player_Normal, -1); }
			battleActive = false;
			battleWon = false;
			battleVictoryTimer = 0;
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