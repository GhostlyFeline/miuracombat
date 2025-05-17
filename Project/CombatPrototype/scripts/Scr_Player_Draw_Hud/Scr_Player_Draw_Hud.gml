// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function Player_Draw_Hud_StyleA()
{
	var _guiLeft   = 0;
	var _guiRight  = display_get_gui_width();
	var _guiTop    = 0;
	var _guiBottom = display_get_gui_height();

	var _guiCenterX = ( _guiLeft + _guiRight  ) * 0.5;
	var _guiCenterY = ( _guiTop  + _guiBottom ) * 0.5;

	var _guiWidth  = display_get_gui_width();
	var _guiHeight = display_get_gui_height();
	
	#region Player Hud

	var _hudOrigin = [ _guiCenterX - charOffset[0], _guiBottom - 96 - charOffset[1] ];

	#region Decorative Elements

	var _elementColor = c_white;
	switch(playerElementCurrent)
	{
		case enumProjPlayerElement.spirit: _elementColor = merge_color(c_blue  , c_white, 0.66); break;
		case enumProjPlayerElement.light:  _elementColor = merge_color(c_yellow, c_white, 0.66); break;
		case enumProjPlayerElement.fire:   _elementColor = merge_color(c_red   , c_white, 0.66); break;
		case enumProjPlayerElement.ice:    _elementColor = merge_color(c_aqua  , c_white, 0.66); break;
	}
	draw_sprite_ext(Spr_Hud_Decoration_Side, 0, _hudOrigin[0] + 24, _hudOrigin[1],  1.00, 1.00, 0, _elementColor, 0.25);
	draw_sprite_ext(Spr_Hud_Decoration_Side, 0, _hudOrigin[0] - 24, _hudOrigin[1], -1.00, 1.00, 0, _elementColor, 0.25);
	draw_sprite_ext(Spr_Hud_Decoration_Mid, 0, _hudOrigin[0], _hudOrigin[1] - 20, 0.85, 0.85, 0, _elementColor, 0.66);

	#endregion

	#region Current Ability
	var _color = c_white;
	if ( pEnergy < pSkillEnergyCost || pSkillCooldownTimer > 0 || pSirenSongStacks >= 3 ) { _color = c_gray; }
	draw_sprite_ext(Spr_Hud_Ability, 0, _hudOrigin[0] + 74, _hudOrigin[1] - 40, 0.8, 0.8, 0, _color, 1);
	#endregion

	#region Shot Element
	//draw_sprite_ext(Spr_Hud_Element, playerElementCurrent, _hudOrigin[0] + 74, _hudOrigin[1] - 40, 0.8, 0.8, 0, c_white, 1);
	#endregion

	#region Spells
	for ( var i = 0; i < 3; i++; )
	{
		var _color = c_white;
		if ( pEnergy < pBreakerEnergyCost || pBreakerCooldownTimer > 0 ) { _color = c_gray; }
		draw_sprite_ext(Spr_Hud_Spell, 0, _hudOrigin[0] - 160 + ( i * 45 ), _hudOrigin[1] - 40, 0.8, 0.8, 0, _color, 1);
	}
	#endregion

	#region Health and Stamina Bars

	drawHpReal    = charHealth;
	drawMpReal    = pEnergy;

	drawHpDisplay = lerp(drawHpDisplay, drawHpReal, 0.5);
	drawMpDisplay = lerp(drawMpDisplay, drawMpReal, 0.5);

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

	var _percent = clamp(drawMpDisplay / pEnergyMax, 0, 1);
	draw_sprite_ext(Spr_Hud_BarFill, 1, _hudOrigin[0] - 66, _hudOrigin[1], -_percent, 1, 0, c_white, 1);
	draw_set_halign(fa_right);
	for( var i = 1; i >= 0; i--; )
	{
		if ( i == 1 ) { draw_set_color(c_navy); } else { draw_set_color(c_white); }
		draw_text(_hudOrigin[0] - 56 - (i*2), _hudOrigin[1] + 36 + (i*2), "MP: " + string( floor(pEnergy) ) + "/" + string(pEnergyMax) );
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

}



function Player_Draw_Hud_StyleB()
{
	var _guiLeft   = 0;
	var _guiRight  = display_get_gui_width();
	var _guiTop    = 0;
	var _guiBottom = display_get_gui_height();

	var _guiCenterX = ( _guiLeft + _guiRight  ) * 0.5;
	var _guiCenterY = ( _guiTop  + _guiBottom ) * 0.5;

	var _guiWidth  = display_get_gui_width();
	var _guiHeight = display_get_gui_height();
	
	#region Player Hud

	var _hudOrigin = [ _guiLeft + 80 - charOffset[0], _guiBottom - 96 - charOffset[1] ];

	#region Decorative Elements

	var _elementColor = c_white;
	switch(playerElementCurrent)
	{
		case enumProjPlayerElement.spirit: _elementColor = merge_color(c_blue  , c_white, 0.66); break;
		case enumProjPlayerElement.light:  _elementColor = merge_color(c_yellow, c_white, 0.66); break;
		case enumProjPlayerElement.fire:   _elementColor = merge_color(c_red   , c_white, 0.66); break;
		case enumProjPlayerElement.ice:    _elementColor = merge_color(c_aqua  , c_white, 0.66); break;
	}
	draw_sprite_ext(Spr_Hud_Decoration_Side, 0, _hudOrigin[0] + 24, _hudOrigin[1],  1.20, 1.20, 0, _elementColor, 0.50);
	draw_sprite_ext(Spr_Hud_Decoration_Mid, 0, _hudOrigin[0], _hudOrigin[1] - 20, 0.85, 0.85, 0, _elementColor, 0.66);

	#endregion

	


	

	#region Health and Stamina Bars

	drawHpReal    = charHealth;
	drawMpReal    = pEnergy;

	drawHpDisplay = lerp(drawHpDisplay, drawHpReal, 0.5);
	drawMpDisplay = lerp(drawMpDisplay, drawMpReal, 0.5);

	draw_set_font(FntHudA_Small);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_valign(fa_middle);

	draw_sprite_ext(Spr_Hud_BarFrame, 0, _hudOrigin[0], _hudOrigin[1] - 24,  1, 1, 0, c_white, 1);
	draw_sprite_ext(Spr_Hud_BarFrame, 0, _hudOrigin[0] + 50, _hudOrigin[1] + 24,  1, 1, 0, c_white, 1);

	var _percent = clamp(drawHpDisplay / charHealthMax, 0, 1);
	var _barPosition = [ _hudOrigin[0] + 66, _hudOrigin[1] - 24 ];
	draw_sprite_ext(Spr_Hud_BarFill, 0, _barPosition[0], _barPosition[1],  _percent, 1, 0, c_white, 1);
	draw_set_halign(fa_left);
	for( var i = 2; i >= 0; i--; )
	{
		var _dropColor = merge_color( merge_color(c_red, c_fuchsia, 0.5), c_black, 0.66 );
		
		if ( i == 2 ) { draw_set_color(merge_color( _dropColor, c_black, 0.5 )); draw_set_alpha(0.5); }
		if ( i == 1 ) { draw_set_color(_dropColor); draw_set_alpha(1); }
		if ( i == 0 ) { draw_set_color(c_white); }
		
		if ( i == 1 )
		{
			for ( var j = 0; j < 6; j++; )
			{
				var _len = 1.5;
				var _dir = (360 / 6) * j;
				var _lX  = lengthdir_x(_len, _dir);
				var _lY  = lengthdir_y(_len, _dir);
				draw_text( _barPosition[0] + 8 + _lX, _barPosition[1] + 2 + _lY, "HP: " + string( floor(charHealth) ) + "/" + string(charHealthMax) );
			}
		}
		else { draw_text( _barPosition[0] + 8 - (i*2), _barPosition[1] + 2 + (i*2), "HP: " + string( floor(charHealth) ) + "/" + string(charHealthMax) ); }
	}

	var _percent = clamp(drawMpDisplay / pEnergyMax, 0, 1);
	var _barPosition = [ _hudOrigin[0] + 50 + 66, _hudOrigin[1] + 24 ];
	draw_sprite_ext(Spr_Hud_BarFill, 1, _barPosition[0], _barPosition[1], _percent, 1, 0, c_white, 1);
	//draw_set_halign(fa_right);
	for( var i = 2; i >= 0; i--; )
	{
		var _dropColor = merge_color( merge_color(c_green, c_teal, 0.5), c_black, 0.66 );
		
		if ( i == 2 ) { draw_set_color(merge_color( _dropColor, c_black, 0.5 )); draw_set_alpha(0.5); }
		if ( i == 1 ) { draw_set_color(_dropColor); draw_set_alpha(1); }
		if ( i == 0 ) { draw_set_color(c_white); }
		
		if ( i == 1 )
		{
			for ( var j = 0; j < 6; j++; )
			{
				var _len = 1.5;
				var _dir = (360 / 6) * j;
				var _lX  = lengthdir_x(_len, _dir);
				var _lY  = lengthdir_y(_len, _dir);
				draw_text(_barPosition[0] + 8 + _lX, _barPosition[1] + 2 + _lY, "MP: " + string( floor(pEnergy) ) + "/" + string(pEnergyMax) );
			}
		}
		draw_text(_barPosition[0] + 8 - (i*2), _barPosition[1] + 2 + (i*2), "MP: " + string( floor(pEnergy) ) + "/" + string(pEnergyMax) );
	}

	#endregion

	#region Player Level
	draw_set_halign(fa_center);
	draw_set_font(FntHudA);
	for( var i = 1; i >= 0; i--; )
	{
		if ( i == 1 ) { draw_set_color(c_navy); } else { draw_set_color(c_white); }
		draw_text(_hudOrigin[0] - (i*2), _hudOrigin[1] + 70 + (i*2), "Lv. 10" );
	}
	#endregion
	
	#region Spells
	for ( var i = 0; i < 3; i++; )
	{
		var _color = c_white;
		if ( pEnergy < pBreakerEnergyCost || pBreakerCooldownTimer > 0 ) { _color = c_gray; }
		draw_sprite_ext(Spr_Hud_Spell, 0, _hudOrigin[0] + 120 + ( i * 45 ), _hudOrigin[1] + 68, 0.8, 0.8, 0, _color, 1);
	}
	#endregion
	
	#region Current Ability
	var _color = c_white;
	if ( pEnergy < pSkillEnergyCost || pSkillCooldownTimer > 0 || pSirenSongStacks >= 3 ) { _color = c_gray; }
	draw_sprite_ext(Spr_Hud_Ability, 0, _hudOrigin[0] + 70, _hudOrigin[1] + 36, 0.8, 0.8, 0, _color, 1);
	#endregion
	
	#region Character Portrait
	draw_sprite_ext(Spr_Hud_Portrait, 0, _hudOrigin[0], _hudOrigin[1], 1, 1, 0, c_white, 1);
	#endregion

	#endregion

}