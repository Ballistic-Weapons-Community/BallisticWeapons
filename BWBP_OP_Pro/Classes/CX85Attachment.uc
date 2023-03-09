class CX85Attachment extends BallisticAttachment;

var   bool			bLaserOn;		//Is laser currently active
var   bool			bOldLaserOn;	//Old bLaserOn
var   LaserActor	Laser;			//The laser actor
var   vector		LaserEndLoc;
var   Emitter		LaserDot;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	unreliable if ( Role==ROLE_Authority && !bNetOwner )
		LaserEndLoc;
}

simulated Event PreBeginPlay()
{
	super.PreBeginPlay();

	if (class'BCReplicationInfo'.static.IsClassicOrRealism())
	{
		TracerClass=Class'BWBP_OP_Pro.TraceEmitter_CX61Spectre';
		TracerChance=1;
		TracerMix=0;
	}
}

simulated function GenerateModeInfo()
{
    Super.GenerateModeInfo();

    ModeInfos[1].ImpactManager = class'BallisticProV55.IM_Bullet';
    ModeInfos[1].TracerClass = class'TraceEmitter_BX85Crossbow';
    ModeInfos[1].WaterTracerClass = class'BallisticProV55.TraceEmitter_WaterBullet';
    ModeInfos[1].TracerChance = 1;
    ModeInfos[1].TracerMix = 0;
    ModeInfos[1].bTrackAnim = false;
    ModeInfos[1].bInstant = true;
    ModeInfos[1].bTracer = true;
    ModeInfos[1].bWaterTracer = true;
    ModeInfos[1].bFlash = false;
    ModeInfos[1].bLight = false;
    ModeInfos[1].bBrass = false;
}

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z;
	
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (BallisticWeapon(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			return CX85AssaultWeapon(Instigator.Weapon).GetModeEffectStart(Mode);
	}
	
	else
    {
        switch(Mode)
        {
        case 1:
		    return GetBoneCoords('tip2').Origin;
        default:
            return GetBoneCoords('tip').Origin;
        }
    }
}

//Laser
simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'G5LaserDot',,,Loc);
	laserDot.bHidden=false;
}

simulated function Tick(float DT)
{
	local Vector Scale3D, Loc;

	Super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_G5Painter',,,Location);

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		KillLaserDot();
		return;
	}
	else
	{
		if (Laser.bHidden)
			Laser.bHidden = false;
		SpawnLaserDot();
	}

	if (LaserDot != None)
		LaserDot.SetLocation(LaserEndLoc);

	Loc = GetModeTipLocation();

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(LaserEndLoc - Loc));
//	Laser.SetRelativeRotation(Rotator(HitLocation - Loc) - GetBoneRotation('tip'));
	Scale3D.X = VSize(LaserEndLoc-Laser.Location)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	if (LaserDot != None)
		LaserDot.Destroy();
	if (Laser != None)
		Laser.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone="tip2"
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     FlashMode=MU_Primary
     LightMode=MU_Primary
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_OP_Anim.CX85_TPm'
     RelativeLocation=(Z=5.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.250000
}
