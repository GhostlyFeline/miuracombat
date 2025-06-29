/// @description Insert description here
// You can write your code in this editor


var _colorA = merge_color(c_blue, c_aqua, 0.50);
var _colorB = merge_color(c_yellow, c_orange, 0.75);

switch(element)
{
	case enumProjPlayerElement.spirit: _colorA = merge_color(c_blue  , c_aqua  , 0.50); _colorB = merge_color(c_blue  , c_white , 0.85); break;				
	case enumProjPlayerElement.light: _colorA = merge_color(c_yellow, c_orange, 0.75); _colorB = merge_color(c_yellow, c_white , 0.75); break;
	case enumProjPlayerElement.ice:   _colorA = merge_color(c_aqua  , c_white , 0.50); _colorB = merge_color(c_aqua  , c_white , 0.50); break;
	case enumProjPlayerElement.fire:  _colorA = merge_color(c_red   , c_orange, 0.50); _colorB = merge_color(c_orange, c_yellow, 0.50); break;
}

gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 1.0, image_yscale * 1.0,  image_angle, _colorA, 1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 0.5, image_yscale * 0.5, -image_angle, _colorB, 1);
gpu_set_blendmode(bm_normal);