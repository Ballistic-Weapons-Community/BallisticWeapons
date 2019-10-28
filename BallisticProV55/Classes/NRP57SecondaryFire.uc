//=============================================================================
// NRP57SecondaryFire.
//
// NRP57 Grenade rolled underhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class NRP57SecondaryFire extends NRP57PrimaryFire;

defaultproperties
{
     NoClipPreFireAnim="RollNoClip"
     SpawnOffset=(Z=-14.000000)
     PreFireAnim="PrepRoll"
     FireAnim="Roll"
     ProjectileClass=Class'BallisticProV55.NRP57Rolled'
}
