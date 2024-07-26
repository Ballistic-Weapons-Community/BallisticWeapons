//=============================================================================
// AP_STANAGChaff.
//
// Two 30 round 5.56mm magazines for the MODERN MILITARY RIFLES.
// Now with chaff!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_STANAGChaff extends BallisticAmmoPickup;


var   Pickup			AltAmmo;
var() class<Pickup>		AltAmmoClass;

event PostBeginPlay()
{
	local Vector S, V, HitLoc, HitNorm, E;
	local Actor T;
	local Rotator R;

	Super.PostBeginPlay();

	V = VRand()*64;
	V.Z = 0;
	S = Location;
	S.Z += AltAmmoClass.default.CollisionHeight - CollisionHeight;
	E.X = AltAmmoClass.default.CollisionRadius;
	E.Y = AltAmmoClass.default.CollisionRadius;
	E.Z = AltAmmoClass.default.CollisionHeight;

	T = Trace(HitLoc, HitNorm, S+V, S, false, E);
	if (T == None)
		HitLoc = S+V;

	R.Yaw = Rand(65536);
	AltAmmo = Spawn(AltAmmoClass,,,HitLoc, R);
}

simulated function Destroyed()
{
	if (AltAmmo != None)
		AltAmmo.Destroy();
	 super.Destroyed();
}

defaultproperties
{
     AltAmmoClass=Class'BWBP_SKC_Pro.ChaffPickup'
     AmmoAmount=60
     InventoryType=Class'BallisticProV55.Ammo_556mm'
     PickupMessage="You got two 30 round 5.56mm magazines"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MJ51.CarbineSM_Ammo'
     DrawScale=0.550000
     PrePivot=(Z=5.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
