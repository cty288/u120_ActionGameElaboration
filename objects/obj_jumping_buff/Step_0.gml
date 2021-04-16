/// @description Insert description here
// You can write your code in this editor
image_alpha-=0.004;
if(image_alpha<=0.7){
	twinkle_timer++;
	if(twinkle_timer>=0.2*room_speed){
		twinkle_timer=0;
		visible=!visible;
	}
}
if(image_alpha<=0){
	instance_destroy();
}