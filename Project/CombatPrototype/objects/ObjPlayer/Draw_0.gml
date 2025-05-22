/// @description Insert description here
// You can write your code in this editor

var _camera = view_camera[0];
var _guiLeft   = camera_get_view_x(_camera);
var _guiRight  = _guiLeft + camera_get_view_width(_camera);
var _guiTop    = camera_get_view_y(_camera);
var _guiBottom = _guiTop + camera_get_view_height(_camera);

var _guiCenterX = ( _guiLeft + _guiRight  ) * 0.5;
var _guiCenterY = ( _guiTop  + _guiBottom ) * 0.5;

var _guiWidth  = camera_get_view_width(_camera);
var _guiHeight = camera_get_view_height(_camera);

var _guiMouseX = window_mouse_get_x();
var _guiMouseY = window_mouse_get_y();




var _aimColor = c_white;
switch(playerElementCurrent)
{
	case enumProjPlayerElement.spirit: _aimColor = merge_color(c_blue  , c_white, 0.33); break;
	case enumProjPlayerElement.light: _aimColor = merge_color(c_yellow, c_white, 0.33); break;
	case enumProjPlayerElement.ice:   _aimColor = merge_color(c_aqua  , c_white, 0.33); break;
	case enumProjPlayerElement.fire:  _aimColor = merge_color(c_red   , c_white, 0.33); break;
}


draw_set_color(c_aqua);
draw_set_alpha(0.10);
draw_set_circle_precision(64);
draw_circle(pMoveBoundsCirclePos[0], pMoveBoundsCirclePos[1], pMoveBoundsCircleRadius + 160, 0);




#region Aiming Line

if ( instance_exists(ObjPlayerTarget.follow) ) 
{
	draw_set_alpha(image_alpha * 0.10);
	var _targetPos = [ObjPlayerTarget.x, ObjPlayerTarget.y];
	gpu_set_blendmode(bm_add);
	draw_line_width_color(x, y, _targetPos[0], _targetPos[1], 2, c_white, _aimColor );
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
}

#endregion


#region Spell Charge Circle

if ( stateCurrent == State_Player_Spell_Charge ) 
{
	var _circleColor = merge_color(_aimColor, c_white, 0.33);
	draw_set_alpha(1);
	
	gpu_set_blendmode(bm_add);
	
	//draw_sprite_ext(SprSpellCircle, 0, x, y, 1, 1, 0, _circleColor, 1);
	
	var _alpha  = 0.3;
	
	for ( var i = 0; i < 2; i++; )
	{
		var _growLerp = 1;
		if ( pSpellChargeTimer <= pSpellChargeFrames && pSpellCharges < 1 ) { _growLerp = pSpellChargeTimer / pSpellChargeFrames; }
		
		var _scl    = lerp(0.5, 1.0, i / 1) * _growLerp * 0.6;
		var _rotSpd = lerp(0.5, 1.0, i / 1);
		var _flip   = lerp( 1, -1, i mod 2 );
		draw_sprite_ext(SprSpellCircle, 0, x, y, _scl, _scl * _flip, pSpellChargeCircleRot * _rotSpd, _circleColor, _alpha);
		
		if ( pSpellCharges >= 1 )
		{
			_growLerp = 1;
			if ( pSpellChargeTimer <= pSpellChargeFrames && pSpellCharges == 1 ) { _growLerp = pSpellChargeTimer / pSpellChargeFrames; }
		
			_scl    = lerp(1.5, 2.0, i / 1) * _growLerp * 0.6;
			_rotSpd = lerp(1.5, 2.0, i / 1);
			_flip   = lerp( 1, -1, ( i + 1 ) mod 2 );
			draw_sprite_ext(SprSpellCircle, 0, x, y, _scl, _scl * _flip,  pSpellChargeCircleRot * _rotSpd, _circleColor, _alpha);
		}
	}
	
	gpu_set_blendmode(bm_normal);
	
	

}

#endregion


#region Player Character

draw_sprite_ext(SprPlayerCollider, 0, x, y, image_xscale, image_yscale, 0, c_white, image_alpha * 0.10);

var _charDrawX = x + charOffset[0];
var _charDrawY = y + charOffset[1];

shader_set(ShaderCharNormal);

var _shader = ShaderCharNormal;
var _colorFlashUniform = shader_get_uniform(_shader, "solidColor");

#region Draw the outline.

var myCol = c_aqua;
var r = colour_get_red(myCol) / 255;
var g = colour_get_green(myCol) / 255;
var b = colour_get_blue(myCol) / 255;
var a = 1;

shader_set_uniform_f(_colorFlashUniform, r, g, b, a);

gpu_set_blendmode(bm_add);
for ( var i = 0; i < 6; i++; )
{
	for ( var j = 3; j >= 1; j--; )
	{
		var _len = j * 4;
		var _dir = ( (360 / 6) * i ) + ( (360 / 12) * (j mod 2) );
		var _lX  = lengthdir_x(_len, _dir);
		var _lY  = lengthdir_y(_len, _dir);
		var _alpha = lerp(0.15, 0.00, j / 3);
	
		draw_sprite_ext(sprite_index, image_index, _charDrawX + _lX, _charDrawY + _lY, image_xscale * squishScl[0], image_yscale * squishScl[1], image_angle, image_blend, image_alpha * _alpha);
	}
}
gpu_set_blendmode(bm_normal);

#endregion
				
if ( charFlashPercent > 0 ) 
{       
	var myCol = charFlashColor;
	var r = colour_get_red(myCol) / 255;
	var g = colour_get_green(myCol) / 255;
	var b = colour_get_blue(myCol) / 255;
	var a = charFlashAlpha * charFlashPercent;

	shader_set_uniform_f(_colorFlashUniform, r, g, b, a);
}
else { shader_set_uniform_f(_colorFlashUniform, 1, 1, 1, 0); }

draw_set_color(c_white);
draw_set_alpha(1);
draw_sprite_ext(sprite_index, image_index, _charDrawX, _charDrawY, image_xscale * squishScl[0], image_yscale * squishScl[1], image_angle, image_blend, image_alpha);
shader_reset();

#endregion

#region Trident Aim Pointer

if ( instance_exists(ObjPlayerTarget.follow) ) 
{
	var _targetPos = [ObjPlayerTarget.x, ObjPlayerTarget.y];
	var _aimDir = point_direction(x, y, _targetPos[0], _targetPos[1]);
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(SprTargetPointer, 0, x, y, 1.2, 1.2, _aimDir, _aimColor, image_alpha * 0.66 );
	gpu_set_blendmode(bm_normal);
}

#endregion

#region Mouse Cursor

draw_set_color(c_aqua);
draw_set_alpha(1);
draw_circle(mouse_x, mouse_y, 8, 1);

#endregion

draw_set_color(c_white);
draw_set_alpha(1);

