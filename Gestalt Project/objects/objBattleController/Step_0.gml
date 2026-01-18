switch (state)
{
    case BSTATE.INTRO:
        state = BSTATE.PLAYER_MENU;
    break;

    case BSTATE.PLAYER_MENU:
        // Navigate
        if (keyboard_check_pressed(vk_up))   menu_index = (menu_index + 3) mod 4;
        if (keyboard_check_pressed(vk_down)) menu_index = (menu_index + 1) mod 4;

        if (keyboard_check_pressed(vk_enter))
        {
            // Resolve selection
            state = BSTATE.PLAYER_RESOLVE;
        }
    break;

    case BSTATE.PLAYER_RESOLVE:
        if (menu_index == 0) // ATTACK
        {
            var pl = objPlayer; // your player instance
            var dmg = pl_get_atk(pl);
            enemy.hp -= dmg;

            // ATTACK lowers mental state
            pl.mental_state = clamp(pl.mental_state - 6, 0, pl.mental_max);
        }
        else if (menu_index == 1) // TALK
        {
            enemy.mercy += 20; // tune this
        }
        else if (menu_index == 2) // USE
        {
            // You’d open an item picker, then call inv_use(id, pl, id)
            // For now just example:
            // inv_use("medkit", objPlayer, id);
        }
        else if (menu_index == 3) // RUN
        {
            if (irandom(99) < 40) { state = BSTATE.WIN; break; } // escape success
        }

        if (enemy.hp <= 0 || enemy.mercy >= 100) { state = BSTATE.WIN; break; }

        // Start enemy attack
        make_seq(5);
        array_resize(input_seq, 0);
        telegraph_timer = 0;
        state = BSTATE.ENEMY_TELEGRAPH;
    break;

    case BSTATE.ENEMY_TELEGRAPH:
        telegraph_timer++;
        if (telegraph_timer >= telegraph_time)
        {
            state = BSTATE.ENEMY_INPUT;
        }
    break;

    case BSTATE.ENEMY_INPUT:
        // Collect arrow inputs
        var got = -1;
        if (keyboard_check_pressed(vk_up))    got = DIR.U;
        if (keyboard_check_pressed(vk_right)) got = DIR.R;
        if (keyboard_check_pressed(vk_down))  got = DIR.D;
        if (keyboard_check_pressed(vk_left))  got = DIR.L;

        if (got != -1)
        {
            var n = array_length(input_seq);
            array_resize(input_seq, n + 1);
            input_seq[n] = got;

            if (array_length(input_seq) >= array_length(seq))
            {
                state = BSTATE.ENEMY_RESOLVE;
            }
        }
    break;

    case BSTATE.ENEMY_RESOLVE:
        var mistakes = 0;
        for (var i = 0; i < array_length(seq); i++)
        {
            if (input_seq[i] != seq[i]) mistakes++;
        }

        // Damage scaling: more mistakes = more damage taken
        var pl2 = objPlayer;
        var base = enemy.atk;
        var mult = lerp(0.2, 1.0, mistakes / max(1, array_length(seq))); // perfect -> 20% dmg
        var dmg_taken = max(1, floor(base * mult) - pl_get_def(pl2));

        pl2.hp -= dmg_taken;

        if (pl2.hp <= 0) { state = BSTATE.LOSE; break; }

        state = BSTATE.PLAYER_MENU;
    break;
}
