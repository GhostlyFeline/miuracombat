/// @description Insert description here
// You can write your code in this editor

Character_Flash_Tick();
Character_Shake_Tick();
Character_Kickback_Tick();

tick++;

var _self = id;
with (FxHandler)
{
	repeat (10)
	{
		var _len = _self.pMoveBoundsCircleRadius + random_range(100, 400);
		var _dir = random(360);
		var _lX  = lengthdir_x(_len, _dir);
		var _lY  = lengthdir_y(_len, _dir);
		
		part_particles_create(fxSysGlobalAbove, _self.pMoveBoundsCirclePos[0] + _lX, _self.pMoveBoundsCirclePos[1] + _lY, fxType[enumFxType.wFxProj_borderCloud00], 1 );
	}
		
	var _num = 6;
	var _initAngle = random(360);
	var _len = _self.pMoveBoundsCircleRadius + 160;
	for ( var i = 0; i < _num; i++; )
	{
		var _dir = _initAngle + ( ( 360 / _num ) * i );
		var _lX  = lengthdir_x(_len, _dir);
		var _lY  = lengthdir_y(_len, _dir);
			
		part_type_direction(fxType[enumFxType.wFxProj_borderLines], _dir + 90, _dir + 90, 0, 0);
		part_particles_create(fxSysGlobalAbove, _self.pMoveBoundsCirclePos[0] + _lX, _self.pMoveBoundsCirclePos[1] + _lY, fxType[enumFxType.wFxProj_borderLines], 1 );
	}
}

if ( global.hitstopActive ) { exit; }

var _menuOpen = false;
if ( Player_Element_Menu_Tick() ) { _menuOpen = true; }
if ( Player_Skill_Menu_Tick()   ) { _menuOpen = true; }

if ( !_menuOpen )
{
	State_Sys_Tick();
}

if ( charHealth <= 0 && stateCurrent != State_Player_Dying && stateCurrent != State_Player_Dead )
{
	State_Change( State_Player_Dying, 60 );
}