// Mental state (single source of truth)
//global.mental_max = 200;
//global.mental_state = 100;
if (!variable_global_exists("hp")) {
    scrStatsInit();
}
scrInvInit();
show_debug_message("ADD pie -> " + string(inv_add("pie", 1)));
show_debug_message("ADD bandage -> " + string(inv_add("bandage", 1)));
show_debug_message("ADD morphine -> " + string(inv_add("morphine", 1)));
show_debug_message("ADD Razor -> " + string(inv_add("razor", 1)));

global.inv_action_guard = false;

show_debug_message("view: " + string(camera_get_view_width(view_camera[0])) + "x" + string(camera_get_view_height(view_camera[0]))
    + "  gui: " + string(display_get_gui_width()) + "x" + string(display_get_gui_height())
    + "  app surface: " + string(surface_get_width(application_surface)) + "x" + string(surface_get_height(application_surface)));