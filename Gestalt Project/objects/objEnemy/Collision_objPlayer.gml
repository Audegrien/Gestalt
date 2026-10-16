
// If this enemy has already started a fight, do nothing more.
if (triggered) exit;
triggered = true;
// objEnemy: Collision with objPlayer
if (grace_timer == 0) 
{
	
	// ---- Hand the combat system what it needs ----
	
	// This enemy's data (name, hp, attack, sprites, attacks), from scrEnemyData.
	global.currentEnemy = enemyInfo;

	// The room to come back to once combat ends.
	global.returnRoom = room;

	// Where the player was standing, so we can put them back later.
	// "other" is the objPlayer instance we just collided with.
	global.returnX = other.x;
	global.returnY = other.y;

	// A message in the Output window, so we can confirm it worked.
	show_debug_message("Combat starting with " + global.currentEnemy.name
		+ " (from " + room_get_name(room) + ")");

	// ---- Go to the combat room ----
	room_goto(rmCombat);
};