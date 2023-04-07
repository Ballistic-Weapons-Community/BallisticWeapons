//=============================================================================
// NRP57PrimaryFire.
//
// NRP57 Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class NRP57PrimaryFire extends BallisticHandGrenadeFire;

defaultproperties
{
     NoClipPreFireAnim="ThrowNoClip"
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassClass=Class'BallisticProV55.Brass_GClip'
     BrassBone="tip"
     BrassOffset=(X=10.000000)
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=12.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     AmmoClass=Class'BallisticProV55.Ammo_Pineapple'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.NRP57Thrown'
	 
	 // AI
	 BotRefireRate=0.4
     WarnTargetPct=0.75
}
