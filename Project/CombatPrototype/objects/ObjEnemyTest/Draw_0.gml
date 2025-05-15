/// @description Insert description here
// You can write your code in this editor

event_inherited();

draw_set_color(c_white);
draw_set_alpha(1);
draw_healthbar(x - 80, y + 64, x + 80, y + 80, (charHealth / charHealthMax) * 100, merge_color(c_black, c_dkgray, 0.5), c_red, c_red, 0, 1, 1);


var _stunBarAmt = enemyStun / enemyStunMax;
if ( stateCurrent == State_Enemy_Stunned ) { _stunBarAmt = 1 - ( stateTick / stateLength ); }
draw_healthbar(x - 60, y + 80, x + 60, y + 90, _stunBarAmt * 100, merge_color(c_black, c_dkgray, 0.5), c_aqua, c_aqua, 0, 1, 1);