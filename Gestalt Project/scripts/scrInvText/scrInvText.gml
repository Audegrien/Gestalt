/// scrInvText(_id)
function scrInvText(_id)
{
    var parts = string_split(_id, "|"); // ["INV","INFO","pie"]
    var cmd = parts[1];
    var item_id = (array_length(parts) > 2) ? parts[2] : "";

    if (cmd == "EMPTY") {
        scrText("You have no items.");
        return;
    }

    var has_item = (item_id != "") && variable_struct_exists(global.ItemDB, item_id);
    if (!has_item) {
        scrText("...");
        return;
    }

    var def = global.ItemDB[$ item_id];

    switch (cmd)
    {
        case "INFO":
            scrText(def.desc);
        break;

        case "USED":
            scrText("You used the " + def.name + ".");
        break;

        case "DISCARD":
            scrText("Throw away the " + def.name + "?");
            scrOption("Yes", "INV|DISCARD_YES|" + item_id);
            scrOption("No",  "INV|DISCARD_NO|"  + item_id);
        break;

		case "DISCARD_YES":
		    if (!variable_global_exists("inv_action_guard")) global.inv_action_guard = false;

		    // Only allow one inventory mutation per SPACE press
		    if (global.inv_action_guard)
		    {
		        scrText("...");
		        break;
		    }
		    global.inv_action_guard = true;
			show_debug_message("DISCARD_YES called for " + item_id);
		    inv_remove_id(item_id, 1);
		    scrText("You threw away the " + def.name + ".");
		break;

        case "DISCARD_NO":
            scrText("...");
        break;
    }
}