//=============================================================================
// E23Attachment.
//
// 3rd person weapon attachment for E23 Plasma Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class HMCAttachment extends BallisticAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bRedTeam;	//Owned by red team or special?
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var   vector					PreviousHitLoc;
var   Emitter				LaserDot;
var   BallisticWeapon		BeamCannon;
var   bool					bBigLaser;
var   bool 					bGreenLaser;
var	bool					bOldGreenLaser;
var byte						SmallCount, SmallCountOld;
var byte						BlastCount, BlastCountOld;
var  Material				GreenLaserSkin;

var Actor 		Pack;			// The Backpack


replication
{
	reliable if ( Role==ROLE_Authority )
		SmallCount, BlastCount, LaserRot, bLaserOn, bGreenLaser, bBigLaser;
 	reliable if (bNetInitial && Role == ROLE_Authority)
 		bRedTeam;
}

simulated event PostNetReceive()
{
	if (BlastCount != BlastCountOld)
	{
		FiringMode = 1;
		BlastCountOld = BlastCount;
		ThirdPersonEffects();
	}
	if (SmallCount != SmallCountOld)
	{
		FiringMode = 0;
		ThirdPersonEffects();
		SmallCountOld = SmallCount;
	}
	
	if (bGreenLaser != bOldGreenLaser && Laser != None)
	{
		if(bGreenLaser)
			Laser.Skins[0] = TexPanner'BWBP_SKC_TexExp.BeamCannon.LaserPannerGreen';
		else Laser.Skins[0] = Laser.default.Skins[0];
		bOldGreenLaser = bGreenLaser;
	}
		
	super.PostNetReceive();
}

function SwitchMedicLaser(bool bGreen)
{
	bGreenLaser = bGreen;
	if(bGreenLaser)
		Laser.Skins[0] = TexPanner'BWBP_SKC_TexExp.BeamCannon.LaserPannerGreen';
	else Laser.Skins[0] = Laser.default.Skins[0];
}

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if ( Pack != None )
		Pack.SetOverlayMaterial(mat, time, bOverride);
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (Pack!= None)
		Pack.bHidden = NewbHidden;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.bHidden=false;
		LaserDot.Kill();
		LaserDot = None;
	}
}

simulated function SpawnLaserDot(vector Loc)
{
	if (LaserDot == None)
	{
		if ( (Instigator.PlayerReplicationInfo.Team != None) && (Instigator.PlayerReplicationInfo.Team.TeamIndex == 0) || bRedTeam )
			LaserDot = Spawn(class'BallisticProV55.IE_GRS9LaserHit',,,Loc);
		else
			LaserDot = Spawn(class'BWBP_SKC_Pro.IE_HMCLase',,,Loc);
		laserDot.bHidden=false;
	}
}

simulated function Tick(float DT)
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator X;
	local Actor Other;

	Super.Tick(DT);

	if (bLaserOn && Role == ROLE_Authority && BeamCannon != None)
	{
		LaserRot = Instigator.GetViewRotation();
		LaserRot += BeamCannon.GetAimPivot();
		LaserRot += BeamCannon.GetRecoilPivot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
	{
		if (bRedTeam)
			Laser = Spawn(class'BWBP_SKC_Pro.LaserActor_HMCRed',,,Location);
		else
			Laser = Spawn(class'BWBP_SKC_Pro.LaserActor_HMC',,,Location);
		if (bGreenLaser)
			Laser.Skins[0] = GreenLaserSkin;
	}

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		if (LaserDot != None)
			KillLaserDot();
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

	Loc = GetTipLocation();

	if (AIController(Instigator.Controller)!=None)
	{
		HitLocation = mHitLocation;
	}
	else
	{
		End = Start + (Vector(X)*3000);
		Other = Trace (HitLocation, HitNormal, End, Start, true);
		if (Other == None)
			HitLocation = End;
	}

	if (LaserDot == None && Other != None)
		SpawnLaserDot(HitLocation);
	else if (LaserDot != None && Other == None)
		KilllaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
	}

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;
	if (bBigLaser)
	{
		Scale3D.Y = 16;
		Scale3D.Z = 16;
	}
	else
	{
		Scale3D.Y = 8;
		Scale3D.Z = 8;
	}
	Laser.SetDrawScale3D(Scale3D);
}

function InitFor(Inventory I)
{
   Super.InitFor(I);

   if (BallisticWeapon(I) != None)
      BeamCannon = BallisticWeapon(I);
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	if(Role == ROLE_Authority && Instigator.Controller != None && Instigator.Controller.GetTeamNum() == 0)
		bRedTeam=True;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	Pack = Spawn(class'HVPCPack');
	if (Instigator != None)
		Instigator.AttachToBone(Pack,'Spine');
	Pack.SetBoneScale(0, 0.0001, 'Bone03');
	
	if (bRedTeam)
	{
		Skins[0] = Shader'BWBP_SKC_TexExp.BeamCannon.RedCannonSD';
     	TracerClass=Class'BallisticProV55.TraceEmitter_HVCRedLightning';
     	MuzzleFlashClass=Class'BWBP_SKCExp_Pro.HMCRedEmitter';
     	AltMuzzleFlashClass=Class'BWBP_SKCExp_Pro.HMCRedEmitter';
     }
	
	if (HMCBeamCannon(Instigator.Weapon).CurrentWeaponMode == 2)
		bGreenLaser=True;
}

simulated function Destroyed()
{
	if (Pack != None)
		Pack.Destroy();
	if (Laser != None)
		Laser.Destroy();
	KillLaserDot();
	Super.Destroyed();
}

function HMCUpdateHit(byte WeaponMode)
{
	ThirdPersonEffects();
}

simulated function InstantFireEffects(byte Mode)
{
	if (Mode == 0)
	{
		if ( (Instigator.PlayerReplicationInfo.Team != None) && (Instigator.PlayerReplicationInfo.Team.TeamIndex == 0) || bRedTeam)
			ImpactManager = class'IM_HVPCProjectile';
		else
			ImpactManager = class'IM_HMCBlast';
	}
	else
	{
		if (VSize(PreviousHitLoc - mHitLocation) < 2)
			return;
		PreviousHitLoc = mHitLocation;
		if ( (Instigator.PlayerReplicationInfo.Team != None) && (Instigator.PlayerReplicationInfo.Team.TeamIndex == 0) || bRedTeam)
			ImpactManager = class'IM_GRS9Laser';
		else
			ImpactManager = class'IM_HMCLase';
	}
	super.InstantFireEffects(Mode);
}

defaultproperties
{
     MuzzleFlashClass=Class'BWBP_SKCExp_Pro.HMCFlashEmitter'
     AltMuzzleFlashClass=Class'BWBP_SKCExp_Pro.HMCFlashEmitter'
     ImpactManager=Class'BWBP_SKC_Pro.IM_HMCBlast'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_HMC'
     TracerChance=2.000000
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.RX22A_TPm'
     DrawScale=0.250000
}
