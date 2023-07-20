//=============================================================================
// DTbatarang.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTbatarang extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k became Batman and took %o out sneakily."
     DeathStrings(1)="%k played Dark Knight with %o and killed him by accident."
     DeathStrings(2)="%o is going straight to the Gotham Cemetery."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh batarangs."
     FemaleSuicide="%o cracked herself with a batarang."
     MaleSuicide="%o cracked himself with a batarang."
}
