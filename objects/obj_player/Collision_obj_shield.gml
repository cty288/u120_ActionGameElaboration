/// @description Insert description here
// You can write your code in this editor
if(player_state==state.alive){
	invincible_timer=random_range(5*room_speed,10*room_speed);
		audio_play_sound(shield,1,false);
	instance_destroy(other);
}
