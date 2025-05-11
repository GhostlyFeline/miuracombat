/// @description Insert description here
// You can write your code in this editor

global.enemySpawnIndex = 0;
global.levelGenericPauseTimer = -1;

spawnAngle = 0;

xpTotal = 0;

battleActive = false;
battleWon = false;



battleEnemyList = ds_list_create();
battleEnemyIdLow  = 0;
battleEnemyIdHigh = 99;