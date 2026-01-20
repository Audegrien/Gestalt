/// scrInvInit()
global.inv_max = 8;
global.inv = []; // array of { id: string, qty: real }

global.ItemDB = {};

function ItemDef(_name, _desc, _consumable, _useFn) constructor {
    name = _name;
    desc = _desc;
    consumable = _consumable;
    useFn = _useFn; // function(player) -> true/false
}

// Example items (replace)
global.ItemDB.pie = new ItemDef(
    "Butterscotch Pie",
    "A pie that heals you a lot.\nSmells like home.",
    true,
    function(p) {
        if (!instance_exists(p)) return false;
        p.hp = clamp(p.hp + 22, 0, p.hp_max);
        return true;
    }
);

global.ItemDB.bandage = new ItemDef(
    "Bandage",
    "It has already been used\nseveral times.",
    false,
    function(p) {
        if (!instance_exists(p)) return false;
        p.hp = clamp(p.hp + 1, 0, p.hp_max);
        return true;
    }
);
