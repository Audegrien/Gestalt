// objBattleController Draw GUI

// Safely get instances
var pl   = instance_exists(objPlayer)     ? instance_find(objPlayer, 0)     : noone;
var ctrl = instance_exists(objController) ? instance_find(objController, 0) : noone;

// Read stats safely
var hp = (pl != noone) ? pl.hp : 0;
var hp_max = (pl != noone) ? pl.hp_max : 1;
var ms = (ctrl != noone) ? ctrl.mental_state : 0;

draw_text(40, 40, "ENEMY: " + enemy.name + "  HP: " + string(enemy.hp));
draw_text(40, 70, "HP: " + string(hp) + "/" + string(hp_max));
draw_text(40, 90, "MENTAL: " + string(ms) + "/200");

// Player menu
if (state == BSTATE.PLAYER_MENU)
{
    var opts = ["Attack", "Talk", "Use", "Run"];
    for (var i = 0; i < 4; i++)
    {
        var prefix = (i == menu_index) ? "> " : "  ";
        draw_text(40, 140 + i*20, prefix + opts[i]);
    }
}

// NOTE: renamed to avoid clashing with built-in draw_arrow()
function draw_dir_icon(_x, _y, _dir, _hidden)
{
    if (_hidden) { draw_text(_x, _y, "?"); return; }

    var s = "^";
    if (_dir == DIR.R) s = ">";
    if (_dir == DIR.D) s = "v";
    if (_dir == DIR.L) s = "<";
    draw_text(_x, _y, s);
}

// Enemy arrow memory
if (state == BSTATE.ENEMY_TELEGRAPH || state == BSTATE.ENEMY_INPUT)
{
    var hide = (state == BSTATE.ENEMY_INPUT);

    for (var i = 0; i < array_length(seq); i++)
    {
        draw_dir_icon(40 + i*20, 220, seq[i], hide);
    }

    // show what player entered so far (optional)
    for (var j = 0; j < array_length(input_seq); j++)
    {
        draw_dir_icon(40 + j*20, 250, input_seq[j], false);
    }
}
