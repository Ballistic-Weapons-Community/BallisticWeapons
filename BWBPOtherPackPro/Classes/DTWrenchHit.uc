class DTWrenchHit extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k permanently adjusted %o's attitude."
     DeathStrings(1)="%k engineered %o's demise."
     DeathStrings(2)="%k loosened a few of %o's nuts."
     DeathStrings(3)="%k made sure %o no longer has a screw loose."
     DeathStrings(4)="%k 'fixed' %o."
     DeathStrings(5)="%k realigned %o's anatomy."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 BlockFatiguePenalty=0.4
	 BlockPenetration=0.25
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=0.75
     WeaponClass=Class'BWBPOtherPackPro.WrenchWarpDevice'
     DeathString="%k permanently adjusted %o's attitude."
     FemaleSuicide="%o adjusted her own attitude."
     MaleSuicide="%o adjusted his own attitude."
     VehicleDamageScaling=4.000000
}
