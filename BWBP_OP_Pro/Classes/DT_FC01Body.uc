//=============================================================================
// DT_FC01Body.
//
// Damage type for the FC01 Smartgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FC01Body extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k didn't unleash a photon stream, but a bullet stream to kill %o."
     DeathStrings(1)="%o was peppered and ripped into shreds silently by %k's proto PDW."
     DeathStrings(2)="%k flooded %o's lungs with lead, drowning %vm literally in bullets."
     DeathStrings(3)="%o didn't want to be subjected to experimental photon tech, so %k just shot %vm with bullets."
     WeaponClass=Class'BWBP_OP_Pro.FC01SmartGun'
     DeathString="%o was torn to shreds by %k's FC01-B."
     FemaleSuicide="%o shot herself in the foot with the FC01-B."
     MaleSuicide="%o shot himself in the foot with the FC01-B."
     bFastInstantHit=True
}
