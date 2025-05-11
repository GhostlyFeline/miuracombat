/// @description Insert description here
// You can write your code in this editor

var _colorA = c_navy;
var _colorB = c_white;

if ( textColor != -1 )
{
	_colorA = merge_color(textColor, c_black, 0.66);
	_colorB = merge_color(textColor, c_white, 0.66);
}

var _string = string(damage);

draw_set_font(textFont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(fadeAlpha);

for ( var i = 2; i >= 0; i--; )
{
	if ( i == 2 ) { draw_set_color(_colorA); }
	if ( i == 1 ) { draw_set_color(_colorA); }
	if ( i == 0 ) { draw_set_color(_colorB); }
	
	if ( i != 1 ) { draw_text_transformed(x - (i*1.5), y + (i*1.5), _string, textScl, textScl, 0 ); }
	else
	{
		for ( var j = 0; j < 5; j++; )
		{
			var _len = 2;
			var _dir = ( 360 / 5 ) * j;
			var _lX  = lengthdir_x(_len, _dir);
			var _lY  = lengthdir_y(_len, _dir);
			draw_text_transformed(x + _lX, y + _lY, _string, textScl, textScl, 0 );
		}
	}
}