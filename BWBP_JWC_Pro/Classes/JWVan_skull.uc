//=============================================================================
// Skull.
//
// A skull.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_skull extends JunkObject;

defaultproperties
{
     HandOffset=(X=3.000000,Z=-0.700000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Skull'
     PickupDrawScale=0.400000
     PickupMessage="You found a Skull. The fallen soldiers will help you! Unintentionally!"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Skull'
     RightGripStyle=GS_Bowl
     PullOutRate=2.000000
     IdleStyle=AS_Bowl
     PutAwayRate=2.000000
     AttachOffset=(Y=-4.000000)
     AttachPivot=(Roll=-1000)
     bCanThrow=True
     bSwapSecondary=True
     Ammo=5
     MaxAmmo=10
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=100.000000,Max=100.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=500,Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-500,Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         HookStopFactor=1.500000
         HookPullForce=90.000000
         Damage=(head=82,Limb=15,Misc=30)
         KickForce=2000
         DamageType=Class'BWBP_JWC_Pro.DTskull'
         RefireTime=0.450000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="SwingHit1"
         Anims(1)="SwingHit2"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_skull.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=110.000000,Max=110.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=500,Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Pitch=-1000,Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-2000,Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         HookStopFactor=1.500000
         HookPullForce=90.000000
         Damage=(head=95,Limb=20,Misc=35)
         KickForce=3000
         DamageType=Class'BWBP_JWC_Pro.DTskull'
         RefireTime=0.350000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="SwingAttack"
         PreFireAnims(0)="SwingPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_skull.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=900
         ProjMass=30
         ProjMesh=StaticMesh'BWBP_JW_Static.Skull'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         SpinRates=(Pitch=30000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         bCanBePickedUp=True
         Damage=(head=75,Limb=18,Misc=35)
         KickForce=2000
         DamageType=Class'BWBP_JWC_Pro.DTskull'
         RefireTime=0.300000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Icepick.Icepick-Swing')
         Anims(0)="SwingThrow"
         PreFireAnims(0)="SwingPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JWVan_skull.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Small')
     FriendlyName="Skull"
     InventoryGroup=3
     MeleeRating=45.000000
     RangeRating=40.000000
     SpawnWeight=1.050000
     PainThreshold=12
     NoUseThreshold=20
     StaticMesh=StaticMesh'BWBP_JW_Static.Skull'
     DrawScale=1.250000
}
