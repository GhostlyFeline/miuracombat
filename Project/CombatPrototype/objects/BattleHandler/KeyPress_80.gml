/// @description Insert description here
// You can write your code in this editor

if ( battleActive ) exit;

with ( ObjPlayer )
{
	x = room_width  * 0.5;
	y = room_height * 0.5;
	charHealth = charHealthMax;
	pEnergy = pEnergyMax;
	pLimit = 0;
	State_Change(State_Player_Normal, -1);
}

with ( ParEnemy ) { instance_destroy(); }
with ( ObjProjEnemy ) { instance_destroy(); }
xpTotal = 0;
itemDropArray = [];

battleActive = true;
battleWon = false;

battleRound = 0;