/// @description Insert description here
// You can write your code in this editor

//if ( global.hitstopActive ) { exit; }


if ( charShakeTimer >= 0 )
{
	var _shakePos = [0, 0];
	
	charShakeDist = lerp( 0, charShakeAmp, charShakeTimer / charShakeFrames );
	charShakeDir = random(360);
	
	_shakePos[0] += lengthdir_x(charShakeDist, charShakeDir);
	_shakePos[1] += lengthdir_y(charShakeDist, charShakeDir);
	
	charShakeTimer--;
	charOffset[0] = _shakePos[0];
	charOffset[1] = _shakePos[1];
}
else
{
	charOffset = [0, 0];
}

var _camera = view_camera[0];
var _lerpAmt = 0.10;


var _focusTarget = [ pMoveBoundsCirclePos[0], pMoveBoundsCirclePos[1] ];
if ( instance_exists(ObjPlayerTarget) ) { _focusTarget = [ ObjPlayerTarget.x, ObjPlayerTarget.y]; }
if ( BattleHandler.battleWon ) { _focusTarget = [ x, y ]; }

var _focusDist = point_distance(x, y, _focusTarget[0], _focusTarget[1]);



if ( _focusDist >= 0 )
{
	var _percent = clamp( (_focusDist - 0) / 1080, 0, 1);
	var _standardSize = [1920, 1080];
	var _maxZoomOut = 3.0;
	
	var _oldSize = [camera_get_view_width(_camera), camera_get_view_height(_camera)];
	var _newSize = [ lerp(_standardSize[0], _standardSize[0] * _maxZoomOut, _percent), lerp(_standardSize[1], _standardSize[1] * _maxZoomOut, _percent) ];
	var _lerpSize = [ lerp(_oldSize[0], _newSize[0], _lerpAmt), lerp(_oldSize[1], _newSize[1], _lerpAmt) ];
	
	camera_set_view_size(_camera, _lerpSize[0], _lerpSize[1]);
}

var _focusPosition = [ lerp( x, _focusTarget[0], 0.5 ), lerp( y, _focusTarget[1], 0.5 )];
var _camDimensions = [camera_get_view_width(_camera), camera_get_view_height(_camera)];

var _camPositionOld = [camera_get_view_x(_camera), camera_get_view_y(_camera)];
var _camPositionNew = [_focusPosition[0] - (_camDimensions[0] * 0.5), _focusPosition[1] - (_camDimensions[1] * 0.5)];
var _camPositionLerp = [ lerp(_camPositionOld[0], _camPositionNew[0], _lerpAmt), lerp(_camPositionOld[1], _camPositionNew[1], _lerpAmt) ];

if ( screenShakeTimer >= 0 )
{
	var _shakePos = [0, 0];
	
	screenShakeDist = lerp( 0, screenShakeAmp, screenShakeTimer / screenShakeFrames );
	screenShakeDir = random(360);
	
	_shakePos[0] += lengthdir_x(screenShakeDist, screenShakeDir);
	_shakePos[1] += lengthdir_y(screenShakeDist, screenShakeDir);
	
	screenShakeTimer--;
	_camPositionLerp[0] += _shakePos[0];
	_camPositionLerp[1] += _shakePos[1];
}

camera_set_view_pos(_camera, _camPositionLerp[0], _camPositionLerp[1] );
