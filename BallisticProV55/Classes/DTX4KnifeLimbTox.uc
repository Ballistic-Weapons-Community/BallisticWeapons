//=============================================================================
// DTX4KnifeLimb.
//
// Damagetype for X4 Knife limb hits
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX4KnifeLimbTox extends DTX4KnifeTox;

defaultproperties
{
     DeathStrings(0)="%k chopped off all of %o's fingers and toes with %kh X4 blade."
     DeathStrings(1)="%o was sliced, diced and filleted by %k's X4 knife."
     DeathStrings(2)="The X4 knife in %k's hand accidentally cut off %o's remaining limbs."
     DamageDescription=",Slash,Stab,"
     WeaponClass=Class'BallisticProV55.X4Knife'
     DeathString="%k chopped off all of %o's fingers and toes with %kh X4 blade."
     FemaleSuicide="%o juggled her X4 for the last time."
     MaleSuicide="%o juggled his X4 for the last time."
     bArmorStops=False
     bNeverSevers=True
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
