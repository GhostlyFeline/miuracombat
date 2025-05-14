/// @description Insert description here
// You can write your code in this editor

with ( ObjPlayer )
{
	charHealth = charHealthMax;
	State_Change(State_Player_Normal, -1);
}
with ( ObjEnemyTest ) { instance_destroy(); }
xpTotal = 0;
battleActive = false;
battleWon = false;