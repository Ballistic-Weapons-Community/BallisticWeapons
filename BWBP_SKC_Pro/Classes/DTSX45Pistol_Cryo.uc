//=============================================================================
// DTGRSXXPistol.
//
// Damage type for the Colt M1911 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSX45Pistol_Cryo extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's handgun gave %o a lethal case of hypothermia."
     DeathStrings(1)="%o took a lot of %k's chilled bullets, enough to be chilled to death."
     DeathStrings(2)="%k made %o into an ice statue before he shattered into many pieces."
     DeathStrings(3)="%o's heart was turned into ice thanks to %k's icy .45's."
     WeaponClass=Class'BWBP_SKC_Pro.SX45Pistol'
     DeathString="%k shot down %o in %vh prime with his SX45K."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     VehicleDamageScaling=0.500000

	TagMultiplier=0.4
	TagDuration=0.4
}
