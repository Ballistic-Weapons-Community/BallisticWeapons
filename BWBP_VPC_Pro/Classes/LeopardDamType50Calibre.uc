//=============================================================================
//The .50 Calibre damage type for the Leopard TMV.
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================
class LeopardDamType50Calibre extends BE_DT_Manager;

defaultproperties
{
     DeathStrings(0)="%o was drilled by %k's TMV .50 Calibre machinegun."
     DeathStrings(1)="%k's TMV .50 Cal softened %o into a lifeless pile."
     DeathStrings(2)="%o couldn't hide before %k's TMV .50 Cal got him down."
     DeathStrings(3)="%o was overcome by the power of %k's TMV .50 Cal."
     FemaleSuicides(0)="%o shot herself with a TMV .50 Cal."
     FemaleSuicides(1)="%o was all too curious when it came to inspecting TMV .50 Cal barrels."
     MaleSuicides(0)="%o shot himself with a TMV .50 Cal."
     MaleSuicides(1)="%o was all too curious when it came to inspecting TMV .50 Cal barrels."
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.360000
}
