if position_meeting(x, y, objPlayer) && keyboard_check_pressed(vk_space) && !instance_exists(objTextbox) && !instance_exists(objPauseBox)
{
	create_textbox(text_id);
}