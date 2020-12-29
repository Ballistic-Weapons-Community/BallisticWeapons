//=============================================================================
// AP_556mmClip.
//
// A 30 round 5.56mm magazine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_556mmClip extends BallisticAmmoPickup;

var   Pickup			M900Ammo;
var() class<Pickup>		M900AmmoClass;

event PostBeginPlay()
{
	local Vector S, V, HitLoc, HitNorm, E;
	local Actor T;
	local Rotator R;

	Super.PostBeginPlay();

	V = VRand()*64;
	V.Z = 0;
	S = Location;
	S.Z += M900AmmoClass.default.CollisionHeight - CollisionHeight;
	E.X = M900AmmoClass.default.CollisionRadius;
	E.Y = M900AmmoClass.default.CollisionRadius;
	E.Z = M900AmmoClass.default.CollisionHeight;

	T = Trace(HitLoc, HitNorm, S+V, S, false, E);
	if (T == None)
		HitLoc = S+V;

	R.Yaw = Rand(65536);
	M900Ammo = Spawn(M900AmmoClass,,,HitLoc, R);
}

simulated function Destroyed()
{
	if (M900Ammo != None)
		M900Ammo.Destroy();
	 super.Destroyed();
}

defaultproperties
{
     M900AmmoClass=Class'BallisticProV55.AP_M900Grenades'
     AmmoAmount=60
     InventoryType=Class'BallisticProV55.Ammo_556mm'
     PickupMessage="You got two 5.56mm magazines."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.M50Magazine'
     DrawScale=0.400000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
