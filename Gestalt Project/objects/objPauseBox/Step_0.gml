// objPauseBox: Step

// -------------------- INPUT --------------------
up_key     = keyboard_check_pressed(vk_up);
down_key   = keyboard_check_pressed(vk_down);
left_key   = keyboard_check_pressed(vk_left);
right_key  = keyboard_check_pressed(vk_right);

accept_key = keyboard_check_released(vk_space); // keep for menu 0/1
back_key   = keyboard_check_pressed(vk_escape);

// -------------------- GLOBAL SPACE LOCK --------------------
if (!variable_global_exists("ui_lock_space")) global.ui_lock_space = false;

// If locked, we block accepts until SPACE is fully up (and we consume that release frame)
if (global.ui_lock_space)
{
    if (keyboard_check(vk_space))
    {
        accept_key = false;
    }
    else
    {
        accept_key = false;
        global.ui_lock_space = false;
    }
}

// -------------------- MENUS 0/1 (Pause + Settings) --------------------
if (menu_level == 0 || menu_level == 1)
{
    op_length = array_length(option[menu_level]);

    pos += down_key - up_key;
    if (pos >= op_length) pos = 0;
    if (pos < 0) pos = op_length - 1;

    if (accept_key)
    {
        var _sml = menu_level;

        switch (menu_level)
        {
            case 0:
                switch (pos)
                {
                    case 0: instance_destroy(); break;

                    case 1:
                        menu_level = 2;
                        pos = 0;
                        inv_mode = 0;
                        inv_action_pos = 0;
                        inv_scroll = 0;

                        // prevent immediate accept after entering inventory
                        global.ui_lock_space = true;
                    break;

                    case 2:
                        menu_level = 3;
                        pos = 0;
                    break;

                    case 3:
                        menu_level = 1;
                    break;

                    case 4:
                        game_end();
                    break;
                }
            break;

            case 1:
                switch (pos)
                {
                    case 0: window_set_fullscreen(!window_get_fullscreen()); break;
                    case 1: /* TODO */ break;
                    case 2: /* TODO */ break;
                    case 3: menu_level = 0; break;
                }
            break;
        }

        if (_sml != menu_level) pos = 0;

        if (menu_level == 0 || menu_level == 1)
            op_length = array_length(option[menu_level]);
    }

    if (back_key && menu_level == 1)
    {
        menu_level = 0;
        pos = 0;
        op_length = array_length(option[menu_level]);
    }

    exit;
}

// -------------------- MENU 2 (Inventory) --------------------
if (menu_level == 2)
{
    // If a textbox exists, it owns input.
    // When it closes, we require SPACE to be released before inventory can accept again.
    if (instance_exists(objTextbox))
    {
        inv_tb_was_open = true;
        inv_accept_cooldown = max(inv_accept_cooldown, 3);
        exit;
    }

    // If textbox JUST closed, latch input
    if (inv_tb_was_open)
    {
        inv_tb_was_open = false;
        inv_accept_cooldown = max(inv_accept_cooldown, 3);
    }

    // Cooldown (prevents double/triple-fires)
    if (inv_accept_cooldown > 0)
    {
        inv_accept_cooldown--;
        exit;
    }

    // Inventory accept MUST be PRESSED (not released)
    var accept_inv = keyboard_check_pressed(vk_space);

    // Back behaviour
    if (back_key)
    {
        if (inv_mode == 1)
        {
            inv_mode = 0;
            inv_accept_cooldown = 3;
            exit;
        }

        menu_level = 0;
        pos = 0;
        inv_mode = 0;
        inv_accept_cooldown = 3;
        exit;
    }

    var invCount = inv_count();

    // Clamp selection
    if (invCount <= 0) pos = 0;
    else pos = clamp(pos, 0, invCount - 1);

    // Scroll
    if (pos < inv_scroll) inv_scroll = pos;
    if (pos >= inv_scroll + inv_visible) inv_scroll = pos - inv_visible + 1;

    // ---------------- LIST MODE ----------------
    if (inv_mode == 0)
    {
        if (invCount > 0)
        {
            pos += down_key - up_key;
            if (pos >= invCount) pos = 0;
            if (pos < 0) pos = invCount - 1;
        }

        if (accept_inv)
        {
            // Latch immediately so one press cannot open+trigger actions
            inv_accept_cooldown = 4;

            if (invCount <= 0)
            {
                create_textbox("INV|EMPTY");
                exit;
            }
            else
            {
                inv_mode = 1;
                inv_action_pos = 0;
                exit;
            }
        }

        exit;
    }

    // ---------------- ACTION MODE ----------------
    var aLen = array_length(inv_actions);
    inv_action_pos += down_key - up_key;
    if (inv_action_pos >= aLen) inv_action_pos = 0;
    if (inv_action_pos < 0) inv_action_pos = aLen - 1;

    if (accept_inv)
    {
        // Latch immediately so one press can never execute twice
        inv_accept_cooldown = 5;

        if (invCount <= 0)
        {
            inv_mode = 0;
            exit;
        }

        var entry = inv_get(pos);
        var item_id = entry.id;
        var def = global.ItemDB[$ item_id];
        var choice = inv_actions[inv_action_pos];

        if (choice == "Cancel")
        {
            inv_mode = 0;
            exit;
        }

        if (choice == "Info")
        {
            create_textbox("INV|INFO|" + item_id);
            inv_mode = 0;
            exit;
        }

        if (choice == "Discard")
        {
            create_textbox("INV|DISCARD|" + item_id);
            inv_mode = 0;
            exit;
        }

        if (choice == "Use")
        {
            var p = instance_find(objPlayer, 0);
            var ok = true;
            if (is_callable(def.useFn)) ok = def.useFn(p);

            if (ok)
            {
				if (def.consumable)
				{
				    if (!variable_global_exists("inv_action_guard")) global.inv_action_guard = false;

				    if (!global.inv_action_guard)
				    {
				        global.inv_action_guard = true;
				        inv_remove_at(pos, 1);
				    }

				    invCount = inv_count();
				    if (invCount <= 0) pos = 0;
				    else pos = clamp(pos, 0, invCount - 1);
				}
                create_textbox("INV|USED|" + item_id);
            }
            else
            {
                create_textbox("INV|EMPTY");
            }

            inv_mode = 0;
            exit;
        }
    }

    exit;
}
