/// @description Insert description here
// You can write your code in this editor

for ( var i = 0; i < ds_list_size(enemyHitList); i++; )
{
	var _item = enemyHitList[| i];
	if ( is_undefined(_item) )
	{
		ds_list_delete(enemyHitList, i);
		i = 0;
	}
}