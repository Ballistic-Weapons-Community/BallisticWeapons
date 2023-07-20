//=============================================================================
// SMATSuicide.
//
// DamageType for the Suicide!!
//
// by SK
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSMATSuicide extends DT_BWExplode;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF, default.FlashV);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF=0.100000
     FlashV=(X=2000.000000,Y=600.000000,Z=600.000000)
     DeathStrings(0)="%o played with a suicide bomber."
     DeathStrings(1)="%o was a little too close to detonator-crazy %k."
     DeathStrings(2)="%k blew %kh gun and %o to hell."
     WeaponClass=Class'BWBP_SKC_Pro.SMATLauncher'
     DeathString="%o played with a suicide bomber."
     FemaleSuicide="%o activated the self-destruct."
     MaleSuicide="%o activated the self-destruct."
     bDelayedDamage=True
}
