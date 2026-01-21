var accept_key = keyboard_check_pressed(vk_space);
if (!variable_global_exists("ui_lock_space")) global.ui_lock_space = false;
if (accept_key) global.ui_lock_space = true; // textbox consumed SPACE this frame

// Don't draw yet if this textbox just spawned
if (spawn_wait > 0)
{
    spawn_wait--;
    exit; // skip Draw event entirely this frame
}

textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]) + 80;


//------------setup------------\\
if setup == false
{
		setup = true;
	
		
		//loop through pages
		for(var p = 0; p < page_number; p++)
		{
			//find how many characters are on each page and store those characters in the "text length" array
			text_length[p] = string_length(text[p]);
			
			//get the x position for the textbox
				//no character (center the textbox)
				text_x_offset[p] = 22;
		}
}


//------------typing the text------------\\
if draw_char < text_length[page]
{
	draw_char += text_spd;
	draw_char = clamp(draw_char, 0, text_length[page]);
}


//------------flip through pages------------\\
if accept_key
{	
	//if the typing is done
	if draw_char == text_length[page]
	{
		//next page
		if page < page_number-1
		{
			page++;
			draw_char = 0;
		}
		//destroy textbox
		else
		{
			//link text for options
			if option_number > 0 
			{
				create_textbox(option_link_id[option_pos]);
			}
			//var link_len = array_length(option_link_id);
			//if (option_pos >= 0 && option_pos < link_len)
			//{
			  //  create_textbox(option_link_id[option_pos]);
			//}
			//else
			//{
			    // No link set for this option index. Do nothing (or handle a default).
			 //   show_debug_message("Missing option_link_id for option_pos=" + string(option_pos));
			//}
			instance_destroy();
		}
	}
	else
	{
		draw_char = text_length[page];
	}
}





//------------draw the textbox----------\\
txtb_img += txtb_img_spd;
txtb_spr_w = sprite_get_width(txtb_spr);
txtb_spr_h = sprite_get_height(txtb_spr);
//back of the textbox
draw_sprite_ext(txtb_spr, txtb_img, textbox_x + text_x_offset[page], textbox_y, textbox_width/txtb_spr_w, textbox_height/txtb_spr_h, 0, c_white, 1);


var tx = textbox_x + text_x_offset[page] + border;
var ty = textbox_y+ border;

