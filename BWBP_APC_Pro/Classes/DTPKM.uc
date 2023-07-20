//=============================================================================
// DTM353MG.
//
// Damage type for the M353 Machinegun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPKM extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o raged against %k's Soviet Machine and was gunned down."
     DeathStrings(1)="%k's PKMA ripped %o into 420 bloody pieces"
     DeathStrings(2)="%o made a futile effort against the might of %k's PKMA."
     DeathStrings(3)="%k's rimmed bullets ripped off %o's ankles."
     DeathStrings(4)="%o got distributed around 4-5 bullets in the gut thanks to %k."
     DamageIdent="Machinegun"
     WeaponClass=Class'BWBP_APC_Pro.PKMMachinegun'
     DeathString="%o was torn to shreds by %k's PKM."
     FemaleSuicide="%o shot herself in the foot with the PKM."
     MaleSuicide="%o shot himself in the foot with the PKM."
     bFastInstantHit=True
}
