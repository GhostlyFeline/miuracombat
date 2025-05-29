/// @description Insert description here
// You can write your code in this editor

if ( charShakeTimer >= 0 )
{
	var _shakePos = [0, 0];
	
	charShakeDist = lerp( 0, charShakeAmp, charShakeTimer / charShakeFrames );
	charShakeDir = random(360);
	
	_shakePos[0] += lengthdir_x(charShakeDist, charShakeDir);
	_shakePos[1] += lengthdir_y(charShakeDist, charShakeDir);
	
	charShakeTimer--;
	charOffset[0] = _shakePos[0];
	charOffset[1] = _shakePos[1];
}
else
{
	charOffset = [0, 0];
}


Character_Flash_Tick();


if ( global.hitstopActive ) { exit; }

if ( enemyPurifyMultiTimer >= 0 )
{
	if ( tick mod 3 == 0 )
	{
		with (FxHandler)
		{					
			var _partPos = [ random_range(other.bbox_left, other.bbox_right), random_range(other.bbox_top, other.bbox_bottom) ];
			part_particles_create(fxSysGlobalAbove, _partPos[0], _partPos[1], fxType[enumFxType.eFxEnemy_purifySparks], 1 );
		}
	}
	
	enemyPurifyMultiTimer--;
}
else { enemyPurifyMulti = 1; }


if ( enemyMagmaTimer >= 0 )
{
	var _self = id;
	with (FxHandler)
	{
		var _radius = min(_self.bbox_right - _self.bbox_left, _self.bbox_bottom - _self.bbox_top);
		
		var _len = random_range(0, _radius * 0.75);
		var _dir = random(360);
		var _pos = [_self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir)];				
		part_particles_create(fxSysGlobalBelow, _pos[0], _pos[1], fxType[enumFxType.pFxPlayer_skillMagmaChargeSpark00], 1 );
	}
	enemyMagmaTimer--;
}

if ( enemyStun >= enemyStunMax * enemyPurifyMulti ) { State_Change(State_Enemy_Stunned); }
else { enemyStun = max( enemyStun - ( enemyStunMax * enemyStunDegrade ), 0 ); }

State_Sys_Tick();

tick++;

if ( charHealth <= 0 )
{
	var _self = id;
	with (FxHandler)
	{		
		part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.eFxEnemy_explodeSpark00], 8 );
		
		part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.eFxEnemy_explodeFlash00], 1 );
		part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.eFxEnemy_explodeFlash01], 1 );
		
		part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.eFxEnemy_explodeSpark01], 8 );
	}
	
	Sound_Play(enumSoundFxList.enemyExplode);
	
	var _text = instance_create_layer(x, y, "TextAbove", ObjXpNumber );
	_text.damage = enemyDropXp;
	BattleHandler.xpTotal += enemyDropXp;
	for ( var i = 0; i < array_length(enemyDropItem); i++; ) { array_push(BattleHandler.itemDropArray, enemyDropItem[i]); }
	
	BattleHandler.battleFinalHitPos = [x, y];
	
	instance_destroy();
} 




