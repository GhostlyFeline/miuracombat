/// @description Insert description here
// You can write your code in this editor

var _self = id;

with (other)
{
	if ( !invincible )
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
			var _dmgVal = floor(_self.damage );
			if ( enemyMagmaTimer > 0 ) { _dmgVal = floor(_self.damage * _self.magmaAuraMulti ); }
			if ( stateCurrent == State_Enemy_Stunned )
			{
				_dmgVal *= _self.critMulti;
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
			charHealth -= _dmgVal;
			enemyStun += _self.stunDamage;
	
			charShakeFrames = 10;
			charShakeTimer  = charShakeFrames;
			charShakeAmp = 16;
			
			var _text = instance_create_layer(x, y + 48, "TextAbove", ObjDamageNumber );
			_text.damage = _dmgVal;
			_text.fadeFrames = 60;
	
			Sound_Play(enumSoundFxList.enemyHit);
			with (_self) { BulletHit(other, !penetrate); }
		}
	
	}
	else
	{
		with (_self) { BulletHit(other, !penetrate); }
	}
}