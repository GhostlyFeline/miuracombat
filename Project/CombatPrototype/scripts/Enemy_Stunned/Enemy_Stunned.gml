// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Enemy_Stunned(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
			
			audio_play_sound(SndEnemyStun, 100, 0);
			
			stateLength = enemyStunFrames;
			
			enemyStun = 0;
			var _text = instance_create_layer(x, y, "TextAbove", ObjStunText );
			_text.master = id;
			
			stateNext = enemyNeutralState;
			stateNextLength = -1;
			
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			if ( stateTick mod 15 == 0 ) { Character_Flash_Activate(15, 1, merge_color(c_yellow, c_white, 0.5), 0.75, true, 100); }
			enemyStun = 0;
						
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			
			
			
			#endregion
			break;
	}
}