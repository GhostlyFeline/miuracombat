/// @description Insert description here
// You can write your code in this editor

event_inherited();

stateNext = State_BossTest_Idle;
stateNextLength = 180;

enemyNeutralState = State_BossTest_Idle;

enemyDropXp = 10000;
enemyDropItem = [enumItemType.potionSmall];

charHealthMax = 1000;
charHealth = charHealthMax;

drawHpReal    = charHealth;
drawHpDisplay = drawHpReal;

bossName = "Angel of the Deep";

enemyWeakness = choose(enumProjPlayerElement.spirit, enumProjPlayerElement.light, enumProjPlayerElement.ice, enumProjPlayerElement.fire);

enemyStunMax = 300;
enemyStunDegrade = 0.25;
enemyStunFrames = 240;

var _len = random(ObjPlayer.pMoveBoundsCircleRadius);
var _dir = random(360);
enemyMoveTarget = [ ( room_width * 0.5 ) + lengthdir_x(_len, _dir), ( room_height * 0.5 ) + lengthdir_y(_len, _dir) ];

tick = 0;