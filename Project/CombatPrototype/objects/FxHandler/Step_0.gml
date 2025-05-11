/// @description Insert description here
// You can write your code in this editor
if ( global.hitstopDelay > 0 ) { global.hitstopDelay--; }
if ( global.hitstopTimer > 0 && global.hitstopDelay <= 0 )
{
	global.hitstopActive = true;
	global.hitstopTimer--;
}
else { global.hitstopActive = false; }


repeat(2)
{
	var _pos = [random_range(-1024, room_width + 1024), random_range(-1024, room_height + 1024) ];
	part_particles_create(fxSysGlobalBelow, _pos[0], _pos[1], fxType[enumFxType.wFxWorld_bubbles00], 1 );
}