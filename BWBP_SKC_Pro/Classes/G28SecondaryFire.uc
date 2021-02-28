//=============================================================================
// T10SecondaryFire.
//
// T10 Grenade rolled underhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G28SecondaryFire extends G28PrimaryFire;

function PlayPreFire()
{
	Weapon.SetBoneScale (0, 1.0, G28Grenade(Weapon).GrenadeBone);
	Weapon.SetBoneScale (1, 0.0, G28Grenade(Weapon).PinBone);
	if (BallisticHandGrenade(Weapon).ClipReleaseTime > 0)
		Weapon.PlayAnim(NoClipPreFireAnim, PreFireAnimRate, TweenTime);
	else
		Weapon.PlayAnim(PreFireAnim, PreFireAnimRate, TweenTime);
}

defaultproperties
{
     NoClipPreFireAnim="PrepRollAlt"
     SpawnOffset=(Z=-14.000000)
     PreFireAnim="PrepRoll"
     FireAnim="Roll"
     ProjectileClass=Class'BWBP_SKC_Pro.G28Rolled'
}
