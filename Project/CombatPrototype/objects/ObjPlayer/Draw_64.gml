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
	
	draw_set_font(FntHudA);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	for ( var i = 0; i < 4; i++; )
	{
		var _dir = 360 * ( i / 4 );
		var _len = pElementMenuRadius;
		var _lX = lengthdir_x(_len, _dir);
		var _lY = lengthdir_y(_len, _dir);
		
		var _string = "";
		
		draw_set_alpha(1.0);
		draw_set_color(c_dkgray);
		draw_circle(_guiCenterX + _lX, _guiCenterY + _lY, 100, 0);	
		draw_set_color(c_white);
		draw_circle(_guiCenterX + _lX, _guiCenterY + _lY, 100, 1);
		
		var _elementColor = c_white;
		switch(i)
		{
			case 1: _elementColor = merge_color(c_blue  , c_white, 0.33); _string = "Spirit"; break;
			case 2: _elementColor = merge_color(c_yellow, c_white, 0.33); _string = "Light";  break;
			case 0: _elementColor = merge_color(c_aqua  , c_white, 0.33); _string = "Ice";    break;
			case 3: _elementColor = merge_color(c_red   , c_white, 0.33); _string = "Fire";   break;
		}
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(SprProjPlayer00, tick * 0.25, _guiCenterX + _lX, _guiCenterY + _lY, 3, 3, tick + 00, _elementColor, 0.66);
		draw_sprite_ext(SprProjPlayer00, tick * 0.25, _guiCenterX + _lX, _guiCenterY + _lY, 1, 1, tick + 30,       c_white, 1.00);
		gpu_set_blendmode(bm_normal);
		
		draw_set_color( merge_color(_elementColor, c_white, 0.66) );
		draw_text(_guiCenterX + _lX, _guiCenterY + _lY + 64, _string);
	}
}



if ( pSkillMenuEnabled )
{
	draw_set_color(c_black);
	draw_set_alpha(0.33);
	draw_rectangle(_guiLeft - 64, _guiTop - 64, _guiRight + 64, _guiBottom + 64, 0);
	
	draw_set_color(c_white);
	draw_set_alpha(0.10);
	draw_circle(_guiCenterX, _guiCenterY, pSkillMenuRadius, 0);	
	draw_set_alpha(1.0);
	draw_circle(_guiCenterX, _guiCenterY, pSkillMenuRadius, 1);
		
	var _lineDir  = pSkillMenuPointDir;
	var _lineDist = pSkillMenuPointDist * pSkillMenuRadius;
	var _lX = lengthdir_x(_lineDist, _lineDir);
	var _lY = lengthdir_y(_lineDist, _lineDir);
	draw_line_width(_guiCenterX, _guiCenterY, _guiCenterX + _lX, _guiCenterY + _lY, 4);
	
	draw_set_font(FntHudA);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	for ( var i = 0; i < 4; i++; )
	{
		var _dir = 360 * ( i / 4 );
		var _len = pSkillMenuRadius;
		var _lX = lengthdir_x(_len, _dir);
		var _lY = lengthdir_y(_len, _dir);
		
		var _string = "";
		
		draw_set_alpha(1.0);
		draw_set_color(c_dkgray);
		draw_circle(_guiCenterX + _lX, _guiCenterY + _lY, 100, 0);	
		draw_set_color(c_white);
		draw_circle(_guiCenterX + _lX, _guiCenterY + _lY, 100, 1);
		
		var _frame = 0;
		switch(i)
		{
			case 1: _frame = 0; _string = "Siren Song";    break;
			case 2: _frame = 1; _string = "Crystal Armor"; break;
			case 0: _frame = 2; _string = "Magma Aura";    break;
			case 3: _frame = 3; _string = "Purification";  break;
		}
		
		draw_sprite_ext(Spr_Hud_Ability, _frame, _guiCenterX + _lX, _guiCenterY + _lY, 2.5, 2.5, 0, c_white, 1.00);
		
		draw_set_color( c_white );
		draw_text(_guiCenterX + _lX, _guiCenterY + _lY + 96, _string);
		
	}
}




