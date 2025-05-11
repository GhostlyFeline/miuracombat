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


if ( enemyStunTimer >= 0 )
{
	if ( enemyStunTimer mod 15 == 0 ) { Character_Flash_Activate(15, 1, merge_color(c_yellow, c_white, 0.5), 0.75, true, 100); }
	enemyStunTimer--;
	enemyStun = 0;
}
else
{
	if ( enemyStun >= enemyStunMax )
	{
		audio_play_sound(SndEnemyStun, 100, 0);
		enemyStun = 0;
		enemyStunTimer = enemyStunFrames;
		var _text = instance_create_layer(x, y, "TextAbove", ObjStunText );
		_text.master = id;
	}
}


if ( enemyStunTimer < 0 )
{	
	var _len = 2;
	var _dir = point_direction(x, y, ObjPlayer.x, ObjPlayer.y);

	x += lengthdir_x(_len, _dir);
	y += lengthdir_y(_len, _dir);


	#region Rotate the character based on their current direction.

	var _xSpd = lengthdir_x(_len, _dir);
	var _ySpd = lengthdir_y(_len, _dir);

	var _mDist = point_distance (0, 0, _xSpd, _ySpd);
	var _mDir  = point_direction(0, 0, _xSpd, _ySpd);

	if ( _mDist != 0 )
	{
		image_angle = _mDir;
		if ( _xSpd > 0 )
		{
			image_xscale = -1;
			image_yscale = 1;
		}
		else if ( _xSpd < 0 )
		{
			image_xscale = -1;
			image_yscale = -1;
		}
	}

	#endregion


	if ( tick > 60 )
	{
		if ( ( tick + ( enemyId * 30 ) ) mod 120 == 0 )
		{
			var _bullet = instance_create_layer(x, y, layer, ObjProjEnemy);
			_bullet.projSpd = 8;
			_bullet.projDir = point_direction(_bullet.x, _bullet.y, ObjPlayer.x, ObjPlayer.y);
			audio_play_sound(SndEnemyShot, 10, 0);
		}
	}
}

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
	_text.damage = enemyGiveXp;
	BattleHandler.xpTotal += enemyGiveXp;
	
	instance_destroy();
} 