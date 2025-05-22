/// @description Insert description here
// You can write your code in this editor



#region Spell Charge Circle

if ( stateCurrent == State_Enemy_Caster_SpellA ) 
{
	gpu_set_blendmode(bm_add);
	for ( var i = 0; i < 6; i++; )
	{
		var _scl    = lerp(0.5, 2.0, i / 5);
		var _alpha  = lerp(1.0, 0.0, i / 5);
		var _rotSpd = lerp(5.0, 0.5, i / 5);
		var _flip   = lerp( 1, -1, i mod 2 )
		draw_sprite_ext(SprSpellCircle, 0, x, y, _scl, _scl * _flip, stateTick * _rotSpd * _flip, c_white, _alpha);
	}
	gpu_set_blendmode(bm_normal);
}

#endregion



event_inherited();

draw_set_color(c_white);
draw_set_alpha(1);
draw_healthbar(x - 80, y + 64, x + 80, y + 80, (charHealth / charHealthMax) * 100, merge_color(c_black, c_dkgray, 0.5), c_red, c_red, 0, 1, 1);


var _stunBarAmt = enemyStun / enemyStunMax;
if ( stateCurrent == State_Enemy_Stunned ) { _stunBarAmt = 1 - ( stateTick / stateLength ); }
draw_healthbar(x - 60, y + 80, x + 60, y + 90, _stunBarAmt * 100, merge_color(c_black, c_dkgray, 0.5), c_aqua, c_aqua, 0, 1, 1);