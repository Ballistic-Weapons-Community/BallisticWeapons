class XOXOAttachment extends BallisticAttachment;

var bool	bStreamOn;
var XOXOStreamEffect StreamEffect;
var sound StreamAmbientSound;
var Actor LockedTarget;

var Actor HeartGlow;
var Emitter LoveEffect, ShockwaveEffect;

var bool bLoveMode, bOldLoveMode;

var bool bShockwave, bOldShockwave;

replication
{
	reliable if (Role == ROLE_Authority)
		StreamEffect, bShockwave;
	reliable if (Role == ROLE_Authority && !bNetOwner)
		bLoveMode;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
    if (level.DetailMode >= DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
		class'BUtil'.static.InitMuzzleFlash (HeartGlow, class'XOXOCoverGlow', DrawScale, self, 'HeartGlow');
}


//===========================================================================
// PostNetReceive
//
// Shockwave / Love Mode propagation to client.
//===========================================================================
simulated function PostNetReceive()
{
	if (bShockwave != bOldShockwave)
	{
		bOldShockwave = bShockwave;
		Shockwave3rd();
	}
	
	if (bLoveMode != bOldLoveMode)
	{
		bOldLoveMode = bLoveMode;
		if (bLoveMode)
		{
			LoveEffect = spawn(class'XOXOLoveModeGlow',Instigator,,Instigator.Location,Instigator.Rotation);
			if (LoveEffect != None)
				LoveEffect.SetBase(Instigator);
		}
		else 
		{
			if (LoveEffect != None)
				LoveEffect.Kill();
		}
	}
	
	Super.PostNetReceive();
}

//===========================================================================
// StartStream
// Called by primary firemode
//===========================================================================
function StartStream()
{
	bStreamOn = True;
	AmbientSound = StreamAmbientSound;
	Instigator.bAlwaysRelevant=True;
	bAlwaysRelevant=True;

	if (StreamEffect == None)
	{
		StreamEffect = spawn(class'XOXOStreamEffect', self);
		StreamEffect.SetLocation(GetBoneCoords('tip2').Origin);
		StreamEffect.SetBase(self);
		if (XOXOStaff(Instigator.Weapon) != None)
			XOXOStaff(Instigator.Weapon).StreamEffect = StreamEffect;
		StreamEffect.Instigator = Instigator;
		StreamEffect.Target = LockedTarget;
		StreamEffect.StaffAttachment = self;
		StreamEffect.UpdateEndpoint();
	}
}

//===========================================================================
// EndStream
//
// Called by primary firemode StopFiring()
//===========================================================================
function EndStream()
{
	bStreamOn = False;
	AmbientSound = None;
	Instigator.bAlwaysRelevant=False;
	bAlwaysRelevant=False;
	LockedTarget = None;
	
	if (StreamEffect != None)
	{
		StreamEffect.bTearOff = True;
		StreamEffect.Kill();
		StreamEffect = None;
	}
}

//===========================================================================
// SetPawnTarget
//===========================================================================
function SetLockedTarget(Actor NewTarget)
{	
	LockedTarget = NewTarget;
	if (StreamEffect != None)
		StreamEffect.Target = NewTarget;
}

simulated function Destroyed()
{
	if (StreamEffect != None)
		StreamEffect.Kill();
	if (HeartGlow != None)
		HeartGlow.Destroy();
	if (LoveEffect != None)
		LoveEffect.Kill();
	
	Super.Destroyed();
}

//===========================================================================
// Shockwave3rd
//
// Called when lust shockwave is fired
//===========================================================================
simulated function Shockwave3rd()
{
	if (Role == ROLE_Authority)
		bShockwave = !bShockwave;
	if (Level.NetMode != NM_DedicatedServer)
	{
		ShockwaveEffect = spawn(class'IE_XOXOShockwave', Instigator,, Instigator.Location);
		ShockwaveEffect.SetBase(Instigator);
	}
}

simulated function Tick(float DT)
{
	super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	
	if (StreamEffect != None && !Instigator.IsFirstPerson())
		StreamEffect.SetLocation(GetBoneCoords('tip2').Origin);
}

defaultproperties
{
     StreamAmbientSound=Sound'BWBP_OP_Sounds.XOXO.XOXO-Stream'
     MuzzleFlashClass=Class'BWBP_OP_Pro.XOXOFlashEmitter'
     MeleeImpactManager=Class'BallisticProV55.IM_A73Knife'
     WeaponLightTime=0.200000
     BrassMode=MU_None
     InstantMode=MU_Secondary
     ReloadAnim="Reload_MG"
     ReloadAnimRate=1.700000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_OP_Anim.XOXO_TPm'
     DrawScale=0.280000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=512.000000
}
