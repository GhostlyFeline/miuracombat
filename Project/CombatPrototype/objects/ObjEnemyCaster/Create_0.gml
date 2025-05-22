/// @description Insert description here
// You can write your code in this editor

event_inherited();

stateNext = State_Enemy_Caster_Idle;
stateNextLength = 180;

enemyNeutralState = State_Enemy_Caster_Idle;

enemyDropXp = 100;
enemyDropItem = [enumItemType.potionSmall];

charHealthMax = 500;
charHealth = charHealthMax;

enemyWeakness = enumProjPlayerElement.light;

enemyStunMax = 200;
enemyStunDegrade = 0.0001;
enemyStunFrames = 240;


var _len = random(ObjPlayer.pMoveBoundsCircleRadius);
var _dir = random(360);
enemyMoveTarget = [ ( room_width * 0.5 ) + lengthdir_x(_len, _dir), ( room_height * 0.5 ) + lengthdir_y(_len, _dir) ];

tick = 0;