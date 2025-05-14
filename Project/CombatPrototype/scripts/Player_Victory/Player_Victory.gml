// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Victory(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
			
			sprite_index = SprPlayerAttack;
			image_index = 8;
			image_speed = 0;
			
			image_angle = 0;
			image_xscale = 1;
			image_yscale = 1;
			
			pMoveXspd = 0;
			pMoveYspd = 0;
			
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			
						
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			
			
			
			#endregion
			break;
	}
}