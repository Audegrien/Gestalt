state = BSTATE.INTRO;

player = objPlayer; // or store a struct snapshot of stats
enemy = { name:"Hollow", hp:40, atk:10, mercy:0 };

menu_index = 0; // 0 atk 1 talk 2 use 3 run

// Arrow attack settings
seq = [];
input_seq = [];
telegraph_timer = 0;
telegraph_time = room_speed * 1.2;

function make_seq(_len)
{
    array_resize(seq, _len);
    for (var i = 0; i < _len; i++)
        seq[i] = irandom(3); // DIR 0..3
}
