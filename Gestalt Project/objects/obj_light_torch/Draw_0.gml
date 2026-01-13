/// @description Alter

// Inherit the parent event (ULS drawing)
event_inherited();

// If this light is off (or we don't want extra glow), don't draw the torch glow/flicker
if (!draw_extra_glow) exit;
if (!(Visible && visible && image_alpha > 0)) exit;

// Draw brilho
gpu_set_blendmode(bm_add);

var v_radius = 145 * random_range(0.995, 1.005);
var v_alpha  = 0.2;

draw_set_alpha(v_alpha);
draw_circle_color(x, y, v_radius, make_color_rgb(255, 238, 53), c_black, 0);

v_radius = 95;
v_alpha  = 0.2 + random_range(0, 0.002);

draw_set_alpha(v_alpha);
draw_circle_color(x, y, v_radius, make_color_rgb(255, 237, 178), c_black, 0);

draw_set_alpha(1);

// Only flicker alpha while actually ON
if (irandom(4) == 1)
{
    uls_set_light_alpha(self, 0.6 * random_range(0.93, 1.06));
}

gpu_set_blendmode(bm_normal);