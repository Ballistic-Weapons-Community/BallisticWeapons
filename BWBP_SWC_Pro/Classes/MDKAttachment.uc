//=============================================================================
// MDKAttachment.
//
// 3rd person weapon attachment for MDK SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MDKAttachment extends BallisticAttachment;

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

	if (MDKSubMachinegun(I) != None)
		SetSilenced(MDKSubMachinegun(I).bSilenced);
}

function SetSilenced(bool bIsSilenced)
{
	bSilenced = bIsSilenced;
	UpdateSilencer();
}

// The suppressor is not on the Silencer bone in this mesh, but it has its own skin
simulated function UpdateSilencer()
{
	bOldSilenced = bSilenced;
	if (bSilenced)
		Skins[2] = None;
	else
		Skins[2] = Texture'BW_Core_WeaponTex.Misc.Invisible';
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
		if (MDKSubMachinegun(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			return Instigator.Weapon.GetEffectStart();
	}
	else if (bSilenced)
		return GetBoneCoords('tip').Origin;
	else
		return GetBoneCoords('tip2').Origin;
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
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
	 WeaponClass=class'MDKSubMachinegun'
     MuzzleFlashClass=Class'BWBP_SWC_Pro.MDKFlashEmitter'
     AltMuzzleFlashClass=Class'BWBP_SWC_Pro.MDKSilencedFlash'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashBone="tip2"
     AltFlashBone="tip"
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMix=-3
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.075000
     CockAnimRate=0.900000
     bRapidFire=True
     bAltRapidFire=True
	 RelativeRotation=(Pitch=32768)
	 RelativeLocation=(z=10.000000)
     Mesh=SkeletalMesh'BWBP_SWC_Anims.MDK_TPm'
     DrawScale=0.350000
     Skins(0)=Texture'BWBP_SWC_Tex.MDK.Main_2D_View'
}
