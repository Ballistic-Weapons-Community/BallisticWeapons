//=============================================================================
// JO_Capacitor.
//
// A devastating, electrical-energy containment device.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_Capacitor extends JunkObject;

var bool bValidDischarge;

function JunkReload()
{
	bValidDischarge=false;
}
function bool HitActor (Actor Other, JunkMeleeFireInfo FireInfo)
{
	if (!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other)!=None && bValidDischarge)
	{
		if (FRand() > 0.65)
			Weapon.MorphJunk();
	}
	return true;
}
/*
function bool DoDamage(WeaponFire Fire, JunkFireInfo FireInfo, Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount)
{
	if (Pawn(Other) != None && Pawn(Other).Health > 0 && Pawn(Other).LastPainTime == level.TimeSeconds)
		bValidDischarge=true;
	return false;
}
*/
function bool SendDamageEffect(WeaponFire Fire, JunkFireInfo FI, int OldHealth, Actor Victim, float Damage, vector HitLocation, vector Dir, class<DamageType> DT)
{
	if (Pawn(Victim) != None && (Pawn(Victim).Health < 1 || Pawn(Victim).LastPainTime == Victim.level.TimeSeconds))
		bValidDischarge=true;
	return false;
}

defaultproperties
{
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.CapacitorLD'
     PickupDrawScale=0.400000
     PickupMessage="You got a charged capacitor... shocking!!"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.Capacitor'
     RightGripStyle=GS_Capacitor
     AttachOffset=(Y=-2.500000)
     AttachPivot=(Pitch=-2048)
     bCanThrow=True
     MaxAmmo=5
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTazerHit'
         Damage=(head=135,Limb=105,Misc=110)
         KickForce=50000
         DamageType=Class'BWBP_JWC_Pro.DTJunkCapacitor'
         RefireTime=0.600000
         AnimRate=1.000000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="StabHit1"
         Anims(1)="StabHit2"
         Anims(2)="StabHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_Capacitor.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTazerHit'
         Damage=(head=135,Limb=105,Misc=110)
         KickForce=50000
         DamageType=Class'BWBP_JWC_Pro.DTJunkCapacitor'
         RefireTime=0.700000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="StabAttack"
         PreFireAnims(0)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_Capacitor.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1800
         ProjMass=10
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.CapacitorLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.150000
         SpinRates=(Pitch=80000)
         ExplodeManager=Class'BWBP_JWC_Pro.IM_JunkTazerHit'
         StickRotation=(Pitch=16384,Roll=16384)
         bCanBePickedUp=True
         Damage=(head=120,Limb=105,Misc=105)
         KickForce=55000
         DamageType=Class'BWBP_JWC_Pro.DTJunkCapacitor'
         RefireTime=0.600000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_Capacitor.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Charged Capacitor"
     InventoryGroup=6
     MeleeRating=100.000000
     RangeRating=27.000000
     MorphedJunk=Class'BWBP_JWC_Pro.JO_EmptyCapacitor'
     SpawnWeight=0.900000
     PainThreshold=16
     NoUseThreshold=34
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.Capacitor'
}
