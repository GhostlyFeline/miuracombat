// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Skills_Init()
{
	pSkillCooldownTimer  = 0;
	pSkillCooldownFrames = 60;
	pSkillEnergyCost = 20;
	pSkillCurrent = State_Player_Skill_SirenSong;
	
	pSirenSongEnergyCost = 30;
	pSirenSongTimer = 0;
	pSirenSongFrames = ( game_get_speed(gamespeed_fps) * 15 );	
	pSirenSongHealthRegen = ( charHealthMax / 20 ) / ( game_get_speed(gamespeed_fps) * 5 ); 
	pSirenSongStacks = 0;
	
	pIceShieldEnergyCost  = 20;
	pIceShieldEnergyDrain = 0.05;	
	pIceShieldHasParried = false;
	pIceShieldParryFrames = 30;
	pIceShieldParryRecoverPercent = 0.75;
	
	pMagmaAuraEnergyCost = 30;
	pMagmaAuraTimer = 0;
	pMagmaAuraFrames = ( game_get_speed(gamespeed_fps) * 3 );
	pMagmaAuraStacks = 0;
	
	pPurifyEnergyCost = 30;
	pPurifyTimer = 0;
	pPurifyFrames = ( game_get_speed(gamespeed_fps) * 3 );
	pPurifyStacks = 0;
}

function Player_Skills_Tick()
{	
	var _self = id;
	
	switch ( pSkillCurrent )
	{
		case State_Player_Skill_SirenSong:
			pSkillEnergyCost = pSirenSongEnergyCost;
			pSkillCooldownFrames = 60;
			break;
			
		case State_Player_Skill_IceShield:
			pSkillEnergyCost = pIceShieldEnergyCost;
			pSkillCooldownFrames = 60;
			break;
			
		case State_Player_Skill_MagmaAura:
			pSkillEnergyCost = pMagmaAuraEnergyCost;
			pSkillCooldownFrames = 60;
			break;
			
		case State_Player_Skill_Purify:
			pSkillEnergyCost = pPurifyEnergyCost;
			pSkillCooldownFrames = 60;
			break;
	}
	
	#region Siren Song
	if ( pSirenSongTimer >= 0 && pSirenSongStacks > 0 )
	{
		charHealth = min( charHealth + ( pSirenSongHealthRegen * pSirenSongStacks ), charHealthMax );
		if ( tick mod round( 15 / _self.pSirenSongStacks) == 0 )
		{
			with (FxHandler)
			{	
				var _pos = [random_range(_self.bbox_left, _self.bbox_right), random_range(_self.bbox_top, _self.bbox_bottom)];				
				part_particles_create(fxSysGlobalAbove, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_regenCross00], 1 );
			}
		}
		
		pSirenSongTimer--;
	}
	else
	{
		pSirenSongStacks = 0;
	}
	#endregion
	
	#region Magma Aura
	if ( pMagmaAuraTimer >= 0 )
	{		
		with (FxHandler)
		{					
			repeat(1)
			{
				var _len = random_range(0, 64);
				var _dir = random(360);
				var _pos = [_self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir)];				
				part_particles_create(fxSysGlobalBelow, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_skillMagmaChargeSpark00], 1 );
			}
			
			repeat(1)
			{
				var _len = random_range(256, 512);
				var _dir = random(360);
				var _pos = [_self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir)];				
				part_particles_create(fxSysGlobalBelow, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_skillMagmaChargeSpark00], 1 );
			}
		}
		
		with ( ObjProjPlayer )
		{
			var _dist = point_distance(_self.x, _self.y, x, y);
			if ( _dist <= 512 ) { magmaAuraMulti = lerp(2.0, 1.2, _dist / 512); }
			else { magmaAuraMulti = 1.0; }
		}
		
		with ( ObjProjPlayer_Critical )
		{
			var _dist = point_distance(_self.x, _self.y, x, y);
			if ( _dist <= 512 ) { magmaAuraMulti = lerp(1.5, 1.2, _dist / 512); }
			else { magmaAuraMulti = 1.0; }
		}
		
		if ( tick mod 15 == 0 )
		{
			var _list = ds_list_create();
			collision_circle_list(x, y, 512, ParEnemy, 0, 1, _list, 0 );
			
			var _listLen = ds_list_size(_list);
			for ( var i = 0; i < _listLen; i++; )
			{
				var _item = _list[| i];
				_item.charHealth -= 3;
				var _len = random(32);
				var _dir = random(360);
				var _lX  = lengthdir_x(_len, _dir);
				var _lY  = lengthdir_y(_len, _dir);
				var _text = instance_create_layer(_item.x + _lX, _item.y + _lY, "TextAbove", ObjDamageNumber );
				_text.damage = 3;
				_text.fadeFrames = 60;
			}
			
			ds_list_destroy(_list);
		}
		
		pMagmaAuraTimer--;
	}
	else
	{
		with ( ObjProjPlayer          ) { magmaAuraMulti = 1; }
		with ( ObjProjPlayer_Critical ) { magmaAuraMulti = 1; }
	}
	#endregion
}