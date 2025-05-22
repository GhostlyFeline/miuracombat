// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#region //------Sound_Init------//

function Sound_Init() {
	
	enum enumSoundFxList
	{
		playerShot00,
		playerHit,
		playerDash,
		playerSwitchElement,
		playerGraze,
		playerBreaker,
		playerSirenSong,
		playerIceShield,
		playerIceParry,
		playerMagmaAura,
		playerSpellCharge,
		playerSpellChargeFinish,
		
		enemyShot00,
		enemyHit,
		enemyExplode,
		enemyStun,
		enemyBreak,
		
		loopBreaker,
	}

	audioSoundListen = false;
	audioSoundFxMap = ds_map_create();

	var _soundList = ds_list_create();
	var _loopBreak = false;
	
	for ( var i = 0; i < 300; i++; )
	{
		switch(i)
		{
			default:
				_soundList[| i] = undefined;
				break;
		
		#region Player Sounds
		
			case enumSoundFxList.playerShot00:
				#region Player Shot
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerShot;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
		
			case enumSoundFxList.playerHit:
				#region Player Hit
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerHit;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
		
			case enumSoundFxList.playerDash:
				#region Player Dash
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerDash;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.playerSwitchElement:
				#region Player Switch Element
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerSwitchElement;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.playerGraze:
				#region Player Graze
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerGraze;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.playerSpellCharge:
				#region Player Spell Charge
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerSpellCharge;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.playerSpellChargeFinish:
				#region Player Spell Charge Finish
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerSpellChargeFinish;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.playerBreaker:
				#region Player Breaker
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerBreaker;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.playerSirenSong:
				#region Player Siren Song
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerSirenSong;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.playerIceShield:
				#region Player Ice Shield
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerIceShield;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.playerIceParry:
				#region Player Ice Parry
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerIceParry;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.playerMagmaAura:
				#region Player Magma Aura
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndPlayerMagmaAura;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
		
		#endregion
		
		#region Enemy Sounds
		
			case enumSoundFxList.enemyShot00:
				#region Enemy Shot
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndEnemyShot;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
		
			case enumSoundFxList.enemyHit:
				#region Enemy Hit
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndEnemyHit;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
		
			case enumSoundFxList.enemyExplode:
				#region Enemy Explode
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndEnemyExplode;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.enemyStun:
				#region Enemy Stun
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndEnemyStun;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
				
			case enumSoundFxList.enemyBreak:
				#region Enemy Break
				var _item = ds_map_create();
			
				_item[? "soundIndex"   ] = SndEnemyBreak;
				_item[? "soundActive"  ] = false;
				_item[? "soundPriority"] = 0;
				_item[? "soundLoop"    ] = false;
			
				_soundList[| i] = _item;
				ds_list_mark_as_map(_soundList, i);
				#endregion
				break;
		
		#endregion
		
		case enumSoundFxList.loopBreaker:
				_loopBreak = true;
				break;		
		}
		
		if ( _loopBreak ) { break; }
	}

	ds_map_add_list(audioSoundFxMap, "soundFxList", _soundList);

}

#endregion

#region //------Sound_Cleanup------//

function Sound_Cleanup() {	
	ds_map_destroy(audioSoundFxMap);
}

#endregion

#region //------Sound_Play------//

/// @function                 Sound_Play(index, priority);
/// @param  {int}  index      The index of the sound fx entry.
/// @param  {real} priority   The priority of the sound.
function Sound_Play(_playIndex, _priority = 10) {

	//var _loop       = argument2;
	
	if ( _playIndex < 0 ) return -1;

	with (BattleHandler)
	{
		var _list = audioSoundFxMap[? "soundFxList"];
		var _item = _list[| _playIndex];
		if ( !is_undefined(_item) )
		{
			_item[? "soundActive"  ] = true;
			_item[? "soundPriority"] = _priority;
			//_item[? "soundLoop"    ] = _loop;
			audioSoundListen = true;
		}
	}

}

#endregion

#region //------Sound_Active_Play------//

function Sound_Active_Play() {

	with (BattleHandler)
	{
		if ( audioSoundListen )
		{
			var _list = audioSoundFxMap[? "soundFxList"];
			var _listSize = ds_list_size(_list);
			if ( _listSize > 0 )
			{
				for ( var i = 0; i < _listSize; i++; )
				{
					var _item = _list[| i];
					if ( !is_undefined(_item) )
					{
						if ( _item[? "soundActive"] ) { audio_play_sound(_item[? "soundIndex"], _item[? "soundPriority"], _item[? "soundLoop"]); }
					}
				}
			}
		}
	}
	
}

#endregion

#region //------Sound_Active_Reset------//

function Sound_Active_Reset() {

	with (BattleHandler)
	{
		var _list = audioSoundFxMap[? "soundFxList"];
		var _listSize = ds_list_size(_list);
		if ( _listSize > 0 )
		{
			for ( var i = 0; i < _listSize; i++; )
			{
				var _item = _list[| i];
				if ( !is_undefined(_item) ) { _item[? "soundActive"] = false; }
			}
		}
		
		audioSoundListen = false;
	}

}

#endregion