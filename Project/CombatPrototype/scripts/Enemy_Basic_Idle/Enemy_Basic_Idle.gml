// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function State_Enemy_Basic_Idle(_status)
{
	var _self = id;
	
	switch (_status)
	{
		case enumStateStatus.init:
			#region Init Script
			
			
			
			#endregion
			break;
			
		case enumStateStatus.tick:
			#region Tick Script
			
			if ( stateTick mod 300 == 0 )
			{
				var _len = random(ObjPlayer.pMoveBoundsCircleRadius);
				var _dir = random(360);
				enemyMoveTarget = [ ( room_width * 0.5 ) + lengthdir_x(_len, _dir), ( room_height * 0.5 ) + lengthdir_y(_len, _dir) ];		
			}	
	
			var _xSpd = 0;
			var _ySpd = 0;
	
			var _speed = 8;
			var _dist = point_distance(x, y, enemyMoveTarget[0], enemyMoveTarget[1]);
			if ( _dist >= _speed )
			{
				var _len = _speed;
				var _dir = point_direction(x, y, enemyMoveTarget[0], enemyMoveTarget[1]);
				_xSpd = lengthdir_x(_len, _dir);
				_ySpd = lengthdir_y(_len, _dir);
		
				//move_and_collide( _xSpd, _ySpd, ParEnemy );
		
				x += _xSpd;
				y += _ySpd;
			}
			else
			{
				var _len = 0;
				var _dir = image_angle;
				x = enemyMoveTarget[0];
				y = enemyMoveTarget[1];
			}


			#region Rotate the character based on their current direction.

			var _xSpd = lengthdir_x(_len, _dir);
			var _ySpd = lengthdir_y(_len, _dir);

			var _mDist = point_distance (0, 0, _xSpd, _ySpd);
			var _mDir  = point_direction(0, 0, _xSpd, _ySpd);

			if ( _mDist != 0 )
			{
				image_angle = _mDir;
				if ( _xSpd > 0 )
				{
					image_xscale = -1;
					image_yscale = 1;
				}
				else if ( _xSpd < 0 )
				{
					image_xscale = -1;
					image_yscale = -1;
				}
			}

			#endregion
	
			var _timer = ( stateTick + ( enemyId * 60 ) ) mod 120;
			if ( _timer == 0 || _timer == 5 || _timer == 10 )
			{
				var _bullet = instance_create_layer(x, y, layer, ObjProjEnemy);
				_bullet.projSpd = 16;
				_bullet.projDir = point_direction(_bullet.x, _bullet.y, ObjPlayer.x, ObjPlayer.y);
				_bullet.projScale = 2;
				audio_sound_pitch(SndEnemyShot, random_range(0.95, 1.05) );
				Sound_Play(enumSoundFxList.enemyShot00);
			}
			
			#endregion
			break;
			
		case enumStateStatus.abort:
			#region Abort Script
			
			
			
			#endregion
			break;
	}
}