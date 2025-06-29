/// @description Insert description here
// You can write your code in this editor

projScale = 40;
image_xscale = projScale;
image_yscale = projScale;
image_alpha = 0.33;

projSpd = 0;
projDir = 0;

tick = 0;

lifetime = 180;


element = enumProjPlayerElement.light;
penetrate = true;
damage = 0;
stunDamage = 0;
critMulti = 1;

magmaAuraMulti = 1;

function BulletHit(_colInst = noone, _destroy = true)
{
	var _self = id;
	with (FxHandler)
	{
		switch(_self.element)
		{
			default:
			case enumProjPlayerElement.spirit:
				if ( _colInst != noone )
				{
					var _dir = point_direction(_colInst.x, _colInst.y, _self.x, _self.y);
					part_type_direction(fxType[enumFxType.pFxProj_spiritHitSpark00], _dir - 90, _dir + 90, 0, 0);
				}
				else { part_type_direction(fxType[enumFxType.pFxProj_spiritHitSpark00], 0, 360, 0, 0); }		
				part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.pFxProj_spiritHitSpark00], 8 );
				part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.pFxProj_spiritHitFlash00], 1 );
				break;
				
			case enumProjPlayerElement.light:	
				part_type_direction(fxType[enumFxType.pFxProj_lightHitSpark00], _self.projDir - 30, _self.projDir + 30, 0, 0);
				repeat(5)
				{
					var _len = random(32);
					var _dir = random(360);
					var _lX  = lengthdir_x(_len, _dir);
					var _lY  = lengthdir_y(_len, _dir);				
					part_particles_create(fxSysGlobalAbove, _self.x + _lX, _self.y + _lY, fxType[enumFxType.pFxProj_lightHitSpark00], 1 );
				}
				
				part_type_speed(fxType[enumFxType.pFxProj_lightHitFlash00], 12, 18, -1, 0);
				part_type_direction(fxType[enumFxType.pFxProj_lightHitFlash00], _self.projDir - 5, _self.projDir + 5, 0, 0);
				repeat(3)
				{
					var _len = random(64);
					var _dir = random(360);
					var _lX  = lengthdir_x(_len, _dir);
					var _lY  = lengthdir_y(_len, _dir);				
					part_particles_create(fxSysGlobalAbove, _self.x + _lX, _self.y + _lY, fxType[enumFxType.pFxProj_lightHitFlash00], 1 );
				}
				
				break;
				
			case enumProjPlayerElement.fire:
				part_type_direction(fxType[enumFxType.pFxProj_fireHitSpark00], 0, 360, 0, 0);		
				part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.pFxProj_fireHitSpark00], 5 );
				part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.pFxProj_fireHitFlash00], 1 );
				break;
				
			case enumProjPlayerElement.ice:
				part_type_direction(fxType[enumFxType.pFxProj_iceHitSpark00], 0, 360, 0, 0);		
				part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.pFxProj_iceHitSpark00], 5 );
				part_particles_create(fxSysGlobalAbove, _self.x, _self.y, fxType[enumFxType.pFxProj_iceHitFlash00], 1 );
				break;
		}
	}
	if ( _destroy ) { instance_destroy(); }
}
