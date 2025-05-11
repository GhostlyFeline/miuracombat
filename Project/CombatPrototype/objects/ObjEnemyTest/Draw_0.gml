/// @description Insert description here
// You can write your code in this editor


draw_set_font(FntDefault);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _string = "";
switch(enemyWeakness)
{
	case enumProjPlayerElement.water: _string = "Water"; break;
	case enumProjPlayerElement.light: _string = "Light"; break;
	case enumProjPlayerElement.ice:   _string = "Ice";   break;
	case enumProjPlayerElement.fire:  _string = "Fire";  break;
}
draw_text(x, y - 64, "Weak: " + _string);

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

draw_sprite_ext(sprite_index, image_index, _charDrawX, _charDrawY, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
shader_reset();


draw_set_color(c_white);
draw_set_alpha(1);
draw_healthbar(x - 80, y + 64, x + 80, y + 80, (charHealth / charHealthMax) * 100, merge_color(c_black, c_dkgray, 0.5), c_red, c_red, 0, 1, 1);


var _stunBarAmt = enemyStun / enemyStunMax;
if ( enemyStunTimer >= 0 ) { _stunBarAmt = enemyStunTimer / enemyStunFrames; }
draw_healthbar(x - 60, y + 80, x + 60, y + 90, _stunBarAmt * 100, merge_color(c_black, c_dkgray, 0.5), c_aqua, c_aqua, 0, 1, 1);