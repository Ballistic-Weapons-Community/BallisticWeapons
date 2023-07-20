//=============================================================================
// FP7SecondaryFire.
// 
// FP7 Grenade rolled underhand
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A51SecondaryFire extends A51PrimaryFire;

defaultproperties
{
     NoClipPreFireAnim="RollNoClip"
     SpawnOffset=(Z=-14.000000)
     PreFireAnim="PrepRoll"
     FireAnim="Roll"
     ProjectileClass=Class'BWBP_SWC_Pro.A51Rolled'
}
