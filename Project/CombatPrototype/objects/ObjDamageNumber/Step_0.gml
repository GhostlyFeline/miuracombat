/// @description Insert description here
// You can write your code in this editor

var _percent = fadeTimer / fadeFrames;
if ( fadeTimer <= 5 ) { textScl = lerp(0, 2.0, fadeTimer / 5); }
else if ( fadeTimer <= 10) { textScl = lerp(2.0, 1.0, ( fadeTimer - 5 ) / 5); }


fadeTimer++;
if ( fadeTimer >= fadeFrames - 10 )
{
	var _percent = ( fadeTimer - ( fadeFrames - 10 ) ) / 10;
	fadeAlpha = lerp(1, 0, _percent);
	if ( fadeTimer >= fadeFrames) { instance_destroy(); }
}

//y -= 4;