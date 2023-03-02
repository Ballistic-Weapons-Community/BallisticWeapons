//=============================================================================
// DTcandle.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTcandle extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o got enlightened by %k."
     DeathStrings(1)="%o was knocked out by a candlestick."
     DeathStrings(2)="%k celebrated Chanukka on %o's head."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=180
     DamageDescription=",Hack,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkFireAxe'
     DeathString="%o was completey halved by %k's candlestick assault."
     FemaleSuicide="%o halved herself with a candlestick."
     MaleSuicide="%o halved himself with a candlestick."
     bNeverSevers=False
}
