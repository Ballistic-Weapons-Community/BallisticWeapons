class BallisticShield extends Actor;

var sound ShieldHitSound;
var float EffectiveThickness;

function bool BlocksShotAt(Actor Other)
{
	return true;
}

defaultproperties
{
     ShieldHitSound=Sound'ONSVehicleSounds-S.ShieldHit'
     DrawType=DT_StaticMesh
     bStasis=True
     bAcceptsProjectors=False
     bIgnoreEncroachers=True
     RemoteRole=ROLE_SimulatedProxy
     bMovable=False
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bCollideActors=True
     bBlockProjectiles=True
     bProjTarget=True
     EffectiveThickness=768
}
