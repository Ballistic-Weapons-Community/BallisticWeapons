//=============================================================================
// Nail Club.
//
// Bludgeon.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_nailcl extends JunkObject;

defaultproperties
{
     HandOffset=(X=5.000000,Y=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.nailclLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Spiked Cudgel. You know what to do."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.nailcl'
     RightGripStyle=GS_Crowbar
     AttachOffset=(X=-0.250000,Y=-0.500000,Z=6.000000)
     AttachPivot=(Yaw=-2048,Roll=-500)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=145.000000,Max=145.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         HookStopFactor=1.600000
         HookPullForce=100.000000
         Damage=(head=110,Limb=20,Misc=45)
         KickForce=7000
         DamageType=Class'BWBP_JWC_Pro.DTnailcl'
         RefireTime=0.400000
         AnimRate=1.200000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_nailcl.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=150.000000,Max=150.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         HookStopFactor=1.600000
         HookPullForce=100.000000
         Damage=(head=130,Limb=35,Misc=65)
         KickForce=12000
         DamageType=Class'BWBP_JWC_Pro.DTnailcl'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
         Anims(0)="WideAttack"
         PreFireAnims(0)="WidePrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_nailcl.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1200
         ProjMass=25
         ProjMesh=StaticMesh'BWBP_JW_Static.nailclLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.100000
         DampenFactorParallel=0.700000
         SpinRates=(Pitch=400000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         StickRotation=(Pitch=16384,Roll=16384)
         bCanBePickedUp=True
         Damage=(head=100,Limb=35,Misc=40)
         KickForce=15000
         DamageType=Class'BWBP_JWC_Pro.DTnailcl'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
         Anims(0)="HeavyThrow"
         PreFireAnims(0)="HeavyPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JWVan_nailcl.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Spiked Cudgel"
     MeleeRating=65.000000
     RangeRating=25.000000
     NoUseThreshold=80
     StaticMesh=StaticMesh'BWBP_JW_Static.nailcl'
     DrawScale=1.160000
}
