// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Skills_Init()
{
	pSkillCooldownTimer  = 0;
	pSkillCooldownFrames = 60;
	pSkillEnergyCost = 30;
	
	pSirenSongTimer = 0;
	pSirenSongFrames = ( game_get_speed(gamespeed_fps) * 15 );	
	pSirenSongHealthRegen = ( charHealthMax / 20 ) / ( game_get_speed(gamespeed_fps) * 5 ); 
	pSirenSongStacks = 0;
}

function Player_Skills_Tick()
{	
	var _self = id;
	
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
}