//=============================================================================
// T10SecondaryFire.
//
// T10 Grenade rolled underhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class T10SecondaryFire extends T10PrimaryFire;

defaultproperties
{
     NoClipPreFireAnim="RollNoClip"
     SpawnOffset=(Z=-14.000000)
     PreFireAnim="PrepRoll"
     FireAnim="Roll"
     ProjectileClass=Class'BallisticProV55.T10Rolled'
}
