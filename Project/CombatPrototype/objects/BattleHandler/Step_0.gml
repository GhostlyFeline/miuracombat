/// @description Insert description here
// You can write your code in this editor


if ( battleActive )
{
	if ( instance_number(ObjEnemyTest) == 0 )
	{
		if ( !battleWon )
		{
			show_debug_message("VICTORY!");
			with (ObjProjEnemy) { BulletHit(); }
			battleWon = true;
		}
	}
}