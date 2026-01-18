if (variable_global_exists("inv") && ds_exists(global.inv, ds_type_list))
{
    ds_list_destroy(global.inv);
}
