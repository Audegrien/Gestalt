#macro STAT_ICON_HP       sprHealthBarHeart   // beating heart (15x15, 5 frames)
#macro STAT_ICON_STAMINA  sprStaminaBarLungs
#macro STAT_ICON_ECHOES   sprEchoesEye  // eye symbol
#macro MENTAL_ICON_SPR    sprMentalStateBrain    // brain: 1 frame, or 4 to change with mental state

#macro PORTRAIT_SPR       sprPlayerPortrait   // 128x128, 12 frames

#macro STAT_ICON_SIZE     15
#macro STAT_ICON_GAP      2

// Bars
#macro BAR_FRAME_SPR      sprBarFrame    // the empty bar frame (1 frame)
#macro BAR_FILL_HP        sprHealthBar // your 21-frame animated fill sprite
#macro BAR_FILL_STAMINA   sprStaminaBar
#macro BAR_FILL_ECHOES    sprEchoesBar
#macro BAR_FILL_MENTAL    sprMentalStateBar

// Where the fill sits inside the 52x11 frame (measured from your art)
#macro BAR_FILL_X         2
#macro BAR_FILL_Y         1
#macro BAR_FILL_W         49
#macro BAR_FILL_H         9

#macro BAR_FILL_MS        100      // ms per frame of the fill's looping animation
#macro BAR_EMPTY_COL      c_black  // backing behind the empty part of a bar
#macro BAR_EMPTY_ALPHA    0.7
#macro BAR_PLACEHOLDER_INSET  1  // keeps plain-colour placeholder fills inside the frame border

#macro BAR_TEXT_FONT      -1   // optional smaller font for bar numbers (e.g. fnt_small); -1 = use the current font

// Text colour changes depending on whether the fill is behind the number.
// Defaults are light text with a dark outline both ways, which stays readable on anything.
// To bring back a light-to-dark swap, set TEXT_FILL to c_black and OUTLINE_FILL to c_white (or similar).
#macro BAR_TEXT_EMPTY     c_white
#macro BAR_OUTLINE_EMPTY  c_black
#macro BAR_TEXT_FILL      c_white
#macro BAR_OUTLINE_FILL   c_black


// ================================================================
// MENTAL TIER: 0 calm, 1 uneasy, 2 Broken, 3 fully demonic
// ================================================================
function mental_tier() {
    var _pct = clamp(global.mental_state / global.mental_max, 0, 1);
    if (_pct <= 0.25) return 3;
    if (_pct < 0.5)   return 2;
    if (_pct <= 0.75) return 1;
    return 0;
}


