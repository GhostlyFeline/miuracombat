/// @description Insert description here
// You can write your code in this editor

var _guiLeft   = 0;
var _guiRight  = display_get_gui_width();
var _guiTop    = 0;
var _guiBottom = display_get_gui_height();

var _guiCenterX = ( _guiLeft + _guiRight  ) * 0.5;
var _guiCenterY = ( _guiTop  + _guiBottom ) * 0.5;

var _guiWidth  = display_get_gui_width();
var _guiHeight = display_get_gui_height();

draw_set_font(FntDefault);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if ( instance_exists(ObjEnemyTest) )
{
	draw_text( _guiLeft + 8, _guiTop +  8, "Lowest Enemy Id: "  + string(battleEnemyIdLow ) );
	draw_text( _guiLeft + 8, _guiTop + 64, "Highest Enemy Id: " + string(battleEnemyIdHigh) );
}



if ( battleWon )
{
	var _colorA = merge_color( merge_color(c_yellow, c_orange, 0.25) , c_black, 0.5);
	var _colorB = merge_color( merge_color(c_yellow, c_orange, 0.25) , c_white, 0.5);

	draw_set_font(FntWinScreenA);
	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	for ( var i = 1; i >= 0; i--; )
	{
		if ( i == 1 ) { draw_set_color(_colorA); }
		if ( i == 0 ) { draw_set_color(_colorB); }
	
		var _textPos = [_guiCenterX, _guiCenterY - 256];
		draw_text(_textPos[0] - (i*2), _textPos[1] + (i*2), "VICTORY!" );
		var _textPos = [_guiCenterX, _guiCenterY + 256];
		draw_text(_textPos[0] - (i*2), _textPos[1] + (i*2), "XP Earned: " + string(BattleHandler.xpTotal) );
	}
}