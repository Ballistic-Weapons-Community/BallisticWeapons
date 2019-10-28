//=============================================================================
// DTleMatShotgunHead.
//
// Damage type for Wilson DB Shotgun headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTleMatShotgunHead extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k uncorked %o with the leMat."
     DeathStrings(1)="%o caught %k's desperation shot in the left ear."
     DeathStrings(2)="%k showed %o the tenth shot."
     DeathStrings(3)="%k's town wasn't big enough for %o's head."
     DeathStrings(4)="%k snaked %o in the face with %kh diamond back."
     SimpleKillString="Wilson 41 Shotgun"
     bHeaddie=True
     DamageIdent="Shotgun"
     WeaponClass=Class'BallisticProV55.leMatRevolver'
     DeathString="%k uncorked %o with the leMat."
     FemaleSuicide="%o nailed herself with the leMat."
     MaleSuicide="%o nailed himself with the leMat."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.400000
     KDamageImpulse=10000.000000
}
