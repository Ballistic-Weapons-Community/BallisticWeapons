//=============================================================================
// DT_MACRadius.
//
// DamageType for the HAMR Cannon radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MACRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o couldn't quite outrun %k's artillery shell."
     DeathStrings(1)="%k demolished %o with %kh HAMR."
     DeathStrings(2)="%o was annihilated by %k's artillery cannon."
     DeathStrings(3)="%k's HAMR round splintered %o into tiny pieces."
     FemaleSuicides(0)="%o totally eradicated herself with her HAMR."
     FemaleSuicides(1)="%o splintered herself with a HAMR cannon."
     MaleSuicides(0)="%o totally eradicated himself with his HAMR."
     MaleSuicides(1)="%o splintered himself with a HAMR cannon."
     InvasionDamageScaling=2.000000
     DamageIdent="Ordnance"
     WeaponClass=Class'BallisticProV55.MACWeapon'
     DeathString="%o couldn't quite outrun %k's artillery shell."
     FemaleSuicide="%o totally eradicated herself with her HAMR."
     MaleSuicide="%o totally eradicated himself with his HAMR."
     bDelayedDamage=True
     bExtraMomentumZ=True
     VehicleDamageScaling=1.500000
}
