/// @description Insert description here
// You can write your code in this editor
if(player_state==state.alive){
if(jumping_buff<5){
	jumping_buff++;
	audio_play_sound(jumping_powerup,1,false);
	instance_destroy(other);
}


}
