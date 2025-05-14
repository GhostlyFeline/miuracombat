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

var _guiMouseX = (window_mouse_get_x() / window_get_width() ) * _guiWidth;
var _guiMouseY = (window_mouse_get_y() / window_get_height()) * _guiHeight;



if ( pElementMenuEnabled )
{
	draw_set_color(c_black);
	draw_set_alpha(0.33);
	draw_rectangle(_guiLeft - 64, _guiTop - 64, _guiRight + 64, _guiBottom + 64, 0);
	
	draw_set_color(c_white);
	draw_set_alpha(0.10);
	draw_circle(_guiCenterX, _guiCenterY, pElementMenuRadius, 0);	
	draw_set_alpha(1.0);
	draw_circle(_guiCenterX, _guiCenterY, pElementMenuRadius, 1);
		
	var _lineDir  = pElementMenuPointDir;
	var _lineDist = pElementMenuPointDist * pElementMenuRadius;
	var _lX = lengthdir_x(_lineDist, _lineDir);
	var _lY = lengthdir_y(_lineDist, _lineDir);
	draw_line_width(_guiCenterX, _guiCenterY, _guiCenterX + _lX, _guiCenterY + _lY, 4);
	
	for ( var i = 0; i < 4; i++; )
	{
		var _dir = 360 * ( i / 4 );
		var _len = pElementMenuRadius;
		var _lX = lengthdir_x(_len, _dir);
		var _lY = lengthdir_y(_len, _dir);
		
		draw_set_alpha(1.0);
		draw_set_color(c_dkgray);
		draw_circle(_guiCenterX + _lX, _guiCenterY + _lY, 100, 0);	
		draw_set_color(c_white);
		draw_circle(_guiCenterX + _lX, _guiCenterY + _lY, 100, 1);
		
		var _elementColor
		switch(i)
		{
			case 1: _elementColor = merge_color(c_blue  , c_white, 0.33); break;
			case 2: _elementColor = merge_color(c_yellow, c_white, 0.33); break;
			case 0: _elementColor = merge_color(c_aqua  , c_white, 0.33); break;
			case 3: _elementColor = merge_color(c_red   , c_white, 0.33); break;
		}
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(SprProjPlayer00, tick * 0.25, _guiCenterX + _lX, _guiCenterY + _lY, 3, 3, tick + 00, _elementColor, 0.66);
		draw_sprite_ext(SprProjPlayer00, tick * 0.25, _guiCenterX + _lX, _guiCenterY + _lY, 1, 1, tick + 30,       c_white, 1.00);
		gpu_set_blendmode(bm_normal);
	}
}


draw_set_color(c_white);
draw_set_alpha(1);
//draw_healthbar(_guiCenterX + 32 + charOffset[0], _guiBottom - 64 + charOffset[1], _guiRight - 128 + charOffset[0], _guiBottom - 32 + charOffset[1], (charHealth / charHealthMax) * 100, merge_color(c_black, c_dkgray, 0.5), c_red, c_red, 0, 1, 1);


#region Status Effects

if ( pSirenSongTimer > 0 )
{
	var _statusOrigin = [ _guiLeft, _guiTop + 300 ];
	draw_set_color(c_black);
	draw_set_alpha(0.25);
	draw_rectangle(_statusOrigin[0] - 64, _statusOrigin[1] - 45, _statusOrigin[0] + 300, _statusOrigin[1] + 45, 0);
	draw_set_color(c_white);
	draw_set_alpha(1.00);	
	//draw_rectangle(_statusOrigin[0] - 64, _statusOrigin[1] - 45, _statusOrigin[0] + 256, _statusOrigin[1] + 45, 1);

	draw_set_font(FntHudA);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	var _string = "BUFF: Siren Song";
	if ( pSirenSongStacks > 0 ) { _string += " Lv" + string(pSirenSongStacks); }
	draw_text( _statusOrigin[0] + 8, _statusOrigin[1], _string );
	
	var _barWidth = 300 - 16;
	draw_set_alpha(1.00);
	draw_set_color(c_dkgray);
	draw_rectangle(_statusOrigin[0] + 8, _statusOrigin[1] + 4, _statusOrigin[0] + 8 + _barWidth, _statusOrigin[1] + 25, 0);
	draw_set_color(c_aqua);
	draw_rectangle(_statusOrigin[0] + 8, _statusOrigin[1] + 4, _statusOrigin[0] + 8 + ( _barWidth * ( pSirenSongTimer / pSirenSongFrames ) ), _statusOrigin[1] + 25, 0);
	
	draw_set_color(c_white);
	draw_line_width( _statusOrigin[0] + 8, _statusOrigin[1], _statusOrigin[0] + 8, _statusOrigin[1] + 29, 4 );
	draw_line_width( _statusOrigin[0] + 8 + _barWidth, _statusOrigin[1], _statusOrigin[0] + 8 + _barWidth, _statusOrigin[1] + 29, 4 );
	
}

