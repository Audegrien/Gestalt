depth = -9999;
//textbox parameters
textbox_width = 103;
spawn_wait = 0; // new variable: blocks drawing until setup finishes

textbox_height = 31;
border = 6;
line_sep = 6;
line_width = textbox_width - border*2;
txtb_spr = sprTextbox;
txtb_img = 0;
txtb_img_spd = 0;


//text
page = 0;
//page_number = 0;
text[0] = "";
page_number = array_length(text);
// make these REAL arrays so text_length[page] works
text_length   = array_create(page_number, 0);
text_x_offset = array_create(page_number, 0);

//text_length = string_length(text[0]);
draw_char = 0;
text_spd = 1;

//Options
option[0] = "";
option_link_id[0] = -1;
option_pos = 0;
option_number = 0;

setup = false;
