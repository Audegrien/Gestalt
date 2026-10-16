// objCombatController: Draw

// ---- 1. Work out the visible area ----
// If this room uses a camera view, use it; otherwise use the whole room.
var _vx = 0;
var _vy = 0;
var _vw = room_width;
var _vh = room_height;
if (view_enabled)
{
    _vx = floor(camera_get_view_x(view_camera[0]));
    _vy = floor(camera_get_view_y(view_camera[0]));
    _vw = camera_get_view_width(view_camera[0]);
    _vh = camera_get_view_height(view_camera[0]);
}
var _cx = _vx + floor(_vw / 2);   // horizontal centre of the screen

// ---- 2. Black background, wiping anything left over ----
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(_vx - 1, _vy - 1, _vx + _vw + 1, _vy + _vh + 1, false);

// ---- 3. The enemy's combat sprite, centred near the top ----
var _spr   = enemy.combatSprite;
var _frame = floor(current_time / 150) mod sprite_get_number(_spr);   // plays its animation, if it has one
var _sx    = _cx - floor(sprite_get_width(_spr) / 2) + sprite_get_xoffset(_spr);
var _sy    = _vy + 8 + sprite_get_yoffset(_spr);
draw_sprite(_spr, _frame, _sx, _sy);

// ---- 4. The enemy's name, below the sprite ----
draw_set_font(global.font_main);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(_cx, _vy + 8 + sprite_get_height(_spr) + 6, enemy.name);

// Temporary hint at the bottom
draw_text(_cx, _vy + _vh - 14, "Enter: leave (temporary)");

// ---- 5. Put the drawing settings back ----
draw_set_halign(fa_left);
draw_set_color(c_white);