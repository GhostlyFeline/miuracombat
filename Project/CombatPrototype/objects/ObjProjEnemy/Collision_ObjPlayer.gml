/// @description Insert description here
// You can write your code in this editor
var _self = id;

if (!other.invincible)
{
	with ( other ) { PlayerHit(_self.damage); }
	BulletHit(other);
}
else
{
	var _self = id;
	if ( other.canGraze )
	{
		with (FxHandler) { part_particles_create(fxSysGlobalBelow, _self.x, _self.y, fxType[enumFxType.pFxPlayer_grazeSpark00], 5 ); }
		
		if ( other.pIceShieldHasParried || other.pRecoveryTimer >= 0 ) { BulletHit(other); }
		Sound_Play(enumSoundFxList.playerGraze);
		
		other.graze = true;
	}
	
}