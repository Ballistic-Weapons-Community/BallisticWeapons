//=============================================================================
// N3X Fists Secondary.
//
// Devastating uppercut which can also heal allies.
// by Casey "Xavious" Johnson and Azarael
//=============================================================================
class N3XPlazSecondaryFire extends BallisticMeleeFire;

var() float 	MinDamage, MaxDamage;

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	Damage = FClamp(MinDamage, MinDamage + (N3XPlaz(BW).HeatLevel * (MaxDamage - MinDamage))/(N3XPlaz(BW).MaxHeat), MaxDamage);
	super.ApplyDamage(Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
}

defaultproperties
{
     bCanBackstab=False
	 MinDamage=70.000000
	 MaxDamage=150.000000
	 FatiguePerStrike=0.400000
     DamageType=Class'BWBP_SKC_Pro.DTShockN3XAlt'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTShockN3XAlt'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTShockN3XAlt'
     KickForce=500
     bUseWeaponMag=False
	 bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroSwing',Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
	 PreFireAnim="PrepHack"
     FireAnim="Hack"
     FireAnimRate=1.500000
     FireRate=1.200000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_N3XCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
