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
     DeathStrings(0)="%k's knife defied all odds to enter %o's vodka-blurred eye."
     DeathStrings(1)="%k drunkenly launched a knife into %o's face."
     DeathStrings(2)="%o took a knife to the eye from %k's PKM launcher."
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
