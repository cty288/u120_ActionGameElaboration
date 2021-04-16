//random event: cloud falling
if(event_counter<=10){
	event_counter++;
	
	
	if(instance_number(obj_platform)>0){
		cloud=instance_find(obj_platform,irandom_range(0,instance_number(obj_platform)-1));
		while(!cloud.is_intact){
			cloud=instance_find(obj_platform,irandom_range(0,instance_number(obj_platform)-1));
		}
		audio_play_sound(cloud_fall,1,false);
		cloud.falling=true;
	}
	alarm[6]=random_range(0.5*room_speed,1.5*room_speed);
	
}else{
	event_counter=0;
}

