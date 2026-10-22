// ================================================================
// 1) ADD these macros next to your other bar macros
//    (you can delete the old BAR_TEXT_ON_EMPTY / BAR_TEXT_ON_FILL pair)
// ================================================================

#macro BAR_PLACEHOLDER_INSET  1       // keeps plain-colour placeholder fills inside the frame border

#macro BAR_TEXT_FONT          -1      // optional smaller font for bar numbers (e.g. fnt_small); -1 = use the current font

// Text colour changes depending on whether the fill is behind the number.
// Defaults are light text with a dark outline both ways, which stays readable on anything.
// To bring back a light-to-dark swap, set TEXT_FILL to c_black and OUTLINE_FILL to c_white (or similar).
#macro BAR_TEXT_EMPTY         c_white
#macro BAR_OUTLINE_EMPTY      c_black
#macro BAR_TEXT_FILL          c_white
#macro BAR_OUTLINE_FILL       c_black


// ================================================================
// 2) REPLACE your whole draw_stat_bar function with this one
// ================================================================

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
// _fill_spr = the fill sprite, or -1 to draw a plain coloured rectangle in _col.
function draw_stat_bar(_x, _y, _w, _h, _value, _max, _col, _mirror, _text, _fill_spr = -1) {
    var _pct       = (_max > 0) ? clamp(_value / _max, 0, 1) : 0;
    var _has_frame = sprite_exists(BAR_FRAME_SPR);
    var _has_fill  = sprite_exists(_fill_spr);
    var _frames    = _has_fill ? sprite_get_number(_fill_spr) : 1;
    var _stepped   = _has_fill && (BAR_FILL_MODE == 0) && (_frames > 1);

    // how far the fill sits in from the frame edge; placeholders get extra inset so they don't cover the frame
    var _ox = _has_fill ? BAR_FILL_OX : max(BAR_FILL_OX, BAR_PLACEHOLDER_INSET);
    var _oy = _has_fill ? BAR_FILL_OY : max(BAR_FILL_OY, BAR_PLACEHOLDER_INSET);

    // the area the fill occupies inside the frame
    var _iw = _has_fill ? sprite_get_width(_fill_spr)  : _w - _ox * 2;
    var _ih = _has_fill ? sprite_get_height(_fill_spr) : _h - _oy * 2;
    var _ix = _mirror ? _x + _w - _ox - _iw : _x + _ox;
    var _iy = _y + _oy;

    // stepped fills show whole frames, so snap the fill level to what is actually drawn
    var _frame = 0;
    if (_stepped) {
        _frame = (_pct <= 0) ? 0 : max(1, round(_pct * (_frames - 1)));
        _pct   = _frame / (_frames - 1);
    }

    // never let a living stat shrink to nothing
    var _fillw = floor(_iw * _pct);
    if (!_stepped && _pct > 0) _fillw = max(_fillw, 1);

    var _fx1 = _mirror ? _ix + _iw - _fillw : _ix;
    var _fx2 = _mirror ? _ix + _iw : _ix + _fillw;

    // frame (behind the fill) or plain backing
    if (_has_frame) {
        if (!BAR_FRAME_ON_TOP) draw_flip_sprite(BAR_FRAME_SPR, 0, _x, _y, sprite_get_width(BAR_FRAME_SPR), _mirror);
    } else {
        draw_set_color(c_dkgray);
        draw_rectangle(_x, _y, _x + _w - 1, _y + _h - 1, false);
    }

    // fill
    if (_stepped) {
        draw_flip_sprite(_fill_spr, _frame, _ix, _iy, _iw, _mirror);
    } else if (_has_fill) {
        if (_fillw > 0) {
            var _af = floor(current_time / BAR_FILL_MS) mod _frames;
            if (_mirror) draw_sprite_part_ext(_fill_spr, _af, 0, 0, _fillw, _ih, _ix + _iw, _iy, -1, 1, c_white, 1);
            else         draw_sprite_part_ext(_fill_spr, _af, 0, 0, _fillw, _ih, _ix, _iy, 1, 1, c_white, 1);
        }
    } else if (_fillw > 0) {
        draw_set_color(_col);
        draw_rectangle(_fx1, _iy, _fx2 - 1, _iy + _ih - 1, false);
    }

    // frame over the fill, if it's only a border
    if (_has_frame && BAR_FRAME_ON_TOP) {
        draw_flip_sprite(BAR_FRAME_SPR, 0, _x, _y, sprite_get_width(BAR_FRAME_SPR), _mirror);
    }

    // ---- number: one outlined string, centred, colour chosen by what is behind its centre ----
    var _prev_font = draw_get_font();
    if (font_exists(BAR_TEXT_FONT)) draw_set_font(BAR_TEXT_FONT);

    var _tw = string_width(_text);
    var _th = string_height(_text);
    var _tx = _x + floor((_w - _tw) / 2);
    var _ty = _y + floor((_h - _th) / 2);

    var _centre  = _x + _w / 2;
    var _on_fill = (_fillw > 0) && (_centre >= _fx1) && (_centre <= _fx2);

    var _tc = _on_fill ? BAR_TEXT_FILL    : BAR_TEXT_EMPTY;
    var _oc = _on_fill ? BAR_OUTLINE_FILL : BAR_OUTLINE_EMPTY;
    draw_text_outlined(_tx, _ty, _text, _tc, _oc);

    draw_set_font(_prev_font);
    draw_set_color(c_white);
}
