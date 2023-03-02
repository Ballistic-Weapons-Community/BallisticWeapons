//=============================================================================
// DTScarabHeld.
//
// Damage type for unreleased NRP57
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTScarabHeld extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o got a share of %k's suicide."
     DeathStrings(1)="%o came too close to pinapple crazy %k."
     DeathStrings(2)="%k killed %o with a self propelled grenade."
     FemaleSuicides(0)="%o held onto their explosive treasure a bit too long."
     FemaleSuicides(1)="%o became a meal for their own swarm of Scarabs."
     FemaleSuicides(2)="%o walked right into a swarm of clusters, their own to be exact."
     MaleSuicides(0)="%o held onto their explosive treasure a bit too long."
     MaleSuicides(1)="%o became a meal for their own swarm of Scarabs."
     MaleSuicides(2)="%o walked right into a swarm of clusters, their own to be exact."
     InvasionDamageScaling=3.000000
     DamageIdent="Grenade"
     bNoSeverStumps=True
     WeaponClass=Class'BWBP_APC_Pro.ScarabGrenade'
     DeathString="%o got a share of %k's suicide."
     FemaleSuicide="%o forgot to let go of her NRX-82."
     MaleSuicide="%o forgot to let go of his NRX-82."
     bSkeletize=True
     GibModifier=0.500000
     GibPerterbation=0.900000
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=0.350000
}
