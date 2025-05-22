// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Skill_MagmaAura(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
						
			//Sound_Play(enumSoundFxList.playerMagmaAura);
			
			with ( ObjProjPlayer_Magma ) { tick = lifetime - 15; }
			
			stateLength = 20;
			
			pSkillCooldownTimer = pSkillCooldownFrames;			
			
			stateNext = State_Player_Normal;
			stateNextLength = -1;
						
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			Player_Move_Tick();
			Player_Targeting_Tick();
			
			pMoveSpeedMulti = 0.25;
			
			#region Play the attack animation based on the length of the attack.
			sprite_index = SprPlayerAttack;
			image_index  = ( stateTick / stateLength ) * sprite_get_number(sprite_index);
			image_speed  = 0;
			#endregion
			
			#region Shoot the bullet!
		
			if ( stateTick == round(stateLength * 0.5) )
			{
				Sound_Play(enumSoundFxList.playerMagmaAura);			
				var _bullet = instance_create_layer(x, y, layer, ObjProjPlayer_Magma);
			}
		
			#endregion
			
			if ( pAttackCooldownTimer  >= 0 ) { pAttackCooldownTimer--;  }
			if ( pBreakerCooldownTimer >= 0 ) { pBreakerCooldownTimer--; }		
			if ( pDashCooldownTimer    >= 0 ) { pDashCooldownTimer--;    }
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