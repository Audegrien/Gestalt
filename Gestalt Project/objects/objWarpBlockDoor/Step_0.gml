var is_dark = (global.mental_state <= 100);

if (place_meeting(x, y, objPlayer) && !instance_exists(objWarp)) && keyboard_check_pressed(vk_space)
{
    var inst = instance_create_depth(0, 0, -999, objWarp);

    // IMPORTANT: keep variable names/case consistent everywhere
    inst.target_X = target_X;
    inst.target_y = target_y;

    // Choose which room to go to
    inst.target_rm = is_dark ? target_rm_dark : target_rm;

    inst.target_face = target_face;
}