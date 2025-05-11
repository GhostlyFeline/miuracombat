// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum enumProjPlayerElement
{
	water,
	light,
	fire,
	ice,
}

function Player_Element_Menu_Init()
{
	playerElementCurrent = enumProjPlayerElement.water;	
	
	pElementMenuEnabled = false;
	pElementMenuRadius    = 240;
	pElementMenuPointDir  = 0;
	pElementMenuPointDist = 0;
	pElementMenuConfirm = false;
}

function Player_Element_Menu_Tick()
{
	if ( pElementMenuEnabled )
	{
		var _dismiss = false;	
	
		var _aimAxisX = input_value("aimright") - input_value("aimleft");
		var _aimAxisY = input_value("aimdown")  - input_value("aimup");
		
		var _rawLen = point_distance (0, 0, _aimAxisX, _aimAxisY);	
	
		if ( _rawLen >= 0.50 )
		{
			pElementMenuPointDir = round(point_direction(0, 0, _aimAxisX, _aimAxisY)/90)*90;
			pElementMenuPointDist = 1;
			pElementMenuConfirm = true;
		}
		else
		{
			pElementMenuPointDist = 0;
		}
	
		if ( pElementMenuConfirm && ( _rawLen < 0.25 || !input_check("element") ) )
		{		
			switch(pElementMenuPointDir)
			{
				case 0:
					playerElementCurrent = enumProjPlayerElement.ice;
					Character_Flash_Activate(15, 1, merge_color(c_aqua, c_white, 0.33), 1, true, 10);
					part_particles_create(FxHandler.fxSysGlobalBelow, x, y, FxHandler.fxType[enumFxType.pFxProj_iceHitFlash00]  , 1 );
					break;
				
				case 90:
					playerElementCurrent = enumProjPlayerElement.water;
					Character_Flash_Activate(15, 1, merge_color(c_blue, c_white, 0.33), 1, true, 10);
					part_particles_create(FxHandler.fxSysGlobalBelow, x, y, FxHandler.fxType[enumFxType.pFxProj_waterHitFlash00], 1 );
					break;
				
				case 180:
					playerElementCurrent = enumProjPlayerElement.light;
					Character_Flash_Activate(15, 1, merge_color(c_yellow, c_white, 0.33), 1, true, 10);
					part_particles_create(FxHandler.fxSysGlobalBelow, x, y, FxHandler.fxType[enumFxType.pFxProj_lightHitFlash00], 1 );
					break;
				
				case 270:
					playerElementCurrent = enumProjPlayerElement.fire;
					Character_Flash_Activate(15, 1, merge_color(c_red, c_white, 0.33), 1, true, 10);
					part_particles_create(FxHandler.fxSysGlobalBelow, x, y, FxHandler.fxType[enumFxType.pFxProj_fireHitFlash00] , 1 );
					break;
			}
				
			audio_play_sound(SndPlayerSwitchElement, 10, 0);		
			show_debug_message("ELEMENT: " + string(playerElementCurrent) );
			pElementSwap_animTimer = pElementSwap_frames;
			_dismiss = true;
		}
	
	
	
		if ( _dismiss || !input_check("element") )
		{
			pElementMenuEnabled = false;
			pElementMenuConfirm = false;
		}
		
		return true;
	}
	else
	{
		if ( pElementSwap_animTimer < 0 && pAttackA_animTimer < 0 )
		{
			if ( input_check_pressed("element" ) )
			{		
				window_mouse_set(window_get_width() / 2, window_get_height() / 2);
				pElementMenuEnabled = true;
				pElementMenuConfirm = false;
				pElementMenuPointDist = 0;
			}
		}
		else { pElementSwap_animTimer--; }
	}
	
	return false;
}