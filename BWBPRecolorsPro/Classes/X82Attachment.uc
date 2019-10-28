//=============================================================================
// X82Attachment.
//
// 3rd person weapon attachment for X82 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class X82Attachment extends BallisticAttachment;

simulated Event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (BallisticTurret(Instigator) != None)
		bHidden=true;
}

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
    local Coords C;
    local Vector X, Y, Z, Loc;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (X82Rifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
			return Loc;
		}
		else
		{
			C = Instigator.Weapon.GetBoneCoords('tip');
    			return C.Origin;
		}
	}
	else if (BallisticTurret(Instigator) != None)
	{
		C = Instigator.GetBoneCoords('tip');
    		return C.Origin;
	}
	else
	{
		C = GetBoneCoords('tip');
	     return C.Origin;
	}
	if (Instigator != None && VSize(C.Origin - Instigator.Location) > 250)
		return Instigator.Location;

}
// Return location of brass ejector
simulated function Vector GetEjectorLocation(optional out Rotator EjectorAngle)
{
    local Coords C;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords(BrassBone);
	else if (BallisticTurret(Instigator) != None)
		C = Instigator.GetBoneCoords(BrassBone);
	else
		C = GetBoneCoords(BrassBone);
	if (Instigator != None && VSize(C.Origin - Instigator.Location) > 200)
	{
		EjectorAngle = Instigator.Rotation;
		return Instigator.Location;
	}
	if (BallisticTurret(Instigator) != None)
		EjectorAngle = Instigator.GetBoneRotation(BrassBone);
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

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     ImpactManager=Class'BWBPRecolorsPro.IM_ExpBullet'
     BrassClass=Class'BWBPRecolorsPro.Brass_BMG'
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_HMG'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'PackageSounds4Pro.X82.X83-FlyBy',Volume=2.500000)
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.800000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.X83A1_3rd'
     RelativeLocation=(X=-17.000000,Z=2.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.250000
}
