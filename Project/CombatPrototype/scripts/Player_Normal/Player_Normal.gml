// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function State_Player_Normal(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
			sprite_index = SprPlayerIdle;
			image_index  = 0;
			image_speed  = 1;
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			Player_Move_Tick();
			Player_Targeting_Tick();
			
			if ( input_check("dash") && pDashCooldownTimer < 0 && pEnergy >= pDashEnergyCost )
			{
				State_Change(State_Player_Dash);
				pEnergy -= pDashEnergyCost;
			}
			else
			if ( ( input_check("breaker") || input_check("spell1") ) && pBreakerCooldownTimer < 0 && pEnergy >= pBreakerEnergyCost )
			{
				State_Change(State_Player_Breaker);				
				pEnergy -= pBreakerEnergyCost;
				pElementSwap_animTimer = -1;
			}
			else
			if ( input_check("skill") && pSkillCooldownTimer < 0 && pEnergy >= pSkillEnergyCost )
			{
				var _canSkill = true;
				if ( pSkillCurrent == State_Player_Skill_SirenSong && pSirenSongStacks >= pSirenSongStackMax ) { _canSkill = false; }
				if ( pSkillCurrent == State_Player_Skill_MagmaAura && pMagmaAuraTimer > 0  ) { _canSkill = false; }
				if ( _canSkill )
				{
					State_Change(pSkillCurrent);
					pEnergy -= pSkillEnergyCost;
					pElementSwap_animTimer = -1;
				}
			}
			else
			if ( input_check("shoot") && pAttackCooldownTimer < 0 ) 
			{ 
				State_Change(State_Player_Attack);
				pElementSwap_animTimer = -1;
			}			
			
			if ( pAttackCooldownTimer  >= 0 ) { pAttackCooldownTimer--;  }	
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
			if ( pSkillCooldownTimer   >= 0 ) { pSkillCooldownTimer--;   }
			Player_Spell_Tick();
			Player_Energy_Tick();
			Player_Skills_Tick();
			
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			
			#endregion
			break;
	}
}