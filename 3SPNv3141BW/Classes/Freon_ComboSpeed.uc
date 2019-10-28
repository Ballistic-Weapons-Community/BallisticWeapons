class Freon_ComboSpeed extends Misc_ComboSpeed;

function StartEffect(xPawn P)
{
    Super.StartEffect(P);

    if(Freon_Pawn(P) != None)
        Freon_Pawn(P).bThawFast = true;
}

function StopEffect(xPawn P)
{
    Super.StopEffect(P);

    if(Freon_Pawn(P) != None)
        Freon_Pawn(P).bThawFast = false;
}

defaultproperties
{
}
