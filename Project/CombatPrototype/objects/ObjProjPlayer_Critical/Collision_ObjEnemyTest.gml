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
		var _damageVal = _self.damage;
		if ( enemyStunTimer >= 0 )
		{
			_damageVal *= _self.critMulti;
			var _text = instance_create_layer(x, y, "TextAbove", ObjStunText );
			_text.textString = "BREAK!";
			enemyStunTimer = -1;
			tick = 0;
			audio_play_sound(SndEnemyBreak, 100, 0);
			
			global.hitstopTimer = 10;
			global.hitstopDelay = 2;
			
			with (FxHandler)
			{	
				part_particles_create(fxSysGlobalBelow, other.x, other.y, fxType[enumFxType.pFxProj_breakerCritTri00], 8 );
			}
		}
		
		ds_list_add(enemyHitList, _self);
		charHealth -= _damageVal;
		enemyStun += _self.stunDamage;
	
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
	
		audio_play_sound(SndEnemyHit, 10, 0);
		with (_self) { BulletHit(other, !penetrate); }
	}
}