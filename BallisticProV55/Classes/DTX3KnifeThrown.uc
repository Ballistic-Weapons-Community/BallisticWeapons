//=============================================================================
// DTX3KnifeThrown.
//
// Damagetype for thrown X3 Knife
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX3KnifeThrown extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k pegged %o with %kh X3."
     DeathStrings(1)="%k flung a knife at %o."
     DeathStrings(2)="%k flicked a knife into %o's flesh."
	 SimpleKillString="X3 Thrown"
     bCanBeBlocked=False
     DamageIdent="Melee"
     DisplacementType=DSP_None
     WeaponClass=Class'BallisticProV55.X3Knife'
     DeathString="%k pegged %o with %kh X3."
     FemaleSuicide="%o threw a knife at herself."
     MaleSuicide="%o threw a knife at himself."
     bNeverSevers=True
     KDamageImpulse=1000.000000
}
