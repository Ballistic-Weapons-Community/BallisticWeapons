//=============================================================================
// AP_556mmClip.
//
// A 30 round 5.56mm magazine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_MX32Bullets extends BallisticAmmoPickup;

var   Pickup			SecondaryAmmo;
var() class<Pickup>		SecondaryAmmoClass;

event PostBeginPlay()
{
	local Vector S, V, HitLoc, HitNorm, E;
	local Actor T;
	local Rotator R;

	Super.PostBeginPlay();

	V = VRand()*64;
	V.Z = 0;
	S = Location;
	S.Z += SecondaryAmmoClass.default.CollisionHeight - CollisionHeight;
	E.X = SecondaryAmmoClass.default.CollisionRadius;
	E.Y = SecondaryAmmoClass.default.CollisionRadius;
	E.Z = SecondaryAmmoClass.default.CollisionHeight;

	T = Trace(HitLoc, HitNorm, S+V, S, false, E);
	if (T == None)
		HitLoc = S+V;

	R.Yaw = Rand(65536);
	SecondaryAmmo = Spawn(SecondaryAmmoClass,,,HitLoc, R);
}

simulated function Destroyed()
{
	if (SecondaryAmmo != None)
		SecondaryAmmo.Destroy();
	 super.Destroyed();
}

defaultproperties
{
     SecondaryAmmoClass=Class'BWBP_OP_Pro.AP_MX32Rockets'
     AmmoAmount=100
     InventoryType=Class'BWBP_OP_Pro.Ammo_MX32Bullets'
     PickupMessage="You got two MX-32 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.MX32.MX32-AmmoStatic'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
