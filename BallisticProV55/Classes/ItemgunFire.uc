class ItemgunFire extends WeaponFire;

function Rotator AdjustAim(Vector Start, float InAimError)
{
    return Instigator.Controller.Rotation;
}

simulated function bool AllowFire()
{
    return true;
}

defaultproperties
{
     bWaitForRelease=True
     bModeExclusive=False
     FireAnimRate=1.500000
     FireRate=0.250000
     BotRefireRate=0.300000
}
