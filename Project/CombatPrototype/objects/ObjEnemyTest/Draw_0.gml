/// @description Insert description here
// You can write your code in this editor


draw_set_font(FntDefault);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);


function RenderStunStars(_above = false)
{
	for ( var i = 0; i < 5; i++; )
	{
		var _len = sprite_width * 0.75;
		var _dir = ( (360 / 5) * i ) + ( enemyStunTimer * 4 );
		var _lX  = lengthdir_x(_len, _dir);
		var _lY  = lengthdir_y(_len, _dir) * 0.25;
		
		var _render = false;		
		if ( _lY <= 0 && !_above ) { _render = true; }
		if ( _lY  > 0 &&  _above ) { _render = true; }
	
		if ( _render ) { draw_sprite_ext(SprFxStunStar, 0, x + _lX, y + _lY, 1, 1, 0, merge_color(c_yellow, c_white, 0.5), 0.75 ); }
	}
}


if ( enemyStunTimer >= 0 ) { RenderStunStars(false); }

var _string = "";
switch(enemyWeakness)
{
	case enumProjPlayerElement.spirit: _string = "Spirit"; break;
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

#region Draw the outline.

var myCol = merge_color(c_red, c_white, 0.2);
var r = colour_get_red(myCol) / 255;
var g = colour_get_green(myCol) / 255;
var b = colour_get_blue(myCol) / 255;
var a = 1;

shader_set_uniform_f(_colorFlashUniform, r, g, b, a);

gpu_set_blendmode(bm_add);
for ( var i = 0; i < 6; i++; )
{
	for ( var j = 3; j >= 1; j--; )
	{
		var _len = j * 5;
		var _dir = ( (360 / 6) * i ) + ( (360 / 12) * (j mod 2) );
		var _lX  = lengthdir_x(_len, _dir);
		var _lY  = lengthdir_y(_len, _dir);
		var _alpha = lerp(0.75, 0.00, j / 3);
	
		draw_sprite_ext(sprite_index, image_index, _charDrawX + _lX, _charDrawY + _lY, image_xscale, image_yscale, image_angle, image_blend, image_alpha * _alpha);
	}
}
gpu_set_blendmode(bm_normal);

#endregion

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


if ( enemyStunTimer >= 0 ) { RenderStunStars(true); }

draw_set_color(c_white);
draw_set_alpha(1);
draw_healthbar(x - 80, y + 64, x + 80, y + 80, (charHealth / charHealthMax) * 100, merge_color(c_black, c_dkgray, 0.5), c_red, c_red, 0, 1, 1);


var _stunBarAmt = enemyStun / enemyStunMax;
if ( enemyStunTimer >= 0 ) { _stunBarAmt = enemyStunTimer / enemyStunFrames; }
draw_healthbar(x - 60, y + 80, x + 60, y + 90, _stunBarAmt * 100, merge_color(c_black, c_dkgray, 0.5), c_aqua, c_aqua, 0, 1, 1);