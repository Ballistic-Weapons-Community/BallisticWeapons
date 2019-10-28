class Ballistic_ComboMiniMe extends Combo;

function StartEffect(xPawn P)
{
    if (P.Role == ROLE_Authority)
    {
		P.SetDrawscale(0.5 * P.Default.DrawScale);
		P.SetCollisionSize(P.CollisionRadius, 0.5*P.CollisionHeight);
		P.BaseEyeheight = 0.5 * P.default.BaseEyeheight;
		P.bCanCrouch = False;
	}
	
	BallisticPawn(P).ClientSetCrouchAbility(false);
}

function StopEffect(xPawn P)
{
    if (P.Role == ROLE_Authority)
    {
		P.SetDrawscale(P.Default.DrawScale);
		P.BaseEyeheight = P.Default.BaseEyeheight;
		P.ForceCrouch();
		P.bCanCrouch = True;
	}
	
	BallisticPawn(P).ClientSetCrouchAbility(true);
}

defaultproperties
{
     ExecMessage="Pint-Sized!"
     Duration=60.000000
     ComboAnnouncementName="Pint_sized"
     keys(0)=8
     keys(1)=8
     keys(2)=4
     keys(3)=4
}
