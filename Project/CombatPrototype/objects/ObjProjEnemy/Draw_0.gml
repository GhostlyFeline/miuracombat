/// @description Insert description here
// You can write your code in this editor

//gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * projScale * 1.00, image_yscale * projScale * 1.00,  image_angle * 1.0, merge_color(c_orange, c_yellow, 0.33), 1.0);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * projScale * 0.75, image_yscale * projScale * 0.75,  image_angle * 0.9, merge_color(c_red, c_orange, 0.5), 1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * projScale * 0.40, image_yscale * projScale * 0.40, -image_angle * 0.5, c_black, 1);
gpu_set_blendmode(bm_normal);