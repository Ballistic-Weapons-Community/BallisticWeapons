//=============================================================================
// MG36Attachment.
//
// 3rd person weapon attachment for MG36 Tactical Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MG36Attachment extends BallisticAttachment;

var	  BallisticWeapon		myWeap;
var() Material	InvisTex;

var bool		bSilenced;
var bool		bOldSilenced;

replication
{
	reliable if ( Role==ROLE_Authority )
		bSilenced;
	//reliable if ( Role==ROLE_Authority )
		//LaserRot;
}

simulated Event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (BallisticTurret(Instigator) != None)
		bHidden=true;
}

simulated event PostNetReceive()
{
	if (bSilenced != bOldSilenced)
	{
		bOldSilenced = bSilenced;
		if (bSilenced)
			SetBoneScale (0, 1.0, 'Silencer');
		else
			SetBoneScale (0, 0.0, 'Silencer');
	}
	Super.PostNetReceive();
}


function IAOverride(bool bSilenced)
{
	if (bSilenced)
		SetBoneScale (0, 1.0, 'Silencer');
	else
		SetBoneScale (0, 0.0, 'Silencer');
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetBoneScale (0, 0.0, 'Silencer');
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
}

defaultproperties
{
	WeaponClass=class'MG36Machinegun'
	MuzzleFlashClass=class'M50FlashEmitter'
	AltMuzzleFlashClass=Class'BWBP_SKC_Pro.MG36SilencedFlash'
	ImpactManager=class'IM_Bullet'
	AltFlashBone="tip2"
	BrassClass=class'Brass_Rifle'
	InstantMode=MU_Both
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_MG36'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	ReloadAnim="Reload_AR"
	ReloadAnimRate=1.200000
	FlashScale=0.500000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.MG36_TPm'
	RelativeRotation=(Pitch=32768)
	DrawScale=1.000000
	PrePivot=(Z=-10.000000)
}