// ================================================================
// ICONS
// _frame = -1 animates through the sprite's frames; otherwise shows that frame
// ================================================================
function draw_stat_icon(_spr, _x, _y, _letter, _ms = 120, _frame = -1) {
    if (sprite_exists(_spr)) {
        if (_frame < 0) _frame = floor(current_time / _ms) mod sprite_get_number(_spr);
        var _ox = floor((STAT_ICON_SIZE - sprite_get_width(_spr)) / 2) + sprite_get_xoffset(_spr);
        var _oy = floor((STAT_ICON_SIZE - sprite_get_height(_spr)) / 2) + sprite_get_yoffset(_spr);
        draw_sprite(_spr, _frame, _x + _ox, _y + _oy);
        return;
    }

    // placeholder box until the sprite exists
    draw_set_color(c_dkgray);
    draw_rectangle(_x, _y, _x + STAT_ICON_SIZE - 1, _y + STAT_ICON_SIZE - 1, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(_x + STAT_ICON_SIZE / 2, _y + floor((STAT_ICON_SIZE - string_height(_letter)) / 2), _letter);
    draw_set_halign(fa_left);
}

// Brain icon: picks its frame from the mental tier, with an occasional 1px twitch when Broken
function draw_mental_icon(_x, _y) {
    if (global.mental_state < 50 && irandom(20) == 0) {
        _x += irandom_range(-1, 1);
        _y += irandom_range(-1, 1);
    }

    var _frame = 0;
    if (sprite_exists(MENTAL_ICON_SPR)) {
        _frame = min(mental_tier(), sprite_get_number(MENTAL_ICON_SPR) - 1);
    }
    draw_stat_icon(MENTAL_ICON_SPR, _x, _y, "M", 120, _frame);
}


// ================================================================
// BARS
// ================================================================

// Draws a sprite with its top-left corner at (_x, _y), optionally flipped horizontally.
// _w is the sprite's own width. Works with any sprite origin.
function draw_flip_sprite(_spr, _frame, _x, _y, _w, _mirror) {
    var _xo = sprite_get_xoffset(_spr);
    var _yo = sprite_get_yoffset(_spr);
    if (_mirror) draw_sprite_ext(_spr, _frame, _x + _w - _xo, _y + _yo, -1, 1, 0, c_white, 1);
    else         draw_sprite(_spr, _frame, _x + _xo, _y + _yo);
}

// Bar size comes from the frame sprite once it exists
function stat_bar_w() {
    return sprite_exists(BAR_FRAME_SPR) ? sprite_get_width(BAR_FRAME_SPR) : 52;
}
function stat_bar_h() {
    return sprite_exists(BAR_FRAME_SPR) ? sprite_get_height(BAR_FRAME_SPR) : string_height("A") + 2;
}

// Draws text with a 1px outline (8 directions), so it stays crisp on pixel art
function draw_text_outlined(_x, _y, _str, _col, _outline) {
    draw_set_color(_outline);
    draw_text(_x - 1, _y - 1, _str);
    draw_text(_x,     _y - 1, _str);
    draw_text(_x + 1, _y - 1, _str);
    draw_text(_x - 1, _y,     _str);
    draw_text(_x + 1, _y,     _str);
    draw_text(_x - 1, _y + 1, _str);
    draw_text(_x,     _y + 1, _str);
    draw_text(_x + 1, _y + 1, _str);
    draw_set_color(_col);
    draw_text(_x, _y, _str);
    draw_set_color(c_white);
}

// Generic stat bar with the number inside.
// _mirror = false fills from the left, true fills from the right (and flips the art).
// _fill_spr = a looping fill animation, or -1 to draw a plain coloured rectangle in _col.
// The fill sprite must be the same size as the frame sprite, lined up top-left.
function draw_stat_bar(_x, _y, _w, _h, _value, _max, _col, _mirror, _text, _fill_spr = -1) {
    var _pct       = (_max > 0) ? clamp(_value / _max, 0, 1) : 0;
    var _has_frame = sprite_exists(BAR_FRAME_SPR);
    var _has_fill  = sprite_exists(_fill_spr);

    // the area the fill can occupy, relative to the bar's top-left corner
    // (with no frame sprite yet, it's simply the whole bar)
    var _rx = _has_frame ? BAR_FILL_X : 0;
    var _ry = _has_frame ? BAR_FILL_Y : 0;
    var _rw = _has_frame ? BAR_FILL_W : _w;
    var _rh = _has_frame ? BAR_FILL_H : _h;

    // absolute position of that area (mirrored bars flip it to the other side)
    var _ix = _mirror ? _x + _w - _rx - _rw : _x + _rx;
    var _iy = _y + _ry;

    // how many pixels are filled, and which pixels they are
    var _fillw = floor(_rw * _pct);
    var _fx1   = _mirror ? _ix + _rw - _fillw : _ix;
    var _fx2   = _mirror ? _ix + _rw : _ix + _fillw;

    // 1. dark backing, so the empty part of the bar reads as empty
    var _a = draw_get_alpha();
    draw_set_alpha(BAR_EMPTY_ALPHA);
    draw_set_color(BAR_EMPTY_COL);
    draw_rectangle(_ix, _iy, _ix + _rw - 1, _iy + _rh - 1, false);
    draw_set_alpha(_a);

    // 2. the fill
    if (_fillw > 0) {
        if (_has_fill) {
            // the looping animation, clipped to the fill level: anything past it isn't drawn
            var _af = floor(current_time / BAR_FILL_MS) mod sprite_get_number(_fill_spr);
            if (_mirror) draw_sprite_part_ext(_fill_spr, _af, _rx, _ry, _fillw, _rh, _ix + _rw, _iy, -1, 1, c_white, 1);
            else         draw_sprite_part_ext(_fill_spr, _af, _rx, _ry, _fillw, _rh, _ix, _iy, 1, 1, c_white, 1);
        } else {
            draw_set_color(_col);
            draw_rectangle(_fx1, _iy, _fx2 - 1, _iy + _rh - 1, false);
        }
    }

    // 3. the frame on top
    if (_has_frame) {
        draw_flip_sprite(BAR_FRAME_SPR, 0, _x, _y, sprite_get_width(BAR_FRAME_SPR), _mirror);
    }

    // 4. number centred in the bar, coloured per character as the fill passes under it
    var _tx = _x + floor((_w - string_width(_text)) / 2);
    var _ty = _y + floor((_h - string_height("A")) / 2);
    for (var i = 1; i <= string_length(_text); i++) {
        var _ch  = string_char_at(_text, i);
        var _cx  = _tx + string_width(string_copy(_text, 1, i - 1));
        var _mid = _cx + string_width(_ch) / 2;
        var _on_fill = (_fillw > 0) && (_mid >= _fx1) && (_mid <= _fx2);
        var _tc = _on_fill ? BAR_TEXT_ON_FILL : BAR_TEXT_ON_EMPTY;
        draw_text_colour(_cx, _ty, _ch, _tc, _tc, _tc, _tc, 1);
    }

    draw_set_color(c_white);
}

// Mental bar: the generic bar plus tick marks at 50 (top and bottom edges, so the number stays clear)
function draw_mental_bar(_x, _y, _w, _h) {
    var _broken = global.mental_state < 50;

    draw_stat_bar(_x, _y, _w, _h, global.mental_state, global.mental_max,
        _broken ? c_red : c_white, false, string(global.mental_state), BAR_FILL_MENTAL);

    // tick marks at 50, on the top and bottom rows of the fill area so the number stays clear
    var _has_frame = sprite_exists(BAR_FRAME_SPR);
    var _rx = _has_frame ? BAR_FILL_X : 0;
    var _ry = _has_frame ? BAR_FILL_Y : 0;
    var _rw = _has_frame ? BAR_FILL_W : _w;
    var _rh = _has_frame ? BAR_FILL_H : _h;

    var _mx = _x + _rx + floor(_rw * 0.5);
    draw_set_color(c_yellow);
    draw_line(_mx, _y + _ry, _mx, _y + _ry + 1);
    draw_line(_mx, _y + _ry + _rh - 2, _mx, _y + _ry + _rh - 1);
    draw_set_color(c_white);
}


// ================================================================
// PORTRAIT (128x128): 12 frames = mental tier * 3 + HP tier
//   0-2 calm, 3-5 uneasy, 6-8 Broken, 9-11 fully demonic
//   (each group: healthy, hurt, critical)
// ================================================================
function portrait_hp_tier() {
    var _pct = global.hp / global.hp_max;
    if (_pct > 0.66) return 0;
    if (_pct > 0.33) return 1;
    return 2;
}

function portrait_frame() {
    return mental_tier() * 3 + portrait_hp_tier();
}

function draw_portrait(_x, _y) {
    if (sprite_exists(PORTRAIT_SPR)) {
        draw_sprite(PORTRAIT_SPR, portrait_frame(), _x, _y);
        return;
    }

    draw_set_color(c_dkgray);
    draw_rectangle(_x, _y, _x + 127, _y + 127, false);
    draw_set_color(c_white);
    draw_text(_x + 4, _y + 4, "frame " + string(portrait_frame()));
}
