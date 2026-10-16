// ---- Which enemy is this? ----
// enemyID is normally set in the Room Editor's Instance Creation Code.
// If this instance doesn't have one, default to "restraint" so the game doesn't crash.
if (!variable_instance_exists(id, "enemyID"))
{
    enemyID = "restraint";
}

attack_triggered = false;
// ---- Look up this enemy's data ----
enemyInfo = scrEnemyData(enemyID);

// ---- Safety net for a mistyped ID ----
// If the ID isn't in scrEnemyData, we get undefined back, and reading anything
// from undefined would crash. So fall back to the default and print a warning
// in the Output window to help you find the typo.
if (is_undefined(enemyInfo))
{
    show_debug_message("objEnemy: unknown enemyID '" + string(enemyID) + "', using 'restraint' instead.");
    enemyID = "restraint";
    enemyInfo = scrEnemyData(enemyID);
}

// ---- Overworld appearance ----
sprite_index = enemyInfo.overworldSprite;

// ---- Combat trigger flag ----
// A Collision event runs on EVERY step the two objects overlap, not just once.
// This flag lets us start combat only the first time, so the game doesn't
// try to start the same fight dozens of times in a row.
triggered = false;

// Create Event - Initialize timer variables
grace_timer = 600;          // Grace period in seconds
