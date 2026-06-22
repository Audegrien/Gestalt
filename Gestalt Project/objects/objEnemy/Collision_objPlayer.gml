// Store this enemy's data globally
// so the combat room can access it
global.currentEnemy = enemyInfo;


// OPTIONAL:
// remember which room we came from
global.returnRoom = room;


// Go to combat room
room_goto(rmCombat);
show_debug_message("COMBAT STARTED");
show_debug_message("Room: " + string(room));