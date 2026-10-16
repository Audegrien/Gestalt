/// @function scrEnemyData(_enemy)
/// @description Returns a struct of data for the given enemy ID,
///              or undefined if that ID doesn't exist.
///
/// A "struct" is a bundle of named values, like a form with labelled boxes.
/// You read a value with a dot, e.g. data.hp or data.name.
/// Every enemy MUST use the same box names, so the rest of the game can rely on them.

function scrEnemyData(_enemy)
{
    // Check which enemy ID was requested.
    switch (_enemy)
    {
        // =========================
        // RESTRAINT
        // =========================
        case "restraint":
            return {
                id : "restraint",                        // internal ID
                name : "Restraint",                      // name shown in combat
                hp : 20,                                 // enemy health
                attack : 4,                              // enemy attack strength
                overworldSprite : sprRestraintOverworld, // small sprite for exploring
                combatSprite : sprRestraintCombat,       // large sprite for combat
                attacks : ["spread"]                     // attacks it can use (lowercase IDs)
            };

        // =========================
        // TEMPLATE FOR THE NEXT ENEMY
        // Copy this, remove the // marks, and fill in real values.
        // Only add an enemy once its sprites exist in the Asset Browser.
        // =========================
        // case "enemyid":
        //     return {
        //         id : "enemyid",
        //         name : "Display Name",
        //         hp : 10,
        //         attack : 3,
        //         overworldSprite : sprNameOverworld,
        //         combatSprite : sprNameCombat,
        //         attacks : ["attackid"]
        //     };
    }

    // No enemy matched this ID, so return undefined.
    // Anything that calls this function must check for undefined (see objEnemy's Create event).
    return undefined;
}