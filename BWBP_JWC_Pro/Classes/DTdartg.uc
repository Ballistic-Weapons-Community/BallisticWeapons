//=============================================================================
// DTdartg.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTDartg extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="A single golden dart was enough for %k to kill %o."
     DeathStrings(1)="%o got some new holes now."
     DeathStrings(2)="%k scored a golden dart kill on %o's head."
     DeathStrings(3)="%k did an epic 360° golden dart ultra kill. %o was involved and died."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh golden dart."
     FemaleSuicide="%o cracked herself with a golden dart."
     MaleSuicide="%o cracked himself with a golden dart."
     bAlwaysGibs=True
}
