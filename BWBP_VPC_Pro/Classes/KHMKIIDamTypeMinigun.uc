//=============================================================================
//The Minigun damage type for the KH MarkII Cobra.
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================
class KHMKIIDamTypeMinigun extends BE_DT_Manager;

defaultproperties
{
     DeathStrings(0)="%o is now leaking like a colander thanks to %k's Cobra machinegun."
     DeathStrings(1)="%k's Cobra machinegun punctured %o like a pin cushion."
     DeathStrings(2)="%o couldn't take the number of holes that %k's Cobra machinegun delivered."
     FemaleSuicides(0)="%o shot herself with a Cobra machinegun in hopes of becoming a colander."
     FemaleSuicides(1)="%o was all too curious when it came to inspecting Cobra machinegun barrels."
     MaleSuicides(0)="%o shot himself with a Cobra machinegun in hopes of becoming a colander."
     MaleSuicides(1)="%o was all too curious when it came to inspecting Cobra machinegun barrels."
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.360000
}
