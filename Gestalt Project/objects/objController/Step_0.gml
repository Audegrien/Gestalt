// Release the inventory action guard when SPACE is released
if (global.inv_action_guard && !keyboard_check(vk_space))
{
    global.inv_action_guard = false;
}
