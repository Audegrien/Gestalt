function pl_get_atk(_pl)
{
	var base = 1;
	if (_pl_equip_weapon != "")
	{
		var it = ds_map_din_value(global.item_db, _pl.equip_weapon);
		if (!is_undefined(it)) base += it.atk;
		{
			return base;
		}
	}
}

function pl_get_def(_pl)
{
	var base = 0;
	if (_pl.equip_armor != "")
	{
		var it = ds_map_find_value(global.item_db, _pl.equip_armor_);
		if (is_undefined(it)) base += it.def;
		{
			return base;	
		}
	}
}