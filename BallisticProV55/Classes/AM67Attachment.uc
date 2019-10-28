//=============================================================================
// AM67Attachment.
//
// 3rd person weapon attachment for AM67 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AM67Attachment extends HandgunAttachment;

simulated function InstantFireEffects(byte Mode)
{
	local vector L, Dir;

	if (Mode == 0)
	{
		super.InstantFireEffects(Mode);
		return;
	}
//	L = GetTipLocation();
	L = Instigator.Location + Instigator.EyePosition();
	Dir = Normal(mHitLocation - L);

	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		Spawn(class'AM67FlashProjector',Instigator,,L+Dir*25,rotator(Dir));
	else
		Spawn(class'AM67FlashProjector',Instigator,,GetTipLocation(),rotator(Dir));
}

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;
	local float DF;

	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode != 0 && AltMuzzleFlashClass != None)
	{
//		AltMuzzleFlash = Spawn(AltMuzzleFlashClass, self);
//		AttachToBone(AltMuzzleFlash, AltFlashBone);
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);

//		DF = Normal(level.GetlocalPlayerController().Location - (Instigator.Location + Instigator.EyePosition())) Dot Normal(mHitLocation - (Instigator.Location + Instigator.EyePosition()));
//		DF = FMax(0,DF);v
		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Min = (200 + DF*600) * DrawScale * FlashScale;
		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Max = Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Min;

//		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Min *= 1 + DF*3;
//		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Max *= 1 + DF*3;

//		class'BallisticEmitter'.static.ScaleEmitter(Emitter(AltMuzzleFlash), DrawScale);

		AltMuzzleFlash.Trigger(self, Instigator);
//		AltMuzzleFlash.LifeSpan = 0.3;
//		Emitter(AltMuzzleFlash).Kill();
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_BigBullet'
     AltFlashBone="ejector"
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     FlashMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=0.950000
     Mesh=SkeletalMesh'BallisticAnims2.AM67-3rd'
     DrawScale=0.140000
}
