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

if ( enemyStun >= enemyStunMax ) { State_Change(State_Enemy_Stunned); }
else { enemyStun = max( enemyStun - enemyStunDegrade, 0 ); }

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
	
	audio_play_sound(SndEnemyExplode, 10, 0);
	
	var _text = instance_create_layer(x, y, "TextAbove", ObjXpNumber );
	_text.damage = enemyDropXp;
	BattleHandler.xpTotal += enemyDropXp;
	for ( var i = 0; i < array_length(enemyDropItem); i++; ) { array_push(BattleHandler.itemDropArray, enemyDropItem[i]); }
	
	instance_destroy();
} 




