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

function create_textbox(_text_id)
{
    // Lock SPACE so menus can't also react to the same input
    if (!variable_global_exists("ui_lock_space")) global.ui_lock_space = false;
    global.ui_lock_space = true;

    var inst = instance_create_depth(0, 0, -10000, objTextbox);

    with (inst)
    {
        spawn_wait = 2;

        page = 0;
        draw_char = 0;
        setup = false;
        page_number = 0;
        option_number = 0;
        option_pos = 0;

        text = [];
        option = [];
        option_link_id = [];

        scrGameText(_text_id);
    }

    return inst;
}
