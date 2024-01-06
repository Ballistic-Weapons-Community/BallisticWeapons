//=============================================================================
// AP_CYLOClip.
//
// A 25 round 7.62mm caseless magazine.
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_ProtoClip extends BallisticAmmoPickup;
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
     M900AmmoClass=Class'BWBP_APC_Pro.AP_ProtoAlt'
     AmmoAmount=100
     InventoryType=Class'BWBP_APC_Pro.Ammo_Proto'
     PickupMessage="You picked up Prototype LMG rounds."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.ProtoLMG.ProtoLMG_SM_Ammo'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
