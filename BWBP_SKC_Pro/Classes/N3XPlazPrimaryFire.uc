//=============================================================================
// N3X Fists Primary.
//
// Rapid, two handed jabs with reasonable range. Everything is timed by notifys
// from the anims
//
// by Casey "Xavious" Johnson and Azarael
//=============================================================================
class N3XPlazPrimaryFire extends BallisticMeleeFire;

var() float 	MinDamage, MaxDamage;

var() Array<name> SliceAnims;
var int SliceAnim;

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	Damage = FClamp(MinDamage, MinDamage + (N3XPlaz(BW).HeatLevel * (MaxDamage - MinDamage))/(N3XPlaz(BW).MaxHeat), MaxDamage);
	super.ApplyDamage(Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
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
	 SliceAnims(0)="Swing1"
     SliceAnims(1)="Swing2"
     SliceAnims(2)="Swing4"
     SliceAnims(3)="Swing3"
     FatiguePerStrike=0.150000
	 MinDamage=40.000000
	 MaxDamage=100.000000
     DamageType=Class'BWBP_SKC_Pro.DTShockN3X'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTShockN3X'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTShockN3X'
     KickForce=20000
     bUseWeaponMag=False
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExp.NEX.NEX-SlashAttack',Radius=32.000000,bAtten=True)
     bAISilent=True
     FireAnim="Chop3"
     FireAnimRate=1.650000
     FireRate=0.600000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_N3XCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
