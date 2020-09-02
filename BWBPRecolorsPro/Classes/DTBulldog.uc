//=============================================================================
// DTBulldog.
//
// Damage type for the AH104 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBulldog extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's Bulldog chewed up and spat out %o."
     DeathStrings(1)="%k ripped apart %o with %kh Bulldog."
     DeathStrings(2)="%o couldn't run fast enough from %k's Bulldog."
     DeathStrings(3)="%k's Bulldog mercilessly blasted %o into little bits."
     DeathStrings(4)="%o's life was ended by %k's rabid Bulldog."
     DeathStrings(5)="%k's Bulldog bit huge chunks out of %o."
     DeathStrings(6)="%k tore %o's limbs off with a menacing Bulldog."
     bIgniteFires=True
     InvasionDamageScaling=2
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBPRecolorsPro.BulldogAssaultCannon'
     DeathString="%k's Bulldog chewed up and spat out %o."
     FemaleSuicide="%o rocked her world with the Bulldog."
     MaleSuicide="%o's Bulldog rocked his world."
     bExtraMomentumZ=True
     VehicleDamageScaling=1.000000
     VehicleMomentumScaling=0.500000
}
