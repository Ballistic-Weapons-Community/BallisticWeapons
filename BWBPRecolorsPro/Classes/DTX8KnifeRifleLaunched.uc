//=============================================================================
// DTX8KnifeRifleLaunched .
//
// Damagetype for RifleLaunched X8 Knife
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX8KnifeRifleLaunched extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k showed %o how in %kh country, KNIFE SHOOTS YOU."
     DeathStrings(1)="%k hit the wrong trigger and pegged %o with a knife."
     DeathStrings(2)="%o mistakenly brought a gun to %k's ballistic knife fight."
     SimpleKillString="X8 Ballistic Knife Launched"
     bCanBeBlocked=False
     bDisplaceAim=False
     WeaponClass=Class'BWBPRecolorsPro.X8Knife'
     DeathString="%k showed %o how in %kh country, KNIFE SHOOTS YOU."
     FemaleSuicide="%o played Russian roulette with her knife launcher."
     MaleSuicide="%o played Russian roulette with his knife launcher."
     bArmorStops=False
     bNeverSevers=True
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.100000
}
