/// @description Insert description here
// You can write your code in this editor

if ( global.hitstopActive ) { exit; }

image_angle += 15;

x += lengthdir_x(projSpd, projDir);
y += lengthdir_y(projSpd, projDir);

var _player = ObjPlayer;
var _boundsDist = point_distance (_player.pMoveBoundsCirclePos[0], _player.pMoveBoundsCirclePos[1], x, y);
if ( _boundsDist > _player.pMoveBoundsCircleRadius ) { instance_destroy(); }