//=============================================================================
// DTcaltrop.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTcaltrop extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k set up a caltrop trap for %o."
     DeathStrings(1)="%o didn't watch out and walked into %k's caltrops."
     DeathStrings(2)="%k let %o taste %kh caltrops."
     DeathStrings(3)="%o tumbled into a couple of caltrops."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh caltrop."
     FemaleSuicide="%o walked into her own caltrops."
     MaleSuicide="%o walked into his own caltrops."
}
