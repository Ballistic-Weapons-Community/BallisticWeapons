//=============================================================================
// ScarabPrimaryFire.
//
// Scarab Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ScarabPrimaryFire extends BallisticHandGrenadeFire;

defaultproperties
{
     NoClipPreFireAnim="ThrowNoClip"
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassClass=Class'BallisticProV55.Brass_GClip'
     BrassBone="tip"
     BrassOffset=(X=10.000000)
     BallisticFireSound=(Sound=Sound'BWBP_CC_Sounds.CruGren.CruGren-Throw',Radius=32.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     AmmoClass=Class'BallisticProV55.Ammo_Pineapple'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBP_APC_Pro.ScarabThrown'
	 
	 // AI
	 BotRefireRate=0.4
     WarnTargetPct=0.75
}
