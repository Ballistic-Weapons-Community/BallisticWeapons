//=============================================================================
// JO_RollingPin.
//
// Used by maniacal chefs to pound the grasping fingers of orphans.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_RollingPin extends JunkObject;

defaultproperties
{
     HandOffset=(X=5.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.RollingPinLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Rolling Pin"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.RollingPin'
     RightGripStyle=GS_Crowbar
     AttachOffset=(Y=-0.500000,Z=2.000000)
     AttachPivot=(Roll=-500)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=130.000000,Max=130.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkRollingPin'
         HookStopFactor=1.000000
         Damage=(head=90,Limb=17,Misc=37)
         KickForce=7000
         DamageType=Class'BWBP_JWC_Pro.DTJunkRollingPin'
         RefireTime=0.600000
         AnimRate=1.200000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing',Pitch=0.850000)
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_RollingPin.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=135.000000,Max=135.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkRollingPin'
         HookStopFactor=1.000000
         Damage=(head=110,Limb=22,Misc=50)
         KickForce=12000
         DamageType=Class'BWBP_JWC_Pro.DTJunkRollingPin'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing',Pitch=0.800000)
         Anims(0)="WideAttack"
         PreFireAnims(0)="WidePrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Early
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_RollingPin.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Rolling Pin"
     RangeRating=0.000000
     PainThreshold=35
     NoUseThreshold=65
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.RollingPin'
     DrawScale=1.650000
}
