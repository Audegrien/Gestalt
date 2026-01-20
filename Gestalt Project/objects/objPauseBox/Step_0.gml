// objPauseBox: Step

// -------------------- INPUT --------------------
up_key     = keyboard_check_pressed(vk_up);
down_key   = keyboard_check_pressed(vk_down);
left_key   = keyboard_check_pressed(vk_left);
right_key  = keyboard_check_pressed(vk_right);

accept_key = keyboard_check_released(vk_space);
back_key   = keyboard_check_pressed(vk_escape);

// -------------------- MENUS 0/1 (Pause + Settings) --------------------
if (menu_level == 0 || menu_level == 1)
{
    // store number of options in current menu
    op_length = array_length(option[menu_level]);

    // cycle through the options
    pos += down_key - up_key;
    if (pos >= op_length) pos = 0;
    if (pos < 0) pos = op_length - 1;

    // using the options
    if (accept_key)
    {
        var _sml = menu_level;

        switch (menu_level)
        {
            // pause menu
            case 0:
                switch (pos)
                {
                    // Resume
                    case 0:
                        instance_destroy();
                    break;

                    // Inventory
                    case 1:
                        menu_level = 2;
                        inv_dirty = true;
                        pos = 0;
                    break;

                    // Character
                    case 2:
                        menu_level = 3;
                        pos = 0;
                    break;

                    // Options / Settings
                    case 3:
                        menu_level = 1;
                    break;

                    // Quit Game
                    case 4:
                        game_end();
                    break;
                }
            break;

            // settings menu
            case 1:
                switch (pos)
                {
                    // Fullscreen
                    case 0:
                        window_set_fullscreen(!window_get_fullscreen());
                    break;

                    // Brightness
                    case 1:
                        // TODO
                    break;

                    // Controls
                    case 2:
                        // TODO
                    break;

                    // Back
                    case 3:
                        menu_level = 0;
                    break;
                }
            break;
        }

        if (_sml != menu_level) pos = 0;

        // correct option length
        if (menu_level == 0 || menu_level == 1)
        {
            op_length = array_length(option[menu_level]);
        }
    }

    // Back key from settings returns to pause menu
    if (back_key && menu_level == 1)
    {
        menu_level = 0;
        pos = 0;
        op_length = array_length(option[menu_level]);
    }

    // Done for 0/1
    exit;
}
// -------------------- MENU 2 (Inventory) --------------------
if (menu_level == 2)
{
    // textbox owns input
    if (instance_exists(objTextbox)) exit;

    var invCount = inv_count();

    // clamp selection
    if (invCount > 0) pos = clamp(pos, 0, invCount - 1);
    else pos = 0;

    // basic scroll safety (even though max is 8)
    if (pos < inv_scroll) inv_scroll = pos;
    if (pos >= inv_scroll + inv_visible) inv_scroll = pos - inv_visible + 1;

    // BACK always returns to pause menu from list, or back to list from actions
    if (back_key)
    {
        if (inv_mode == 1) { inv_mode = 0; exit; }
        menu_level = 0;
        pos = 0;
        inv_mode = 0;
        exit;
    }

    if (inv_mode == 0)
    {
        // list navigation
        if (invCount > 0)
        {
            pos += down_key - up_key;
            if (pos >= invCount) pos = 0;
            if (pos < 0) pos = invCount - 1;
        }

        // open actions
        if (accept_key)
        {
            if (invCount <= 0)
            {
                create_textbox("INV|EMPTY");
            }
            else
            {
                inv_mode = 1;
                inv_action_pos = 0;
            }
        }
    }
    else // inv_mode == 1 (actions)
    {
        // action navigation
        var aLen = array_length(inv_actions);
        inv_action_pos += down_key - up_key;
        if (inv_action_pos >= aLen) inv_action_pos = 0;
        if (inv_action_pos < 0) inv_action_pos = aLen - 1;

        if (accept_key && invCount > 0)
        {
			var entry = inv_get(pos);
			var item_id = entry.id;
			var def = global.ItemDB[$ item_id];
			var choice = inv_actions[inv_action_pos];

			if (choice == "Info")
			{
			    create_textbox("INV|INFO|" + item_id);
			}
			else if (choice == "Discard")
			{
			    create_textbox("INV|DISCARD|" + item_id);
			    inv_mode = 0;
			}
			else if (choice == "Use")
			{
			    var p = instance_find(objPlayer, 0);
			    var ok = true;

			    if (is_callable(def.useFn)) ok = def.useFn(p);
			    if (ok)
			    {
			        if (def.consumable) inv_remove_at(pos, 1);
			        create_textbox("INV|USED|" + item_id);
			    }
			    else
			    {
			        create_textbox("INV|EMPTY"); // swap later if you want “It won’t work.”
			    }

			    inv_mode = 0;
			}
			else // Cancel
			{
			    inv_mode = 0;
			}

            }
        }

    exit;
}
