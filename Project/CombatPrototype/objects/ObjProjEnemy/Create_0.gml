/// @description Insert description here
// You can write your code in this editor

image_xscale = 1.2;
image_yscale = 1.2;

projSpd = 0;
projDir = 0;

function BulletHit(_colInst = noone, _destroy = true)
{	
	var _self = id;
	with (FxHandler)
	{
		if ( _colInst != noone )
		{
			var _dir = point_direction(_colInst.x, _colInst.y, _self.x, _self.y);
			part_type_direction(fxType[enumFxType.eFxProj_hitSpark00], _dir - 60, _dir + 60, 0, 0);
		}
		else { part_type_direction(fxType[enumFxType.eFxProj_hitSpark00], 0, 360, 0, 0); }
		
		part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.eFxProj_hitSpark00], 8 );
		part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.eFxProj_hitFlash00], 1 );
	}
	if ( _destroy ) { instance_destroy(); }
}

damage = 5;