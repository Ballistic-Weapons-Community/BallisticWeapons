//=============================================================================
// Melee_M50AssaultRifle.
//
// M50 Assault Rifle with only the camera
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Melee_M50AssaultRifle extends M50AssaultRifle HideDropDown CacheExempt;

simulated function PlayIdle()
{
	Super(BallisticWeapon).PlayIdle();
}
function GrenadePickedUp ();
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super(BallisticWeapon).GiveAmmo(m, WP, bJustSpawned);
}
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (Anim == CamUpAnim && Camera != None)
		CameraView();
	Super.AnimEnd(Channel);
}
simulated function LoadGrenade();

function float GetAIRating()
{
	return 0.0;
}

defaultproperties
{
     FireModeClass(0)=Class'BallisticProV55.M50CamFire'
     FireModeClass(1)=Class'BallisticProV55.M50CamFire'
     AIRating=0.000000
     Priority=11
     PickupClass=Class'BallisticProV55.Melee_M50Pickup'
     ItemName="Unfireable M50 Assault Rifle"
}
