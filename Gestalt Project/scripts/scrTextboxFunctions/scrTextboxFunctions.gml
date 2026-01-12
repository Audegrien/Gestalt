/// @param text
function scrText(_text)
{
	text[page_number] = _text;
	
	page_number++;
}

/// @param option
/// @param link_id
function scrOption(_option, _link_id)
{
	option[option_number] = _option;
	option_link_id[option_number] = _link_id;
	
	option_number++;	
}

// @param text_id
//function create_textbox(_text_id)
//{
//	with(instance_create_depth(0, 0, -9999, objTextbox))
//	{
//		scrGameText(_text_id);
//	}
	
//}

function create_textbox(_text_id)
{
    var inst = instance_create_depth(0, 0, -9999, objTextbox);

    with (inst)
    {
        // Prevent drawing until this textbox is ready
        spawn_wait = 2; // wait 2 frames before showing text

        // Reset counters for clean dialogue
        page = 0;
        draw_char = 0;
        setup = false;
        page_number = 0;
        option_number = 0;
        option_pos = 0;

        // Clear old arrays
        text = [];
        option = [];
        option_link_id = [];

        // Populate new text
        scrGameText(_text_id);
    }

    return inst;
}
