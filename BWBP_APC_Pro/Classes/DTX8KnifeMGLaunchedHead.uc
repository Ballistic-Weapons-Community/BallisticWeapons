//=============================================================================
// DTX8KnifeRifleLaunchedHead.
//
// Damagetype for launched X8 Knife hitting heads
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX8KnifeMGLaunchedHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k ran out of bullets, but %kh small knife pierced %o's retina."
     DeathStrings(1)="%o stared down the wrong end of %k's MG, should've seen the ballistic knife poking %vh eye."
     DeathStrings(2)="%k had one last surprise for %o, a ballistic knife to the dome."
     SimpleKillString="PKMA - X8 Ballistic Knife"
     bCanBeBlocked=False
     bHeaddie=True
     WeaponClass=Class'BWBP_APC_Pro.PKMMachinegun'
     DeathString="%k's knife defied all odds to enter %o's vodka-blurred eye."
     FemaleSuicide="%o's PKM bayonet gave her a surprise."
     MaleSuicide="%o's PKM bayonet gave him a surprise."
     bArmorStops=False
     bNeverSevers=True
     KDamageImpulse=1000.000000
}
