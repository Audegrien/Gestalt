
if grace_timer > 0 {
	for (var i = 0; i < 600; i += 1)
	{
		grace_timer = grace_timer - 1;   
		show_debug_message("Grace Time = " + string(grace_timer));
		break;
	
	}
}
if grace_timer == 0 & triggered == true{triggered = false;}