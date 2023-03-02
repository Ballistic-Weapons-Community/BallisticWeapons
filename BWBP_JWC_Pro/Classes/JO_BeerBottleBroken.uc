//=============================================================================
// JO_BeerBottleBroken.
//
// Aftermath of a bar-fight.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_BeerBottleBroken extends JunkObject;

simulated function JunkReload ()
{
	AttachPivot.Yaw = RandRange(-32768, 32768);
//	Weapon.SetBoneRotation(AttachBone, Attachpivot);
}
simulated function bool Initialize(JunkObject OldJunk)
{
	if (JO_BeerBottle(OldJunk) != None)
		AttachPivot.Yaw = OldJunk.AttachPivot.Yaw;
	else
		AttachPivot.Yaw = Rand(65536);
	return false;
}

defaultproperties
{
     HandOffset=(X=4.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.BeerBottleBroken'
     PickupDrawScale=0.300000
     PickupMessage="You got the Broken Beer Bottles."
     ThirdPersonDrawScale=0.150000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.BeerBottleBroken'
     PullOutRate=2.000000
     PutAwayRate=2.000000
     AttachOffset=(X=1.000000,Z=1.250000)
     bCanThrow=True
     bSwapSecondary=True
     MaxAmmo=8
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=85.000000,Max=85.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkBeerBottleStab'
         HookStopFactor=1.200000
         Damage=(head=65,Limb=15,Misc=30)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTJunkBeerBottleBroken'
         RefireTime=0.300000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Swing')
         Anims(0)="StabHit1"
         Anims(1)="StabHit2"
         Anims(2)="StabHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_BeerBottleBroken.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=100.000000,Max=100.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkBeerBottleStabSec'
         HookStopFactor=1.300000
         Damage=(head=82,Limb=25,Misc=40)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkBeerBottleBrokenSec'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Swing')
         Anims(0)="StabAttack"
         PreFireAnims(0)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_BeerBottleBroken.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=2000
         ProjMass=10
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.BeerBottleBroken'
         ProjScale=0.250000
         SpinRates=(Pitch=650000)
         ExplodeManager=Class'BWBP_JWC_Pro.IM_JunkBeerBottleBreak'
         Damage=(head=45,Limb=12,Misc=25)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkBeerBottle'
         RefireTime=0.400000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Swing')
         Anims(0)="StabThrow"
         PreFireAnims(0)="StabPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_BeerBottleBroken.JunkThrowFireInfo0'

     SelectSound=(Sound=Sound'BWBP_JW_Sound.Misc.Pullout-Bottle')
     FriendlyName="Broken Beer Bottle"
     InventoryGroup=3
     MeleeRating=40.000000
     RangeRating=30.000000
     PainThreshold=10
     NoUseThreshold=20
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.BeerBottleBroken'
}
