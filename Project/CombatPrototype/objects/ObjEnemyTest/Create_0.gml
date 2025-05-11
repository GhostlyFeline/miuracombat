/// @description Insert description here
// You can write your code in this editor

Character_Flash_Init();

enemyId = 0;

enemyGiveXp = 20;

enemyHitList = ds_list_create();

charHealthMax = 200;
charHealth = charHealthMax;

enemyWeakness = choose(enumProjPlayerElement.water, enumProjPlayerElement.light, enumProjPlayerElement.ice, enumProjPlayerElement.fire);

enemyStun = 0;
enemyStunMax = 100;

enemyStunTimer  = -1;
enemyStunFrames = 240;


charOffset = [0, 0];

charShakeTimer = -1;
charShakeFrames = 5;
charShakeDir = 0;
charShakeDist = 0;
charShakeAmp = 0;

tick = 0;