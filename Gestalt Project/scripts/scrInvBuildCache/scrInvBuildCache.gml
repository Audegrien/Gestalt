/// @param tab_index
function scrInvBuildCache(_tab)
{
    var out = [];
    if (!ds_exists(global.inv, ds_type_list)) return out;

    var n = ds_list_size(global.inv);
    for (var i = 0; i < n; i++)
    {
        var e = global.inv[| i];
        if (e.type == _tab)
        {
            var k = array_length(out);
            array_resize(out, k + 1);
            out[k] = i; // store inventory list index
        }
    }
    return out;
}
