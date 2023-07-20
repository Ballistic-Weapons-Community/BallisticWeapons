//=============================================================================
// JO_TwoByFour.
//
// A piece-of-crap wood with attached metal objects. Every thug has one of these.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_TwoByFour extends JunkObject;

defaultproperties
{
     HandOffset=(X=4.000000,Z=-1.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.2x4LD'
     PickupDrawScale=0.400000
     PickupMessage="You got the 2x4"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.2x4'
     RightGripStyle=GS_2x4
     AttachOffset=(X=1.000000,Y=-1.300000,Z=4.000000)
     AttachPivot=(Yaw=-2048,Roll=-750)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=140.000000,Max=140.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTwoByFour'
         HookStopFactor=1.000000
         Damage=(head=100,Limb=30,Misc=47)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkTwoByFour'
         RefireTime=0.600000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="WideHit1"
         Anims(1)="WideHit2"
         Anims(2)="WideHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_TwoByFour.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=145.000000,Max=145.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTwoByFour'
         HookStopFactor=1.000000
         Damage=(head=120,Limb=32,Misc=57)
         KickForce=20000
         DamageType=Class'BWBP_JWC_Pro.DTJunkTwoByFour'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="WideAttack"
         PreFireAnims(0)="WidePrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_TwoByFour.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Heavy')
     FriendlyName="2x4"
     InventoryGroup=2
     MeleeRating=80.000000
     RangeRating=0.000000
     PainThreshold=55
     NoUseThreshold=105
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.2x4'
     DrawScale=0.850000
}
