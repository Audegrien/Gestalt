// objPauseBox: Draw

draw_set_font(global.font_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_alpha(1);
draw_set_color(c_white);
gpu_set_blendmode(bm_normal);

var cx = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
var cy = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;

// -------------------- PAUSE + SETTINGS (menu_level 0/1) --------------------
if (menu_level == 0 || menu_level == 1)
{
    var _new_w = 0;
    for (var i = 0; i < op_length; i++)
    {
        var _op_w = string_width(option[menu_level, i]);
        _new_w = max(_new_w, _op_w);
    }

    width  = _new_w + op_border * 2;
    height = op_border * 2 + string_height(option[0, 0]) + (op_length - 1) * op_space;

    var px = cx - width / 2;
    var py = cy - height / 2;

    draw_sprite_ext(sprite_index, image_index, px, py,
        width / sprite_width, height / sprite_height, 0, c_white, 1);

    for (var i = 0; i < op_length; i++)
    {
        var _c = (pos == i) ? c_yellow : c_white;
        draw_text_colour(px + op_border, py + op_border + op_space * i,
            option[menu_level, i], _c, _c, _c, _c, 1);
    }

    exit;
}

// -------------------- INVENTORY (menu_level 2) --------------------
if (menu_level == 2)
{
    var inv_space  = 12;
    var inv_border = 5;

    var invCount = inv_count();

    // Measure widest label (use ASCII-safe empty label)
    var maxw = string_width("(No items)");

    for (var i = 0; i < inv_visible; i++)
    {
        var idx = inv_scroll + i;

        if (idx < invCount)
        {
            var e = inv_get(idx);
            var def = global.ItemDB[$ e.id];

            var label = def.name;
            if (e.qty > 1) label += " x" + string(e.qty);

            maxw = max(maxw, string_width(label));
        }
    }

    var list_w = maxw + inv_border * 2;
    var list_h = inv_border * 2 + string_height("A") + (inv_visible - 1) * inv_space;

    var act_w = 0;
    for (var a = 0; a < array_length(inv_actions); a++)
        act_w = max(act_w, string_width(inv_actions[a]));
    act_w += inv_border * 2;

    var act_h = inv_border * 2 + string_height("A") + (array_length(inv_actions) - 1) * inv_space;

    var pxL = cx - (list_w + 16 + act_w) / 2;
    var pyL = cy - list_h / 2;

    var pxR = pxL + list_w + 16;
    var pyR = cy - act_h / 2;

    // Left panel bg
    draw_sprite_ext(sprite_index, image_index, pxL, pyL,
        list_w / sprite_width, list_h / sprite_height, 0, c_white, 1);

    // Draw list
    for (var i = 0; i < inv_visible; i++)
    {
        var idx = inv_scroll + i;
        var yy = pyL + inv_border + inv_space * i;

        var label = "";
        if (invCount <= 0)
        {
            if (i == 0) label = "(No items)";
        }
        else if (idx < invCount)
        {
            var e = inv_get(idx);
            var def = global.ItemDB[$ e.id];

            label = def.name;
            if (e.qty > 1) label += " x" + string(e.qty);
        }

        var col = c_white;
        if (inv_mode == 0 && idx == pos && invCount > 0) col = c_yellow;

        if (label != "")
            draw_text_colour(pxL + inv_border, yy, label, col, col, col, col, 1);
    }

    // Right panel (actions)
    draw_sprite_ext(sprite_index, image_index, pxR, pyR,
        act_w / sprite_width, act_h / sprite_height, 0, c_white, 1);

    for (var a = 0; a < array_length(inv_actions); a++)
    {
        var yy = pyR + inv_border + inv_space * a;

        var col = c_white;
        if (inv_mode == 1 && a == inv_action_pos) col = c_yellow;

        draw_text_colour(pxR + inv_border, yy, inv_actions[a], col, col, col, col, 1);
    }

    exit;
}


// menu_level 3 etc...
