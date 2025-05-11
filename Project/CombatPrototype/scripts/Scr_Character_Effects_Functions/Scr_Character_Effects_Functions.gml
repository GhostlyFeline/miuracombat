// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#region //------------CHARACTER SPRITE OFFSET------------//

#region //------Character_Offset_Init------//

/// @function Character_Offset_Init()
/// @description Initialize the variables that can offset the sprite position.

function Character_Offset_Init() {

	charOffsetX = 0;
	charOffsetY = 0;

	charShakeX = 0;
	charShakeY = 0;

	charKickbackX = 0;
	charKickbackY = 0;

	Character_Shake_Init();
	Character_Kickback_Init();

}

#endregion

#endregion


#region //------------CHARACTER SHAKE------------//

#region //------Character_Shake_Init------//

/// @function Character_Shake_Init()
/// @description Initialize the character shake properties.
function Character_Shake_Init() {

	charShakeDisable  = false;
	charShakeType     = 0;
	charShakeTimer    = -1;
	charShakeFrames   = 10;
	charShakeDist     = 32;
	charShakePercent  = 0;
	charShakePriority = 0;
	charShakeReset    = false;

}

#endregion

#region //------Character_Shake_Tick------//

/// @function Character_Shake_Tick()
/// @description Shake the character if necessary.
function Character_Shake_Tick() {

	if ( charShakeDisable ) { exit; }

	var _sX = 0;
	var _sY = 0;

	if ( charShakeTimer >= 0 ) {
		var _sPercent = charShakeTimer / charShakeFrames;
	
	#region Change the distance based on the type.
	
		switch( charShakeType )
		{
			default:
				charShakePercent = 1;
				break;
			
			case 1:
				charShakePercent = lerp( 0, 1, _sPercent );
				if ( charShakePercent <= 0 ) { charShakeReset = true; }
				break;
		
			case 2:
				charShakePercent = lerp( 1, 0, _sPercent );
				break;
		}
	
	#endregion
	
		if ( global.levelGenericPauseTimer < 0 )
		{
		#region Tick down the timer, and reset the priority at the end.
			charShakeTimer--;
			if ( charShakeTimer < 0 ) { charShakePriority = 0; }
		#endregion
		}
	
	}
	else
	if ( charShakeReset ) { charShakeReset = false; charShakePercent = 0; }

#region Set the coordinates.

	var _sLen = charShakeDist * charShakePercent;
	var _sDir = random(360);
	
	var _sX = lengthdir_x( _sLen, _sDir );
	var _sY = lengthdir_y( _sLen, _sDir );
	
#endregion

#region Move the offset position to the correct coordinates.
	charShakeX = _sX;
	charShakeY = _sY;
#endregion

}

#endregion

#region //------Character_Shake_Activate------//

/// @function                  Scr_Character_Shake_Activate(frames, type, distance, reset, priority)
/// @description               Activate the shake with the desired properties.
/// @param   {int}  frames     The amount of frames to shake the character.
/// @param   {bool} type       Whether to fade to 0, or stay constant.
/// @param   {real} distance   The maximum distance to shake character.
/// @param   {bool} reset      Whether to reset the distance at the end.
/// @param   {int}  priority   The priority to override an existing effect.
	
function Scr_Character_Shake_Activate(_frames, _type, _distance, _reset, _priority) {

	if ( _priority >= charShakePriority ) {
		charShakeFrames = _frames;
		charShakeTimer  = _frames;
		charShakeType   = _type;
		charShakeDist   = _distance;
		charShakeReset  = _reset;
		charShakePriority = _priority;
	}

}

#endregion

#endregion


#region //------------CHARACTER KICKBACK------------//

#region //------Character_Kickback_Init------//

/// @function Character_Kickback_Init()
/// @description Initialize the character kickback properties.
function Character_Kickback_Init() {

	charKickbackDisable  = false;
	charKickbackType     = 0;
	charKickbackTimer    = -1;
	charKickbackFrames   = 10;
	charKickbackDist     = 32;
	charKickbackDir      = 0;
	charKickbackPercent  = 0;
	charKickbackPriority = 0;
	charKickbackReset    = false;

}

#endregion

#region //------Character_Kickback_Tick------//

