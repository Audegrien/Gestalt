function scrGetPlayer()
{
    if (instance_exists(objPlayer)) return instance_find(objPlayer, 0);
    return noone;
}
