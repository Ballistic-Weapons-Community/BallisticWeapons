//=============================================================================
// Balisong.
//
// ba-ba-balisooooongausug.
//=============================================================================
class JWVan_balisong extends JunkObject;

function bool DoDamage(WeaponFire Fire, JunkFireInfo FI, Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount)
{
	local float				Dmg;
	local class<DamageType>	HitDT;
	local Actor				Victim;
	local Vector			RelativeVelocity, ForceDir, BoneTestLocation, ClosestLocation, testDir;
	local int				Surf, OldHealth;
	local BallisticMeleeFire	JWFire;
	
	JWFire = BallisticMeleeFire(Fire);
	
	//Locational damage code from Mr Evil
	if(Other.IsA('xPawn'))
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the shot along its direction to a point where it is closest to the victim's Z axis.
		BoneTestLocation = Dir;
		BoneTestLocation *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(HitLocation - TraceStart);
		BoneTestLocation += HitLocation;
		
		Dmg = JWFire.GetDamage(Other, BoneTestLocation, Dir, Victim, HitDT);
	}
	
	else Dmg = JWFire.GetDamage(Other, HitLocation, Dir, Victim, HitDT);
	//End locational damage code
	
	if (JWFire.RangeAtten != 1.0)
		Dmg *= Lerp(VSize(HitLocation-TraceStart)/JWFire.TraceRange.Max, 1, JWFire.RangeAtten);
	if (PenetrateCount > 0)
		Dmg *= JWFire.PDamageFactor ** PenetrateCount;
	if (WallCount > 0)
		Dmg *= JWFire.WallPDamageFactor ** WallCount;
	if (JWFire.bUseRunningDamage)
	{
		RelativeVelocity = Instigator.Velocity - Other.Velocity;
		Dmg += Dmg * (VSize(RelativeVelocity) / JWFire.RunningSpeedThresh) * (Normal(RelativeVelocity) Dot Normal(Other.Location-Instigator.Location));
	}
	if (Pawn(Victim) != None)
		OldHealth = Pawn(Victim).Health;
		
	//Backstab code - Azarael
	testDir = Dir;
	testDir.Z = 0;
	
	if (Vector(Victim.Rotation) Dot testDir > 0.2)
	{
		log("Input damage:"@Dmg);
		Dmg *= 1.5;
		log("Output damage:"@Dmg);
	}
	//End backstab code

	if (JWFire.HookStopFactor != 0 && JWFire.HookPullForce != 0 && Pawn(Victim) != None && Pawn(Victim).bProjTarget)
	{
		ForceDir = Normal(Other.Location-TraceStart);
		ForceDir.Z *= 0.3;

		Pawn(Victim).AddVelocity( Normal(Victim.Acceleration) * JWFire.HookStopFactor * -FMin(Pawn(Victim).GroundSpeed, VSize(Victim.Velocity)) - ForceDir * JWFire.HookPullForce );
	}

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, JWFire.KickForce * Dir, HitDT);
	
	if ( !SendDamageEffect(Fire, FI, OldHealth, Victim, Dmg, HitLocation, Dir, HitDT) &&
	(OldHealth < 1 || (Pawn(Victim) != None && Pawn(Victim).Health < OldHealth)) )
	{
		if (Vehicle(Victim) != None)
			Surf = 3;//EST_Metal
		else
			Surf = 6;//EST_Flesh
		if (JWFire.Weapon != None)
			JunkWeaponAttachment(JWFire.Weapon.ThirdPersonActor).JunkHitActor(Victim, HitLocation, -Normal(Dir), Surf, (FI != MeleeAFireInfo));
	}
	
	return true;
}

defaultproperties
{
     HandOffset=(X=3.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.balisongLD'
     PickupDrawScale=0.300000
     PickupMessage="You got the Balisong. Stab some backs!"
     ThirdPersonDrawScale=0.450000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.balisong'
     RightGripStyle=GS_Thin
     PullOutRate=2.000000
     PutAwayRate=2.000000
     AttachOffset=(Z=1.000000)
     AttachPivot=(Roll=-1000)
     bCanThrow=True
     MaxAmmo=5
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
         Damage=(head=95,Limb=25,Misc=30)
         KickForce=2000
         DamageType=Class'BWBP_JWC_Pro.DTbalisong'
         RefireTime=0.350000
         AnimRate=1.300000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="StabHit1"
         Anims(1)="StabHit2"
         Anims(2)="StabHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_balisong.JunkFireInfo0'

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
         Damage=(head=100,Limb=28,Misc=35)
         KickForce=3000
         DamageType=Class'BWBP_JWC_Pro.DTbalisong'
         RefireTime=0.350000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="StabAttack"
         PreFireAnims(0)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_balisong.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=2000
         ProjMass=15
         ProjMesh=StaticMesh'BWBP_JW_Static.balisongTHR'
         ProjScale=0.250000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         SpinRates=(Pitch=30000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkScrewDriver'
         bCanBePickedUp=True
         Damage=(head=80,Limb=15,Misc=35)
         KickForce=2000
         DamageType=Class'BWBP_JWC_Pro.DTbalisong'
         RefireTime=0.300000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="StabThrow"
         PreFireAnims(0)="StabPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JWVan_balisong.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Small')
     FriendlyName="Balisong"
     InventoryGroup=3
     MeleeRating=45.000000
     RangeRating=40.000000
     SpawnWeight=1.050000
     PainThreshold=12
     NoUseThreshold=20
     StaticMesh=StaticMesh'BWBP_JW_Static.balisong'
     DrawScale=1.650000
}
