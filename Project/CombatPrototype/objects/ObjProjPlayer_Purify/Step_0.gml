/// @description Insert description here
// You can write your code in this editor

if ( global.hitstopActive ) { exit; }

image_angle = projDir;

image_xscale = projScale * 40; //15
image_yscale = projScale * 40; //6

x += lengthdir_x(projSpd, projDir);
y += lengthdir_y(projSpd, projDir);

var _player = ObjPlayer;
var _boundsDist = point_distance (_player.pMoveBoundsCirclePos[0], _player.pMoveBoundsCirclePos[1], x, y);
if ( _boundsDist > _player.pMoveBoundsCircleRadius ) { BulletHit(); }

tick++;
if ( tick >= lifetime - 20 )
{
	image_alpha = lerp(0.33, 0, ( tick - (lifetime - 20) ) / 20);
}
if ( tick > lifetime ) { instance_destroy(); }