// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Enemy_Caster_SpellA(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
			
			stateNext = enemyNeutralState;
			stateNextLength = -1;
			
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