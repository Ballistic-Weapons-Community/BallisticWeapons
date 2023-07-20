//=============================================================================
// DTImmolation.
//
// Damage type for players caught alight by burning Gnomes.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkGnomeDaemonFire extends DTJunkDamage;

static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (BallisticPawn(Victim) == None)
		super.DoBloodEffects( HitLocation, Damage, Momentum, Victim, bLowDetail );
}

defaultproperties
{
     DeathStrings(0)="%k's underworld fire erupted under %o's feet."
     DeathStrings(1)="%o was scorched from below by %k's Gnome immolation."
     DeathStrings(2)="%k scourged %o from the map with hellfire."
     bIgniteFires=True
     DamageDescription=",Flame,Hazard,NonSniper,"
     DeathString="%k's underworld fire erupted under %o's feet."
     FemaleSuicide="%o scorched herself with hellfire."
     MaleSuicide="%o scorched himself with hellfire."
     bLocationalHit=False
     bCausesBlood=False
     GibPerterbation=0.500000
     KDamageImpulse=1000.000000
}
