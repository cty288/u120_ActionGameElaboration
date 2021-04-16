/// @description Insert description here
// You can write your code in this editor
if(player_state==state.alive){
	player_life++;
	audio_play_sound(item_pickup,1,false);
	instance_destroy(other);
}
