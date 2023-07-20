class ThorLCAttachment extends BallisticAttachment;

var bool	bStreamOn,  bUseAlt, bUseAltColor;
var ThorLCStreamEffectNew StreamEffect;
var ThorLCStreamEffectChild StreamEffectChild;
var sound StreamAmbientSound, StreamAmbientSoundAlt;
var Actor LockedTarget;
var Actor Pack;			// The Backpack
var byte ModeColor;
var	vector	EndEffect;
var Actor BoostMuzzleFlash;
var class<BallisticEmitter> BoostMuzzleFlashClass;


replication
{
	reliable if (Role == ROLE_Authority)
		StreamEffect, StreamEffectChild, ModeColor;
}

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (Mode != 0)
	{
		if (ModeColor == 0 && AltMuzzleFlashClass != None)
		{
			if (AltMuzzleFlash == None)
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
			AltMuzzleFlash.Trigger(self, Instigator);
			if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
		}
		else if (ModeColor != 0 && BoostMuzzleFlashClass != None)
		{
			if (AltMuzzleFlash == None)
				class'BUtil'.static.InitMuzzleFlash (BoostMuzzleFlash, BoostMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
			BoostMuzzleFlash.Trigger(self, Instigator);
			if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
		}
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
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

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	if (Instigator.GetTeamNum() == 1)
		Pack.Skins[0]=Shader'BWBP_OP_Tex.Proton_pack_SH_1';
	if (Instigator != None)
		Instigator.AttachToBone(Pack,'Spine');
	Pack.SetBoneScale(0, 0.0001, 'Bone03');
}	

//===========================================================================
// StartStream
// Called by primary firemode
//===========================================================================
function StartStream()
{
	bStreamOn = True;
	if (!bUseAlt)
		AmbientSound = StreamAmbientSound;
	else	AmbientSound = StreamAmbientSoundAlt;
	Instigator.bAlwaysRelevant=True;
	bAlwaysRelevant=True;
	
	if (StreamEffect == None )
	{
		if (!bUseAlt)	
			StreamEffect = spawn(class'ThorLCStreamEffectNew', self);
		else StreamEffect = spawn(class'ThorLCStreamEffectNewAlt', self);

		StreamEffect.bAltColor = bUseAltColor;
		StreamEffect.SetLocation(GetBoneCoords('tip2').Origin);
		StreamEffect.SetBase(self);
		if (ThorLightningCannon(Instigator.Weapon) != None)
			ThorLightningCannon(Instigator.Weapon).StreamEffect = StreamEffect;
		StreamEffect.Instigator = Instigator;
		StreamEffect.LinkedPawn = LockedTarget;
	}
	if (StreamEffectChild == None )
	{
		if (!bUseAlt)	
			StreamEffectChild = spawn(class'ThorLCStreamEffectChild', self);
		else StreamEffectChild = spawn(class'ThorLCStreamEffectChildAlt', self);
		
		StreamEffectChild.bAltColor = bUseAltColor;
		StreamEffectChild.SetLocation(GetBoneCoords('tip2').Origin);
		StreamEffectChild.SetBase(self);
		if (ThorLightningCannon(Instigator.Weapon) != None)
			ThorLightningCannon(Instigator.Weapon).StreamEffectChild = StreamEffectChild;
		StreamEffectChild.Instigator = Instigator;
		StreamEffectChild.LinkedPawn = LockedTarget;
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
		StreamEffect.destroy();
		StreamEffect = None;
	}
	if (StreamEffectChild != None)
	{
		StreamEffectChild.bTearOff = True;
		StreamEffectChild.destroy();
		StreamEffectChild = None;
	}	
}

//===========================================================================
// SetPawnTarget
//===========================================================================
function SetLockedTarget(Actor NewTarget)
{
	LockedTarget = NewTarget;
	StreamEffect.LinkedPawn = NewTarget;
	StreamEffectChild.LinkedPawn = NewTarget;
//	StreamEffect.Target = NewTarget;
	if (Pawn(NewTarget) != None && Instigator.Controller.SameTeamAs(Pawn(NewTarget).Controller))
	{
		StreamEffect.bAltColor = true;
		StreamEffectChild.bAltColor = true;
	}
	else
	{
		StreamEffect.bAltColor = false;
		StreamEffectChild.bAltColor = false;	
	}
}

function SetUnlockedEnd(Vector NewEndEffect)
{
	EndEffect = NewEndEffect;
	StreamEffect.EndEffect = EndEffect;
	StreamEffectChild.EndEffect = EndEffect;
	//StreamEffect.mWaveLockEnd = False;
}

simulated function Destroyed()
{
	if (StreamEffect != None)
		StreamEffect.destroy();
	if (StreamEffectChild != None)
		StreamEffectChild.destroy();
	if (Pack != None)
		Pack.Destroy();
	Super.Destroyed();
}

simulated function Tick(float DT)
{
	super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	
	if (StreamEffect != None && !Instigator.IsFirstPerson())
		StreamEffect.SetLocation(GetBoneCoords('tip2').Origin);
		
	if (StreamEffectChild != None && !Instigator.IsFirstPerson())
		StreamEffectChild.SetLocation(GetBoneCoords('tip2').Origin);
}

defaultproperties
{
     StreamAmbientSound=Sound'BWBP_OP_Sounds.ProtonPack.Proton-FireLoop'
     StreamAmbientSoundAlt=Sound'BWBP_OP_Sounds.ProtonPack.Proton-FireLoopAlt'
     BoostMuzzleFlashClass=Class'BWBP_APC_Pro.ThorLCFlashEmitterBoost'
     MuzzleFlashClass=Class'BWBP_APC_Pro.ThorLCFlashEmitter'
     AltMuzzleFlashClass=Class'BWBP_APC_Pro.ThorLCFlashEmitterAlt'
     ImpactManager=Class'BWBP_OP_Pro.IM_ProtonStream'
     WeaponLightTime=0.200000
     FlashScale=0.600000
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_Both
     ReloadAnim="Reload_MG"
     ReloadAnimRate=1.700000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_OP_Anim.ProtonPack_TPm'
     DrawScale=0.900000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=512.000000
}
