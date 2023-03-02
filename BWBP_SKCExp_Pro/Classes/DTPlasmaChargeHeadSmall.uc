//=============================================================================
// DTA73SkrithHead.
//
// Damage type for HVPC alt headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPlasmaChargeHeadSmall extends DTPlasmaChargeHead;

defaultproperties
{
     DeathStrings(0)="%k peppered %o's face with a plasma fusillade."
     DeathStrings(1)="%o looked %k's plasma bolt right in the eye."
     DeathStrings(2)="%o swallowed a plasma bolt for %k's team."
     DeathStrings(3)="%k gunned off %o's head with a plasma machinegun."
     DeathString="%k peppered %o's face with a plasma fusillade."
     FemaleSuicide="%o's H-VPC attacked her face."
     MaleSuicide="%o's H-VPC attacked his face."
	 WeaponClass=Class'BWBP_SKCExp_Pro.HVPCMk5PlasmaCannon'
     bAlwaysSevers=True
     bSpecial=True
}