draw_set_color(c_white);
draw_set_alpha(1);
//draw_healthbar(_guiCenterX + 32 + charOffset[0], _guiBottom - 64 + charOffset[1], _guiRight - 128 + charOffset[0], _guiBottom - 32 + charOffset[1], (charHealth / charHealthMax) * 100, merge_color(c_black, c_dkgray, 0.5), c_red, c_red, 0, 1, 1);


#region Status Effects

if ( pSirenSongTimer > 0 )
{
	var _statusOrigin = [ _guiLeft, _guiTop + 200 ];
	var _baseColor = merge_color(c_teal, c_blue, 0.33);
	var _bgColor       = merge_color(_baseColor,  c_black, 0.66);
	var _barEmptyColor = merge_color(_baseColor, c_dkgray, 0.80);
	var _barFillColor  = merge_color(_baseColor,  c_white, 0.10);
	
	#region Background
	
	draw_set_color(_bgColor);
	draw_set_alpha(0.33);
	draw_rectangle(_statusOrigin[0] - 64, _statusOrigin[1] - 42, _statusOrigin[0] + 320, _statusOrigin[1] + 42, 0);
	
	#endregion
	
	#region Label Text
	
	draw_set_font(FntHudA);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_alpha(1.00);
	var _string = "BUFF: Siren Song";
	if ( pSirenSongStacks > 0 ) { _string += " Lv" + string(pSirenSongStacks); }
	for( var i = 1; i >= 0; i--; )
	{
		if ( i == 1 ) { draw_set_color(_baseColor); } else { draw_set_color(c_white); }
		draw_text( _statusOrigin[0] + 160 - (i*2), _statusOrigin[1] + (i*2), _string );
	}
	draw_text( _statusOrigin[0] + 160, _statusOrigin[1], _string );
	
	#endregion
	
	#region Bar
	
	var _barWidth = 320 - 32;
	draw_set_alpha(1.00);
	draw_set_color(_barEmptyColor);
	draw_rectangle(_statusOrigin[0] + 16, _statusOrigin[1] + 4, _statusOrigin[0] + 16 + _barWidth, _statusOrigin[1] + 25, 0);
	draw_rectangle_color(_statusOrigin[0] + 16, _statusOrigin[1] + 4, _statusOrigin[0] + 16 + ( _barWidth * ( pSirenSongTimer / pSirenSongFrames ) ), _statusOrigin[1] + 25, _barFillColor, c_white, c_white, _barFillColor, 0);
	
	draw_set_color(c_white);
	draw_line_width( _statusOrigin[0] + 16, _statusOrigin[1], _statusOrigin[0] + 16, _statusOrigin[1] + 29, 3 );
	draw_line_width( _statusOrigin[0] + 16 + _barWidth, _statusOrigin[1], _statusOrigin[0] + 16 + _barWidth, _statusOrigin[1] + 29, 3 );
	
	#endregion	
}


