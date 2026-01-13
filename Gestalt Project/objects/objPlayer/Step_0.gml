//Creates the Integers for whether a key is being pressed
right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);

xspd = (right_key - left_key) * movespeed;
yspd = (down_key - up_key) * movespeed;

if !instance_exists(objPauseBox) && !instance_exists(objTextbox) &&keyboard_check_pressed(vk_escape)
{
	instance_create_depth(x, y, -9999, objPauseBox);
}
if instance_exists(objPauser)
{
	xspd = 0;
	yspd = 0;
	
}

//Collisions
if place_meeting(x + xspd, y, objTestwall) == true
{
    xspd = 0;
}
if place_meeting(x, y + yspd, objTestwall) == true
{
    yspd = 0;
}


//Flashlight
// Toggle flashlight
//Flashlight
if (keyboard_check_pressed(vk_shift))
{
    // create once
    if (!instance_exists(flashlight_inst))
    {
        flashlight_inst = instance_create_depth(x, y, -9999, objFlashlight);
        flashlight_inst.owner = id;

        // start OFF
        flashlight_inst.enabled = false;
        flashlight_inst.Visible = false;
        flashlight_inst.image_alpha = 0;
        uls_set_light_animation(flashlight_inst, false);
    }

    // only allow turning ON if you have charge
    if (!flashlight_on && battery <= 0)
    {
        // optional click sound
        // audio_play_sound(sndClick, 1, false);
    }
    else
    {
        flashlight_on = !flashlight_on;
    }
}

var dt = delta_time / 1000000; // seconds

// Drain / recharge
if (flashlight_on)
{
    battery = max(0, battery - drain_per_sec * dt);

    if (battery <= 0)
    {
        battery = 0;
        flashlight_on = false;
    }
}
else
{
    battery = min(battery_max, battery + recharge_per_sec * dt);
}

// Apply flashlight output EVERY frame (prevents lingering surface glow)
if (instance_exists(flashlight_inst))
{
    if (flashlight_on)
    {
        flashlight_inst.enabled = true;
        flashlight_inst.Visible = true;

        // base brightness
        var a = flashlight_inst.on_alpha;

        // low battery flicker
        if (battery <= 15)
        {
            a = (irandom(10) == 0) ? 0.2 : a;
        }

        flashlight_inst.image_alpha = a;
        uls_set_light_animation(flashlight_inst, false);
        uls_set_light_color(flashlight_inst, flashlight_inst.warm_col);
    }
    else
    {
        flashlight_inst.enabled = false;

        // IMPORTANT: controller checks Visible + uses image_alpha
        flashlight_inst.Visible = false;
        flashlight_inst.image_alpha = 0;

        uls_set_light_animation(flashlight_inst, false);
    }
}

//set sprite
mask_index = sprite[DOWN];
if yspd == 0
	{
	if xspd > 0 {face = RIGHT};
	if xspd < 0 {face = LEFT};
	}
if xspd > 0 && face == LEFT {face = RIGHT};
if xspd < 0 && face == RIGHT {face = LEFT};
if xspd == 0
	{
	if yspd > 0 {face = DOWN};
	if yspd < 0 {face = UP};
	}
if yspd > 0 && face == UP {face = DOWN};
if yspd < 0 && face == DOWN {face = UP};
sprite_index = sprite[face];


//Adds the integer of speed for X & Y onto the X/Y position
x += xspd;
y += yspd;



//animate
if xspd == 0 && yspd == 0
	{
		image_index = 0;
	}
	
global.flashlight_on = flashlight_on;
global.battery = battery;

depth = -bbox_bottom;