/// @function Character_Kickback_Tick()
/// @description Kick the character in a certain direction if necessary.
function Character_Kickback_Tick() {

	if ( charKickbackDisable ) { exit; }

	if ( charKickbackTimer >= 0 ) {
		var _sPercent = charKickbackTimer / charKickbackFrames;
	
	#region Change the distance based on the type.
	
		switch( charKickbackType )
		{
			default:
				charKickbackPercent = 1;
				break;
			
			case 1:
				charKickbackPercent = lerp( 0, 1, _sPercent );
				if ( charKickbackPercent <= 0 ) { charKickbackReset = true; }
				break;
		
			case 2:
				charKickbackPercent = lerp( 1, 0, _sPercent );
				break;
		}
	
	#endregion
	
		if ( global.levelGenericPauseTimer < 0 )
		{
		#region Tick down the timer, and reset the priority at the end.
			charKickbackTimer--;
			if ( charKickbackTimer < 0 ) { charKickbackPriority = 0; }
		#endregion
		}
	
	}
	else
	if ( charKickbackReset ) { charKickbackReset = false; charKickbackPercent = 0; }

#region Set the coordinates.

	var _sLen = charKickbackDist * charKickbackPercent;
	var _sDir = charKickbackDir;
	
	var _sX = lengthdir_x( _sLen, _sDir );
	var _sY = lengthdir_y( _sLen, _sDir );
	
#endregion

#region Move the offset position to the correct coordinates.
	charKickbackX = _sX;
	charKickbackY = _sY;
#endregion

}

#endregion

#region //------Character_Kickback_Activate------//

/// @function                   Scr_Character_Kickback_Activate(frames, type, direction, distance, reset, priority)
/// @description                Activate the kickback with the desired properties.
/// @param   {int}  frames      The amount of frames to shake the character.
/// @param   {bool} type        Whether to fade to 0, or stay constant.
/// @param   {real} direction   The maximum distance to shake character.
/// @param   {real} distance    The maximum distance to shake character.
/// @param   {bool} reset       Whether to reset the distance at the end.
/// @param   {int}  priority    The priority to override an existing effect.

function Scr_Character_Kickback_Activate(_frames, _type, _direction, _distance, _reset, _priority) {

	if ( _priority >= charKickbackPriority ) {
		charKickbackFrames   = _frames;
		charKickbackTimer    = _frames;
		charKickbackType     = _type;
		charKickbackDir      = _direction;
		charKickbackDist     = _distance;
		charKickbackReset    = _reset;
		charKickbackPriority = _priority;
	}

}

#endregion

#endregion


#region //------------CHARACTER COLOR FLASH------------//

#region //------Character_Flash_Init------//

/// @function Character_Flash_Init()
/// @description Initialize the character flash.
function Character_Flash_Init() {

	charFlashDisable  = false;
	charFlashType     = 0;
	charFlashTimer    = -1;
	charFlashFrames   = 10;
	charFlashColor    = c_white;
	charFlashAlpha    = 1;
	charFlashPercent  = 0;
	charFlashPriority = 0;
	charFlashReset    = false;

}

#endregion

#region //------Character_Flash_Tick------//

/// @function Character_Flash_Tick()
/// @description Flash the character.
function Character_Flash_Tick() {

	if ( charFlashDisable ) { exit; }

	if ( charFlashTimer >= 0 ) {
		var _sPercent = charFlashTimer / charFlashFrames;
	
		#region Change the transparency based on the type.
	
			switch( charFlashType )
			{
				default:
					charFlashPercent = 1;
					break;
			
				case 1:
					charFlashPercent = lerp( 0, 1, _sPercent );
					if ( charFlashPercent <= 0 ) { charFlashReset = true; }
					break;
		
				case 2:
					charFlashPercent = lerp( 1, 0, _sPercent );
					break;
			
				case 3:
					if ( _sPercent >= 0.5 ) { charFlashPercent = 1; } else { charFlashPercent = lerp( 0, 1, _sPercent / 0.5 ); }
					if ( charFlashPercent <= 0 ) { charFlashReset = true; }
					break;
		
				case 4:
					charFlashPercent = lerp( 1, 0, _sPercent );
					break;
			}
	
		#endregion
	
		if ( global.levelGenericPauseTimer < 0 )
		{
		#region Tick down the timer, and reset the priority at the end.
	
			charFlashTimer--;
			if ( charFlashTimer < 0 ) { charFlashPriority = 0; }
	
		#endregion
		}
	}
	else
	if ( charFlashReset ) { charFlashPercent = 0; charFlashReset = false; }

}

#endregion

#region //------Character_Flash_Activate------//

/// @function                   Character_Flash_Activate(frames, type, direction, distance, priority)
/// @description                Activate the flash with the desired properties.
/// @param   {int}   frames     The amount of frames to shake the character.
/// @param   {bool}  type       Whether to fade to 0, or stay constant.
/// @param   {color} color      The maximum distance to shake character.
/// @param   {real}  alpha      The maximum distance to shake character.
/// @param   {bool}  reset      Whether to reset the color fade at the end.
/// @param   {int}   priority   The priority to override an existing effect.

function Character_Flash_Activate(_frames, _type, _color, _alpha, _reset, _priority) {

	if ( _priority >= charFlashPriority ) {
		charFlashFrames   = _frames;
		charFlashTimer    = _frames;
		charFlashType     = _type;
		charFlashColor    = _color;
		charFlashAlpha    = _alpha;
		charFlashReset    = _reset;
		charFlashPriority = _priority;
	}

}

#endregion

#endregion
