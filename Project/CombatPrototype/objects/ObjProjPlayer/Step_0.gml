/// @description Insert description here
// You can write your code in this editor

if ( global.hitstopActive ) { exit; }

image_angle += 15;

image_xscale = projScale + random_range(0.5, 1.0);
image_yscale = image_xscale;

if ( !projMovePause )
{
	x += lengthdir_x(projSpd, projDir);
	y += lengthdir_y(projSpd, projDir);
}

var _player = ObjPlayer;
var _boundsDist = point_distance (_player.pMoveBoundsCirclePos[0], _player.pMoveBoundsCirclePos[1], x, y);
if ( _boundsDist > _player.pMoveBoundsCircleRadius + sprite_width ) { BulletHit(); }