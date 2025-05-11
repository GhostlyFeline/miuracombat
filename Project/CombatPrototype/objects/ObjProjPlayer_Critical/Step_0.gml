/// @description Insert description here
// You can write your code in this editor

if ( global.hitstopActive ) { exit; }

image_angle = projDir;

image_xscale = projScale * 30; //15
image_yscale = projScale * 30; //6

x += lengthdir_x(projSpd, projDir);
y += lengthdir_y(projSpd, projDir);

var _player = ObjPlayer;
var _boundsDist = point_distance (_player.pMoveBoundsCirclePos[0], _player.pMoveBoundsCirclePos[1], x, y);
if ( _boundsDist > _player.pMoveBoundsCircleRadius ) { BulletHit(); }

tick++;
if ( tick >= lifetime - 5 )
{
	image_alpha = lerp(0.33, 0, ( tick - (lifetime - 5) ) / 5);
}
if ( tick > lifetime ) { instance_destroy(); }