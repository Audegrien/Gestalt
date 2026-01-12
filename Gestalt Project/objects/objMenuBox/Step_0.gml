//Set the input keys
up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(vk_space);

//store number of options in current menu
op_length = array_length(option[menu_level])

//cycle through the options
pos += down_key - up_key;
if pos >= op_length {pos = 0};
if pos < 0 {pos = op_length-1};

//using the options
if accept_key {
	
	var _sml = menu_level;
	
	switch(menu_level)
	{
		//pause menu
		case 0:
		switch(pos)
		{
			
			//start game
			case 0: if !instance_exists(objWarp_1){var inst = instance_create_depth(0, 0, -999, objWarp_1)}; break;
			//settings
			case 1: menu_level = 1; break;
			//quit game
			case 2: game_end(); break;
		}
		break;
		
		case 1:
		switch(pos)
		{
			//Fullscreen
			case 0:
			if window_get_fullscreen(){
				window_set_fullscreen(false);
			} else{
				window_set_fullscreen(true);
			}
			
			
			break;
			//brightness
			case 1:
			
			break;
			//controls
			case 2:
			
			break;
			//back
			case 3:
			menu_level = 0;
			break
		}
	}
	if _sml != menu_level {pos = 0};
	
	//correct option length
	op_length = array_length(option[menu_level])
}