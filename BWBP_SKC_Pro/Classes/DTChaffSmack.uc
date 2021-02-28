//=============================================================================
// DTChaffSmack.
//
// Damagetype for BEATING PEOPLE WITH A GRENADE
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTChaffSmack extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="A psychotic %k beat %o to death with a grenade."
     DeathStrings(1)="%k taught %o the meaning of an MOA-C 'potato masher'."
     DeathStrings(2)="%o got smacked upside the head by %k's smoke grenade."
     SimpleKillString="MOAC Chaff Melee"
     WeaponClass=Class'BWBP_SKC_Pro.ChaffGrenadeWeapon'
     DeathString="A psychotic %k beat %o to death with a grenade."
     FemaleSuicide="%o cracked her skull with her own grenade."
     MaleSuicide="%o cracked his skull with his smoke grenade."
     bExtraMomentumZ=True
	 BlockFatiguePenalty=0.2
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.100000
     VehicleMomentumScaling=1.300000
}
