//=============================================================================
// Horseshoe.
//
// Where are da horsesocks.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_horseshoe extends JunkObject;

defaultproperties
{
     HandOffset=(X=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.horseshoeLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Horseshoe. Kick some ass with it."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.horseshoe'
     RightGripStyle=GS_Crowbar
     AttachPivot=(Yaw=-2580,Roll=-800)
     bCanThrow=True
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=96.000000,Max=96.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         HookStopFactor=1.000000
         Damage=(head=110,Limb=30,Misc=45)
         KickForce=8000
         DamageType=Class'BWBP_JWC_Pro.DThorseshoe'
         RefireTime=0.650000
         AnimRate=1.100000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="WideHit1"
         Anims(1)="WideHit2"
         Anims(2)="WideHit3"
         AnimTimedFire=ATS_Early
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_horseshoe.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=110.000000,Max=110.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         HookStopFactor=1.000000
         Damage=(head=120,Limb=40,Misc=60)
         KickForce=15000
         DamageType=Class'BWBP_JWC_Pro.DThorseshoe'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="WideAttack"
         PreFireAnims(0)="WidePrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_horseshoe.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=800
         ProjMass=50
         ProjMesh=StaticMesh'BWBP_JW_Static.horseshoeLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         SpinRates=(Pitch=30000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         bCanBePickedUp=True
         Damage=(head=120,Limb=45,Misc=45)
         KickForce=2500
         DamageType=Class'BWBP_JWC_Pro.DThorseshoe'
         RefireTime=0.600000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Swing')
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JWVan_horseshoe.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Horseshoe"
     InventoryGroup=2
     MeleeRating=67.000000
     RangeRating=0.000000
     PainThreshold=55
     StaticMesh=StaticMesh'BWBP_JW_Static.horseshoe'
     DrawScale=1.350000
}
