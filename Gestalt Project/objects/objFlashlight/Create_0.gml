event_inherited(); 

owner   = noone;
enabled = true;

// “On” settings (prevents the light staying off after toggle)
on_alpha = 0.7;
on_anim  = true; 

// Warm colour (tweak values if you want)
warm_col = make_color_rgb(255, 180, 130);

// Apply initial colour + ensure animation state
uls_set_light_color(id, warm_col);
uls_set_light_animation(id, on_anim);
