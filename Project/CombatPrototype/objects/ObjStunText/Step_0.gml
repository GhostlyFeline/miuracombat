/// @description Insert description here
// You can write your code in this editor

var _percent = fadeTimer / fadeFrames;
if ( fadeTimer <= 5 ) { textScl = lerp(0, 3.0, fadeTimer / 5); }
else if ( fadeTimer <= 10) { textScl = lerp(3.0, 1.0, ( fadeTimer - 5 ) / 5); }


fadeTimer++;
if ( fadeTimer >= fadeFrames - 20 )
{
	var _percent = ( fadeTimer - ( fadeFrames - 20 ) ) / 20;
	fadeAlpha = lerp(1, 0, _percent);
	if ( fadeTimer >= fadeFrames) { instance_destroy(); }
}

if ( master != -1 )
{
	if ( instance_exists(master) )
	{
		x = master.x;
		y = master.y;
	}
	else { instance_destroy(); }
}
