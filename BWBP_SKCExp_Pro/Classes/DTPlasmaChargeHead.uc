//=============================================================================
// DTA73SkrithHead.
//
// Damage type for A73 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPlasmaChargeHead extends DTPlasmaCharge;

defaultproperties
{
     DeathStrings(0)="%k melted %o's face with %kh plasma cannon."
     DeathStrings(1)="%o took a burning red ball to the face, courtesy of %k."
     DeathStrings(2)="%o was force fed electrically charged plasma by %k."
     DeathStrings(3)="%k blasted %o's head off with his plasma cannon."
     DeathString="%k melted %o's face with %kh plasma cannon."
     FemaleSuicide="%o's H-VPC attacked her face."
     MaleSuicide="%o's H-VPC attacked his face."
	 WeaponClass=Class'BWBP_SKCExp_Pro.HVPCMk5PlasmaCannon'
     bAlwaysSevers=True
     bSpecial=True
}
