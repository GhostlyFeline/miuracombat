/// @description Insert description here
// You can write your code in this editor


if ( battleActive )
{
	if ( !battleWon )
	{
		if ( instance_number(ObjEnemyTest) == 0 )
		{
			show_debug_message("VICTORY!");
			with (ObjProjEnemy) { BulletHit(); }
			battleWon = true;
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