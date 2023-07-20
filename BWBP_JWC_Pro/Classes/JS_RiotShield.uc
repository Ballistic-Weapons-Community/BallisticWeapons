//=============================================================================
// JS_RiotShield.
//
// A handy police riot shield
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JS_RiotShield extends JunkShield;

defaultproperties
{
     UpDir=(Yaw=-4096)
     UpCoverage=0.300000
     BlockRate=0.900000
     rating=65.000000
     ShieldPropClass=Class'BWBP_JWC_Pro.JS_RiotShieldProp'
     AttachOffset=(Y=0.000000,Z=1.000000)
     AttachPivot=(Pitch=1024,Yaw=-16000,Roll=14000)
     Health=650
     HurtThreshold=40
     MaxProtection=250
     PickupClass=Class'BWBP_JWC_Pro.JS_RiotShieldPickup'
     PlayerViewOffset=(X=0.000000,Y=9.000000,Z=-20.000000)
     AttachmentClass=Class'BWBP_JWC_Pro.JS_RiotShieldAttachment'
     ItemName="Riot Shield"
}
