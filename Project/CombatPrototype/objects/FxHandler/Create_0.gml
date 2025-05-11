/// @description Insert description here
// You can write your code in this editor

global.hitstopTimer = 0;
global.hitstopDelay = 0;
global.hitstopActive = false;

fxSysGlobalAbove = part_system_create();
part_system_layer(fxSysGlobalAbove, "FxAbove");

fxSysGlobalBelow = part_system_create();
part_system_layer(fxSysGlobalBelow, "FxBelow");

enum enumFxType
{
	pFxPlayer_dashTrail00,
	pFxPlayer_dashBubbles00,
	pFxPlayer_dashShine00,
	
	pFxPlayer_grazeSpark00,
	
	pFxProj_spiritHitFlash00,
	pFxProj_spiritHitSpark00,
	
	pFxProj_lightHitFlash00,
	pFxProj_lightHitSpark00,
	
	pFxProj_fireHitFlash00,
	pFxProj_fireHitSpark00,
	
	pFxProj_iceHitFlash00,
	pFxProj_iceHitSpark00,
	
	pFxProj_breakerCritTri00,
	
	eFxProj_hitFlash00,
	eFxProj_hitSpark00,
	
	eFxEnemy_explodeFlash00,
	eFxEnemy_explodeFlash01,
	eFxEnemy_explodeSpark00,
	eFxEnemy_explodeSpark01,
	
	wFxProj_borderCloud00,
	wFxProj_borderLines,
	wFxWorld_bubbles00,
}

#region Player Dash

var _entry = enumFxType.pFxPlayer_dashTrail00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxDashTrail, 0, 0, 0);
part_type_size(fxType[_entry], 0.7, 0.7, -(0.7/40), 0 );
part_type_alpha2(fxType[_entry], 0.10, 0 );
part_type_color3(fxType[_entry], c_white, c_aqua, c_blue);
part_type_blend(fxType[_entry], true);
part_type_speed(fxType[_entry], 1, 1, 0, 0);
part_type_direction(fxType[_entry], 0, 0, 0, 0);
part_type_orientation(fxType[_entry], 0, 0, 0, 0, true);
part_type_life(fxType[_entry], 40, 40);

var _entry = enumFxType.pFxPlayer_dashBubbles00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxBubble, 0, 0, 0);
part_type_size(fxType[_entry], 0.25, 0.50, 0, 0 );
part_type_alpha2(fxType[_entry], 1.00, 0 );
part_type_color2(fxType[_entry], c_white, c_aqua);
part_type_blend(fxType[_entry], true);
part_type_speed(fxType[_entry], 1, 2, 0, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_life(fxType[_entry], 40, 40);

var _entry = enumFxType.pFxPlayer_dashShine00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprProjPlayer00, 0, 0, 0);
part_type_size(fxType[_entry], 0.125, 0.33, -(0.125 / 30), 0 );
part_type_alpha3(fxType[_entry], 1.00, 1.00, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_aqua);
part_type_blend(fxType[_entry], true);
part_type_speed(fxType[_entry], 0, 0, 0, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_life(fxType[_entry], 30, 30);

#endregion


var _entry = enumFxType.pFxPlayer_grazeSpark00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactSpark, 0, 0, 0);
part_type_scale(fxType[_entry], 1, 0.5);
part_type_size(fxType[_entry], 0.25, 0.5, 0.20, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_aqua);
part_type_speed(fxType[_entry], 12, 24, 0, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_orientation(fxType[_entry], 0, 0, 0, 0, true);
part_type_life(fxType[_entry], 10, 10);


#region Player Projectiles


#region Spirit

var _entry = enumFxType.pFxProj_spiritHitFlash00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactFlash, 0, 0, 0);
part_type_size(fxType[_entry], 0, 0, 0.15, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_blue);
part_type_blend(fxType[_entry], true);
part_type_life(fxType[_entry], 10, 10);

var _entry = enumFxType.pFxProj_spiritHitSpark00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactSpark, 0, 0, 0);
part_type_size(fxType[_entry], 0.1, 0.3, 0.10, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_blue);
part_type_blend(fxType[_entry], true);
part_type_speed(fxType[_entry], 8, 12, 0, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_orientation(fxType[_entry], 0, 0, 0, 0, true);
part_type_life(fxType[_entry], 10, 10);

#endregion

#region Light

var _entry = enumFxType.pFxProj_lightHitFlash00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactFlash, 0, 0, 0);
part_type_size(fxType[_entry], 0, 0, 0.10, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, merge_color(c_yellow, c_white, 0.5), merge_color(c_orange, c_white, 0.5) );
part_type_blend(fxType[_entry], true);
part_type_life(fxType[_entry], 15, 15);

var _entry = enumFxType.pFxProj_lightHitSpark00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactSpark, 0, 0, 0);
part_type_scale(fxType[_entry], 2, 0.5);
part_type_size(fxType[_entry], 0.2, 0.6, 0.10, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_yellow);
part_type_blend(fxType[_entry], true);
part_type_speed(fxType[_entry], 12, 16, 0, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_orientation(fxType[_entry], 0, 0, 0, 0, true);
part_type_life(fxType[_entry], 10, 10);

#endregion

#region Fire

var _entry = enumFxType.pFxProj_fireHitFlash00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactFlash, 0, 0, 0);
part_type_size(fxType[_entry], 0, 0, 0.40, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_orange, c_red );
part_type_blend(fxType[_entry], true);
part_type_life(fxType[_entry], 10, 10);

