function scrItemDB_Init()
{
    global.item_db = ds_map_create();

    // Helper to define items
    function _def(_id, _name, _desc, _type, _max_stack, _use_fn, _atk, _def)
    {
        var item = {
            id:_id, name:_name, desc:_desc, type:_type,
            max_stack:_max_stack,
            use_fn:_use_fn,  // function(player, battle_controller) or undefined
            atk:_atk, def:_def
        };
        ds_map_add(global.item_db, _id, item);
    }

    // Examples
    _def("key_lab",   "Lab Key", "A cold key with dried rust.", ITEM_TYPE.KEY,     1,  undefined, 0, 0);
    _def("medkit",    "Medkit",  "Restores 25 HP.",             ITEM_TYPE.CONSUME, 10, function(_pl,_bc){_pl.hp = clamp(_pl.hp + 25, 0, _pl.hp_max);}, 0, 0);

    _def("shiv",      "Shiv",    "A chipped blade. +2 ATK",     ITEM_TYPE.WEAPON,  1,  undefined, 2, 0);
    _def("jacket",    "Jacket",  "Worn padding. +1 DEF",        ITEM_TYPE.ARMOR,   1,  undefined, 0, 1);
}
