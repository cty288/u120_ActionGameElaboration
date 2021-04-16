/// @description Insert description here
// You can write your code in this editor
if(falling){
	y_speed+=this_gravity;
	y+=y_speed;
}

delete_in--;
if(delete_in==0){
	instance_destroy();
}

change_size_timer++;

if(size<=2 && is_intact){
	if(change_size_timer>=change_size_time){
		
		change_size_time=random_range(0.5,2)*room_speed;
		change_size_timer=0;
		size++;
		
		sprite_index=intact_sprites[size];
		image_speed=1;
		image_index=0;
	}
}

if(y>camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])+10){
	instance_destroy();
}