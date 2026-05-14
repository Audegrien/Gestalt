function scrEnemy_Data(_enemy)
{
    // Check which enemy ID was requested
    switch(_enemy)
    {
        // =========================
        // SLIME
        // =========================
        case "restraint":

            // Return a struct containing all slime data
            return
            {
                // Internal enemy ID
                id : "restraint",

                // Name shown to player
                name : "Restraint",

                // Enemy health
                hp : 20,

                // Enemy attack strength
                attack : 4,

                // Sprite used in overworld
                overworldSprite : sprRestraintOverworld,
				
				// Sprite used in combat
				combatSprite : sprRestraintCombat,
				
                // List of attacks this enemy can use
                attacks : ["Spread"]
            };

        // =========================
        // GHOST
        // =========================
        case "amputation":

            return
            {
                id : "amputation",

                name : "Amputation",

                hp : 12,

                attack : 7,

                sprite : sprAmputation,

                attacks : ["dash"]
            };
    }

    // If no enemy was found,
    // return undefined to avoid errors
    return undefined;
}