#endregion


#region Player Hud

var _hudOrigin = [ _guiCenterX - charOffset[0], _guiBottom - 96 - charOffset[1] ];

#region Decorative Elements

draw_sprite_ext(Spr_Hud_Decoration_Side, 0, _hudOrigin[0] + 24, _hudOrigin[1],  1.00, 1.00, 0, c_white, 0.25);
draw_sprite_ext(Spr_Hud_Decoration_Side, 0, _hudOrigin[0] - 24, _hudOrigin[1], -1.00, 1.00, 0, c_white, 0.25);
draw_sprite_ext(Spr_Hud_Decoration_Mid, 0, _hudOrigin[0], _hudOrigin[1] - 20, 0.85, 0.85, 0, c_white, 0.25);

#endregion

#region Current Ability
var _color = c_white;
if ( pEnergy < pSkillEnergyCost || pSkillCooldownTimer > 0 ) { _color = c_gray; }
draw_sprite_ext(Spr_Hud_Ability, 0, _hudOrigin[0] - 74, _hudOrigin[1] - 40, 0.8, 0.8, 0, _color, 1);
#endregion

#region Shot Element
draw_sprite_ext(Spr_Hud_Element, playerElementCurrent, _hudOrigin[0] + 74, _hudOrigin[1] - 40, 0.8, 0.8, 0, c_white, 1);
#endregion

#region Health and Stamina Bars

drawHpReal    = charHealth;
drawSpReal    = pEnergy;

drawHpDisplay = lerp(drawHpDisplay, drawHpReal, 0.5);
drawSpDisplay = lerp(drawSpDisplay, drawSpReal, 0.5);

draw_set_font(FntHudA);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_valign(fa_middle);

draw_sprite_ext(Spr_Hud_BarFrame, 0, _hudOrigin[0], _hudOrigin[1],  1, 1, 0, c_white, 1);
draw_sprite_ext(Spr_Hud_BarFrame, 0, _hudOrigin[0], _hudOrigin[1], -1, 1, 0, c_white, 1);

var _percent = clamp(drawHpDisplay / charHealthMax, 0, 1);
draw_sprite_ext(Spr_Hud_BarFill, 0, _hudOrigin[0] + 66, _hudOrigin[1],  _percent, 1, 0, c_white, 1);
draw_set_halign(fa_left);
for( var i = 1; i >= 0; i--; )
{
	if ( i == 1 ) { draw_set_color(c_navy); } else { draw_set_color(c_white); }
	draw_text(_hudOrigin[0] + 56 - (i*2), _hudOrigin[1] + 36 + (i*2), "HP: " + string( floor(charHealth) ) + "/" + string(charHealthMax) );
}

var _percent = clamp(drawSpDisplay / pEnergyMax, 0, 1);
draw_sprite_ext(Spr_Hud_BarFill, 1, _hudOrigin[0] - 66, _hudOrigin[1], -_percent, 1, 0, c_white, 1);
draw_set_halign(fa_right);
for( var i = 1; i >= 0; i--; )
{
	if ( i == 1 ) { draw_set_color(c_navy); } else { draw_set_color(c_white); }
	draw_text(_hudOrigin[0] - 56 - (i*2), _hudOrigin[1] + 36 + (i*2), "SP: " + string( floor(pEnergy) ) + "/" + string(pEnergyMax) );
}

#endregion

#region Player Level
draw_set_halign(fa_center);
for( var i = 1; i >= 0; i--; )
{
	if ( i == 1 ) { draw_set_color(c_navy); } else { draw_set_color(c_white); }
	draw_text(_hudOrigin[0] - (i*2), _hudOrigin[1] + 70 + (i*2), "Lv. 10" );
}
#endregion

#region Character Portrait
draw_sprite_ext(Spr_Hud_Portrait, 0, _hudOrigin[0], _hudOrigin[1], 1, 1, 0, c_white, 1);
#endregion

#endregion