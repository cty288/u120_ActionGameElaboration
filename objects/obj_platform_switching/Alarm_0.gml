//start switching color state
//at this state, both players can jump on it
//last a few seconds

if(counter<6){
	sw_state=2;
	counter++;
	if(current_color==colors[0]){
		current_color=colors[1];
	}else{
		current_color=colors[0];
	}
	
	image_blend=current_color;
	if(!audio_is_playing(switch_cloud)){
		audio_play_sound(switch_cloud,1,false);
	}
	
	alarm[0]=0.14*room_speed;
	
}else{ //finish switching, change a color
	counter=0;
	if(current_color==colors[0]){
		current_color=colors[1];
		sw_state=1;
	}else{
		current_color=colors[0];
		sw_state=0;
	}
	image_blend=current_color;
	
	alarm[0]=random_range(1*room_speed,3*room_speed);
}
