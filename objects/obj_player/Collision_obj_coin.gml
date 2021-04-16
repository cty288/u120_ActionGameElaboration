/// @description Insert description here
// You can write your code in this editor
if(player_state==state.alive){
	coin++;
	instance_destroy(other);
	audio_play_sound(coins,1,false);
	//TODO: play a sound
}
