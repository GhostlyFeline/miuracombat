/// @description Insert description here
// You can write your code in this editor

Character_Flash_Init();

enemyId = 0;

enemyDropXp = 20;
enemyDropItem = [enumItemType.potionSmall];

enemyHitList = ds_list_create();

charHealthMax = 300;
charHealth = charHealthMax;

enemyWeakness = choose(enumProjPlayerElement.spirit, enumProjPlayerElement.light, enumProjPlayerElement.ice, enumProjPlayerElement.fire);

enemyStun = 0;
enemyStunMax = 200;
enemyStunDegrade = 0.1;

enemyStunTimer  = -1;
enemyStunFrames = 240;


var _len = random(ObjPlayer.pMoveBoundsCircleRadius);
var _dir = random(360);
enemyMoveTarget = [ ( room_width * 0.5 ) + lengthdir_x(_len, _dir), ( room_height * 0.5 ) + lengthdir_y(_len, _dir) ];		


charOffset = [0, 0];

charShakeTimer = -1;
charShakeFrames = 5;
charShakeDir = 0;
charShakeDist = 0;
charShakeAmp = 0;

tick = 0;