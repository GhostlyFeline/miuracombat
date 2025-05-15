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
			image_index = 2;
			
			stateLength = -1;
						
			stateNext = State_Player_Breaker;
			stateNextLength = -1;
						
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			Player_Move_Tick();
			Player_Targeting_Tick();
			
			pMoveSpeedMulti = 0.33;
			
			if ( stateTick mod 5 == 0 ) { Character_Flash_Activate(5, 1, merge_color(c_aqua, c_white, 0.66), 0.25, true, 10); }
			
			if ( !input_check("breaker") )
			{
				State_Change(State_Player_Breaker);
				pEnergy -= pBreakerEnergyCost;
			}
			
			if ( pAttackCooldownTimer  >= 0 ) { pAttackCooldownTimer--;  }
			if ( pBreakerCooldownTimer >= 0 ) { pBreakerCooldownTimer--; }		
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
			if ( pSkillCooldownTimer   >= 0 ) { pSkillCooldownTimer--;   }
			Player_Skills_Tick();
						
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			pMoveSpeedMulti = 1;
			#endregion
			break;
	}
}