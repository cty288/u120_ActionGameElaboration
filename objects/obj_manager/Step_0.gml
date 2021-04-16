/// @description Insert description here
// You can write your code in this editor

p1=instance_find(obj_player_1,0);
p2=instance_find(obj_player_2,0);
//change background color
layer_background_blend(4, merge_color(layer_background_get_blend(4),target_color,0.04));

if(keyboard_check_pressed(ord("R"))){
	audio_stop_all();
	room_restart();
	
}
if(current_state==game_state.starting){
	audio_stop_sound(Bananana_Gameplay_B);
	audio_stop_sound(Bananana_Game_Over_B);
	if(keyboard_check_pressed(vk_enter)&&!starting_enter_pressed){
		starting_enter_pressed=true;
		alarm[2]=2*room_speed;	
	}
	if(!audio_is_playing(Bananana_Main_Menu_B)){
		audio_play_sound(Bananana_Main_Menu_B,1,true);
	}
	

}else{
	if(time_respawn==2){
	audio_stop_sound(Bananana_Main_Menu_B);
	
	current_state=game_state.ongoing;
}
//generate platforms 
platform_generate_timer++;
if(platform_generate_timer>=platform_generate_time){
	platform_generate_timer=0;
	platform_generate_time = random_range(0.1*room_speed,1*room_speed+platform_generate_time_offset);
	if(current_platform<max_platforms){
		var num=irandom_range(1,3);
		if(global.height>=150){
			num=irandom_range(2,4);
		}
		if(current_platform<=5){
			num=5;
		}
		SpawnPlatforms(num,camera_get_view_y(view_camera[0]),camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])-60);
	
	}
}

platform_generate_time_offset=-0.002*global.height;
if(platform_generate_time_offset<=-0.6){
	platform_generate_time_offset=-0.6;
}

if(global.height%100<=1){
	if(!reward){
		reward=true;
		p1.player_life++;
		p2.player_life++;
		//TODO: play a sound here
		audio_play_sound(reward_notification,1,false);
	}
}else{
	reward=false;
}

if(current_state==game_state.ongoing){
	if(!audio_is_playing(Bananana_Gameplay_B)){
		audio_play_sound(Bananana_Gameplay_B,1,true);
	}
	
	if(p1.player_life<=0 || p2.player_life<=0){
		current_state=game_state.finished;
		audio_stop_sound(Bananana_Gameplay_B);
		audio_stop_sound(Bananana_Main_Menu_B);
		if(!audio_is_playing(Bananana_Game_Over_B)){
		audio_play_sound(Bananana_Game_Over_B,1,true);
		}
	}
	
	if(global.height>=400){
		if(p1.coin!=p2.coin){	//if their coin numbers are equal, the game will continue the game until one's coin is greater than the other
			current_state=game_state.finished;
			audio_stop_sound(Bananana_Gameplay_B);
			audio_stop_sound(Bananana_Main_Menu_B);
			if(!audio_is_playing(Bananana_Game_Over_B)){
				audio_play_sound(Bananana_Game_Over_B,1,true);
			}
		}
	}
	
	
}


current_platform=instance_number(obj_platform);
}



