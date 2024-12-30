//=============================================================================
// AP_HKMK23Clip.
//
// Clips for the HKMK 23
//
// by Fischer Felix
//=============================================================================
class AP_HKMKSpecBullets extends BallisticAmmoPickup;

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
     M900AmmoClass=Class'BWBP_JCF_Pro.AP_HKMKSG'
	 AmmoAmount=32
     InventoryType=Class'BWBP_JCF_Pro.Ammo_HKMKSpecBullets'
     PickupMessage="You got 32 .45 ACP rounds & 12 Buckshot Rounds for the HKM-26 Pistol"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     //StaticMesh=StaticMesh'BWBP_JCF_Static.HKMKSpec.HKMKSpecClip'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=16.000000
}
