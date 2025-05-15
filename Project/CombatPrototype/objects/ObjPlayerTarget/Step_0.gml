/// @description Insert description here
// You can write your code in this editor

if ( global.hitstopActive ) { exit; }

image_angle += 5;

if ( instance_exists(follow) )
{
	x = follow.x;
	y = follow.y;
	targCircleAlpha = lerp( targCircleAlpha, 1, 0.20 );
}
else
{
	if ( instance_exists(ParEnemy) ) { follow = instance_nearest(x, y, ParEnemy); }
	else { targCircleAlpha = lerp( targCircleAlpha, 0, 0.20 ); }
	
	if ( targCircleAlpha <= 0.01 )
	{
		x = ObjPlayer.x;
		y = ObjPlayer.y;	
	}
}