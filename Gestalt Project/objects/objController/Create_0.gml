// objController: Create

// Mental state (single source of truth)
global.mental_max = 200;
global.mental_state = 101;

// Inventory: ds_list of structs { id, qty, type, desc }
// type: 0 consumable, 1 key, 2 weapon, 3 armor
if (!variable_global_exists("inv") || !ds_exists(global.inv, ds_type_list))
{
    global.inv = ds_list_create();

    // Example items (replace later with your real DB)
    ds_list_add(global.inv, { id:"Medkit",  qty:2, type:0, desc:"Restores 25 HP." });
    ds_list_add(global.inv, { id:"Lab Key", qty:1, type:1, desc:"Opens something downstairs." });
    ds_list_add(global.inv, { id:"Shiv",    qty:1, type:2, desc:"+2 ATK" });
    ds_list_add(global.inv, { id:"Jacket",  qty:1, type:3, desc:"+1 DEF" });
}
