//=============================================================================
// Unarmed G5 damagetype
//=============================================================================
class DTRGPXUnarmed extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%o was a victim of taking %k's unarmed rocket to the groin, no more children for them."
     DeathStrings(1)="%k found that not even dislocating %o's jaw was good enough to swallow their rocket."
     DeathStrings(2)="%o had their windpipe crushed by %k's unarmed RGX rocket."
     DeathStrings(3)="%k was danger close, but still managed to end %o's life without blowing themselves up."
     DeathStrings(4)="%o captured %k's unarmed rocket with their teeth."
	 SimpleKillString="RGPX Bazooka Impact"
     InvasionDamageScaling=2.000000
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBP_JCF_Pro.RGPXBazooka'
     DeathString="%o was knocked into next week by %k's unarmed G5."
     FemaleSuicide="%o somehow managed to hit herself with her own G5 rocket."
     MaleSuicide="%o somehow managed to hit himself with his own G5 rocket."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
     VehicleMomentumScaling=0.200000
}
