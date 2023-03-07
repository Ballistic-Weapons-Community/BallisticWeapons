//=============================================================================
// AS50Attachment.
//
// 3rd person weapon attachment for SSG-50 Sniper
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AS50Attachment extends BallisticAttachment;

var() class<BCTraceEmitter>	AltTracerClass;		//Type of tracer to use for instant fire effects

simulated Event PreBeginPlay()
{
	super.PreBeginPlay();
	if (class'BCReplicationInfo'.static.IsClassicOrRealism())
	{
		ImpactManager=Class'IM_IncendiaryHMGBullet';
	}
}

simulated Event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (BallisticTurret(Instigator) != None)
		bHidden=true;
}

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z, Loc;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		if (AS50Rifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
			return Loc;
		}
		else
		{
			return Instigator.Weapon.GetEffectStart();
		}
	}
	else
	{
	    return GetBoneCoords('tip').Origin;
	}
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


// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (/*Level.DetailMode < DM_High || */class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetModeTipLocation();
	Dist = VSize(V - TipLoc);

	// Count shots to determine if it's time to spawn a tracer
	if (TracerMix == 0)
		bThisShot=true;
	else
	{
		TracerCounter++;
		if (TracerMix < 0)
		{
			if (TracerCounter >= -TracerMix)	{
				TracerCounter = 0;
				bThisShot=false;			}
			else
				bThisShot=true;
		}
		else if (TracerCounter >= TracerMix)	{
			TracerCounter = 0;
			bThisShot=true;					}
	}
	// Spawn a tracer
	if (TracerClass != None && TracerMode != MU_None && (TracerMode == MU_Both || (TracerMode == MU_Secondary && Mode != 0) || (TracerMode == MU_Primary && Mode == 0)) &&
		bThisShot && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
			if (Mode == 0)
				Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
			else Tracer = Spawn(AltTracerClass, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && Mode != 0) || (WaterTracerMode == MU_Primary && Mode == 0)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}

defaultproperties
{
     AltTracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Incendiary'
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     ImpactManager=Class'IM_IncendiaryBullet'
     BrassClass=Class'BWBP_SKC_Pro.Brass_BMGInc'
     TracerMode=MU_Secondary
     InstantMode=MU_Both
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_HMG'
     TracerChance=2.000000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlyBy',Volume=1.500000)
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=0.700000
     CockAnimRate=0.700000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FSSG-50_TPm'
     RelativeLocation=(X=-17.000000,Z=2.000000)
     RelativeRotation=(Pitch=32768)
     PrePivot=(Z=-1.000000)
     Skins(0)=Texture'BWBP_SKC_Tex.FSG50.FSG-Main'
     Skins(1)=Texture'BWBP_SKC_Tex.FSG50.FSG-Scope'
     Skins(2)=Texture'BW_Core_WeaponTex.A73.A73Energy'
     Skins(3)=Texture'BWBP_SKC_Tex.FSG50.FSG-Misc'
     Skins(4)=Texture'BWBP_SKC_Tex.FSG50.FSG-Stock'
}
