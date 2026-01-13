event_inherited();

owner = noone;
enabled = true;

warm_col = make_color_rgb(255, 150, 100);

on_alpha = 0.8;
on_anim  = false; // keep false unless you WANT flicker/size pulsing

// Force a stable starting state (prevents parent default animation fighting you)
uls_set_light_animation(id, false);
uls_set_light_alpha(id, on_alpha);
uls_set_light_color(id, warm_col);

draw_extra_glow = false;
light_animation = true;