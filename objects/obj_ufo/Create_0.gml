/// @description Insert description here
// You can write your code in this editor
enum ufo_state{
	idle,
	start_falling,
	moving
}

this_state=ufo_state.idle;

target_y=camera_get_view_y(view_camera[0])-450;
target_x=room_width/2-256;

x_speed=2;
move_dir=1;
change_direction_timer=0;
change_direction_time=random_range(1*room_speed,3*room_speed);

