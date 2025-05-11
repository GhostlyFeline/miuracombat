// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Dash_Init()
{
	pDashA_animTimer = -1;
	pDashA_frames = 24;
	pDashCooldownTimer = -1;
	pDashCooldownFrames = 40;
	pDashA_lastDir = 0;
	pDashEnergyCost = 10;
}


function Player_Dash_Tick()
{
	var _self = id;
	var _moveAxisX = input_check("right") - input_check("left");
	var _moveAxisY = input_check("down")  - input_check("up");
	
	if ( input_check_pressed("ability") && pDashA_animTimer < 0 && pDashCooldownTimer < 0 && pEnergy >= pDashEnergyCost ) { pDashA_animTimer = 0; pEnergy -= pDashEnergyCost; }
	
	if ( pDashA_animTimer >= 0 )
	{		
		if ( pDashA_animTimer == 0 )
		{
			#region Start the dash, setting the initial direction to where the player is inputting.
			var _dashInitDir = pDashA_lastDir;
			if ( point_distance(0, 0, _moveAxisX, _moveAxisY) > 0.25 ) { _dashInitDir = point_direction(0, 0, _moveAxisX, _moveAxisY); }
			pMoveXspd = lengthdir_x(40, _dashInitDir);
			pMoveYspd = lengthdir_y(40, _dashInitDir);
				
			audio_play_sound(SndPlayerDash, 10, 0);
			#endregion
		}
	
		pMoveSpeedMulti = 2;
		pMoveEaseMulti = 0.20;
		invincible = true;
		pLockonRotateOverride = true;
		
		#region Visual Effects
		
		with (FxHandler)
		{
			var _dir = point_direction(_self.xprevious, _self.yprevious, _self.x, _self.y);
			part_type_direction(fxType[enumFxType.pFxPlayer_dashTrail00], _dir, _dir, 0, 0);
			part_particles_create(fxSysGlobalBelow, _self.x, _self.y, fxType[enumFxType.pFxPlayer_dashTrail00], 1 );
		
			var _len = random(32);
			var _dir = random(360);
			var _lX  = lengthdir_x(_len, _dir);
			var _lY  = lengthdir_y(_len, _dir);
			part_particles_create(fxSysGlobalBelow, _self.x + _lX, _self.y + _lY, fxType[enumFxType.pFxPlayer_dashBubbles00], 1 );
		
			var _len = random(80);
			var _dir = random(360);
			var _lX  = lengthdir_x(_len, _dir);
			var _lY  = lengthdir_y(_len, _dir);
			part_particles_create(fxSysGlobalBelow, _self.x + _lX, _self.y + _lY, fxType[enumFxType.pFxPlayer_dashShine00], 1 );
		}
		if ( pDashA_animTimer mod 5 == 0 ) { Character_Flash_Activate(5, 1, merge_color(c_aqua, c_white, 0.5), 0.5, true, 10); }
		
		#endregion
		
		pDashA_animTimer++;
		if ( pDashA_animTimer > pDashA_frames )
		{
			#region End the dash.
			pDashA_animTimer = -1;
			pMoveSpeedMulti = 1;
			pMoveEaseMulti = 1;
			pDashCooldownTimer = pDashCooldownFrames;
		
			invincible = false;
			pLockonRotateOverride = false;
			#endregion
		}
	}

	if ( pDashCooldownTimer >= 0 ) { pDashCooldownTimer--; }
}