/// scrInv.gml

function inv_count() {
    return array_length(global.inv);
}

function inv_get(_i) {
    return global.inv[_i];
}

function inv_add(_id, _amount) {
    if (!variable_struct_exists(global.ItemDB, _id)) return false;

    // stack if exists
    for (var i = 0; i < array_length(global.inv); i++) {
        if (global.inv[i].id == _id) {
            global.inv[i].qty += _amount;
            return true;
        }
    }

    // new slot
    if (array_length(global.inv) >= global.inv_max) return false;

    array_push(global.inv, { id: _id, qty: _amount });
    return true;
}

function inv_remove_at(_i, _amount) {
    if (_i < 0 || _i >= array_length(global.inv)) return false;

    global.inv[_i].qty -= _amount;

    if (global.inv[_i].qty <= 0) {
        global.inv = array_delete(global.inv, _i, 1);
    }

    return true;
}

function inv_remove_id(_id, _amount) {
    for (var i = 0; i < array_length(global.inv); i++) {
        if (global.inv[i].id == _id) {
            return inv_remove_at(i, _amount);
        }
    }
    return false;
}
