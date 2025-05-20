/// @description Insert description here
// You can write your code in this editor

var _center = [ room_width * 0.5, room_height * 0.5 ];

var _colorA = #0f474d;
var _colorB = #0f294c;
var _radius = 6000;
var _ratio  = 9/16;

draw_set_alpha(1);
draw_rectangle_color(_center[0] - _radius, _center[1] - ( _radius * _ratio ), _center[0] + _radius, _center[1] + ( _radius * _ratio ), _colorA, _colorA, _colorB, _colorB, 0);