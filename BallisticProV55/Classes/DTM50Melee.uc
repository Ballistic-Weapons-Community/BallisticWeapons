//=============================================================================
// DTM50Melee.
//
// Damagetype for the M50 melee attack
//=============================================================================
class DTM50Melee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bludgeoned %o to death with the butt of %kh M50."
     DeathStrings(1)="%o was clubbed down by %k's M50."
     DeathStrings(2)="%k beat %o to a pulp with the M50."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=0.50
	 BlockFatiguePenalty=0.25
     WeaponClass=Class'BallisticProV55.M50AssaultRifle'
     DeathString="%k bludgeoned %o to death with the butt of %kh M50."
     FemaleSuicide="%o beat herself to death with the M50."
     MaleSuicide="%o beat himself to death with the M50."
}
