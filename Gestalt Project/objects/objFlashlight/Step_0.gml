event_inherited();

if (!enabled) exit;
if (!instance_exists(owner)) { instance_destroy(); exit; }

// Follow player
x = owner.x;
y = owner.y;

// Face player direction
switch (owner.face)
{
    case RIGHT: image_angle =   0; break;
    case UP:    image_angle = 90; break;
    case LEFT:  image_angle = 180; break;
    case DOWN:  image_angle =  270; break;
}

// match player's depth rules, then nudge based on facing
depth = owner.depth;

// when pointing UP, draw beam BEHIND player
if (owner.face == UP)
    depth = owner.depth + 1; 
else
    depth = owner.depth - 1;  