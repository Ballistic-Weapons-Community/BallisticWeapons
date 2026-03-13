class BWClientLockerHider extends Info;

var bool bHideLockers;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    if (Level.NetMode == NM_DedicatedServer)
    {
        Destroy();
        return;
    }

    // Ensure all actors are loaded
    SetTimer(0.05, false);
}

simulated function Timer()
{
    local xPickupBase PB;
    local WeaponLocker W;

    foreach AllActors(class'xPickupBase', PB)
    {
        PB.bHidden = true;
        PB.SetDrawType(DT_None);
        //log("Hiding PickupBase: " $ PB.GetHumanReadableName());
        if (PB.myEmitter != None)
            PB.myEmitter.Destroy();
    }

    foreach AllActors(class'WeaponLocker', W)
    {
        if (bHideLockers)
        {
            W.GotoState('Disabled');
            W.bHidden = True;
            W.SetDrawType(DT_None);
            //log("Disabling WeaponLocker: " $ W.GetHumanReadableName());
            //continue;
        }
    }
    Destroy();
}

defaultproperties
{
}