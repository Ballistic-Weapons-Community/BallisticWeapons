class Misc_ComboSpeed extends ComboSpeed;

function StartEffect(xPawn P)
{
    Super.StartEffect(P);

    if(Misc_Player(P.Controller) != None)
        Misc_Player(P.Controller).bSeeInvis = true;
}

function StopEffect(xPawn P)
{
    P.AirControl /= 1.4;
    P.GroundSpeed /= 1.4;
    P.WaterSpeed /= 1.4;
    P.AirSpeed /= 1.4;
    P.JumpZ /= 1.5;

    if (LeftTrail != None)
        LeftTrail.Destroy();

    if (RightTrail != None)
        RightTrail.Destroy();

    if(Misc_Player(P.Controller) != None)
        Misc_Player(P.Controller).bSeeInvis = false;
}

defaultproperties
{
     Duration=45.000000
}
