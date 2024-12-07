//=============================================================================
// AP_STANAGChaff.
//
// Two 30 round 5.56mm magazines for the MODERN MILITARY RIFLES.
// Now with chaff!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SHADRACHChaff extends BallisticAmmoPickup;


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
     AltAmmoClass=Class'BWBP_APC_Pro.SHADRACHPickup'
     AmmoAmount=108
     InventoryType=Class'BWBP_APC_Pro.Ammo_45APC'
     PickupMessage="You got two 108 round 10mm HV magazines"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_APC_Static.SPXSmg.SPXSmg_Mag'
     DrawScale=0.100000
     PrePivot=(Z=5.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
