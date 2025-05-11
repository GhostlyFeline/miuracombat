/// @description Insert description here
// You can write your code in this editor

for ( var i = 0; i < array_length(fxType); i++; ) { part_type_destroy(fxType[i]); }
part_system_destroy(fxSysGlobalAbove);
part_system_destroy(fxSysGlobalBelow);