if ( pMagmaAuraTimer > 0 )
{
	var _statusOrigin = [ _guiLeft, _guiTop + 300 ];
	var _baseColor = merge_color(c_teal, c_blue, 0.33);
	var _bgColor       = merge_color(_baseColor,  c_black, 0.66);
	var _barEmptyColor = merge_color(_baseColor, c_dkgray, 0.80);
	var _barFillColor  = merge_color(_baseColor,  c_white, 0.10);
	
	#region Background
	
	draw_set_color(_bgColor);
	draw_set_alpha(0.33);
	draw_rectangle(_statusOrigin[0] - 64, _statusOrigin[1] - 42, _statusOrigin[0] + 320, _statusOrigin[1] + 42, 0);
	
	#endregion
	
	#region Label Text
	
	draw_set_font(FntHudA);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_alpha(1.00);
	var _string = "BUFF: Magma Aura";
	//if ( pSirenSongStacks > 0 ) { _string += " Lv" + string(pSirenSongStacks); }
	for( var i = 1; i >= 0; i--; )
	{
		if ( i == 1 ) { draw_set_color(_baseColor); } else { draw_set_color(c_white); }
		draw_text( _statusOrigin[0] + 160 - (i*2), _statusOrigin[1] + (i*2), _string );
	}
	draw_text( _statusOrigin[0] + 160, _statusOrigin[1], _string );
	
	#endregion
	
	#region Bar
	
	var _barWidth = 320 - 32;
	draw_set_alpha(1.00);
	draw_set_color(_barEmptyColor);
	draw_rectangle(_statusOrigin[0] + 16, _statusOrigin[1] + 4, _statusOrigin[0] + 16 + _barWidth, _statusOrigin[1] + 25, 0);
	draw_rectangle_color(_statusOrigin[0] + 16, _statusOrigin[1] + 4, _statusOrigin[0] + 16 + ( _barWidth * ( pMagmaAuraTimer / pMagmaAuraFrames ) ), _statusOrigin[1] + 25, _barFillColor, c_white, c_white, _barFillColor, 0);
	
	draw_set_color(c_white);
	draw_line_width( _statusOrigin[0] + 16, _statusOrigin[1], _statusOrigin[0] + 16, _statusOrigin[1] + 29, 3 );
	draw_line_width( _statusOrigin[0] + 16 + _barWidth, _statusOrigin[1], _statusOrigin[0] + 16 + _barWidth, _statusOrigin[1] + 29, 3 );
	
	#endregion	
}

if ( pIceArmorTimer > 0 )
{
	var _statusOrigin = [ _guiLeft, _guiTop + 400 ];
	var _baseColor = merge_color(c_teal, c_blue, 0.33);
	var _bgColor       = merge_color(_baseColor,  c_black, 0.66);
	var _barEmptyColor = merge_color(_baseColor, c_dkgray, 0.80);
	var _barFillColor  = merge_color(_baseColor,  c_white, 0.10);
	
	#region Background
	
	draw_set_color(_bgColor);
	draw_set_alpha(0.33);
	draw_rectangle(_statusOrigin[0] - 64, _statusOrigin[1] - 42, _statusOrigin[0] + 320, _statusOrigin[1] + 42, 0);
	
	#endregion
	
	#region Label Text
	
	draw_set_font(FntHudA);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_alpha(1.00);
	var _string = "BUFF: Crystal Armor";
	for( var i = 1; i >= 0; i--; )
	{
		if ( i == 1 ) { draw_set_color(_baseColor); } else { draw_set_color(c_white); }
		draw_text( _statusOrigin[0] + 160 - (i*2), _statusOrigin[1] + (i*2), _string );
	}
	draw_text( _statusOrigin[0] + 160, _statusOrigin[1], _string );
	
	#endregion
	
	#region Bar
	
	var _barWidth = 320 - 32;
	draw_set_alpha(1.00);
	draw_set_color(_barEmptyColor);
	draw_rectangle(_statusOrigin[0] + 16, _statusOrigin[1] + 4, _statusOrigin[0] + 16 + _barWidth, _statusOrigin[1] + 25, 0);
	draw_rectangle_color(_statusOrigin[0] + 16, _statusOrigin[1] + 4, _statusOrigin[0] + 16 + ( _barWidth * ( pIceArmorTimer / pIceArmorFrames ) ), _statusOrigin[1] + 25, _barFillColor, c_white, c_white, _barFillColor, 0);
	
	draw_set_color(c_white);
	draw_line_width( _statusOrigin[0] + 16, _statusOrigin[1], _statusOrigin[0] + 16, _statusOrigin[1] + 29, 3 );
	draw_line_width( _statusOrigin[0] + 16 + _barWidth, _statusOrigin[1], _statusOrigin[0] + 16 + _barWidth, _statusOrigin[1] + 29, 3 );
	
	#endregion	
}

#endregion

if ( pHudStyleToggle ) { Player_Draw_Hud_StyleB(); } else { Player_Draw_Hud_StyleA(); }