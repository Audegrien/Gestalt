// objCombatController: Create
// Runs once, when the combat room starts.

// Draw this object LAST so its black background covers anything left over.
// (A lower depth number means drawn later, on top.)
depth = -5000;

// ---- Which enemy are we fighting? ----
// objEnemy's Collision event stored it in global.currentEnemy.
// Safety net: if you press Run while rmCombat is open, no fight was started and that
// global doesn't exist, so fall back to a test enemy instead of crashing.
if (variable_global_exists("currentEnemy") && !is_undefined(global.currentEnemy))
{
    enemy = global.currentEnemy;
}
else
{
    enemy = scrEnemyData("restraint");
}

// ---- Hide the overworld player ----
// objPlayer is persistent, so it travelled here with us.
// "with" runs the code inside every instance of that object.
with (objPlayer)
{
    visible = false;
}

show_debug_message("Combat room ready. Enemy: " + enemy.name);