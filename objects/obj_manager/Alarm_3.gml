//event timer
//generate a random event each 20s
total_events++;
current_random_event_index=irandom_range(0,array_length(random_event_sprites)-1);

//The UFO event is so cool, Please uncomment below if you want to play this event right after the game starts
/*
if(total_events==1){
	current_random_event_index=3;
}*/

//start drawing the icon for 3 seconds before the event actually starts
random_event_icon_drawing=true;
audio_play_sound(warning,1,false);
alarm[4]=3*room_speed;


//restart this process, since each event takes 13 seconds, we give the restarting timer 33 seconds
alarm[3]=33*room_speed;
