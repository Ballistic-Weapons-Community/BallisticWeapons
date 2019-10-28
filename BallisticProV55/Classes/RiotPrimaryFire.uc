//=============================================================================
// EKS43PrimaryFire.
//
// Horizontalish swipe attack for the EKS43. Uses melee swpie system to do
// horizontal swipes. When the swipe traces find a player, the trace closest to
// the aim will be used to do the damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RiotPrimaryFire extends BallisticMeleeFire;

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
     SliceAnims(0)="Slam"
     SliceAnims(1)="Slam"
     SliceAnims(2)="Slam"
     SliceAnims(3)="Slam"
     TraceRange=(Min=96.000000,Max=96.000000)
     Damage=65.000000
     DamageHead=65.000000
     DamageLimb=65.000000
     DamageType=Class'BallisticProV55.DTRiotShield'
     DamageTypeHead=Class'BallisticProV55.DTRiotShield'
     DamageTypeArm=Class'BallisticProV55.DTRiotShield'
     KickForce=13000
     HookStopFactor=1.700000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=32.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slam"
     FireRate=1.000000
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=512.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.100000
}
