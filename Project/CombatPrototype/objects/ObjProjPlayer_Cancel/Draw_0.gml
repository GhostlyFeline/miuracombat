/// @description Insert description here
// You can write your code in this editor


//var _colorA = merge_color(c_blue, c_aqua, 0.50);
//var _colorB = merge_color(c_yellow, c_orange, 0.75);
//
//switch(element)
//{
//	case enumProjPlayerElement.spirit: _colorA = merge_color(c_blue  , c_aqua  , 0.50); _colorB = merge_color(c_blue  , c_white , 0.85); break;				
//	case enumProjPlayerElement.light: _colorA = merge_color(c_yellow, c_orange, 0.75); _colorB = merge_color(c_yellow, c_white , 0.75); break;
//	case enumProjPlayerElement.ice:   _colorA = merge_color(c_aqua  , c_white , 0.50); _colorB = merge_color(c_aqua  , c_white , 0.50); break;
//	case enumProjPlayerElement.fire:  _colorA = merge_color(c_red   , c_orange, 0.50); _colorB = merge_color(c_orange, c_yellow, 0.50); break;
//}
//
//gpu_set_blendmode(bm_add);
//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 1.0, image_yscale * 1.0, image_angle, _colorA, image_alpha);
//draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 0.5, image_yscale * 0.5, image_angle, _colorB, image_alpha);
//gpu_set_blendmode(bm_normal);


var _radius = ( bbox_right - bbox_left ) * 0.5;

draw_set_circle_precision(48);

gpu_set_blendmode(bm_add);
draw_set_alpha(image_alpha);
draw_circle_color(x, y, _radius * 1.0, c_black, c_aqua, 0);
draw_circle_color(x, y, _radius * 0.9, merge_color(c_blue, c_aqua , 0.50), c_black, 0);
draw_circle_color(x, y, _radius * 0.8, merge_color(c_aqua, c_white, 0.50), c_black, 0);
gpu_set_blendmode(bm_normal);


draw_set_circle_precision(16);