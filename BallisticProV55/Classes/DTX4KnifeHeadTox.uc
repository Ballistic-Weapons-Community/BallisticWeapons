//=============================================================================
// DTX4KnifeHead.
//
// DamageType for the X4 headshots
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX4KnifeHeadTox extends DTX4KnifeTox;

defaultproperties
{
     DeathStrings(0)="%k's carved %kh name on %o's face with %kh X4 blade."
     DeathStrings(1)="%o lost %vh ears and eyes to %k's X4 blade."
     DeathStrings(2)="%k jammed %kh X4 in %o's skull and wriggled it around a bit."
     DamageDescription=",Slash,Stab,"
     WeaponClass=Class'BallisticProV55.X4Knife'
     DeathString="%k's X4 was used to separate %o from %vh head."
     FemaleSuicide="%o attempted brain surgery on herself with an X4."
     MaleSuicide="%o attempted brain surgery on himself with an X4."
     bArmorStops=False
     bNeverSevers=False
     bSpecial=True
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
