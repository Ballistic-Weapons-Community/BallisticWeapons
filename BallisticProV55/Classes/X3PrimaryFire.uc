//=============================================================================
// X3PrimaryFire.
//
// Rapid swining of the knife. Effective in an insane melee.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class X3PrimaryFire extends BallisticMeleeFire;

var() Array<name> SliceAnims;
var int SliceAnim;

simulated function bool AllowFire()
{
	if (level.TimeSeconds > X3Knife(Weapon).NextThrowTime)
		return super.AllowFire();
	return false;
}
simulated event ModeDoFire()
{
	FireAnim = SliceAnims[SliceAnim];
	SliceAnim++;
	if (SliceAnim >= SliceAnims.Length)
		SliceAnim = 0;

	Super.ModeDoFire();
}

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SliceAnims(0)="Slice1"
     SliceAnims(1)="Slice2"
     SliceAnims(2)="Slice3"
     SliceAnims(3)="Slice4"
     FatiguePerStrike=0.035000
     bCanBackstab=False
     TraceRange=(Min=130.000000,Max=130.000000)     
     DamageType=Class'BallisticProV55.DTX3Knife'
     DamageTypeHead=Class'BallisticProV55.DTX3KnifeHead'
     DamageTypeArm=Class'BallisticProV55.DTX3KnifeLimb'
     KickForce=100
     BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Knife.KnifeSlash',Radius=378.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slice1"
     FireAnimRate=1.800000
     FireRate=0.250000
     AmmoClass=Class'BallisticProV55.Ammo_X3Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.990000
     WarnTargetPct=0.300000
}
