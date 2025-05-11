/// @description Insert description here
// You can write your code in this editor

var _self = id;

ds_list_clear(battleEnemyList);

with(ObjEnemyTest) { ds_list_add(_self.battleEnemyList, id); }

var _low  = 99;
var _high = 0;

var _listSize = ds_list_size(battleEnemyList);
for ( var i = 0; i < _listSize; i++; )
{
	if ( battleEnemyList[| i].enemyId < _low  ) { _low  = battleEnemyList[| i].enemyId; }
	if ( battleEnemyList[| i].enemyId > _high ) { _high = battleEnemyList[| i].enemyId; }
}

battleEnemyIdLow  = _low;
battleEnemyIdHigh = _high;