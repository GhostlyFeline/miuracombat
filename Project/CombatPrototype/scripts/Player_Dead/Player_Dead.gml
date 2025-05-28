// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Player_Dead(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
			
			isDying = true;
			
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