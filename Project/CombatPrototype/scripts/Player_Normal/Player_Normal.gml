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
			
			if ( input_check("ability") && pDashCooldownTimer < 0 && pEnergy >= pDashEnergyCost )
			{
				State_Change(State_Player_Dash);
				pEnergy -= pDashEnergyCost;
			}
			else
			if ( input_check("breaker") && pBreakerCooldownTimer < 0 )
			{
				State_Change(State_Player_Breaker);
				pElementSwap_animTimer = -1;
			}
			else
			if ( input_check("shoot") && pAttackCooldownTimer < 0 ) 
			{ 
				State_Change(State_Player_Attack);
				pElementSwap_animTimer = -1;
			}			
			
			if ( pAttackCooldownTimer  >= 0 ) { pAttackCooldownTimer--;  }
			if ( pBreakerCooldownTimer >= 0 ) { pBreakerCooldownTimer--; }		
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
			
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			
			#endregion
			break;
	}
}