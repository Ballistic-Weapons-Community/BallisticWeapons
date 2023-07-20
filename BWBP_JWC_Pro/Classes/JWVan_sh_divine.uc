//=============================================================================
// Divine.
//
// Holy shi..eld.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_sh_divine extends JunkShield;

var float  NextRegenTime;

simulated event Tick(float DT)
{
 super.Tick(DT);
 if (Instigator.Health > 0 && level.TimeSeconds >= NextRegenTime && bActive)
 {
  Instigator.GiveHealth(1, Instigator.HealthMax);
  if (bBlocking)
   Instigator.GiveHealth(1, Instigator.HealthMax*1.50);
  NextRegenTime = level.TimeSeconds + 0.5; 
 }
}

defaultproperties
{
     DownDir=(Pitch=-4296,Yaw=-8592)
     UpDir=(Yaw=-3096)
     DownCoverage=85.000000
     BlockRate=15.500000
     rating=85.000000
     ShieldPropClass=Class'BWBP_JWC_Pro.JWVan_sh_divineProp'
     AttachOffset=(X=0.000000,Y=0.150000,Z=1.000000)
     AttachPivot=(Pitch=1024,Yaw=-16000,Roll=0)
     Health=3500
     HurtThreshold=5000
     MaxProtection=5000
     PickupClass=Class'BWBP_JWC_Pro.JWVan_sh_divinePickup'
     PlayerViewOffset=(X=-10.000000,Y=16.000000)
     AttachmentClass=Class'BWBP_JWC_Pro.JWVan_sh_divineAttachment'
     ItemName="Divine Shield"
}
