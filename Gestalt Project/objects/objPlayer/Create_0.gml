//Variable to dictate the speed of the player
xspeed = 0;
yspeed = 0;
movespeed = 1;

//Creates arrays for each direction
sprite[RIGHT] = sprPlayer_Right;
sprite[UP] = sprPlayer_Up;
sprite[LEFT] = sprPlayer_Left;
sprite[DOWN] = sprPlayer_Down;

face = DOWN;

//Flashlight (now a lighter) 
battery_max = 100;
battery     = battery_max;

// Full lasts 60s, empty->full in 2s
drain_per_sec    = battery_max / 60; // ~1.6667 per sec
recharge_per_sec = battery_max / 2;  // 50 per sec

if (!variable_global_exists("flashlight_on")) global.flashlight_on = false;
if (!variable_global_exists("battery"))       global.battery = 100;

flashlight_on = global.flashlight_on;
battery       = global.battery;

flashlight_inst = noone;

hp_max = 100;
hp = hp_max;

scrInvInit();
inv_add("pie", 1);
inv_add("bandage", 1);
