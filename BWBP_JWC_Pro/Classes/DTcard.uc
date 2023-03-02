//=============================================================================
// DTcard.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTcard extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k checkmated %o and... wait, wrong game."
     DeathStrings(1)="%o asked %k for an 8. He got it."
     DeathStrings(2)="%k got full street now the street's filled with %o's limbs."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh card."
     FemaleSuicide="%o cracked herself with a card."
     MaleSuicide="%o cracked himself with a card."
}
