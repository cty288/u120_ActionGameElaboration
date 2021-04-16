enum game_state{
	starting,
	ready,
	ongoing,
	finished
}

randomize();
total_events=0;

time_respawn=0;
current_state=game_state.starting;
global.height=20;

max_platforms=20;
initial_platform=5;

props[0]=obj_coin;
props[1]=obj_heart;
props[2]=obj_shield;
props[3]=obj_jumping_buff;

platform[0]=obj_platform;
platform[1]=obj_platform_jumping;
platform[2]=obj_platform_switching;

platform_initial_min_height=room_height-600
platform_initial_max_height=room_height-100;

current_platform=0;

platform_generate_time = random_range(0.5*room_speed,1*room_speed);
platform_generate_timer = 0;

//increase the platform generation time gap for each 20 seconds, until this variable reach 0.5
platform_generate_time_offset=0;
invincible_image_twinkle_timer_p1=0;
invincible_image_twinkle_timer_p2=0;
twinkle_on_p1=true;
twinkle_on_p2=true;
reward=false;
ending_alpha=0;
starting_alpha=1;
starting_enter_pressed=false;

random_event_sprites[0]=spr_random_event_star_rain_warning;
random_event_sprites[1]=spr_random_event_cloud_falling_warning;
random_event_sprites[2]=spr_random_event_coin_rain_sign;
random_event_sprites[3]=spr_random_event_ufo_warning;

current_random_event_index=-1;
random_event_icon_drawing=false;
random_event_drawing_timer=0;
icon_drawing_alpha=0;
event_counter=0;

bg_color_normal=make_color_rgb(0,182,255);
bg_color_ufo=make_color_rgb(154,86,173);
target_color=bg_color_normal;

layer_background_blend(4,bg_color_normal);
ufo=instance_find(obj_ufo,0);

tips[0]="The heart item can give you an extra life!";
tips[1]="Collect boot items to jump higher! You can own 5 boots at maximum, but you will lose one when you die";
tips[2]="Look out! There are some random events in the game!";
tips[3]="Never touch the stars. Believe me.";
tips[4]="You can jump much higher on the yellow cloud!";
tips[5]="Have you seen those twinkling clouds? You can only jump on it when your shirt has the same color as its color."
tips[6]="When the twinkling cloud is switching its color, anyone can jump on it!"
tips[7]="Don't be afraid! You are invincible for a short time when you respawn";
tips[8]="The shield can make you invincible for a short time! However, you will lose it once it protects you from falling out of the game";
tips[9]="Jump on your opponent's head and give him a big punch!";
tips[10]="For every 100 meters you climb, you gain an extra life!";
tips[11]="When you are inside the UFO's beam, you will be pulled upward towards it!";
tips[12]="When you see the UFO, never move close to it!";

tip_index = irandom_range(0,array_length(tips)-1);

function Initialization(){
	alarm[1]=20*room_speed;

	var spawn_x = random_range(0,room_width - 64);
	var spawn_y = 3000;

	instance_create_layer(spawn_x,spawn_y,"Instances",obj_player_1);
	instance_create_layer(spawn_x,spawn_y,"Instances",obj_player_2);

	//Spawn some platforms at the beginning of the game
	alarm[0] = 0.1*room_speed;
	
	
	
	//event timer
	alarm[3] = 10*room_speed;


}



function SpawnPlatforms(number,min_height,max_height){
	for(var i=0; i<number;i++){
		var spawn_x = random_range(64,room_width - 64);
		var spawn_y = random_range(min_height,max_height);
		
		//select a platform
		var random_index=irandom_range(0,99);
		var platform_chosen=noone;
		if(0<=random_index && random_index<90){ //90% chance to generate a normal platform
			platform_chosen=platform[0]
		}else if(90<=random_index && random_index<95){ //5% chance to generate a switching color platform
			platform_chosen=platform[2];
		}else{ //5% chance to generate a jumping buff platform
			platform_chosen=platform[1];
		}
	
		var new_platform = instance_create_layer(spawn_x, spawn_y, "Objects", platform_chosen);
		var attempts=0;
		
		with(new_platform){
			while((collision_rectangle(x-256,y-180,x,y,obj_platform,true,true)!=noone ||
			collision_rectangle(x,y-180,x+256,y,obj_platform,true,true)!=noone ||
			collision_rectangle(x-256,y+180,x,y,obj_platform,true,true)!=noone || 
			collision_rectangle(x,y,x+256,y+180,obj_platform,true,true)!=noone) &&
			attempts <1000){
				 x = random_range(64,room_width - 64);
				 y = random_range(min_height,max_height);
				 attempts++;
				 
				 if(attempts==1000){
					instance_destroy();
				 }
			}
		}
		
		if(attempts<1000){
			//generate a prop by chance
			var is_generate=irandom_range(0,100);
				if(is_generate<=10){ //10% chance to generate a prop
					var pop_gen =irandom_range(0,100);
					//coin: 40%. heart: 30%, invincible: 15% jumping buff: 15%
					if(0<=pop_gen && pop_gen<40){ //coin
						instance_create_layer(new_platform.x,new_platform.y+40,"Objects",props[0]);
					}else if(40<=pop_gen && pop_gen<70){ //heart
						instance_create_layer(new_platform.x-40,new_platform.y-32,"Objects",props[1]);
					}else if(70<=pop_gen && pop_gen<85){ //shield
						instance_create_layer(new_platform.x-40,new_platform.y-32,"Objects",props[2]);
					}else if(85<=pop_gen && pop_gen<=100){ //jumping buff; will not be generated when both players alrady had 5 buffs
						if(p1.jumping_buff<5 || p2.jumping_buff<5){
							instance_create_layer(new_platform.x-40,new_platform.y-32,"Objects",props[3]);
						}
					}
				
					
				}
		}
	}

}

