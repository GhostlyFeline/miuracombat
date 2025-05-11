/// @description Insert description here
// You can write your code in this editor

var _camera = view_camera[0];
var _guiLeft   = camera_get_view_x(_camera);
var _guiRight  = _guiLeft + camera_get_view_width(_camera);
var _guiTop    = camera_get_view_y(_camera);
var _guiBottom = _guiTop + camera_get_view_height(_camera);

var _guiCenterX = ( _guiLeft + _guiRight  ) * 0.5;
var _guiCenterY = ( _guiTop  + _guiBottom ) * 0.5;

var _guiWidth  = camera_get_view_width(_camera);
var _guiHeight = camera_get_view_height(_camera);

var _guiMouseX = window_mouse_get_x();
var _guiMouseY = window_mouse_get_y();




draw_set_color(c_aqua);
draw_set_alpha(0.10);
draw_circle(pMoveBoundsCirclePos[0], pMoveBoundsCirclePos[1], pMoveBoundsCircleRadius + 160, 0);
//draw_set_alpha(1);
//draw_circle(pMoveBoundsCirclePos[0], pMoveBoundsCirclePos[1], pMoveBoundsCircleRadius, 1);


draw_sprite_ext(SprPlayerCollider, 0, x, y, image_xscale, image_yscale, 0, c_white, 0.5);




shader_set(ShaderCharNormal);

var _shader = ShaderCharNormal;
var _colorFlashUniform = shader_get_uniform(_shader, "solidColor");
				
var _charDrawX = x + charOffset[0];
var _charDrawY = y + charOffset[1];

if ( charFlashPercent > 0 ) 
{       
	var myCol = charFlashColor;
	var r = colour_get_red(myCol) / 255;
	var g = colour_get_green(myCol) / 255;
	var b = colour_get_blue(myCol) / 255;
	var a = charFlashAlpha * charFlashPercent;

	shader_set_uniform_f(_colorFlashUniform, r, g, b, a);
}
else { shader_set_uniform_f(_colorFlashUniform, 1, 1, 1, 0); }


draw_set_color(c_white);
draw_set_alpha(1);
draw_sprite_ext(sprite_index, image_index, _charDrawX, _charDrawY, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
shader_reset();

draw_set_color(c_aqua);
draw_set_alpha(1);
draw_circle(mouse_x, mouse_y, 8, 1);

draw_set_color(c_white);
draw_set_alpha(1);

if ( instance_exists(ObjPlayerTarget.follow) ) 
{
	var _targetPos = [ObjPlayerTarget.x, ObjPlayerTarget.y];
	var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
	var _aimColor = c_white;
	switch(playerElementCurrent)
	{
		case enumProjPlayerElement.water: _aimColor = merge_color(c_blue  , c_white, 0.33); break;
		case enumProjPlayerElement.light: _aimColor = merge_color(c_yellow, c_white, 0.33); break;
		case enumProjPlayerElement.ice:   _aimColor = merge_color(c_aqua  , c_white, 0.33); break;
		case enumProjPlayerElement.fire:  _aimColor = merge_color(c_red   , c_white, 0.33); break;
	}
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(SprTargetPointer, 0, x, y, 1.2, 1.2, _aimDir, _aimColor, 0.66 );
	gpu_set_blendmode(bm_normal);
}
