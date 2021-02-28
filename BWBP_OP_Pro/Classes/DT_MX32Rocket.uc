//=============================================================================
// DT_MRL.
//
// DamageType for the JL-21 PeaceMaker
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MX32Rocket extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o's heart went boom, along with the rest of him due to %k's barrage."
     DeathStrings(1)="%k made it rain with a storm of rockets landing on %o's head."
     DeathStrings(2)="%o couldn’t outrun a guided cloud of rockets coming from %k’s MX32."
     DeathStrings(3)="%k directed some explosive maelstrom on %o, blowing him to smithereens."
     SimpleKillString="MX-32 Rocket"
     DamageIdent="Sniper"
     WeaponClass=Class'BWBP_OP_Pro.MX32Weapon'
     DeathString="%o's heart went boom, along with the rest of him due to %k's barrage."
     FemaleSuicide="%o had her heart set aflame by a MX32 rocket."
     MaleSuicide="%o had his heart set aflame by a MX32 rocket."
     bDelayedDamage=True
     bExtraMomentumZ=True
}
