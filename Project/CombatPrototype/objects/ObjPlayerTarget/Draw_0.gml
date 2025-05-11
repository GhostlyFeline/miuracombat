/// @description Insert description here
// You can write your code in this editor

gpu_set_blendmode(bm_add);
draw_set_alpha(1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 1.0, image_yscale * 1.0, image_angle * 1.0, merge_color(c_blue, c_aqua, 0.75), 0.75 * targCircleAlpha);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 0.8, image_yscale * 0.8, image_angle * 0.7, c_white, 0.75 * targCircleAlpha);
gpu_set_blendmode(bm_normal);