// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Spell_Charge(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
						
			sprite_index = SprPlayerAttack;
			image_speed = 0;
			image_index = 0;
			
			stateLength = -1;
						
			stateNext = State_Player_Breaker;
			stateNextLength = -1;
			
			pSpellCharges = 0;
			pSpellChargeTimer = 0;						
			pSpellChargeMax = 2;
			for ( var i = 0; i <= 2; i++; )
			{
				if ( pEnergy >= pSpellChargeCosts[i] ) { pSpellChargeMax = i; }
			}			
			
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			Player_Move_Tick();
			Player_Targeting_Tick();
			
			if ( stateTick == 10 ) { Sound_Play(enumSoundFxList.playerSpellCharge); }
			
			if ( stateTick <= 10 ) { image_index = lerp(0, 2, stateTick / 10); }
			
			pMoveSpeedMulti = 0.33;
			
			
			if ( pSpellChargeMax > 0 )
			{			
				pSpellChargeCircleRot += lerp( 1.0, 1.5, pSpellCharges / pSpellChargeMax );
								
				if ( pSpellCharges < pSpellChargeMax )
				{
					
					if ( pSpellChargeTimer < pSpellChargeFrames )
					{
						pSpellChargeTimer++;
					
						if ( pSpellChargeTimer >= pSpellChargeFrames )
						{
							pSpellCharges++;
							pSpellChargeTimer = 0;
							if ( pSpellCharges == pSpellChargeMax )
							{
								audio_stop_sound(SndPlayerSpellCharge);
								Sound_Play(enumSoundFxList.playerSpellChargeFinish);
							}
						}
					}
					
				}
				
			}
			
			
			if ( pSpellCharges >= 1 )
			{				
				var _colorA = c_gray;
				switch(playerElementCurrent)
				{
					case enumProjPlayerElement.spirit: _colorA = merge_color(c_blue  , c_white, 0.33); break;
					case enumProjPlayerElement.light:  _colorA = merge_color(c_yellow, c_white, 0.33); break;
					case enumProjPlayerElement.ice:    _colorA = merge_color(c_aqua  , c_white, 0.33); break;
					case enumProjPlayerElement.fire:   _colorA = merge_color(c_red   , c_white, 0.33); break;
				}
				
				var _colorB = c_gray;
				switch(playerElementCurrent)
				{
					case enumProjPlayerElement.spirit: _colorB = merge_color(c_blue  , c_black, 0.33); break;
					case enumProjPlayerElement.light:  _colorB = merge_color(c_yellow, c_black, 0.33); break;
					case enumProjPlayerElement.ice:    _colorB = merge_color(c_aqua  , c_black, 0.33); break;
					case enumProjPlayerElement.fire:   _colorB = merge_color(c_red   , c_black, 0.33); break;
				}
				
				with (FxHandler)
				{
					part_type_color3(fxType[enumFxType.pFxPlayer_spellChargeFlash00], c_white, _colorA, _colorB);
					repeat (1)
					{
						var _len = random_range(0, 96);
						var _dir = random(360);
						var _lX  = lengthdir_x(_len, _dir);
						var _lY  = lengthdir_y(_len, _dir);
						
						part_particles_create(fxSysGlobalBelow, _self.x + _lX, _self.y + _lY, fxType[enumFxType.pFxPlayer_spellChargeFlash00], 1 );
					}
				}
				
				if ( pSpellCharges >= 2 )
				{
					
					with (FxHandler)
					{
						part_type_color3(fxType[enumFxType.pFxPlayer_spellChargeFlash01], c_white, c_white, _colorA);
						repeat (2)
						{
							var _len = 0;
							var _dir = random(360);
							var _lX  = lengthdir_x(_len, _dir);
							var _lY  = lengthdir_y(_len, _dir);
		
							part_particles_create(fxSysGlobalBelow, _self.x + _lX, _self.y + _lY, fxType[enumFxType.pFxPlayer_spellChargeFlash01], 1 );
						}
					}
					
				}
				
			}
			
			if ( stateTick mod 5 == 0 ) { Character_Flash_Activate(5, 1, merge_color(c_aqua, c_white, 0.66), 0.25, true, 10); }
			charShakeFrames = 5;
			charShakeTimer  = charShakeFrames;
			charShakeAmp = pSpellCharges;
			
			
			if ( !input_check("breaker") || pSpellChargeMax <= 0 )
			{
				State_Change(State_Player_Breaker);
				pEnergy -= pSpellChargeCosts[pSpellCharges];
			}
			
			if ( pAttackCooldownTimer  >= 0 ) { pAttackCooldownTimer--;  }
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
			if ( pSkillCooldownTimer   >= 0 ) { pSkillCooldownTimer--;   }
			Player_Spell_Tick();
			Player_Skills_Tick();
						
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			pMoveSpeedMulti = 1;
			audio_stop_sound(SndPlayerSpellCharge);
			#endregion
			break;
	}
}