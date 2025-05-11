/// @description Insert description here
// You can write your code in this editor


var _colorA = merge_color( merge_color(c_yellow, c_orange, 0.25) , c_black, 0.5);
var _colorB = merge_color( merge_color(c_yellow, c_orange, 0.25) , c_white, 0.5);

if ( textColor != -1 )
{
	_colorA = merge_color(textColor, c_black, 0.50);
	_colorB = merge_color(textColor, c_white, 0.66);
}

var _string = string(damage) + "xp";

draw_set_font(FntXpNumA);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(fadeAlpha);
draw_set_color(_colorA);
draw_text(x - 2, y + 2, _string );
draw_set_color(_colorB);
draw_text(x, y, _string );