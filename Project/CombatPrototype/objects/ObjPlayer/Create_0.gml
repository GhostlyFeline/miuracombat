/// @description Insert description here
// You can write your code in this editor

State_Sys_Init(State_Player_Normal, -1);

Character_Flash_Init();
Character_Shake_Init();
Character_Kickback_Init();

Player_Energy_Init();
Player_Move_Init();
Player_Dash_Init();
Player_Targeting_Init();
Player_Shoot_Init();
Player_Breaker_Init();
Player_Element_Menu_Init();


charHealthMax = 100;
charHealth = charHealthMax;




tick = 0;



invincible = false;
pElementSwap_animTimer = -1;
pElementSwap_frames = 3;



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



function PlayerHit(_damage)
{		
	charHealth = max( charHealth - _damage, 0 );
	audio_play_sound(SndPlayerHit, 10, 0);
	
	charShakeFrames = 30;
	charShakeTimer  = charShakeFrames;
	charShakeAmp = 8;
	
	screenShakeFrames = 30;
	screenShakeTimer  = screenShakeFrames;
	screenShakeAmp = 16;
	global.hitstopTimer = 8;
	global.hitstopDelay = 2;
	
	Character_Flash_Activate(8, 1, c_red, 1.0, true, 100);
}