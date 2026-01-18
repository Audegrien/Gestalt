function scrGetController()
{
    if (instance_exists(objController)) return instance_find(objController, 0);
    return noone;
}
