width = 81;
height = 80;

op_border = 8;
op_space = 16;

pos = 0;

//pausemenu
option[0, 0] = "Resume";
option[0, 1] = "Inventory";
option[0, 2] = "Character";
option[0, 3] = "Options";
option[0, 4] = "Quit Game";

//settingsmenu
option[1, 0] = "Fullscreen";
option[1, 1] = "Brightness";
option[1, 2] = "Controls";
option[1, 3] = "Back";

op_length = 0;
menu_level = 0;

// -------------------- INVENTORY MENU VARS --------------------
inv_mode = 0; // 0=list, 1=actions
inv_action_pos = 0;

inv_actions[0] = "Use";
inv_actions[1] = "Info";
inv_actions[2] = "Discard";
inv_actions[3] = "Cancel";

inv_scroll = 0;
inv_visible = 6; // smaller Y than 8; change to 8 if you prefer

// Critical: prevents Space that closes a textbox from also triggering inventory
inv_require_space_up = true;
inv_tb_was_open = false;
inv_accept_cooldown = 0;
