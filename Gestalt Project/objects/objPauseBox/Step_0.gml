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
    // Back to pause menu
    if (back_key)
    {
        menu_level = 0;
        pos = 0;
        op_length = array_length(option[menu_level]);
        exit;
    }

    // Tab switching
    if (right_key)
    {
        inv_tab = (inv_tab + 1) mod 4;
        inv_dirty = true;
        pos = 0;
    }
    if (left_key)
    {
        inv_tab = (inv_tab + 3) mod 4;
        inv_dirty = true;
        pos = 0;
    }

    // Rebuild cache if needed
    if (inv_dirty)
    {
        inv_cache = scrInvBuildCache(inv_tab);
        inv_dirty = false;
        pos = 0;
    }

    var count = array_length(inv_cache);

    // Move selection within current tab list
    if (count > 0)
    {
        pos += down_key - up_key;
        if (pos >= count) pos = 0;
        if (pos < 0) pos = count - 1;
    }
    else
    {
        pos = 0;
    }

    // Use / Equip
    if (accept_key && count > 0)
    {
        var inv_index = inv_cache[pos];
        var e = global.inv[| inv_index];

        var pl = instance_exists(objPlayer) ? instance_find(objPlayer, 0) : noone;

        switch (inv_tab)
        {
            case 0: // Consumables
                // Apply effect
                if (pl != noone)
                {
                    switch (e.id)
                    {
                        case "Medkit":
                            pl.hp = clamp(pl.hp + 25, 0, pl.hp_max);
                        break;
                    }
                }

                // Consume 1
                e.qty -= 1;
                if (e.qty <= 0) ds_list_delete(global.inv, inv_index);
                else global.inv[| inv_index] = e;

                inv_dirty = true;
            break;

            case 1: // Key Items
                // Inspect-only for now (no action)
            break;

            case 2: // Weapons
                if (pl != noone) pl.equip_weapon = e.id;
            break;

            case 3: // Armour
                if (pl != noone) pl.equip_armor = e.id;
            break;
        }
    }

    exit;
}

// -------------------- MENU 3 (Character/Stats) --------------------
if (menu_level == 3)
{
    // ESC or SPACE to go back
    if (back_key || accept_key)
    {
        menu_level = 0;
        pos = 0;
        op_length = array_length(option[menu_level]);
    }

    exit;
}
