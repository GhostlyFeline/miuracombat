/// @description Insert description here
// You can write your code in this editor

if ( global.hitstopActive ) { exit; }

var _self = id;

image_xscale = projScale; //15
image_yscale = projScale; //6


//if ( tick mod 3 == 0 )
{
	with (FxHandler)
	{	
		var _radius = ( _self.bbox_right - _self.bbox_left ) * 0.5;
		
		var _len = random(_radius);
		var _dir = random(360);
		
		var _partPos = [ _self.x + lengthdir_x(_len, _dir), _self.y + lengthdir_y(_len, _dir) ];
		
		part_particles_create(fxSysGlobalAbove, _partPos[0], _partPos[1], fxType[enumFxType.eFxEnemy_purifySparks], 1 );
	}
}

tick++;
if ( tick <= 15 ) { image_alpha = lerp(0, 0.33, tick / 15); }
if ( tick >= lifetime - 30 ) { image_alpha = lerp(0.33, 0, ( tick - (lifetime - 30) ) / 30); }
if ( tick > lifetime ) { instance_destroy(); }