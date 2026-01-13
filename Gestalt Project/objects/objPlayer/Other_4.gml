// always recreate the flashlight object in the new room
if (!instance_exists(flashlight_inst))
{
    flashlight_inst = instance_create_depth(x, y, -9999, objFlashlight);
    flashlight_inst.owner = id;
}

// apply current state
if (flashlight_on)
{
    flashlight_inst.enabled = true;
    flashlight_inst.Visible = true;
    flashlight_inst.image_alpha = flashlight_inst.on_alpha;

    uls_set_light_animation(flashlight_inst, false);
    uls_set_light_color(flashlight_inst, flashlight_inst.warm_col);
}
else
{
    flashlight_inst.enabled = false;
    flashlight_inst.Visible = false;
    flashlight_inst.image_alpha = 0;

    uls_set_light_animation(flashlight_inst, false);
}
