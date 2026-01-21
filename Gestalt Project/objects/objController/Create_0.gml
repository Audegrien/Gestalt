// Mental state (single source of truth)
global.mental_max = 200;
global.mental_state = 100;
scrInvInit();
show_debug_message("ADD pie -> " + string(inv_add("pie", 1)));
show_debug_message("ADD bandage -> " + string(inv_add("bandage", 1)));
show_debug_message("ADD morphine -> " + string(inv_add("morphine", 1)));
global.inv_action_guard = false;
