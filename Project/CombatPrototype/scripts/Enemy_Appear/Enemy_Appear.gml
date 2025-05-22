// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Enemy_Appear(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
			
			image_blend = c_black;
			image_xscale = 0;
			image_yscale = 0;
			
			Character_Flash_Activate(120, 1, c_black, 1, true, 1000);
			
			charShakeFrames = 120;
			charShakeTimer  = charShakeFrames;
			charShakeAmp = 16;
			
			invincible = true;
			
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			image_blend = c_white;
			
			var _statePercent = stateTick / stateLength;
			
			if ( _statePercent <= 0.5 )
			{
				image_xscale = _statePercent / 0.5;
				image_yscale = image_xscale;
				
				with (FxHandler)
				{					
					repeat(2)
					{
						var _pos = [random_range(_self.bbox_left, _self.bbox_right), random_range(_self.bbox_top, _self.bbox_bottom)];				
						part_particles_create(fxSysGlobalAbove, _pos[0], _pos[1], fxType[enumFxType.eFxEnemy_appearSpark00], 1 );
					}
				}
			}
						
			invincible = true;			
			
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			
			invincible = false;
			
			#endregion
			break;
	}
}