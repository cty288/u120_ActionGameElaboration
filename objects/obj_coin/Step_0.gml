/// @description Insert description here
// You can write your code in this editor
if(falling){
	y_speed+=this_gravity;
	y+=y_speed;
}


if(y>camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])+10){
	instance_destroy();
}