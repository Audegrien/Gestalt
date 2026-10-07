/// scr_stats.gml

function scrStatsInit() {
    global.hp            = 75;
    global.hp_max        = 100;

    global.stamina       = 100;
    global.stamina_max   = 100;

    global.mental_state  = 100;   // you already have this one
    global.mental_max    = 100;

    global.echoes        = 0;     // currency, no max
	global.echoes_max = 999;
}

function hp_change(_amount) {
    global.hp = clamp(global.hp + _amount, 0, global.hp_max);
    if (global.hp <= 0) {
        // trigger game over here
    }
}

function stamina_change(_amount) {
    global.stamina = clamp(global.stamina + _amount, 0, global.stamina_max);
}

function mental_change(_amount) {
    global.mental_state = clamp(global.mental_state + _amount, 0, global.mental_max);
}

function echoes_change(_amount) {
    global.echoes = clamp(global.echoes + _amount, 0, global.echoes_max);
}

function echoes_can_afford(_cost) {
    return global.echoes >= _cost;
}

function mental_is_broken() {
    return global.mental_state < 50;
}