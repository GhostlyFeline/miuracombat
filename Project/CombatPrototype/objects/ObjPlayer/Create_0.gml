/// @description Insert description here
// You can write your code in this editor

charHealthMax = 100;
charHealth = charHealthMax;
invincible = false;

State_Sys_Init(State_Player_Normal, -1);

Character_Flash_Init();
Character_Shake_Init();
Character_Kickback_Init();

Player_Energy_Init();
Player_Move_Init();
Player_Dash_Init();
Player_Targeting_Init();
Player_Shoot_Init();
Player_Spell_Init();
Player_Skills_Init();
Player_Element_Menu_Init();
Player_Skill_Menu_Init();

tick = 0;


pLimit = 0;
pLimitMax = 100;


pRecoveryTimer = -1;
pRecoveryFrames = 15;


canGraze = true;
graze = false;

isDying = false;

pElementSwap_animTimer = -1;
pElementSwap_frames = 3;

pHudStyleToggle = true;

screenShakeTimer = -1;
screenShakeFrames = 5;
screenShakeDir = 0;
screenShakeDist = 0;
screenShakeAmp = 0;

charOffset = [0, 0];
charShakeTimer = -1;
charShakeFrames = 5;
charShakeDir = 0;
charShakeDist = 0;
charShakeAmp = 0;


display_set_gui_size(1920, 1080);


drawHpReal    = charHealth;
drawHpDisplay = drawHpReal;

drawMpReal    = pEnergy;
drawMpDisplay = drawMpReal;


drawSpellFinishTimer [0] = 0;
drawSpellFinishFrames[0] = 10;

drawSpellFinishTimer [1] = 0;
drawSpellFinishFrames[1] = 10;

drawSpellFinishTimer [2] = 0;
drawSpellFinishFrames[2] = 10;


squishScl = [1, 1];


function PlayerHit(_damage)
{		
	var _newDamage = floor(_damage * pIceArmorMultiplier);
		
	charHealth = max( charHealth - _newDamage, 0 );
	Sound_Play(enumSoundFxList.playerHit);
	
	var _len = random(32);
	var _dir = random(360);
	var _lX  = lengthdir_x(_len, _dir);
	var _lY  = lengthdir_y(_len, _dir);
	var _text = instance_create_layer(x + _lX, y + _lY, "TextAbove", ObjDamageNumber );
	_text.damage = _newDamage;
	_text.textColor = c_red;
	_text.textFont  = FntDamageNumB;
	_text.fadeFrames = 60;
	
	charShakeFrames = 30;
	charShakeTimer  = charShakeFrames;
	charShakeAmp = 8;
	
	screenShakeFrames = 30;
	screenShakeTimer  = screenShakeFrames;
	screenShakeAmp = 16;
	
	global.hitstopTimer = 3;
	global.hitstopDelay = 2;
	
	Character_Flash_Activate(8, 1, c_red, 1.0, true, 100);
	
	pRecoveryTimer = pRecoveryFrames;
	
	var _limitGainCalc = ( _newDamage / charHealthMax ) * 50;
	pLimit = min( pLimit + _limitGainCalc, pLimitMax );
}