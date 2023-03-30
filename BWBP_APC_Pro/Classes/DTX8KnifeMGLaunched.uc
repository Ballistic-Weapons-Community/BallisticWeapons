//=============================================================================
// DTX8KnifeRifleLaunched .
//
// Damagetype for RifleLaunched X8 Knife
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX8KnifeMGLaunched extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o never saw %k's small ballistic knife on %kh big PKMA."
     DeathStrings(1)="%k showed %o it's not the size that matters, it's how you use it."
     DeathStrings(2)="%o mistakenly brought a gun to %k's ballistic knife fight, again."
     SimpleKillString="PKMA - X8 Ballistic Knife"
     bCanBeBlocked=False
     WeaponClass=Class'BWBP_APC_Pro.PKMMachinegun'
     DeathString="%k showed %o how in %kh country, KNIFE SHOOTS YOU."
     FemaleSuicide="%o played Russian roulette with her knife launcher."
     MaleSuicide="%o played Russian roulette with his knife launcher."
     bArmorStops=False
     bNeverSevers=True
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.100000
}
