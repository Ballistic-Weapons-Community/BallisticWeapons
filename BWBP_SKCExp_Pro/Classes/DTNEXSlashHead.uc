//=============================================================================
// DTGRS9LaserHead.
//
// DT for GRS9 laser headshots. Adds red blinding effect and motion blur
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTNEXSlashHead extends DT_BWBlade;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF, default.FlashV);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF=0.800000
     FlashV=(X=2000.000000,Y=700.000000,Z=700.000000)
     DeathStrings(0)="%k lopped %o's head with a clean sweep of the NEX."
     DeathStrings(1)="%o's head made a good stone for %k's sword."
     DeathStrings(2)="%k rammed the tip of %kh Plas-Edge into %o's neck."
     DeathStrings(3)="%k stuck %kh sword in between %o's ears."
     DeathStrings(4)="%o had %vh eyes poked out by %k."
     BloodManagerName="BWBP_SKC_Pro.BloodMan_HMCLaser"
     ShieldDamage=3
     bIgniteFires=True
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKCExp_Pro.N3XPlaz'
     DeathString="%k lopped %o's head with a clean sweep of the NEX."
     FemaleSuicide="%o burnt her head off..."
     MaleSuicide="%o burnt his head off..."
     bArmorStops=False
     bAlwaysSevers=True
     GibModifier=3.000000
     PawnDamageSounds(0)=SoundGroup'BWBP_SKC_SoundsExp.NEX.Nex-HitBod'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
