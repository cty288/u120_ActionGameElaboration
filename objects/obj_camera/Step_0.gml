p1 = instance_find(obj_player_1,0);
p2 = instance_find(obj_player_2,0);

if(obj_manager.current_state!=game_state.finished){
	if(p1!=noone && p2!=noone){
	if(p1.player_state==state.alive || p2.player_state==state.alive){ // alive
		target_cam_y -= camera_move_speed;
		global.height+=camera_move_speed*0.01;
	}
}else{
	target_cam_y = room_height/3;
}

camera_move_speed=2+global.height*0.015;
if(camera_move_speed>=5.5){
	camera_move_speed=5.5;
}
//lerp
camera_set_view_pos(view_camera[0],0+irandom_range(-10,10),lerp(camera_get_view_y(view_camera[0]+irandom_range(-10,10)),target_cam_y,0.05));
}
