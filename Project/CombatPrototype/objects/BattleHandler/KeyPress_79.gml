/// @description Insert description here
// You can write your code in this editor

with ( ObjPlayer )
{
	State_Change(State_Player_Normal, -1);
}

with ( ObjEnemyTest ) { instance_destroy(); }
with ( ObjProjEnemy ) { instance_destroy(); }

battleActive = false;
battleWon = false;

battleRound = 0;