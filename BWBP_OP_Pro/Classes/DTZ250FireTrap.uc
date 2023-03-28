//=============================================================================
// DTRX22AFireTrap.
//
// Damage type for RX22A surface fires
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTZ250FireTrap extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o dipped %vh toes into %k's puddle of hellfire before being cremated."
     DeathStrings(1)="%k laid %kh trap for %o to fall into perfectly, shame %ve got overcooked."
     DeathStrings(2)="%o tripped into %k's patch of fire, what a clumsy fool."
     DeathStrings(3)="%k's Z250 managed to transform %o into a roasted turkey after burning %vm."
     BloodManagerName="BallisticProV55.BloodMan_FireExploded"
     bIgnoredOnLifts=True
     InvasionDamageScaling=1.500000
     DamageIdent="Machinegun"
     bOnlySeverLimbs=True
     WeaponClass=Class'BWBP_OP_Pro.Z250Minigun'
     DeathString="%o swam in %k's fire."
     FemaleSuicide="%o ran into a fire."
     MaleSuicide="%o ran into a fire."
     bDelayedDamage=True
     KDamageImpulse=2000.000000
}
