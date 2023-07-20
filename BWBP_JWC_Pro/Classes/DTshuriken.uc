//=============================================================================
// DTshuriken.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTshuriken extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k went ninja all over the place and killed %o."
     DeathStrings(1)="%k silently took out %o."
     DeathStrings(2)="Ching chang chong, %o was killed by %k's shurik...ong."
     DeathStrings(3)="%o got ninja'd by %k."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
     DeathString="%k punctured %o into sponge with %kh shuriken."
     FemaleSuicide="%o cracked herself with a shuriken."
     MaleSuicide="%o cracked himself with a shuriken."
}
