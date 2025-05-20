/// @description Insert description here
// You can write your code in this editor

var _self = id;

with (other)
{
	var _checkList = false;
	
	for ( var i = 0; i < ds_list_size(enemyHitList); i++; )
	{
		var _item = enemyHitList[| i];
		if ( !is_undefined(_item) )
		{
			if ( _item == _self ) { _checkList = true; }
		}
	}
	
	if (!_checkList)
	{
		var _damageVal = floor(_self.damage * _self.magmaAuraMulti);
				
		//ds_list_add(enemyHitList, _self);
		
		enemyStunMulti = 1.5;
		enemyStunMultiTimer = 60;
	
		charShakeFrames = 10;
		charShakeTimer  = charShakeFrames;
		charShakeAmp = 16;
	
		//Sound_Play(enumSoundFxList.enemyHit);
		
		with (FxHandler)
		{
			part_type_direction(fxType[enumFxType.pFxProj_lightHitFlash00], 0, 360, 0, 0);
			repeat(1)
			{
				var _len = random(64);
				var _dir = random(360);
				var _lX  = lengthdir_x(_len, _dir);
				var _lY  = lengthdir_y(_len, _dir);				
				part_particles_create(fxSysGlobalAbove, other.x + _lX, other.y + _lY, fxType[enumFxType.pFxProj_lightHitFlash00], 1 );
			}
		}
		
	}
}