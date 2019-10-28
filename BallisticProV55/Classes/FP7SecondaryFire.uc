//=============================================================================
// FP7SecondaryFire.
// 
// FP7 Grenade rolled underhand
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7SecondaryFire extends FP7PrimaryFire;

defaultproperties
{
     NoClipPreFireAnim="RollNoClip"
     SpawnOffset=(Z=-14.000000)
     PreFireAnim="PrepRoll"
     FireAnim="Roll"
     ProjectileClass=Class'BallisticProV55.FP7Rolled'
}
