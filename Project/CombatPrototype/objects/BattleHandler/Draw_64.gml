/// @description Insert description here
// You can write your code in this editor

var _guiLeft   = 0;
var _guiRight  = display_get_gui_width();
var _guiTop    = 0;
var _guiBottom = display_get_gui_height();

var _guiCenterX = ( _guiLeft + _guiRight  ) * 0.5;
var _guiCenterY = ( _guiTop  + _guiBottom ) * 0.5;

var _guiWidth  = display_get_gui_width();
var _guiHeight = display_get_gui_height();

draw_set_font(FntDefault);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if ( instance_exists(ObjEnemyTest) )
{
	draw_text( _guiLeft + 8, _guiTop +  8, "Lowest Enemy Id: "  + string(battleEnemyIdLow ) );
	draw_text( _guiLeft + 8, _guiTop + 64, "Highest Enemy Id: " + string(battleEnemyIdHigh) );
}



if ( battleWon )
{
	#region Victory Screen
	
	var _colorA = merge_color( merge_color(c_yellow, c_orange, 0.25) , c_black, 0.5);
	var _colorB = merge_color( merge_color(c_yellow, c_orange, 0.25) , c_white, 0.5);
	
	draw_set_alpha(0.33);	
	draw_set_color(c_black);
	draw_rectangle(_guiLeft - 128, _guiTop - 128, _guiRight + 128, _guiBottom + 128, 0);

	draw_set_font(FntWinScreenA);
	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	for ( var i = 1; i >= 0; i--; )
	{
		if ( i == 1 ) { draw_set_color(_colorA); }
		if ( i == 0 ) { draw_set_color(_colorB); }
		
		draw_set_font(FntWinScreenA);
		//draw_set_halign(fa_center);
		var _textPos = [_guiCenterX, _guiCenterY - 300];
		draw_text(_textPos[0] - (i*2), _textPos[1] + (i*2), "VICTORY!" );
		
		draw_set_font(FntWinScreenB);
		_textPos[1] += 100;
		draw_text(_textPos[0] - (i*2), _textPos[1] + (i*2), "XP Earned: " + string(BattleHandler.xpTotal) );
		
		_textPos[1] += 100;
		draw_text(_textPos[0] - (i*2), _textPos[1] + (i*2), "Items Gained" );
		
		draw_set_font(FntWinScreenC);
		_textPos[1] += 60;		
		
		function UniqueItem(_index, _num) constructor
		{
			unItemIndex = _index;
			unItemNumber = _num;
		}
		
		var _uniqueItemsArray = array_create(0);
		for ( var j = 0; j < enumItemType.null; j++; )
		{
			_uniqueItemsArray[j] = new UniqueItem(j, 0);
			
			var _arrayLen = array_length(itemDropArray);
			for ( var k = 0; k < _arrayLen; k++; )
			{
				if ( itemDropArray[k] == _uniqueItemsArray[j].unItemIndex ) { _uniqueItemsArray[j].unItemNumber++; }
			}
			
			var _itemString = "";
			switch(_uniqueItemsArray[j].unItemIndex)
			{
				case enumItemType.potionSmall: _itemString = "Small Potion"; break;
				case enumItemType.null:        _itemString = "<NULL>";       break;
			}
			_itemString += " x " + string(_uniqueItemsArray[j].unItemNumber);
			
			draw_text(_textPos[0] - (i*2), _textPos[1] + (j*48) + (i*2), _itemString );
		}		
		
	}
	
	#endregion
}

if ( battleLost )
{
	#region Game Over Screen
	
	var _alpha = 1;
	var _textAlpha = 1;
	var _textScl = 1.5;
	
	if ( battleGameOverTimer <= 90 ) { _alpha = battleGameOverTimer / 90; }	
	if ( battleGameOverTimer >= battleGameOverFrames - 90 ) { _textAlpha = lerp( 1, 0, ( battleGameOverTimer - ( battleGameOverFrames - 90 ) ) / 90 ); }
	_textScl = lerp(1.5, 2.0, battleGameOverTimer / battleGameOverFrames);
	
	var _colorA = merge_color( c_red, c_black, 0.66);
	var _colorB = merge_color( c_red, c_white, 0.66);

	draw_set_alpha(1 * _alpha);	
	draw_set_color(c_black);
	draw_rectangle(_guiLeft - 128, _guiTop - 128, _guiRight + 128, _guiBottom + 128, 0);
	
	draw_set_alpha(1 * _alpha * _textAlpha);
	draw_set_font(FntWinScreenA);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	for ( var i = 1; i >= 0; i--; )
	{
		if ( i == 1 ) { draw_set_color(_colorA); }
		if ( i == 0 ) { draw_set_color(_colorB); }
		
		draw_set_font(FntWinScreenA);
		//draw_set_halign(fa_center);
		var _textPos = [_guiCenterX, _guiCenterY];
		draw_text_transformed(_textPos[0] - (i*4), _textPos[1] + (i*4), "GAME OVER", _textScl, _textScl, 0 );
	}
	
	#endregion
}