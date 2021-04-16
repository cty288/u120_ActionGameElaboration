//random event: star rain
if(event_counter<=20){
	event_counter++;
	
	star_x=random_range(0,room_width-128);
	star_y = camera_get_view_y(view_camera[0])-100;
	instance_create_layer(star_x,star_y,"Instances",obj_star);
	
	alarm[5]=0.5*room_speed;
}else{
	event_counter=0;
}

