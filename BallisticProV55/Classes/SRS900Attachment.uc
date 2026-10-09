//=============================================================================
// SRS900Attachment.
//
// 3rd person weapon attachment for SRS900 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SRS900Attachment extends BallisticAttachment;

var   bool		bSilenced;		//Suppressor is on the barrel
var   bool		bOldSilenced;

replication
{
	reliable if ( Role==ROLE_Authority )
		bSilenced;
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (SRS900Rifle(I) != None)
		SetSilenced(SRS900Rifle(I).bSilenced);
}

function SetSilenced(bool bIsSilenced)
{
	bSilenced = bIsSilenced;
	UpdateSilencer();
}

// The suppressor is on the model for as long as it is on the gun, not from one shot to the next
simulated function UpdateSilencer()
{
	bOldSilenced = bSilenced;
	if (bSilenced)
		SetBoneScale (0, 1.0, 'Silencer');
	else
		SetBoneScale (0, 0.0, 'Silencer');
}

simulated event PostNetReceive()
{
	if (bSilenced != bOldSilenced)
		UpdateSilencer();
	Super.PostNetReceive();
}

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z;

	if (Instigator != None && Instigator.IsFirstPerson())
	{
		if (SRS900Rifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			return Instigator.Weapon.GetEffectStart();
	}
	else
		return GetBoneCoords('tip').Origin;
}


// After the layout's mesh is set
simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	UpdateSilencer();
}

simulated function FlashMuzzleFlash(byte Mode)
{
	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode != 0 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*0.6, self, AltFlashBone);
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
	}
}

defaultproperties
{
	WeaponClass=class'SRS900Rifle'
    MuzzleFlashClass=class'M50FlashEmitter'
    AltMuzzleFlashClass=class'XK2SilencedFlash'
    ImpactManager=class'IM_Bullet'
    AltFlashBone="tip2"
    FlashScale=0.800000
    BrassClass=class'Brass_Rifle'
    BrassMode=MU_Both
    InstantMode=MU_Both
    FlashMode=MU_Both
    TracerClass=class'TraceEmitter_Default'
    WaterTracerClass=class'TraceEmitter_WaterBullet'
    WaterTracerMode=MU_Both
    FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
    ReloadAnim="Reload_AR"
    bRapidFire=True
    bAltRapidFire=True
	ReloadAnimRate=0.800000
	CockAnimRate=1.200000
    Mesh=SkeletalMesh'BW_Core_WeaponAnim.SRS900_TPm'
    DrawScale=0.250000
	RelativeLocation=(X=2,Z=2.5)
}
