// objCombatController: Step
// TEMPORARY: Enter leaves combat so we can test the round trip.
if (keyboard_check_pressed(vk_enter))
{
    // Only possible if a fight was actually started (not if rmCombat was run directly).
    if (variable_global_exists("returnRoom"))
    {
        // Put the player back where they were standing, and show them again.
        with (objPlayer)
        {
            x = global.returnX;
            y = global.returnY;
            visible = true;
        }

        // Go back to the room we came from.
        room_goto(global.returnRoom);
    }
    else
    {
        show_debug_message("No return room stored: rmCombat was opened directly.");
    }
}