var _entry = enumFxType.pFxProj_fireHitSpark00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactSpark, 0, 0, 0);
//part_type_scale(fxType[_entry], 2, 0.5);
part_type_size(fxType[_entry], 0.2, 0.6, 0.10, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_yellow, c_red);
part_type_blend(fxType[_entry], true);
part_type_speed(fxType[_entry], 12, 16, 0, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_orientation(fxType[_entry], 0, 0, 0, 0, true);
part_type_life(fxType[_entry], 10, 10);

#endregion

#region Ice

var _entry = enumFxType.pFxProj_iceHitFlash00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactFlash, 0, 0, 0);
part_type_size(fxType[_entry], 0, 0, 0.20, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_aqua );
part_type_blend(fxType[_entry], true);
part_type_life(fxType[_entry], 15, 15);

var _entry = enumFxType.pFxProj_iceHitSpark00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactSpark, 0, 0, 0);
part_type_scale(fxType[_entry], 2, 0.5);
part_type_size(fxType[_entry], 0.2, 0.6, 0.10, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_aqua);
part_type_blend(fxType[_entry], true);
part_type_speed(fxType[_entry], 12, 16, 0, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_orientation(fxType[_entry], 0, 0, 0, 0, true);
part_type_life(fxType[_entry], 10, 10);

#endregion

var _entry = enumFxType.pFxProj_breakerCritTri00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxShineTri, 0, 0, 0);
part_type_scale(fxType[_entry], 1, 0.25);
part_type_size(fxType[_entry], 0.5, 1.0, -0.02, 0 );
part_type_alpha2(fxType[_entry], 1, 0 );
part_type_color1(fxType[_entry], c_white);
part_type_blend(fxType[_entry], true);
part_type_orientation(fxType[_entry], 0, 360, 0, 0, true);
part_type_life(fxType[_entry], 15, 15);

#endregion

#region Enemy Explode

var _entry = enumFxType.eFxEnemy_explodeFlash00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactFlash, 0, 0, 0);
part_type_size(fxType[_entry], 0.0, 0.0, 0.25, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color2(fxType[_entry], c_black, c_purple);
part_type_life(fxType[_entry], 15, 15);

var _entry = enumFxType.eFxEnemy_explodeFlash01;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactFlash, 0, 0, 0);
part_type_size(fxType[_entry], 1.0, 1.0, 0.05, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_purple);
part_type_life(fxType[_entry], 15, 15);

var _entry = enumFxType.eFxEnemy_explodeSpark00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactSpark, 0, 0, 0);
part_type_scale(fxType[_entry], 2, 0.5);
part_type_size(fxType[_entry], 0.25, 1.0, 0.20, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_purple);
part_type_speed(fxType[_entry], 24, 32, 0, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_orientation(fxType[_entry], 0, 0, 0, 0, true);
part_type_life(fxType[_entry], 10, 10);

var _entry = enumFxType.eFxEnemy_explodeSpark01;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprProjEnemy, 0, 0, 0);
part_type_size(fxType[_entry], 1.5, 2.5, -0.05, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color2(fxType[_entry], c_black, c_purple);
part_type_speed(fxType[_entry], 8, 12, -0.25, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_life(fxType[_entry], 40, 60);

#endregion

#region Enemy Projectiles

var _entry = enumFxType.eFxProj_hitFlash00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactFlash, 0, 0, 0);
part_type_size(fxType[_entry], 0, 0, 0.30, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_red);
part_type_life(fxType[_entry], 10, 10);

var _entry = enumFxType.eFxProj_hitSpark00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjImpactSpark, 0, 0, 0);
part_type_scale(fxType[_entry], 3, 0.5);
part_type_size(fxType[_entry], 0.5, 1.0, 0.20, 0 );
part_type_alpha3(fxType[_entry], 1, 1, 0 );
part_type_color3(fxType[_entry], c_white, c_white, c_red);
part_type_speed(fxType[_entry], 32, 64, 0, 0);
part_type_direction(fxType[_entry], 0, 360, 0, 0);
part_type_orientation(fxType[_entry], 0, 0, 0, 0, true);
part_type_life(fxType[_entry], 10, 10);

#endregion

#region World Arena Effects

var _entry = enumFxType.wFxProj_borderCloud00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxProjCloud, 0, 0, 0);
part_type_size(fxType[_entry], 0.5, 1, 0.05, 0 );
part_type_alpha2(fxType[_entry], 0.10, 0 );
part_type_color_mix(fxType[_entry], c_black, c_fuchsia);
part_type_orientation(fxType[_entry], 0, 360, 0, 0, false);
part_type_life(fxType[_entry], 40, 60);


var _entry = enumFxType.wFxProj_borderLines;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxDashTrail, 0, 0, 0);
part_type_size(fxType[_entry], 1, 1, 0.05, 0 );
part_type_alpha3(fxType[_entry], 0.25, 0.25, 0 );
part_type_color3(fxType[_entry], c_aqua, c_fuchsia, c_lime);
part_type_blend(fxType[_entry], true);
part_type_speed(fxType[_entry], 1, 2, 0, 0);
part_type_direction(fxType[_entry], 0, 0, 0, 0);
part_type_orientation(fxType[_entry], 0, 0, 0, 0, true);
part_type_life(fxType[_entry], 40, 50);


var _entry = enumFxType.wFxWorld_bubbles00;
fxType[_entry] = part_type_create();
part_type_sprite(fxType[_entry], SprFxBubble, 0, 0, 0);
part_type_size(fxType[_entry], 0.25, 0.75, 0, 0 );
part_type_alpha3(fxType[_entry], 0, 0.3, 0 );
part_type_color2(fxType[_entry], c_white, c_aqua);
part_type_blend(fxType[_entry], true);
part_type_speed(fxType[_entry], 0, 1, 0.05, 0);
part_type_direction(fxType[_entry], 80, 100, 0, 0);
part_type_life(fxType[_entry], 120, 120);

#endregion