//=============================================================================
// DTNRP57Held.
//
// Damage type for unreleased NRP57
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA51Held extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o got a share of %k's suicide."
     DeathStrings(1)="%o came too close to acidify crazy %k."
     DeathStrings(2)="%k killed %o with a Self Propelled Grenade."
     FemaleSuicides(0)="%o forgot to let go of her A51."
     FemaleSuicides(1)="%o couldn't part with her A51 so it parted her."
     MaleSuicides(0)="%o forgot to let go of his A51."
     MaleSuicides(1)="%o couldn't part with his A51 so it parted him."
     bNoSeverStumps=True
     WeaponClass=Class'BWBP_SWC_Pro.A51Grenade'
     DeathString="%o got a share of %k's suicide."
     FemaleSuicide="%o forgot to let go of her A51."
     MaleSuicide="%o forgot to let go of his A51."
     bSkeletize=True
     GibModifier=0.500000
     GibPerterbation=0.900000
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=1.500000
}
