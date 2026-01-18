function inv_find_index(_id)
{
    for (var i = 0; i < ds_list_size(global.inv); i++)
    {
        var e = global.inv[| i];
        if (e.id == _id) return i;
    }
    return -1;
}

function inv_add(_id, _qty)
{
    var item = ds_map_find_value(global.item_db, _id);
    if (is_undefined(item)) return false;

    var idx = inv_find_index(_id);
    if (idx >= 0)
    {
        var e = global.inv[| idx];
        e.qty = min(e.qty + _qty, item.max_stack);
        global.inv[| idx] = e;
    }
    else
    {
        ds_list_add(global.inv, { id:_id, qty:min(_qty, item.max_stack) });
    }
    return true;
}

function inv_remove(_id, _qty)
{
    var idx = inv_find_index(_id);
    if (idx < 0) return false;

    var e = global.inv[| idx];
    e.qty -= _qty;

    if (e.qty <= 0) ds_list_delete(global.inv, idx);
    else global.inv[| idx] = e;

    return true;
}

function inv_entries_by_type(_type) // returns a ds_list of indices into global.inv
{
    var out = ds_list_create();
    for (var i = 0; i < ds_list_size(global.inv); i++)
    {
        var e = global.inv[| i];
        var item = ds_map_find_value(global.item_db, e.id);
        if (!is_undefined(item) && item.type == _type) ds_list_add(out, i);
    }
    return out;
}

function inv_use(_id, _player_struct, _battle_controller)
{
    var idx = inv_find_index(_id);
    if (idx < 0) return false;

    var e = global.inv[| idx];
    var item = ds_map_find_value(global.item_db, _id);
    if (is_undefined(item)) return false;

    if (!is_undefined(item.use_fn))
    {
        item.use_fn(_player_struct, _battle_controller);
        inv_remove(_id, 1);
        return true;
    }
    return false;
}
