//ufo start falling
target_color=bg_color_ufo;
ufo.this_state=ufo_state.start_falling;

audio_play_sound(ufo_landing,2,false);
audio_play_sound(ufo_bgm,2,false);


audio_pause_sound(Bananana_Gameplay_B);
alarm[9]=2*room_speed;