//=============================================================================
// X4PrimaryFire.
//
// Rapid swinging of the knife. Effective in an insane melee.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class SandbagMeleeFire extends BallisticMeleeFire;

var() Array<name> SliceAnims;
var int SliceAnim;

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
     SliceAnims(0)="Slash1"
     SliceAnims(1)="Slash2"
     SliceAnims(2)="Slash3"
     SliceAnims(3)="Slash4"
     bCanBackstab=False
     TraceRange=(Min=130.000000,Max=130.000000)
     Damage=140.000000
     
     
     DamageType=Class'BallisticProV55.DTX4Knife'
     DamageTypeHead=Class'BallisticProV55.DTX4KnifeHead'
     DamageTypeArm=Class'BallisticProV55.DTX4KnifeLimb'
     KickForce=100
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds_25.X4.X4_Melee',Radius=378.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slash1"
     FireAnimRate=1.500000
     FireRate=0.400000
     AmmoClass=Class'BallisticProV55.Ammo_X4Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.100000
}
