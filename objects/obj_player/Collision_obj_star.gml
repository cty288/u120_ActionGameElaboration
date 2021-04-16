/// @description Insert description here
// You can write your code in this editor

if(!invincible && player_state==state.alive){
	player_state=state.dead;
	audio_play_sound(player_bounce,1,false);
	if(other_player.jumping_buff>0){
		jumping_buff--;
		die_buff_disappear_effect_timer=2*room_speed;
	}
	player_life--;
	GenerateDeathEffect(x+64,y-80);
	y_speed=15;
	remainder_y=0;
	//TODO: play a sound here
}