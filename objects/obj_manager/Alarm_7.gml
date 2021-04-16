//random event: coin rain
if(event_counter<=40){
	event_counter++;
	
	coin_x=random_range(0,room_width-128);
	coin_y = camera_get_view_y(view_camera[0])-100;
	coin = instance_create_layer(coin_x,coin_y,"Instances",obj_coin);
	coin.falling=true;
	
	alarm[7]=0.25*room_speed;
}else{
	event_counter=0;
}



