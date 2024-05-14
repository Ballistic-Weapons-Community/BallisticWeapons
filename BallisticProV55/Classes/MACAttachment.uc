//=============================================================================
// MACAttachment.
//
// 3rd person weapon attachment for HAMR
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MACAttachment extends BallisticAttachment;

simulated Event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (BallisticTurret(Instigator) != None)
		bHidden=true;
}

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return Instigator.Weapon.GetBoneCoords('tip').Origin;
	else if (BallisticTurret(Instigator) != None)
		return Instigator.GetBoneCoords('tip').Origin;
;
	return GetBoneCoords('tip').Origin;
}
// Return location of brass ejector
simulated function Vector GetEjectorLocation(optional out Rotator EjectorAngle)
{
    local Coords C;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords(BrassBone);
	else if (BallisticTurret(Instigator) != None)
		C = Instigator.GetBoneCoords('RightHandle');
	else
		C = GetBoneCoords(BrassBone);
	if (Instigator != None && VSize(C.Origin - Instigator.Location) > 200)
	{
		EjectorAngle = Instigator.Rotation;
		return Instigator.Location;
	}
	if (BallisticTurret(Instigator) != None)
	{
		EjectorAngle = Instigator.GetBoneRotation('RightHandle');
		return C.Origin + class'BUtil'.static.AlignedOffset(EjectorAngle, vect(-12, -8, -4));
	}
	else
		EjectorAngle = GetBoneRotation(BrassBone);
    return C.Origin;
}

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode != 0 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
		{
			if (BallisticTurret(Instigator) != None)
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*1.666, Instigator, AltFlashBone);
			else
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
		}
		AltMuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
		{
			if (BallisticTurret(Instigator) != None)
				class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*1.666, Instigator, FlashBone);
			else
				class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		}
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

simulated function Tick(float DT)
{
	local rotator	newRot;
//	local int		VP;

	if (Instigator != None && !bHidden)
	{
//		VP = (256 * Instigator.ViewPitch) & 65535;
//		if (VP > 32768)
//			VP -= 65536;
		newRot = Instigator.Rotation;
		newRot.Pitch = Instigator.SmoothViewPitch;

		SetBoneDirection('Artillery', newRot,, 1.0, 1);
	}
}

defaultproperties
{
	WeaponClass=class'MACWeapon'
	MuzzleFlashClass=class'R78FlashEmitter'
	FlashScale=2.500000
	BrassClass=class'Brass_HAMR'
	InstantMode=MU_None
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_HAMR'
	DrawScale=0.200000
}
