//=============================================================================
// Kukri.
//
// A crude blade for clearing bush and shaving tough beards. Two.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_kukri extends JunkObject;

defaultproperties
{
     HandOffset=(X=4.000000,Y=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.kukriLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Kukri. Shave some beards."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.kukri'
     RightGripStyle=GS_Axe
     AttachOffset=(Y=0.250000)
     AttachPivot=(Yaw=-2048,Roll=-500)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=124.000000,Max=128.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
         HookStopFactor=0.700000
         HookPullForce=100.000000
         Damage=(head=130,Limb=20,Misc=40)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTkukri'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Swing',Pitch=1.200000)
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_kukri.JunkFireInfo0'

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
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
         HookStopFactor=0.700000
         HookPullForce=100.000000
         Damage=(head=150,Limb=22,Misc=50)
         KickForce=9000
         DamageType=Class'BWBP_JWC_Pro.DTkukri'
         RefireTime=0.500000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Swing',Pitch=1.100000)
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_kukri.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.kukriLD'
         ProjScale=0.400000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         DampenFactor=0.200000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
         StickRotation=(Pitch=10000)
         bCanBePickedUp=True
         Damage=(head=120,Limb=35,Misc=40)
         KickForce=12000
         DamageType=Class'BWBP_JWC_Pro.DTkukri'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Swing',Pitch=1.200000)
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JWVan_kukri.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Kukri"
     MeleeRating=60.000000
     RangeRating=25.000000
     PainThreshold=25
     NoUseThreshold=45
     StaticMesh=StaticMesh'BWBP_JW_Static.kukri'
     DrawScale=2.000000
}
