// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Move_Init()
{
	pMoveXspd = 0;
	pMoveYspd = 0;

	pMoveCurrentSpeed = 16;

	pMoveSpeedMulti = 1;
	pMoveEaseMulti  = 1;

	pMoveIsSlowed  = false;
	pMoveIsHalted  = false;

	pMoveSpeedEasing = 0.25;

	pMoveBoundsEnable = true;
	pMoveBoundsCirclePos    = [room_width * 0.5, room_height * 0.5];
	pMoveBoundsCircleRadius = 2000;

	//pMoveBoundsLeft  = 32;
	//pMoveBoundsRight = room_width - 32;
	//pMoveBoundsUp    = 32;
	//pMoveBoundsDown  = room_height - 32;
}


function Player_Move_Tick()
{
	var _self = id;
	var _moveAxisX = input_check("right") - input_check("left");
	var _moveAxisY = input_check("down")  - input_check("up");
	
	#region Movement Code

	#region Get the values for xspeed and yspeed.
	
		//var _len = point_distance (0, 0, _moveAxisX, _moveAxisY) * ( pMoveCurrentSpeed * _moveMulti );

		var _rawLen = point_distance (0, 0, _moveAxisX, _moveAxisY);
		var _maxLen = point_distance (0, 0, sign(_moveAxisX), sign(_moveAxisY));
	
		var _dir = point_direction(0, 0, _moveAxisX, _moveAxisY);
	
		if ( _moveAxisX == 0 && _moveAxisY == 0 )
		{
			if ( stateCurrent == State_Player_Dash )
			{
				_rawLen = 1;
				_dir = pDashLastDir;
			}
		}	
	
		var _len = 0;
		var _finalLen = _rawLen;
		if ( _finalLen > 1 ) { _finalLen = _rawLen / _maxLen; }
		if ( _rawLen != 0 ) { _len = _finalLen * ( pMoveCurrentSpeed * pMoveSpeedMulti ); }

		var _lX  = lengthdir_x(_len, _dir);
		var _lY  = lengthdir_y(_len, _dir);

	#endregion

	#region Apply a slight easing to movement.

		if ( !pMoveIsHalted )
		{
			pMoveXspd = lerp(pMoveXspd, _lX, pMoveSpeedEasing * pMoveEaseMulti);
			pMoveYspd = lerp(pMoveYspd, _lY, pMoveSpeedEasing * pMoveEaseMulti);
		}
		else
		{
			pMoveXspd = 0;
			pMoveYspd = 0;
		}

	#endregion

	#region Move the player.
		x += pMoveXspd;
		y += pMoveYspd;
	#endregion

	#region Rotate the character based on their current direction.

	var _mDist = point_distance (0, 0, pMoveXspd, pMoveYspd);
	var _mDir  = point_direction(0, 0, pMoveXspd, pMoveYspd);

	if ( _mDist > 1 )
	{
		pDashLastDir = _mDir;	
		image_angle = _mDir;
		if ( pMoveXspd > 0 )
		{
			image_xscale = 1;
			image_yscale = 1;
		}
		else if ( pMoveXspd < 0 )
		{
			image_xscale = 1;
			image_yscale = -1;
		}
	}

	#endregion

	#region Keep the player within game boundaries.
	if ( pMoveBoundsEnable )
	{
		//x = clamp(x, pMoveBoundsLeft, pMoveBoundsRight);
		//y = clamp(y, pMoveBoundsUp  , pMoveBoundsDown );
		
		var _boundsDist = point_distance (pMoveBoundsCirclePos[0], pMoveBoundsCirclePos[1], x, y);
		var _boundsDir  = point_direction(pMoveBoundsCirclePos[0], pMoveBoundsCirclePos[1], x, y);
	
		if ( _boundsDist > pMoveBoundsCircleRadius )
		{
			x = pMoveBoundsCirclePos[0] + lengthdir_x(pMoveBoundsCircleRadius, _boundsDir);
			y = pMoveBoundsCirclePos[1] + lengthdir_y(pMoveBoundsCircleRadius, _boundsDir);
		}
	}
	#endregion

	#endregion
}