/// @description Insert description here
// You can write your code in this editor

event_inherited();

stateNext = State_Enemy_Basic_Idle;
stateNextLength = 180;

enemyNeutralState = State_Enemy_Basic_Idle;

enemyDropXp = 20;
enemyDropItem = [enumItemType.potionSmall];

charHealthMax = 200;
charHealth = charHealthMax;

enemyWeakness = choose(enumProjPlayerElement.spirit, enumProjPlayerElement.light, enumProjPlayerElement.ice, enumProjPlayerElement.fire);

enemyStunMax = 100;
enemyStunDegrade = 0.1;
enemyStunFrames = 240;




var _len = random(ObjPlayer.pMoveBoundsCircleRadius);
var _dir = random(360);
enemyMoveTarget = [ ( room_width * 0.5 ) + lengthdir_x(_len, _dir), ( room_height * 0.5 ) + lengthdir_y(_len, _dir) ];

tick = 0;