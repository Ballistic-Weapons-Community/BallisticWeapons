//=============================================================================
// AH250Attachment.
//
// 3rd person weapon attachment for AH208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AH250Attachment extends HandgunAttachment;
var Vector		SpawnOffset;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
}

/*simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	SetBoneScale (0, 0.0, 'RedDotSight');
	SetBoneScale (1, 0.0, 'LAM');
}*/

simulated function Tick(float DT)
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator X;
	local Actor Other;

	Super.Tick(DT);

	if (bLaserOn && Role == ROLE_Authority && Handgun != None)
	{
		LaserRot = Instigator.GetViewRotation() + Handgun.GetFireRot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_Third',,,Location);

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

	Loc = GetModeTipLocation();

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
}

simulated function Destroyed()
{
	if (Laser != None)
		Laser.Destroy();
	Super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'AH250Pistol'
	MuzzleFlashClass=class'D49FlashEmitter'
	ImpactManager=class'IM_BigBullet'
	MeleeImpactManager=class'IM_GunHit'
	FlashScale=0.250000
	BrassClass=class'Brass_Pistol'
	BrassBone="Scope"
	TracerClass=class'TraceEmitter_Pistol'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_Pistol"
	CockingAnim="Cock_RearPull"
	ReloadAnimRate=0.850000
	CockAnimRate=0.900000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.AHDeagle_TPm'
	RelativeLocation=(Z=6.000000)
	DrawScale=0.175
	Skins(0)=Shader'BWBP_SKC_Tex.Eagle.Eagle-MainShine'
	Skins(1)=Shader'BWBP_SKC_Tex.Eagle.Eagle-MainShine'
	Skins(2)=Texture'BWBP_SKC_Tex.Eagle.Eagle-Misc'
	Skins(3)=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeRed'
	Skins(4)=Texture'BWBP_SKC_Tex.Eagle.Eagle-Front'
	Skins(5)=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen'
}
