// objPauseBox: Draw

draw_set_font(global.font_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_alpha(1);
draw_set_color(c_white);
gpu_set_blendmode(bm_normal);

// Center reference
var cx = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
var cy = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;

// -------------------- PAUSE + SETTINGS (menu_level 0/1) --------------------
if (menu_level == 0 || menu_level == 1)
{
    // dynamically get width and height of menu
    var _new_w = 0;
    for (var i = 0; i < op_length; i++)
    {
        var _op_w = string_width(option[menu_level, i]);
        _new_w = max(_new_w, _op_w);
    }
    width  = _new_w + op_border * 2;
    height = op_border * 2 + string_height(option[0, 0]) + (op_length - 1) * op_space;

    // top-left of panel
    var px = cx - width / 2;
    var py = cy - height / 2;

    // draw background
    draw_sprite_ext(sprite_index, image_index, px, py,
        width / sprite_width, height / sprite_height, 0, c_white, 1);

    // draw options
    for (var i = 0; i < op_length; i++)
    {
        var _c = c_white;
        if (pos == i) _c = c_yellow;

        draw_text_colour(px + op_border, py + op_border + op_space * i,
            option[menu_level, i], _c, _c, _c, _c, 1);
    }

    exit;
}

// -------------------- INVENTORY (menu_level 2) --------------------
if (menu_level == 2)
{
    width  = 360;
    height = 240;

    var px = cx - width / 2;
    var py = cy - height / 2;

    draw_sprite_ext(sprite_index, image_index, px, py,
        width / sprite_width, height / sprite_height, 0, c_white, 1);

    // Title
    draw_text_colour(px + op_border, py + op_border, "INVENTORY", c_white, c_white, c_white, c_white, 1);

    // Tabs
    var tab_y = py + op_border + 20;
    for (var t = 0; t < 4; t++)
    {
        var col = (t == inv_tab) ? c_yellow : c_white;
        draw_text_colour(px + op_border + t * 90, tab_y, tabs[t], col, col, col, col, 1);
    }

    // Build cache if needed (safety)
    if (inv_dirty)
    {
        inv_cache = scrInvBuildCache(inv_tab);
        inv_dirty = false;
        pos = 0;
    }

    var list_y = tab_y + 28;
    var count = array_length(inv_cache);

    if (count == 0)
    {
        draw_text(px + op_border, list_y, "(Empty)");
        inv_desc = "";
    }
    else
    {
        // simple scroll window
        var show_max = 8;
        var start = 0;
        if (pos >= show_max) start = pos - (show_max - 1);

        var lines = min(show_max, count - start);

        for (var i = 0; i < lines; i++)
        {
            var inv_index = inv_cache[start + i];
            var e = global.inv[| inv_index];

            var line_col = (start + i == pos) ? c_yellow : c_white;

            var line = e.id;
            if (e.qty > 1) line += " x" + string(e.qty);

            draw_text_colour(px + op_border, list_y + i * 18,
                line, line_col, line_col, line_col, line_col, 1);

            if (start + i == pos)
            {
                inv_desc = is_undefined(e.desc) ? "" : e.desc;
            }
        }
    }

    // Description + help
    draw_text(px + op_border, py + height - 40, inv_desc);
    draw_text(px + op_border, py + height - 20, "ESC: Back   <- / ->: Tabs   SPACE: Use/Equip");

    exit;
}

// -------------------- CHARACTER / STATS (menu_level 3) --------------------
if (menu_level == 3)
{
    width  = 360;
    height = 240;

    var px = cx - width / 2;
    var py = cy - height / 2;

    draw_sprite_ext(sprite_index, image_index, px, py,
        width / sprite_width, height / sprite_height, 0, c_white, 1);

    draw_text(px + op_border, py + op_border, "CHARACTER");

    // Safely grab instances
    var pl = instance_exists(objPlayer) ? instance_find(objPlayer, 0) : noone;

    // Defaults
    var hp = 0, hp_max = 1;
    var ms_max = 200;
    var ms = global.mental_state; // <-- FIXED: use global mental state here

    var weapon = "";
    var armor = "";
    var portrait = -1;

    if (pl != noone)
    {
        if (!is_undefined(pl.hp)) hp = pl.hp;
        if (!is_undefined(pl.hp_max)) hp_max = pl.hp_max;

        weapon = is_undefined(pl.equip_weapon) ? "" : pl.equip_weapon;
        armor  = is_undefined(pl.equip_armor)  ? "" : pl.equip_armor;

        portrait = is_undefined(pl.portrait_sprite) ? -1 : pl.portrait_sprite;
    }

    // Portrait area
    if (portrait != -1)
    {
        draw_sprite(portrait, 0, px + op_border + 40, py + op_border + 70);
    }
    else
    {
        draw_text(px + op_border, py + op_border + 40, "(no portrait set)");
    }

    // Bars
    var bar_x = px + op_border + 120;
    var bar_y = py + op_border + 40;
    var bar_w = 200;
    var bar_h = 10;

    // HP bar
    draw_text(bar_x, bar_y - 16, "HP  " + string(hp) + "/" + string(hp_max));
    draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);
    draw_rectangle(bar_x, bar_y, bar_x + bar_w * clamp(hp / max(1, hp_max), 0, 1), bar_y + bar_h, true);

    // Mental bar
    bar_y += 40;
    draw_text(bar_x, bar_y - 16, "MENTAL  " + string(ms) + "/" + string(ms_max));
    draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);
    draw_rectangle(bar_x, bar_y, bar_x + bar_w * clamp(ms / ms_max, 0, 1), bar_y + bar_h, true);

    // Equipment
    var eq_y = py + op_border + 140;
    draw_text(bar_x, eq_y,      "Weapon: " + (weapon == "" ? "(none)" : weapon));
    draw_text(bar_x, eq_y + 20, "Armour: " + (armor  == "" ? "(none)" : armor));

    draw_text(px + op_border, py + height - 20, "ESC / SPACE: Back");

    exit;
}
