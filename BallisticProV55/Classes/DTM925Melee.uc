//=============================================================================
// DTM925Melee.
//
// Damagetype for the M925 melee attack
//=============================================================================
class DTM925Melee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bludgeoned %o to death with the butt of %kh M925."
     DeathStrings(1)="%o was clubbed down by %k's M925."
     DeathStrings(2)="%k beat %o to a pulp with the M925."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=0.50
	 BlockFatiguePenalty=0.25
     WeaponClass=Class'BallisticProV55.M925Machinegun'
     DeathString="%k bludgeoned %o to death with the butt of %kh M925."
     FemaleSuicide="%o beat herself to death with the M925."
     MaleSuicide="%o beat himself to death with the M925."
}
