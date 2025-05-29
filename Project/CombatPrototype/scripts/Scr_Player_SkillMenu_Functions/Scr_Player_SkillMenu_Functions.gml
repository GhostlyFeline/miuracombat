// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum enumPlayerSkills
{
	sirenSong,
	iceShield,
	magmaAura,
	purify,
}

function Player_Skill_Menu_Init()
{
	//playerElementCurrent = enumProjPlayerElement.spirit;	
	
	pSkillMenuEnabled = false;
	pSkillMenuRadius    = 240;
	pSkillMenuPointDir  = 0;
	pSkillMenuPointDist = 0;
	pSkillMenuConfirm = false;
	pSkillMenuHolding = false;
}

function Player_Skill_Menu_Tick()
{
	if ( pSkillMenuEnabled )
	{
		pSkillMenuHolding = true;
		
		var _dismiss = false;	
	
		var _aimAxisX = input_value("aimright") - input_value("aimleft");
		var _aimAxisY = input_value("aimdown")  - input_value("aimup");
		
		if ( input_player_using_keyboard() )
		{
			var _guiCenterX = display_get_gui_width() * 0.5;
			var _guiCenterY = display_get_gui_height() * 0.5;

			var _guiMouseX = (window_mouse_get_x() / window_get_width() ) * display_get_gui_width();
			var _guiMouseY = (window_mouse_get_y() / window_get_height()) * display_get_gui_height();
			
			
			var _dist = point_distance (_guiCenterX, _guiCenterX, _guiMouseX, _guiMouseY);
			var _dir  = point_direction(_guiCenterX, _guiCenterX, _guiMouseX, _guiMouseY);
			
			_aimAxisX = ( _guiMouseX - _guiCenterX ) / pElementMenuRadius;
			_aimAxisY = ( _guiMouseY - _guiCenterY ) / pElementMenuRadius;
		}
		
		var _rawLen = point_distance (0, 0, _aimAxisX, _aimAxisY);	
	
		if ( _rawLen >= 0.25 )
		{
			pSkillMenuPointDir = round(point_direction(0, 0, _aimAxisX, _aimAxisY)/90)*90;
			pSkillMenuPointDist = 1;
			pSkillMenuConfirm = true;
		}
		else
		{
			if ( input_player_using_gamepad() ) { pSkillMenuPointDist = 0; }
		}
	
		if ( pSkillMenuConfirm && ( ( _rawLen < 0.25 && input_player_using_gamepad() ) || !input_check("skillSwap") ) )
		{		
			switch(pSkillMenuPointDir)
			{
				
				
				case 90:
					pSkillCurrent = State_Player_Skill_SirenSong;
					Character_Flash_Activate(15, 1, merge_color(c_fuchsia, c_white, 0.33), 1, true, 10);
					part_particles_create(FxHandler.fxSysGlobalBelow, x, y, FxHandler.fxType[enumFxType.pFxProj_spiritHitFlash00], 1 );
					break;
				
				case 180:
					pSkillCurrent = State_Player_Skill_IceShield;
					Character_Flash_Activate(15, 1, merge_color(c_aqua, c_white, 0.33), 1, true, 10);
					part_particles_create(FxHandler.fxSysGlobalBelow, x, y, FxHandler.fxType[enumFxType.pFxProj_lightHitFlash00], 1 );
					break;
					
				case 0:
					pSkillCurrent = State_Player_Skill_MagmaAura;
					Character_Flash_Activate(15, 1, merge_color(c_orange, c_white, 0.33), 1, true, 10);
					part_particles_create(FxHandler.fxSysGlobalBelow, x, y, FxHandler.fxType[enumFxType.pFxProj_iceHitFlash00]  , 1 );
					break;
				
				case 270:
					pSkillCurrent = State_Player_Skill_Purify;
					Character_Flash_Activate(15, 1, merge_color(c_green, c_white, 0.33), 1, true, 10);
					part_particles_create(FxHandler.fxSysGlobalBelow, x, y, FxHandler.fxType[enumFxType.pFxProj_fireHitFlash00] , 1 );
					break;
			}
				
			Sound_Play(enumSoundFxList.playerSwitchElement);
			show_debug_message("SKILL: " + string(pSkillCurrent) );
			pElementSwap_animTimer = pElementSwap_frames;
			_dismiss = true;
		}
	
	
	
		if ( _dismiss || !input_check("skillSwap") )
		{
			pSkillMenuEnabled = false;
			pSkillMenuConfirm = false;
		}
		
		return true;
	}
	else
	{
		if ( pElementSwap_animTimer < 0 && stateCurrent == State_Player_Normal )
		{
			if ( input_check("skillSwap" ) && !pSkillMenuHolding )
			{		
				window_mouse_set(window_get_width() / 2, window_get_height() / 2);
				pSkillMenuEnabled = true;
				pSkillMenuConfirm = false;
				pSkillMenuPointDist = 0;
			}
		}
		else { pElementSwap_animTimer--; }
	}
	
	if ( !input_check("skillSwap") ) { pSkillMenuHolding = false; }
	
	return false;
}