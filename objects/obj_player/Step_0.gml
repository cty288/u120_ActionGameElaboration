//sprite_width=128;
//sprite_height=128;
if(obj_manager.current_state!=game_state.finished){
	jump_vel=-28-2.5*jumping_buff;

die_buff_disappear_effect_timer--;
invincible_buff_disappear_effect_timer--;

y_speed += player_gravity;

if(x+x_speed<0 ||x+x_speed>room_width-64){
	x_speed*=-1.2;
	remainder_x=0;
	move_x=0;
	if(!audio_is_playing(wall_bounce)){
		audio_play_sound(wall_bounce,1,false);
	}
	
}

x+=move_x;
y_speed += player_gravity;
x_speed*=0.9;

remainder_x+=x_speed;
remainder_y+=y_speed;

move_x=round(remainder_x);
move_y=round(remainder_y);

remainder_x-=move_x;
remainder_y-=move_y;

invincible_timer--;
if(invincible_timer>0){
	invincible=true;
	if(invincible_timer>=3*room_speed){
		image_blend=invincible_blend_color;
	}else{
		invincible_image_twinkle_timer++;
		if(invincible_image_twinkle_timer>=0.2*room_speed){
			invincible_image_twinkle_timer=0;
			image_blend= image_blend == make_color_rgb(255,255,255)?invincible_blend_color: make_color_rgb(255,255,255);
		}
	}
	
}else{
	invincible=false;
	image_blend=make_color_rgb(255,255,255);
	invincible_image_twinkle_timer=0;
}

if(player_state==state.dead){
	respawn_timer++;
	if(respawn_timer>=respawn_time){
		respawn_timer=0;
		respawn_time=random_range(1*room_speed,2*room_speed);
		player_state=state.alive;
		Respawn();
	}
}

var new_y = y+move_y;
for(var i=0; i<abs(move_y); i++){
	new_y = y + sign(move_y);
	var platform_collide_with = instance_place(x,new_y,obj_platform);
	//var player_collide_with = instance_place(x,new_y,obj_player);
	
	//hit the platform
	if(move_y>0 && !ufo_collison_enter){
		if(platform_collide_with!=noone){
			if(y<=platform_collide_with.y && platform_collide_with.is_intact && player_state==state.alive){
				if(platform_collide_with.pf_type==cloud_type.normal){
					y_speed=jump_vel;
					move_y=jump_vel;
					remainder_y=0;
					platform_collide_with.OnBounced();	
					audio_play_sound(cloud_bounce_01,1,false);
					y=new_y;
					break;
				}else if(platform_collide_with.pf_type==cloud_type.jumping){
					y_speed=jump_vel-12;
					move_y=jump_vel-12;
					remainder_y=0;
					platform_collide_with.OnBounced();	
					audio_play_sound(jump_cloud,1,false);
					y=new_y;
					break;
				}else if(platform_collide_with.pf_type==cloud_type.switching_color){
					var this_player=other_player.other_player;
					if(platform_collide_with.sw_state==0){ //p1
						if(this_player==obj_player_1){
							y_speed=jump_vel;
							move_y=jump_vel;
							remainder_y=0;
							platform_collide_with.OnBounced();	
							audio_play_sound(cloud_bounce_01,1,false);
							y=new_y;
							break;
						}
					}else if(platform_collide_with.sw_state==1){
						if(this_player==obj_player_2){
							y_speed=jump_vel;
							move_y=jump_vel;
							remainder_y=0;
							platform_collide_with.OnBounced();	
							audio_play_sound(cloud_bounce_01,1,false);
							y=new_y;
							break;
						}
					}else{
						y_speed=jump_vel;
						move_y=jump_vel;
						remainder_y=0;
						platform_collide_with.OnBounced();	
						audio_play_sound(cloud_bounce_01,1,false);
						y=new_y;
						break;
					}
				}
			}
		}
		
		if(y<other_player.y && player_state==state.alive && other_player.player_state==state.alive && other_player.invincible==false){
			if(other_player.y-y<=70 && abs(x-other_player.x)<=70){
				y_speed=jump_vel;
				move_y=jump_vel;
				remainder_y=0;
				y=new_y;
				other_player.player_state=state.dead;
				
				if(other_player.jumping_buff>0){
					other_player.jumping_buff--;
					other_player.die_buff_disappear_effect_timer=2*room_speed;
				}
				other_player.y_speed=15;
				other_player.player_life--;
				other_player.remainder_y=0;
				

				
				audio_play_sound(player_bounce,1,false);
				for(var i=0; i<irandom_range(1,3); i++){
					pos_x=random_range(other_player.x-64,other_player.x+192);
					pos_y=random_range(other_player.y,other_player.y+64);
					GenerateDeathEffect(pos_x,pos_y);
				}
				break;
			}
		}
		

			
	}
	y+=sign(move_y);
}

if(place_meeting(x,y,obj_ufo)&&player_state==state.alive && obj_ufo.this_state!=ufo_state.idle){
	if(y-obj_ufo.y<200){
		 if(!invincible){
			audio_play_sound(ufo__bounce,1,false);
			player_state=state.dead;
			if(other_player.jumping_buff>0){
			jumping_buff--;
			die_buff_disappear_effect_timer=2*room_speed;
			}
			player_life--;
			GenerateDeathEffect(x+64,y-80);
			y_speed=15;
			remainder_y=0;
		 }
		y_speed=0;
		//TODO: play a sound here
	}else{
		player_gravity=ufo_gravity;
		x_acc=ufo_x_acc;
		if(!ufo_collison_enter){
			ufo_collison_enter=true;
			y_speed*=0.1;
			remainder_y=0;
			
		}
	}
	
}else{
	 ufo_collison_enter=false;
	player_gravity=normal_gravity;
	x_acc=normal_x_acc;
}

SetAnimation();

if(y>camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])){
	if(player_state==state.alive){
		if(invincible){
			y_speed=jump_vel*2;
			move_y=jump_vel*2;
			remainder_y=0;
			//TODO: play another sound here
			audio_play_sound(bounce_bottom,1,false);
			y=new_y;
			alarm[0]=0.1*room_speed;
		}else{
			player_life--;
			if(jumping_buff>0){
				jumping_buff--;
				die_buff_disappear_effect_timer=2*room_speed;
			}
		
			GenerateDeathEffect(x+64,y-80);
			audio_play_sound(fall_out,1,false);
		}
		
	}
	if(!invincible){
		invincible_timer=0;
		remainder_x=0;
		remainder_y=0;
		player_state=state.dead;
	}
	
}
}
