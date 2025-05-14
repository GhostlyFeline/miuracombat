// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum enumStateStatus
{
	init,
	tick,
	abort,
}

function State_Sys_Init(_initState = -1, _initLength = -1) 
{
	stateCurrent  = _initState;
	statePrevious = _initState;
	stateNext     = -1;
	
	stateTick   = 0;
	stateLength = _initLength;
	stateNextLength = -1;
	
	stateCurrent(enumStateStatus.init);
}

function State_Sys_Tick()
{
	stateCurrent(enumStateStatus.tick);
	stateTick++;
	if ( stateLength >= 0 && stateTick >= stateLength ) { State_Change(stateNext, stateNextLength); }
}

function State_Change(_state = stateNext, _stateLength = stateNextLength, _forceReset = false)
{
	//if ( !is_method(_state) ) { show_debug_message("ERROR: No State Method"); return stateCurrent; }
	
	if ( _state == stateCurrent && !_forceReset ) { return stateCurrent; }
	
	//End the previous state.
	statePrevious = stateCurrent;
	statePrevious(enumStateStatus.abort);
	
	//Initialize the new state.
	stateCurrent = _state;
	stateTick    = 0;
	stateLength = _stateLength;	
	stateCurrent(enumStateStatus.init);
	
	//stateNext = stateCurrent;
	//stateNextLength = -1;
		
	return stateCurrent;
}