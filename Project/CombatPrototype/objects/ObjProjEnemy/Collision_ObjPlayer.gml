/// @description Insert description here
// You can write your code in this editor
var _self = id;

if (!other.invincible)
{
	var _len = random(32);
	var _dir = random(360);
	var _lX  = lengthdir_x(_len, _dir);
	var _lY  = lengthdir_y(_len, _dir);
	var _text = instance_create_layer(x + _lX, y + _lY, "TextAbove", ObjDamageNumber );
	_text.damage = damage;
	_text.textColor = c_red;
	_text.textFont  = FntDamageNumB;
	_text.fadeFrames = 60;

	with ( other ) { PlayerHit(_self.damage); }
	BulletHit(other);
}
else
{
	audio_play_sound(SndPlayerGraze, 10, 0);
}