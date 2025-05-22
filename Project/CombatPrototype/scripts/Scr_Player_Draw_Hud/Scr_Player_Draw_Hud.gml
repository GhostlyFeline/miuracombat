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
	
	var _frame = 0;
	switch (pSkillCurrent)
	{
		case State_Player_Skill_SirenSong: _frame = 0; break;
		case State_Player_Skill_IceShield: _frame = 1; break;
		case State_Player_Skill_MagmaAura: _frame = 2; break;
		case State_Player_Skill_Purify:    _frame = 3; break;
	}
	
	var _color = c_white;
	if ( pEnergy < pSkillEnergyCost || pSkillCooldownTimer > 0 || pSirenSongStacks >= 3 ) { _color = c_gray; }
	draw_sprite_ext(Spr_Hud_Ability, _frame, _hudOrigin[0] + 74, _hudOrigin[1] - 40, 0.8, 0.8, 0, _color, 1);
	#endregion

	#region Shot Element
	//draw_sprite_ext(Spr_Hud_Element, playerElementCurrent, _hudOrigin[0] + 74, _hudOrigin[1] - 40, 0.8, 0.8, 0, c_white, 1);
	#endregion

	#region Spells
	
	
	for ( var i = 0; i < 3; i++; )
	{
		var _percent = 1;
		if ( i == 0 )
		{
			if ( pBreakerCooldownTimer > 0 ) { _percent = 1 - ( pBreakerCooldownTimer / pBreakerCooldownFrames ); }
			if ( pEnergy < pBreakerEnergyCost ) { _percent = 0; }
		}
		
		var _spellOrigin = [ _hudOrigin[0] - 160 + ( i * 45 ), _hudOrigin[1] - 40 ];
		var _sprOrigin = [ sprite_get_xoffset(Spr_Hud_Spell), sprite_get_yoffset(Spr_Hud_Spell) ];
	
		var _sprW = sprite_get_width (Spr_Hud_Spell);
		var _sprH = sprite_get_height(Spr_Hud_Spell);
	
		var _left    = 0;
		var _right   = _sprW;
		var _top     = _sprH - ( _percent * _sprH );
		var __bottom = _sprH;
				
		draw_sprite_ext(Spr_Hud_Spell, 0, _spellOrigin[0], _spellOrigin[1], 1, 1, 0, c_gray, 1);
		draw_sprite_part_ext(Spr_Hud_Spell, 0, _left, _top, _sprW, _sprH, _spellOrigin[0] - _sprOrigin[0], _spellOrigin[1] - _sprOrigin[1] + _top, 1, 1, c_white, 1);
	}
	
	
	for ( var i = 0; i < 3; i++; )
	{
		//var _color = c_white;
		//if ( pEnergy < pBreakerEnergyCost || pBreakerCooldownTimer > 0 ) { _color = c_gray; }
		//draw_sprite_ext(Spr_Hud_Spell, 0, _hudOrigin[0] - 160 + ( i * 45 ), _hudOrigin[1] - 40, 0.8, 0.8, 0, _color, 1);
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
	
	var _healthVal = floor(charHealth);
	if ( charHealth > 0 && charHealth < 1 ) { _healthVal = 1; }
	
	for( var i = 2; i >= 0; i--; )
	{
		var _dropColor = merge_color( merge_color(c_red, c_fuchsia, 0.5), c_black, 0.50 );
		
		if ( i == 2 ) { draw_set_color(merge_color( _dropColor, c_black, 0.25 )); draw_set_alpha(0.25); }
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
				draw_text(_hudOrigin[0] + 56 + _lX, _hudOrigin[1] + 36 + _lY, "HP: " + string( _healthVal ) + "/" + string(charHealthMax) );
			}
		}
		else { draw_text(_hudOrigin[0] + 56 - (i*2), _hudOrigin[1] + 36 + (i*2), "HP: " + string( _healthVal ) + "/" + string(charHealthMax) ); }
	}
	
	
	

	var _percent = clamp(drawMpDisplay / pEnergyMax, 0, 1);
	draw_sprite_ext(Spr_Hud_BarFill, 1, _hudOrigin[0] - 66, _hudOrigin[1], -_percent, 1, 0, c_white, 1);
	draw_set_halign(fa_right);
	for( var i = 2; i >= 0; i--; )
	{
		var _dropColor = merge_color( merge_color(c_green, c_teal, 0.5), c_black, 0.50 );
		
		if ( i == 2 ) { draw_set_color(merge_color( _dropColor, c_black, 0.25 )); draw_set_alpha(0.25); }
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
				draw_text(_hudOrigin[0] - 56 + _lX, _hudOrigin[1] + 36 + _lY, "SP: " + string( floor(pEnergy) ) + "/" + string(pEnergyMax) );
			}
		}
		else { draw_text(_hudOrigin[0] - 56 - (i*2), _hudOrigin[1] + 36 + (i*2), "SP: " + string( floor(pEnergy) ) + "/" + string(pEnergyMax) ); }
	}

	#endregion

	#region Player Level
	draw_set_halign(fa_center);
	for( var i = 1; i >= 0; i--; )
	{
		//if ( i == 1 ) { draw_set_color(c_navy); } else { draw_set_color(c_white); }
		//draw_text(_hudOrigin[0] - (i*2), _hudOrigin[1] + 70 + (i*2), "Lv. 10" );
	}
	
	for( var i = 2; i >= 0; i--; )
	{
		var _dropColor = merge_color( c_teal, c_black, 0.33 );
		
		if ( i == 2 ) { draw_set_color(merge_color( _dropColor, c_black, 0.25 )); draw_set_alpha(0.5); }
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
				draw_text(_hudOrigin[0] + _lX, _hudOrigin[1] + 70 + _lY, "Lv. 10" );
			}
		}
		else { draw_text(_hudOrigin[0] - (i*2), _hudOrigin[1] + 70 + (i*2), "Lv. 10" ); }
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

	var _hudOrigin = [ _guiLeft + 88 - charOffset[0], _guiBottom - 96 - charOffset[1] ];

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
	
	var _healthVal = floor(charHealth);
	if ( charHealth > 0 && charHealth < 1 ) { _healthVal = 1; }

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
				draw_text( _barPosition[0] + 8 + _lX, _barPosition[1] + 2 + _lY, "HP: " + string( _healthVal ) + "/" + string(charHealthMax) );
			}
		}
		else { draw_text( _barPosition[0] + 8 - (i*2), _barPosition[1] + 2 + (i*2), "HP: " + string( _healthVal ) + "/" + string(charHealthMax) ); }
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
				draw_text(_barPosition[0] + 8 + _lX, _barPosition[1] + 2 + _lY, "SP: " + string( floor(pEnergy) ) + "/" + string(pEnergyMax) );
			}
		}
		draw_text(_barPosition[0] + 8 - (i*2), _barPosition[1] + 2 + (i*2), "SP: " + string( floor(pEnergy) ) + "/" + string(pEnergyMax) );
	}

	#endregion

	#region Player Level
	draw_set_halign(fa_center);
	draw_set_font(FntHudA);
	for( var i = 2; i >= 0; i--; )
	{
		var _dropColor = merge_color( c_teal, c_black, 0.33 );
		
		if ( i == 2 ) { draw_set_color(merge_color( _dropColor, c_black, 0.25 )); draw_set_alpha(0.5); }
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
				draw_text(_hudOrigin[0] + _lX, _hudOrigin[1] + 70 + _lY, "Lv. 10" );
			}
		}
		else { draw_text(_hudOrigin[0] - (i*2), _hudOrigin[1] + 70 + (i*2), "Lv. 10" ); }
	}
	#endregion
	
	#region Spells
	for ( var i = 0; i < 3; i++; )
	{
		var _percent = 1;
		if ( i == 0 )
		{
			if ( pBreakerCooldownTimer > 0 ) { _percent = 1 - ( pBreakerCooldownTimer / pBreakerCooldownFrames ); }
			if ( pEnergy < pBreakerEnergyCost ) { _percent = 0; }
		}
		
		var _spellOrigin = [ _hudOrigin[0] + 120 + ( i * 47 ), _hudOrigin[1] + 70 ];
		var _sprOrigin = [ sprite_get_xoffset(Spr_Hud_Spell), sprite_get_yoffset(Spr_Hud_Spell) ];
	
		var _sprW = sprite_get_width (Spr_Hud_Spell);
		var _sprH = sprite_get_height(Spr_Hud_Spell);
	
		var _left    = 0;
		var _right   = _sprW;
		var _top     = _sprH - ( _percent * _sprH );
		var __bottom = _sprH;
				
		draw_sprite_ext(Spr_Hud_Spell, 0, _spellOrigin[0], _spellOrigin[1], 1, 1, 0, c_gray, 1);
		draw_sprite_part_ext(Spr_Hud_Spell, 0, _left, _top, _sprW, _sprH, _spellOrigin[0] - _sprOrigin[0], _spellOrigin[1] - _sprOrigin[1] + _top, 1, 1, c_white, 1);
	}
	#endregion
	
	#region Current Ability
	
	var _percent = 1;
	//if ( i == 0 )
	{
		if ( pSkillCooldownTimer > 0 ) { _percent = 1 - ( pSkillCooldownTimer / pSkillCooldownFrames ); }
		if ( pEnergy < pSkillEnergyCost ) { _percent = 0; }
	}
	
	var _frame = 0;
	switch (pSkillCurrent)
	{
		case State_Player_Skill_SirenSong: _frame = 0; break;
		case State_Player_Skill_IceShield: _frame = 1; break;
		case State_Player_Skill_MagmaAura: _frame = 2; break;
		case State_Player_Skill_Purify:    _frame = 3; break;
	}
	
	var _abilityPos = [ _hudOrigin[0] + 70, _hudOrigin[1] + 36 ];
	
	var _sprOrigin = [ sprite_get_xoffset(Spr_Hud_Ability), sprite_get_yoffset(Spr_Hud_Ability) ];
	
	var _sprW = sprite_get_width (Spr_Hud_Ability);
	var _sprH = sprite_get_height(Spr_Hud_Ability);
	
	var _left    = 0;
	var _right   = _sprW;
	var _top     = _sprH - ( _percent * _sprH );
	var __bottom = _sprH;
	
	
	draw_sprite_ext(Spr_Hud_Ability, _frame, _abilityPos[0], _abilityPos[1], 1, 1, 0, c_gray, 1);
	
	draw_sprite_part_ext(Spr_Hud_Ability, _frame, _left, _top, _sprW, _sprH, _abilityPos[0] - _sprOrigin[0], _abilityPos[1] - _sprOrigin[1] + _top, 1, 1, c_white, 1);
	
	
	
	var _color = c_white;
	if ( pEnergy < pSkillEnergyCost || pSkillCooldownTimer > 0 || pSirenSongStacks >= 3 ) { _color = c_gray; }
	//draw_sprite_ext(Spr_Hud_Ability, 0, _hudOrigin[0] + 70, _hudOrigin[1] + 36, 0.8, 0.8, 0, _color, 1);
	#endregion
	
	#region Limit Meter
	var lMeterPos = [ _hudOrigin[0] - 16, _hudOrigin[1] ];
	
	var _sprOrigin = [ sprite_get_xoffset(Spr_Hud_LimitMeter), sprite_get_yoffset(Spr_Hud_LimitMeter) ];
	
	var _sprW = sprite_get_width (Spr_Hud_LimitMeter);
	var _sprH = sprite_get_height(Spr_Hud_LimitMeter);
	
	var _left    = 0;
	var _right   = _sprW;
	var _top     = _sprH - ( (pLimit / pLimitMax) * _sprH );
	var __bottom = _sprH;
	
	
	draw_sprite_ext(Spr_Hud_LimitMeter, 0, lMeterPos[0], lMeterPos[1], 1, 1, 0, c_ltgray, 1);
	
	draw_sprite_part_ext(Spr_Hud_LimitMeter, 1, _left, _top, _sprW, _sprH, lMeterPos[0] - _sprOrigin[0], lMeterPos[1] - _sprOrigin[1] + _top, 1, 1, c_white, 1);
	if ( pLimit >= pLimitMax )
	{
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(Spr_Hud_LimitMeter, 1, lMeterPos[0], lMeterPos[1], 1, 1, 0, c_white, ( 1 - ( (tick mod 10) / 10 ) ) * 0.5 ); 
		gpu_set_blendmode(bm_normal);
	}
	
	#endregion
	
	#region Character Portrait
	draw_sprite_ext(Spr_Hud_Portrait, 0, _hudOrigin[0], _hudOrigin[1], 1, 1, 0, c_white, 1);
	#endregion

	#endregion

}