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
			var _stunVal = _self.stunDamage;
			if ( _self.element = enemyWeakness ) { _stunVal *= 3; }
		
			ds_list_add(enemyHitList, _self);
			charHealth -= _dmgVal;
			enemyStun += _stunVal;
	
			charShakeFrames = 10;
			charShakeTimer  = charShakeFrames;
			charShakeAmp = 16;
	
			var _len = random(64);
			var _dir = random(360);
			var _lX  = lengthdir_x(_len, _dir);
			var _lY  = lengthdir_y(_len, _dir);
			var _text = instance_create_layer(_self.x + _lX, _self.y + _lY, "TextAbove", ObjDamageNumber );
			_text.damage = _dmgVal;
	
			Sound_Play(enumSoundFxList.enemyHit);
			with (_self) { BulletHit(other, !penetrate); }
		}
	
	}
	else
	{
		with (_self) { BulletHit(other, !penetrate); }
	}
}