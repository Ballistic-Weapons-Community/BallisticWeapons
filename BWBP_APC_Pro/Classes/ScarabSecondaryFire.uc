//=============================================================================
// ScarabSecondaryFire.
//
// NRP57 Grenade rolled underhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ScarabSecondaryFire extends ScarabPrimaryFire;

defaultproperties
{
     NoClipPreFireAnim="RollNoClip"
     SpawnOffset=(Z=-14.000000)
     PreFireAnim="PrepRoll"
     FireAnim="Roll"
     ProjectileClass=Class'BWBP_APC_Pro.ScarabRolled'
}
