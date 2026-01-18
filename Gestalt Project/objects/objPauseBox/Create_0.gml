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

// --- Inventory / Character screens ---
inv_tab = 0;          // 0 consumable, 1 key, 2 weapon, 3 armor
inv_cache = [];       // array of indices into global.inv for current tab
inv_dirty = true;     // rebuild cache when tab changes or inventory changes
inv_desc = "";        // hover/selected item description

tabs[0] = "Consumables";
tabs[1] = "Key Items";
tabs[2] = "Weapons";
tabs[3] = "Armour";

// Character page settings
char_line = 0; // not required, just reserved
