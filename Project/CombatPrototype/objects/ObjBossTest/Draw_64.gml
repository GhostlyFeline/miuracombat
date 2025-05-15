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

#region Boss Hud Test

var _hudOrigin = [ _guiCenterX, _guiTop + 48 ];

drawHpReal    = charHealth;
drawHpDisplay = lerp(drawHpDisplay, drawHpReal, 0.25);

var _scl = 1.5;
var _percent = drawHpDisplay / charHealthMax;

draw_sprite_ext(Spr_Hud_BossBarFrame, 0, _hudOrigin[0]             , _hudOrigin[1], _scl           , 0.8, 0, c_white, 1);
draw_sprite_ext(Spr_Hud_BossBarFill , 0, _hudOrigin[0] - (512*_scl), _hudOrigin[1], _scl * _percent, 0.8, 0, c_white, 1);

draw_set_font(FntHudA);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for( var i = 1; i >= 0; i--; )
{
	if ( i == 1 ) { draw_set_color(c_red); } else { draw_set_color(c_white); }
	draw_text(_hudOrigin[0] - (i*2), _hudOrigin[1] + 40 + (i*2), bossName );
}

#endregion
