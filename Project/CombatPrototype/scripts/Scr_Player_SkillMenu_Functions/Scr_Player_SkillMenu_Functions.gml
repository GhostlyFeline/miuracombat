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
}

function Player_Skill_Menu_Tick()
{
	if ( pSkillMenuEnabled )
	{
		var _dismiss = false;	
	
		var _aimAxisX = input_value("aimright") - input_value("aimleft");
		var _aimAxisY = input_value("aimdown")  - input_value("aimup");
		
		var _rawLen = point_distance (0, 0, _aimAxisX, _aimAxisY);	
	
		if ( _rawLen >= 0.50 )
		{
			pSkillMenuPointDir = round(point_direction(0, 0, _aimAxisX, _aimAxisY)/90)*90;
			pSkillMenuPointDist = 1;
			pSkillMenuConfirm = true;
		}
		else
		{
			pSkillMenuPointDist = 0;
		}
	
		if ( pSkillMenuConfirm && ( _rawLen < 0.25 || !input_check("skillSwap") ) )
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
		if ( pElementSwap_animTimer < 0 && stateCurrent != State_Player_Attack )
		{
			if ( input_check_pressed("skillSwap" ) )
			{		
				window_mouse_set(window_get_width() / 2, window_get_height() / 2);
				pSkillMenuEnabled = true;
				pSkillMenuConfirm = false;
				pSkillMenuPointDist = 0;
			}
		}
		else { pElementSwap_animTimer--; }
	}
	
	return false;
}