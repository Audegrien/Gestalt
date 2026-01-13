event_inherited();

if (!instance_exists(owner)) { instance_destroy(); exit; }

// always follow / rotate
x = owner.x;
y = owner.y;

// Offset the light a few pixels in front of the player
var off_side = 6;
var off_up   = 10; // usually needs a bit more to avoid overlapping head/torso
var off_down = 6;

switch (owner.face)
{
    case RIGHT:
        x += off_side;
        break;

    case LEFT:
        x -= off_side;
        break;

    case DOWN:
        y += off_down;
        break;

    case UP:
        y -= off_up;
        break;
}

// hard control light output every frame
uls_set_light_animation(id, false); // animation changes alpha/size :contentReference[oaicite:1]{index=1}

if (owner.flashlight_on)
{
    uls_set_light_alpha(id, on_alpha);
    uls_set_light_color(id, warm_col);
}
else
{
    uls_set_light_alpha(id, 0);
}
