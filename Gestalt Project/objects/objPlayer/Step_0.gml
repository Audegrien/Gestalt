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

//Collisions
if place_meeting(x + xspd, y, objTestwall) == true
	{
		xspd = 0;
	}
if place_meeting(x, y + yspd, objTestwall) == true
	{
		yspd = 0;
	}

//Adds the integer of speed for X & Y onto the X/Y position
x += xspd;
y += yspd;



//animate
if xspd == 0 && yspd == 0
	{
		image_index = 0;
	}
	
depth = -bbox_bottom;