/// @description Insert description here
// You can write your code in this editor

//gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 1.2, image_yscale * 1.2,  image_angle * 1.0, merge_color(c_orange, c_yellow, 0.33), 1.0);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 0.9, image_yscale * 0.9,  image_angle * 0.9, merge_color(c_red, c_orange, 0.5), 1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 0.5, image_yscale * 0.5, -image_angle * 0.5, c_black, 1);
gpu_set_blendmode(bm_normal);