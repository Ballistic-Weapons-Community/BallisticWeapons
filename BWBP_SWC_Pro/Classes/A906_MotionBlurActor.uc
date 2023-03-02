//=============================================================================
// BC_MotionBlurActor.
//
// This actor is spaawned locally and linked to a playercontroller to handle
// motion blur effects for that player. To bring order to the situation, this
// will be used for all motion blur effects in BW.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A906_MotionBlurActor extends BC_MotionBlurActor;

simulated function PreBeginPlay()
{
	//if (!class'BallisticMod'.default.bUseMotionBlur)
	//	Destroy();
}

simulated function InitMotionBlur (float NewBlurFactor, float NewBlurTime, optional bool bNoFading, optional bool bNoAdd)
{
	//log("InitMotionBlur");
	PC = level.GetLocalPlayerController();
	if (PC == None /*|| !class'BallisticMod'.default.bUseMotionBlur*/)
		Destroy();
	else if (bNoAdd || BlurEndTime < level.TimeSeconds)
	{
		BlurFactor = NewBlurFactor;
		BlurTime = NewBlurTime;
		BlurEndTime = level.TimeSeconds + NewBlurTime;
		bNoFade = bNoFading;
		StartBlur();
	}
	else if ((BlurEndTime-level.TimeSeconds) + NewBlurTime > 10)
	{
		BlurFactor += NewBlurFactor;
		BlurTime += NewBlurTime;
		BlurEndTime = level.TimeSeconds + 10;
		bNoFade = bNoFading;
		StartBlur();
	}
	else
	{
		BlurFactor += NewBlurFactor;
		BlurTime += NewBlurTime;
		BlurEndTime += NewBlurTime;
		bNoFade = bNoFading;
		StartBlur();
	}
}

static function BC_MotionBlurActor DoMotionBlur (PlayerController PC, float NewBlurFactor, float NewBlurTime, optional bool bNoFading)
{
	local BC_MotionBlurActor B;
	local int i;

	if (PC == None /*||!class'BallisticMod'.default.bUseMotionBlur*/)
		return none;

	for (i=0;i<PC.Attached.length;i++)
		if (BC_MotionBlurActor(PC.Attached[i]) != None)
		{
			B = BC_MotionBlurActor(PC.Attached[i]);
			break;
		}
	if (B == None)
	{
		B = PC.Spawn(default.class, PC,,PC.Location);
		B.SetBase(PC);
	}
	if (B != None)
		B.InitMotionBlur (NewBlurFactor, NewBlurTime, bNoFading);
	return B;
}


simulated function StartBlur()
{
	local int i;

	if (PC == None)
		return;
	//log("In startblur");
	// To avoid conflict problems, we'll hijack any existing 'MotionBlur' rather than spawning a new one...
	for (i=0;i<PC.CameraEffects.length;i++)
		if (MotionBlur(PC.CameraEffects[i]) != None)	{
			MBlur = MotionBlur(PC.CameraEffects[i]);
			break;										}

	if (MBlur == None)
		MBlur = new class'MotionBlur';

	if (bNoFade)
		MBlur.BlurAlpha = 255 - 255 * FMin(1, BlurFactor);
	else
		MBlur.BlurAlpha = 255 - 255 * FMin(1, BlurFactor * ((BlurEndTime - level.TimeSeconds) / BlurTime));

	bIsBlurred=true;
	if (PC.CameraEffects.length < 1 || PC.CameraEffects[PC.CameraEffects.length-1] != MBlur)
		PC.AddCameraEffect(MBlur,true);
}

defaultproperties
{
}