//------------ OPTIONS ------------\\
// Only run this block when:
// 1) The dialogue has finished typing
// 2) We are on the FINAL page of dialogue
if (draw_char == text_length[page] && page == page_number - 1)
{
    // ---------- OPTION SELECTION INPUT ----------
    // Move selection down (+1) when DOWN is pressed
    // Move selection up (-1) when UP is pressed
    // keyboard_check_pressed returns 1 or 0, so subtraction works cleanly
    option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

    // Clamp selection so it never goes below 0 or above last option
    // option_number = total number of options
    option_pos = clamp(option_pos, 0, option_number - 1);


    // ---------- OPTION LAYOUT (TEXT SPACE / UNSCALED) ----------
    // Vertical spacing between options BEFORE scaling is applied
    // Increase to spread options further apart
    var _op_space = 19;

    // Horizontal padding inside option box (left + right)
    // Increase to give text more breathing room horizontally
    var _op_bord  = 5;

    // Scale applied ONLY to text + option UI
    // MUST match dialogue text scale to stay consistent
    var s = 0.5;


    // ---------- OPTION BOX HEIGHT CONTROL (Y ONLY) ----------
    // Visual height of each option box
    // Increase this to make boxes taller (does NOT affect text size)
    var option_box_height = 18;

    // Vertical padding for option text inside the box
    // Increase to move text downward / add breathing room
    var option_text_pad_y = 3;


    // ---------- POSITION RELATIVE TO MAIN TEXTBOX ----------
    // Vertical offset ABOVE the main dialogue text
    // Increase to move options further upward
    var option_offset_y = 4;

    // World-space X anchor for options
    // Uses dialogue text X (tx) so everything lines up visually
    var ox = tx + 4;

    // World-space Y anchor ABOVE the dialogue text
    var oy = ty - option_offset_y;


    // ---------- MATRIX SETUP (SCALE ONLY THE OPTIONS) ----------
    // Save the current world transform
    // This is CRITICAL so scaling doesn't affect the rest of the game
    var m_old = matrix_get(matrix_world);

    // Build a new transform that:
    // - Moves drawing origin to (ox, oy)
    // - Scales everything by s (text + boxes + arrow)
    var m = matrix_build(ox, oy, 0, 0, 0, 0, s, s, 1);

    // Apply the transform
    matrix_set(matrix_world, m);


    // ---------- DRAW SETTINGS ----------
    // Always set font + alignment before drawing text
    // Prevents other draw events from interfering
    draw_set_font(global.font_main);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);


    // ---------- DRAW EACH OPTION ----------
    for (var op = 0; op < option_number; op++)
    {
        // Calculate Y position for this option
        // Options stack upward from the anchor point
        var _y = -_op_space * option_number + (_op_space * op);


        // ---------- OPTION BOX WIDTH ----------
        // Measure the width of this option's text
        var text_w = string_width(option[op]);

        // Box width is text width + horizontal padding
        // Changing this DOES NOT affect height
        var _o_w = text_w + _op_bord * 2.5;


        // ---------- OPTION BOX HEIGHT ----------
        // Height is fully independent from width and text
        var _o_h = option_box_height;


        // ---------- DRAW OPTION BOX ----------
        // Draw textbox sprite scaled to desired width + height
        // Position is (0, _y) because we're already inside the matrix
        draw_sprite_ext(txtb_spr, txtb_img, 0, _y, _o_w / txtb_spr_w, _o_h / txtb_spr_h, 0, c_white, 1);


        // ---------- DRAW SELECTION ARROW (SCALED SPACE) ----------
        // Only draw arrow for the currently selected option
        if (option_pos == op)
        {
            // Arrow sprite dimensions (unscaled text space)
            var aw = sprite_get_width(sprTextboxArrow);
            var ah = sprite_get_height(sprTextboxArrow);

            // Gap between arrow and option box
            // Increase to move arrow further left
            var arrow_gap = 2;

            // X position: to the LEFT of the option box
            var ax = -aw - arrow_gap;

            // Y position: vertically centered in the option box
            var ay = _y + (_o_h - ah) * 0.5;

            // Draw arrow (inherits scale from matrix)
            draw_sprite(sprTextboxArrow, 0, ax, ay);
        }


        // ---------- DRAW OPTION TEXT ----------
        // Draw option text inside the box with vertical padding
        draw_text(_op_bord, _y + option_text_pad_y, option[op]);
    }


    // ---------- CLEANUP ----------
    // Restore original world transform
    // VERY IMPORTANT to avoid scaling everything else
    matrix_set(matrix_world, m_old);
}


// =====================================================================
// ===================== MAIN DIALOGUE TEXT DRAW ========================
// =====================================================================


// Copy only the visible characters (typing effect)
var _drawtext = string_copy(text[page], 1, draw_char);

// Dialogue text scale
// Keep this identical to option scale for consistency
var s = 0.5;


// Ensure correct font + alignment
draw_set_font(global.font_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);


// Save current transform before scaling dialogue text
var m_old = matrix_get(matrix_world);

// Build scaled transform at dialogue text position (tx, ty)
var m = matrix_build(tx, ty, 0, 0, 0, 0, s, s, 1);

// Apply transform
matrix_set(matrix_world, m);


// Draw wrapped dialogue text
// NOTE: line spacing and width are divided by scale
// so wrapping behaves correctly inside scaled space
draw_text_ext(0, 0,_drawtext, line_sep / s, line_width / s);


// Restore original transform
matrix_set(matrix_world, m_old);
