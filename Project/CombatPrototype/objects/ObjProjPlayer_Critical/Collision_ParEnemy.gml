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
		if ( stateCurrent == State_Enemy_Stunned )
		{
			_damageVal *= _self.critMulti;
			var _text = instance_create_layer(x, y, "TextAbove", ObjStunText );
			_text.textString = "BREAK!";
			stateTick = stateLength;
			tick = 0;
			Sound_Play(enumSoundFxList.enemyBreak);
			
			global.hitstopTimer = 10;
			global.hitstopDelay = 2;
			
			with (FxHandler)
			{	
				part_particles_create(fxSysGlobalBelow, other.x, other.y, fxType[enumFxType.pFxProj_breakerCritTri00], 8 );
			}
			
			ObjPlayer.pLimit = min(ObjPlayer.pLimit + 20, ObjPlayer.pLimitMax);
		}
		
		ds_list_add(enemyHitList, _self);
		charHealth -= _damageVal;
		enemyStun += _self.stunDamage * enemyStunMulti;
	
		charShakeFrames = 10;
		charShakeTimer  = charShakeFrames;
		charShakeAmp = 16;
	
		var _len = random(32);
		var _dir = random(360);
		var _lX  = lengthdir_x(_len, _dir);
		var _lY  = lengthdir_y(_len, _dir);
		var _text = instance_create_layer(x, y + 48, "TextAbove", ObjDamageNumber );
		_text.damage = _damageVal;
		_text.fadeFrames = 60;
	
		Sound_Play(enumSoundFxList.enemyHit);
		with (_self) { BulletHit(other, !penetrate); }
	}
}