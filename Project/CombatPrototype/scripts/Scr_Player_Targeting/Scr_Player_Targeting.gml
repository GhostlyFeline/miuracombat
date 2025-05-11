// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Player_Targeting_Init()
{
	pLockonHasTarget = false;
	pLockonCurrentId = -1;
	pLockonRotateOverride = false;
	instance_destroy(ObjPlayerTarget);
	instance_create_layer(x, y, layer, ObjPlayerTarget);
}

function Player_Target_Find(_findNearest = false)
	{
		var _self = id;
		
		if ( instance_exists(ObjEnemyTest) )
		{
			var _low  = BattleHandler.battleEnemyIdLow;
			var _high = BattleHandler.battleEnemyIdHigh;	
			
			if ( _high == 0 && _low == 99 ) { return -1; }
			
			var _hasTarget = false;
			var _targetInst = noone;
			
			if ( _findNearest )
			{
				#region Simply find the nearest target.
				
				_targetInst = instance_nearest(x, y, ObjEnemyTest);
				_hasTarget = true;
				
				#endregion
			}
			else
			{
				#region Cycle to the next target based on enemy id.
				
				pLockonCurrentId++;
				while ( !_hasTarget )
				{
					with ( ObjEnemyTest )
					{
						if ( enemyId == _self.pLockonCurrentId )
						{
							_hasTarget = true;
							_targetInst = id;
						}
					}
				
					if ( !_hasTarget )
					{
						pLockonCurrentId++;
						if ( pLockonCurrentId > _high ) { pLockonCurrentId = _low; }
					}
				}
				
				#endregion
			}
			
			if ( _hasTarget )
			{
				ObjPlayerTarget.follow = _targetInst;
				ObjPlayerTarget.x = _targetInst.x;
				ObjPlayerTarget.y = _targetInst.y;				
			}
		}
		
	}

function Player_Targeting_Tick()
{	
	if ( input_check_pressed("target") ) { Player_Target_Find(); }
	
	if ( instance_exists(ObjPlayerTarget.follow) )
	{
		pLockonHasTarget = true;	
		pLockonCurrentId = ObjPlayerTarget.follow.enemyId;
		var _targetPos = [ObjPlayerTarget.x, ObjPlayerTarget.y]; 
		if ( !pLockonRotateOverride )
		{
			#region Rotate the character based on their current direction.

			var _mDist = point_distance (x, y, _targetPos[0], _targetPos[1]);
			var _mDir  = point_direction(x, y, _targetPos[0], _targetPos[1]);

			if ( _mDist > 1 )
			{
				image_angle = _mDir;
				if ( _targetPos[0] - x > 0 )
				{
					image_xscale = 1;
					image_yscale = 1;
				}
				else if ( _targetPos[0] - x < 0 )
				{
					image_xscale = 1;
					image_yscale = -1;
				}
			}	

			#endregion
		}
	}
	else
	{
		pLockonHasTarget = false;
		pLockonCurrentId = -1;
		Player_Target_Find(true);
	}
	
	
	
	
}