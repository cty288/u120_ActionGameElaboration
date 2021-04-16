
draw_set_alpha(1);



draw_set_font(font_gui);

draw_set_halign(fa_middle);
//background_color=c_black;
if(current_state!=game_state.starting){
	if(current_state!=game_state.finished){
		var height_color= (global.height>=350)?c_red:c_white;
		
		draw_text_transformed_color(room_width/2,30,"Height: "+string(global.height)+"m",1.5,1.5,0,height_color,height_color,height_color,height_color,1);
	if(global.height%100<=5){
		draw_sprite(spr_reward_life,0,room_width/2-128,80);
	}
	
	if(random_event_icon_drawing){
		random_event_drawing_timer++;
		if(random_event_drawing_timer>=0.3*room_speed){
			random_event_drawing_timer=0;
			icon_drawing_alpha= icon_drawing_alpha==0?1:0;
			
		}
		draw_sprite_ext(random_event_sprites[current_random_event_index],0,room_width/2-64,100,1,1,0,c_white,icon_drawing_alpha);
	}


	draw_set_halign(fa_left);

	if(p1.player_state==state.alive){
		draw_sprite_ext(spr_player1_profile_pic,0,10,10,2,2,0,c_white,1);
	}else{
		if(current_state==game_state.ongoing){
			draw_sprite_ext(spr_player1_profile_pic_die,0,10,10,2,2,0,c_white,1);
		}
	
	}

	draw_sprite(spr_coin,0,180,64);
	if(p1.invincible){
		if(p1.invincible_timer>=3*room_speed){
			draw_sprite_ext(spr_shield,0,20,20,0.8,0.8,0,c_white,0.8);
		}else{
			invincible_image_twinkle_timer_p1++;
			if(invincible_image_twinkle_timer_p1>=0.2*room_speed){
				invincible_image_twinkle_timer_p1=0;
				twinkle_on_p1=!twinkle_on_p1;
			}
			draw_sprite_ext(spr_shield,0,20,20,0.8,0.8,0,c_white,twinkle_on_p1?0.8:0);
		}
	}
	if(p1.invincible_buff_disappear_effect_timer>0){
		draw_sprite_ext(spr_invincible_lose,0,20,20,0.8,0.8,0,c_white,0.8);
	}

	for(var i=0; i<p1.jumping_buff;i++){
		draw_sprite_ext(spr_jumping_buff,0,10+50*i,140,0.4,0.4,0,c_white,0.8);
	}
	draw_text_transformed_color(218,0,"x"+string(p1.coin),1.5,1.5,0,c_blue,c_blue,c_blue,c_blue,1);

	draw_sprite(spr_heart,0,148,64);

	draw_text_transformed_color(218,64,"x"+string(p1.player_life),1.5,1.5,0,c_blue,c_blue,c_blue,c_blue,1);

	draw_set_halign(fa_right);
	draw_sprite(spr_coin,0,room_width-170-64-32,64);
	if(p2.player_state==state.alive){
		draw_sprite_ext(spr_player2_profile_pic,0,room_width-128,10,2,2,0,c_white,1);
	}else{
		if(current_state==game_state.ongoing){
			draw_sprite_ext(spr_player2_profile_pic_die,0,room_width-128,10,2,2,0,c_white,1);
		}
	
	}

	if(p2.invincible){
		if(p2.invincible_timer>=3*room_speed){
			draw_sprite_ext(spr_shield,0,room_width-115,20,0.8,0.8,0,c_white,0.8);
		}else{
			invincible_image_twinkle_timer_p2++;
			if(invincible_image_twinkle_timer_p2>=0.2*room_speed){
				invincible_image_twinkle_timer_p2=0;
				twinkle_on_p2=!twinkle_on_p2;
			}
			draw_sprite_ext(spr_shield,0,room_width-115,20,0.8,0.8,0,c_white,twinkle_on_p2?0.8:0);
		}
	}
	if(p2.invincible_buff_disappear_effect_timer>0){
		draw_sprite_ext(spr_invincible_lose,0,room_width-115,20,0.8,0.8,0,c_white,0.8);
	}

	for(var i=0; i<p2.jumping_buff;i++){
		draw_sprite_ext(spr_jumping_buff,0,room_width-50-50*i,140,0.4,0.4,0,c_white,0.8);
	}

	draw_text_transformed_color(window_get_width()-138,0,"x"+string(p2.coin),1.5,1.5,0,c_green,c_green,c_green,c_green,1);

	draw_sprite(spr_heart,0,room_width-170-64-64,64);
	draw_text_transformed_color(window_get_width()-138,64,"x"+string(p2.player_life),1.5,1.5,0,c_green,c_green,c_green,c_green,1);
	}else{ //game end
		ending_alpha+=0.01;
		draw_set_alpha(ending_alpha);
		draw_rectangle_color(-10,-10,2000,2000,c_black,c_black,c_black,c_black,c_black);
	
		var winner=noone;
		var winner_sprite=noone;
		if(global.height>=400 && p1.coin!=p2.coin){
			if(p1.coin>p2.coin){
				winner=p1;
				winner_sprite=spr_player1_fall_left;
			}else{
				winner=p2;
				winner_sprite=spr_player2_fall_left;
			}
		
			draw_sprite(winner_sprite,0,room_width/2-64, 500-100);
			draw_text_transformed_color(room_width/2,500/2+290,"Wins",1,1,0,c_white,c_white,c_white,c_white,1);
		
			draw_text_transformed_color(room_width/2,500/2+360,"You owns more coins than your opponent when you reached 400m",1,1,0,c_white,c_white,c_white,c_white,1);
		}else{
			if(p1.player_life<=0){
				winner=p2;
				winner_sprite=spr_player2_fall_left;
			}else{
				winner=p1;
				winner_sprite=spr_player1_fall_left;
			}
		
			draw_sprite(winner_sprite,0,room_width/2-64, 500-100);
			draw_text_transformed_color(room_width/2,500/2+290,"Wins",2,2,0,c_white,c_white,c_white,c_white,1);
			draw_text_transformed_color(room_width/2,500/2+390,"Your opponent lost all lives",1,1,0,c_white,c_white,c_white,c_white,1);
		}
	
		draw_text_transformed_color(room_width/2,500/2+700,"Press R to restart the game",0.6,0.6,0,c_white,c_white,c_white,c_white,1);
}

}else{
	draw_set_alpha(starting_alpha);
	//draw_rectangle_color(-10,-10,2000,2000,c_black,c_black,c_black,c_black,c_black);
	draw_sprite(spr_cloud_jumper,0,0,0);
	
	draw_text_ext_transformed_color(room_width/2,500/2+670,"tips: "+tips[tip_index],50,1600,0.6,0.6,0,c_black,c_black,c_black,c_black,starting_alpha);
	if(starting_enter_pressed){
		starting_alpha-=0.01;
	}
	
}
