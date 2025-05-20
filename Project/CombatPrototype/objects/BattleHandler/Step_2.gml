/// @description Insert description here
// You can write your code in this editor

if ( ObjPlayer.stateCurrent == State_Player_Dying || ObjPlayer.stateCurrent == State_Player_Dead || ObjPlayer.stateCurrent == State_Player_Victory )
{
	with ( ParEnemy ) { if ( stateCurrent != State_Enemy_GameOver ) { State_Change( State_Enemy_GameOver, -1, true ) } }	
	with ( ObjProjEnemy ) { BulletHit(); }	
}

Sound_Active_Play();
Sound_Active_Reset();