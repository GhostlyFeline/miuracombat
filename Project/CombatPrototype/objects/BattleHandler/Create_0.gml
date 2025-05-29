/// @description Insert description here
// You can write your code in this editor

enum enumItemType
{
	potionSmall,
	
	null,
}

global.enemySpawnIndex = 0;
global.levelGenericPauseTimer = -1;


Sound_Init();

spawnAngle = 0;

xpTotal = 0;
itemDropArray = array_create(0);

battleActive = false;
battleWon = false;
battleLost = false;

battleFinalHitFrames = 90;
battleFinalHitTimer  = 0;
battleFinalHitPos = [0, 0];

battleVictoryFrames = 300;
battleVictoryTimer  = 0;

battleGameOverFrames = 300;
battleGameOverTimer  = 0;


battleEnemyList = ds_list_create();
battleEnemyIdLow  = 0;
battleEnemyIdHigh = 99;


battleRound = 0;
battleRoundMax = 3;
battleRoundStartTimer = -1;
battleRoundStartFrames = 60;
battleRoundArray = array_create(0);


battleRoundArray[0] = function() {
	#region Round 1
	
	var _spawnNum = 4;
	spawnAngle += ( 360 / _spawnNum ) + 180;
	for ( var i = 0; i < _spawnNum; i++; )
	{
		var _pos = [room_width * 0.5, room_height * 0.5];
		var _len = 1080;
		var _dir = spawnAngle + ( 360 * ( i / _spawnNum ) );
		_pos[0] += lengthdir_x(_len, _dir);
		_pos[1] += lengthdir_y(_len, _dir);
	
		var _enemy = instance_create_layer(_pos[0], _pos[1], "GameplayInst", ObjEnemyTest);
		_enemy.enemyId = global.enemySpawnIndex;
		_enemy.enemyWeakness = global.enemySpawnIndex mod 4;
		global.enemySpawnIndex++;
	}
	
	#endregion
}

battleRoundArray[1] = function() {
	#region Round 2
	
	//var _pos = [room_width * 0.5, room_height * 0.3];
	//var _enemy = instance_create_layer(_pos[0], _pos[1], "GameplayInst", ObjEnemyCaster);
	//_enemy.enemyId = global.enemySpawnIndex;
	//_enemy.enemyWeakness = enumProjPlayerElement.light;
	//global.enemySpawnIndex++;
	
	
	var _spawnNum = 6;
	spawnAngle += ( 360 / _spawnNum ) + 180;
	for ( var i = 0; i < _spawnNum; i++; )
	{
		var _pos = [room_width * 0.5, room_height * 0.5];
		var _len = 1080;
		var _dir = spawnAngle + ( 360 * ( i / _spawnNum ) );
		_pos[0] += lengthdir_x(_len, _dir);
		_pos[1] += lengthdir_y(_len, _dir);
	
		var _enemy = instance_create_layer(_pos[0], _pos[1], "GameplayInst", ObjEnemyTest);
		_enemy.enemyId = global.enemySpawnIndex;
		_enemy.enemyWeakness = global.enemySpawnIndex mod 4;
		global.enemySpawnIndex++;
	}
	
	#endregion
}

battleRoundArray[2] = function() {
	#region Round 3
	
	//var _spawnNum = 8;
	//spawnAngle += ( 360 / _spawnNum ) + 180;
	//for ( var i = 0; i < _spawnNum; i++; )
	//{
	//	var _pos = [room_width * 0.5, room_height * 0.5];
	//	var _len = 1080;
	//	var _dir = spawnAngle + ( 360 * ( i / _spawnNum ) );
	//	_pos[0] += lengthdir_x(_len, _dir);
	//	_pos[1] += lengthdir_y(_len, _dir);
	//
	//	var _enemy = instance_create_layer(_pos[0], _pos[1], "GameplayInst", ObjEnemyTest);
	//	_enemy.enemyId = global.enemySpawnIndex;
	//	_enemy.enemyWeakness = global.enemySpawnIndex mod 4;
	//	global.enemySpawnIndex++;
	//}
	
	var _pos = [room_width * 0.5, room_height * 0.5];
	var _enemy = instance_create_layer(_pos[0], _pos[1], "GameplayInst", ObjBossTest);
	_enemy.enemyId = global.enemySpawnIndex;
	_enemy.enemyWeakness = enumProjPlayerElement.spirit;
	global.enemySpawnIndex++;
	
	#endregion
}