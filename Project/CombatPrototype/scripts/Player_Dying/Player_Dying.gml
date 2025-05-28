// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Dying(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
			
			stateNext = State_Player_Dead;
			stateNextLength = -1;			
			isDying = true;
			
			Character_Flash_Activate( stateLength, 2, c_black, 1.0, false, 100000 );
			
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			var _percent = stateTick / stateLength;
			var _amp = 4;			
			if ( _percent <= 0.33 ) { _amp = lerp(0, _amp, _percent / 0.33); }
			else { _amp = lerp(_amp, 0, ( _percent - 0.33 ) / 0.67); }
			
			charShakeFrames = 5;
			charShakeTimer  = charShakeFrames;
			charShakeAmp = _amp;
						
			if ( _percent >= 0.25 )
			{
				image_alpha = lerp(1, 0, (_percent - 0.25) / 0.5);
			}
						
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			
			
			
			#endregion
			break;
	}
}