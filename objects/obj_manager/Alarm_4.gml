/// @description Insert description here
// You can write your code in this editor
random_event_icon_drawing=false;

//start random event
switch(current_random_event_index){
	case 0: //star rain
	alarm[5]=0.1*room_speed;
	break;
	case 1: //cloud falling
	alarm[6]=0.1*room_speed;
	break;
	case 2: //coin rain
	alarm[7]=0.1*room_speed;
	break;
	case 3: //ufo
	alarm[8]=0.1*room_speed;
	break;
}