/// @description Insert description here
// You can write your code in this editor

charOffset = [0, 0];

charShakeTimer = -1;
charShakeFrames = 5;
charShakeDir = 0;
charShakeDist = 0;
charShakeAmp = 0;

Character_Flash_Init();

State_Sys_Init(State_Enemy_Appear, 120);
stateNext = State_Enemy_Basic_Idle;
stateNextLength = 180;

enemyNeutralState = State_Enemy_Basic_Idle;

enemyId = 0;

enemyDropXp = 20;
enemyDropItem = [enumItemType.potionSmall];

enemyHitList = ds_list_create();

charHealthMax = 200;
charHealth = charHealthMax;

enemyWeakness = choose(enumProjPlayerElement.spirit, enumProjPlayerElement.light, enumProjPlayerElement.ice, enumProjPlayerElement.fire);

enemyStun = 0;
enemyStunMax = 100;
enemyStunDegrade = 0.01;
enemyStunTimer  = -1;
enemyStunFrames = 240;
enemyPurifyMulti = 1;
enemyPurifyMultiTimer = 0;

enemyMagmaTimer = 0;
enemyMagmaFrames = 30;

invincible = false;

isDying = false;


var _len = random(ObjPlayer.pMoveBoundsCircleRadius);
var _dir = random(360);
enemyMoveTarget = [ ( room_width * 0.5 ) + lengthdir_x(_len, _dir), ( room_height * 0.5 ) + lengthdir_y(_len, _dir) ];		




tick = 0;



