//=============================================================================
// Syringe.
//
// A medical syringe.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_syringe extends JunkObject;

function bool SendDamageEffect(WeaponFire Fire, JunkFireInfo FI, int OldHealth, Actor Other, float Damage, vector HitLocation, vector Dir, class<DamageType> DT)
{
   local BallisticPawn Target;
   Target=BallisticPawn(Other);
   
   if(IsValidHealTarget(Target))
   {
      Target.GiveHealth(5, Target.HealthMax); // Change 25 to whatever you want.
      return true;
   }
   
   if (Mover(Other) != None || Vehicle(Other) != None)
      return true;
   super.SendDamageEffect(Fire,FI,OldHealth,Other,Damage,HitLocation,Dir,DT);
}

function bool IsValidHealTarget(Pawn Target)
{
   if(Target==None||Target==Instigator)
      return False;

   if(Target.Health<=0)
      return False;

   if(!Level.Game.bTeamGame)
      return False;

   if(Vehicle(Target)!=None)
      return False;

   return (Target.Controller!=None && Instigator.Controller.SameTeamAs(Target.Controller));
}

defaultproperties
{
     HandOffset=(X=3.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.syringeLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Syringe. Euthanize your enemies."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Syringe'
     RightGripStyle=GS_Axe
     PullOutRate=2.000000
     PutAwayRate=2.000000
     AttachOffset=(Z=1.000000)
     AttachPivot=(Roll=-1000)
     bCanThrow=True
     bSwapSecondary=True
     MaxAmmo=2
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=100.000000,Max=100.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=500,Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-500,Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
         HookStopFactor=1.500000
         HookPullForce=90.000000
         Damage=(head=85,Limb=20,Misc=30)
         KickForce=2000
         DamageType=Class'BWBP_JWC_Pro.DTsyringe'
         RefireTime=0.450000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="StabHit1"
         Anims(1)="StabHit2"
         Anims(2)="StabHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_syringe.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=110.000000,Max=110.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=500,Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Pitch=-1000,Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-2000,Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriverSec'
         HookStopFactor=1.500000
         HookPullForce=90.000000
         Damage=(head=95,Limb=20,Misc=35)
         KickForce=3000
         DamageType=Class'BWBP_JWC_Pro.DTsyringe'
         RefireTime=0.350000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="StabAttack"
         PreFireAnims(0)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_syringe.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=2000
         ProjMass=10
         ProjMesh=StaticMesh'BWBP_JW_Static.syringeLD'
         ProjScale=0.250000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         SpinRates=(Pitch=30000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
         bCanBePickedUp=True
         Damage=(head=80,Limb=15,Misc=35)
         KickForce=2000
         DamageType=Class'BWBP_JWC_Pro.DTsyringe'
         RefireTime=0.300000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="StabThrow"
         PreFireAnims(0)="StabPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JWVan_syringe.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Small')
     FriendlyName="Syringe"
     InventoryGroup=3
     MeleeRating=45.000000
     RangeRating=40.000000
     SpawnWeight=1.050000
     PainThreshold=12
     NoUseThreshold=20
     StaticMesh=StaticMesh'BWBP_JW_Static.Syringe'
     DrawScale=1.250000
}
