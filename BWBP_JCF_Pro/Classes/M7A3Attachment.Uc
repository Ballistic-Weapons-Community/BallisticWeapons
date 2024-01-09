//=============================================================================
// M7A3Attachment.
//
// 3rd person weapon attachment for M7A3 Assault
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class M7A3Attachment extends BallisticAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var	  BallisticWeapon		myWeap;
var Vector		SpawnOffset;

var Pawn TazerHit, OldTazerHit;
var M7A3TazerEffect TazerEffect;

replication
{
	reliable if (Role == ROLE_Authority)
		TazerHit;
}


/*replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
}


function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
}

simulated function Vector GetModeTipLocation()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (M7A3AssaultRifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip').Origin;
	if (VSize(Loc - Instigator.Location) > 200)
		return Instigator.Location;
    return Loc;
}

simulated function Tick(float DT)
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator X;
	local Actor Other;

	Super.Tick(DT);

	if (bLaserOn && Role == ROLE_Authority && myWeap != None)
	{
		LaserRot = Instigator.GetViewRotation();
		LaserRot += myWeap.GetAimPivot();
		LaserRot += myWeap.GetRecoilPivot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'BallisticProV55.LaserActor_Third',,,Location);

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		return;
	}
	else
	{
		if (Laser.bHidden)
			Laser.bHidden = false;
	}

	if (Instigator != None)
		Start = Instigator.Location + Instigator.EyePosition();
	else
		Start = Location;
	X = LaserRot;

//	Loc = GetModeTipLocation();
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + (Vector(X)*5000);
	Other = Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
}*/

//===========================================================================
// PostNetReceive
//
// Notifies clients of targets
//===========================================================================
simulated function PostNetReceive()
{
	if (TazerHit != OldTazerHit)
	{
		OldTazerHit = TazerHit;
		if (TazerHit != None)
			GotTarget(TazerHit);
		else
		{
			TazerEffect.Kill();
			TazerEffect = None;
			if (M7A3AssaultRifle(Instigator.Weapon) != None)
				M7A3AssaultRifle(Instigator.Weapon).TazerEffect = None;
		}
	}
	
	Super.PostNetReceive();
}

//===========================================================================
 // GotTarget
 //
 // Called from secondary fire on tazer hit.
//===========================================================================
simulated function GotTarget(Pawn A)
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		TazerHit = A;
	if (TazerEffect == None)
	{
		TazerEffect = spawn(class'M7A3TazerEffect', self,,,rot(0,0,0));
		if (M7A3AssaultRifle(Instigator.Weapon) != None)
			M7A3AssaultRifle(Instigator.Weapon).TazerEffect = TazerEffect;
		TazerEffect.SetTarget(A);
		TazerEffect.Instigator = Instigator;
		TazerEffect.UpdateTargets();
	}
	else
		TazerEffect.SetTarget(A);
}

//===========================================================================
 // TazeEnd
 //
 // Called from secondary fire on release of altfire key or from tazereffect on loss of target.
//===========================================================================
simulated function TazeEnd()
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		TazerHit = None;
	if (TazerEffect != None)
	{
		TazerEffect.KillFlashes();
		TazerEffect.SetTimer(0.0, false);
		TazerEffect.Kill();

		if (M7A3AssaultRifle(Instigator.Weapon) != None)
			M7A3AssaultRifle(Instigator.Weapon).TazerEffect = None;
	}
}

simulated function Tick(float DT)
{
	super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	
	if (TazerEffect != None && !Instigator.IsFirstPerson())
		TazerEffect.SetLocation(GetBoneCoords('tip2').Origin);
}

simulated function Destroyed()
{
	if (TazerEffect != None)
	{
		TazerEffect.KillFlashes();
		TazerEffect.SetTimer(0.0, false);
		TazerEffect.Kill();
	}
	
	Super.Destroyed();
}

defaultproperties
{
	 WeaponClass=class'M7A3AssaultRifle'
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashScale=2.000000
     BrassClass=Class'BWBP_JCF_Pro.Brass_M7A3AR'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMix=-3
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_JCF_Anims.TPm_M7A3'
     DrawScale=0.350000
}
