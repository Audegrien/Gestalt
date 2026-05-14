// If no enemyID was assigned,
// use a default enemy
if (!variable_instance_exists(id, "enemyID"))
{
    enemyID = "restraint";
}


// Load enemy data
enemyInfo = scrEnemy_Data(enemyID);


// Set overworld sprite
sprite_index = enemyInfo.overworldSprite;