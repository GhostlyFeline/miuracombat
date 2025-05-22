/// @description Insert description here
// You can write your code in this editor

image_angle = projDir;

image_xscale = projScale; //15
image_yscale = projScale; //6


tick++;
if ( tick >= lifetime - 20 )
{
	image_alpha = lerp(0.33, 0, ( tick - (lifetime - 20) ) / 20);
}
if ( tick > lifetime ) { instance_destroy(); }


