/// @description Insert description here
// You can write your code in this editor

battleActive = true;
battleWon = false;

var _numCap = 8
if ( instance_number(ObjEnemyTest) >= _numCap ) exit;

spawnAngle += ( 360 / _numCap ) + 180;
var _spawnNum = 4;
for ( var i = 0; i < _spawnNum; i++; )
{
	var _pos = [room_width * 0.5, room_height * 0.5];
	var _len = 1080;
	var _dir = spawnAngle + ( 360 * ( i / _spawnNum ) );
	_pos[0] += lengthdir_x(_len, _dir);
	_pos[1] += lengthdir_y(_len, _dir);
	
	var _enemy = instance_create_layer(_pos[0], _pos[1], layer, ObjEnemyTest);
	_enemy.enemyId = global.enemySpawnIndex;
	_enemy.enemyWeakness = global.enemySpawnIndex mod 4;
	global.enemySpawnIndex++;
}

with ( ObjPlayer ) { State_Change(State_Player_Normal, -1); }