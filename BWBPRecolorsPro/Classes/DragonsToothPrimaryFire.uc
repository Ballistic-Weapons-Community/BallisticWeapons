//=============================================================================
// DragonsToothPrimaryFire.
//
// Horizontalish swipe attack for the EKS43. Uses melee swpie system to do
// horizontal swipes. When the swipe traces find a player, the trace closest to
// the aim will be used to do the damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DragonsToothPrimaryFire extends BallisticMeleeFire;

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
     SliceAnims(0)="Swing1"
     SliceAnims(1)="Swing2"
     SliceAnims(2)="Swing3"
     FatiguePerStrike=0.025
     bCanBackstab=False
     TraceRange=(Min=160.000000,Max=160.000000)
     Damage=75.000000
     DamageHead=75.000000
	DamageLimb=75.000000
	FireRate=0.55
     DamageType=Class'BWBPRecolorsPro.DT_DTSChest'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_DTSHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_DTSLimb'
     KickForce=100
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.DTS.DragonsTooth-Swipe',Volume=4.100000,Radius=256.000000,bAtten=True)
     bAISilent=True
	FireAnim="Slash1"
	FireAnimRate=1.25
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=256.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.800000
}
