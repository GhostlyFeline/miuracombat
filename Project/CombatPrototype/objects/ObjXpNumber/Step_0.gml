/// @description Insert description here
// You can write your code in this editor

fadeTimer++;
if ( fadeTimer >= fadeFrames - 20 )
{
	var _percent = ( fadeTimer - ( fadeFrames - 20 ) ) / 20;
	fadeAlpha = lerp(1, 0, _percent);
	if ( fadeTimer >= fadeFrames) { instance_destroy(); }
}

y -= 1;