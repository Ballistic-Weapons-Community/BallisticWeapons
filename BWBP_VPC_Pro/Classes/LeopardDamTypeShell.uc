//=============================================================================
//The primary shell damage type for the Leopard TMV.
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================
class LeopardDamTypeShell extends BE_DT_Manager;

defaultproperties
{
     DeathStrings(0)="%o was popped by %k's TMV Shell."
     DeathStrings(1)="%k's TMV Shell turned %o into a crispy critter."
     DeathStrings(2)="%o pulled off a 'flying grass hopper' impression with the aid of %k's TMV Shell."
     DeathStrings(3)="%o saw the pretty light's of %k's TMV Shell."
     DeathStrings(4)="%o was splattered like so many italian tomatos by %k's TMV Shell."
     FemaleSuicides(0)="%o's TMV and it's fire button where all too big for her childish self."
     FemaleSuicides(1)="%o tried to shoot through walls with her TMV Shell."
     FemaleSuicides(2)="%o blew her top off with a TMV Shell."
     MaleSuicides(0)="%o's TMV and it's fire button where all too big for his childish self."
     MaleSuicides(1)="%o tried to shoot through walls with his TMV Shell."
     MaleSuicides(2)="%o blew his top off with a TMV Shell."
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=2000.000000
     VehicleDamageScaling=0.360000
}
