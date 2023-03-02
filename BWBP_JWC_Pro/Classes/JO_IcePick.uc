//=============================================================================
// JO_IcePick.
//
// Used for climbing glaciers, icy cliffs and opponents faces.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_IcePick extends JunkObject;

defaultproperties
{
     HandOffset=(X=3.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.IcePickLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Ice Pick"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.Icepick'
     RightGripStyle=GS_IcePick
     AttachOffset=(X=-0.200000,Y=-1.000000,Z=1.000000)
     AttachPivot=(Pitch=-1024,Yaw=-2048,Roll=-1000)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkIcePick'
         HookStopFactor=1.200000
         HookPullForce=100.000000
         Damage=(head=87,Limb=15,Misc=32)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTJunkIcePick'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_IcePick.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkIcePick'
         HookStopFactor=1.200000
         HookPullForce=100.000000
         Damage=(head=100,Limb=17,Misc=40)
         KickForce=9000
         DamageType=Class'BWBP_JWC_Pro.DTJunkIcePick'
         RefireTime=0.500000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Swing')
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_IcePick.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.IcePickLD'
         ProjScale=0.400000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         DampenFactor=0.200000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkIcePick'
         StickRotation=(Pitch=8192)
         bCanBePickedUp=True
         Damage=(head=92,Limb=22,Misc=37)
         KickForce=12000
         DamageType=Class'BWBP_JWC_Pro.DTJunkIcePick'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Swing')
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_IcePick.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Ice Pick"
     MeleeRating=65.000000
     RangeRating=25.000000
     PainThreshold=35
     NoUseThreshold=60
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.Icepick'
     DrawScale=1.400000
}
