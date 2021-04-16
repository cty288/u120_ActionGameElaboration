
// Inherit the parent event
event_inherited();

pf_type=cloud_type.switching_color;


colors[0]=c_blue;
colors[1]=make_color_rgb(109,255,91);

var index=irandom_range(0,1);

sw_state=index; //0: blue, 1: green, 2:switching
current_color=colors[index];

counter=0;
image_blend=current_color;


alarm[0]=random_range(0*room_speed,3*room_speed);