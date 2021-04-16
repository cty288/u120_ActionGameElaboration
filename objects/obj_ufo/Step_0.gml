if(this_state==ufo_state.idle){
	target_y=camera_get_view_y(view_camera[0])-500;
	if(y<=camera_get_view_y(view_camera[0])-450){
		target_x=room_width/2-256;
	}
	sprite_index=spr_ufo;
}

if(this_state=ufo_state.start_falling){
	target_y=camera_get_view_y(view_camera[0])-100;
	target_x=room_width/2-256;
	sprite_index=spr_ufo;
}

if(this_state==ufo_state.moving){
	target_y=camera_get_view_y(view_camera[0])-100;
	target_x+=x_speed*move_dir;
	
	if(target_x>room_width-512){
		target_x=room_width-512;
	}
	if(target_x<0){
		target_x=0;
	}
	change_direction_timer++;
	if(change_direction_timer>=change_direction_time){
		change_direction_timer=0;
		change_direction_time=random_range(1*room_speed,3*room_speed);
		move_dir*=-1;
	}
	sprite_index=spr_ufo_open;
}

y=lerp(y,target_y,0.05);
x=lerp(x,target_x,0.1);