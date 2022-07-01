//=============================================================================
// AR23Attachment.
//
// 3rd person weapon attachment for AR23 Heavy Rifle
//
// by Marc "Sgt. Kelly" Moylan.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AR23Attachment extends BallisticAttachment;

var() class<BallisticShotgunFire>	FireClass;
var() vector		ScopedTracerOffset;

simulated function InstantFireEffects(byte Mode)
{
	if (FiringMode == 1)
		ShotgunFireEffects(FiringMode);

	super.InstantFireEffects(Mode);
}

// Do trace to find impact info and then spawn the effect
// This should be called from sub-classes
simulated function ShotgunFireEffects(byte Mode)
{
	local Vector HitLocation, Start, End;
	local Rotator R;
	local Material HitMat;
	local int i;
	local float XS, YS, RMin, RMax, Range, fX;

	if (Level.NetMode == NM_Client && FireClass != None)
	{
		XS = FireClass.default.XInaccuracy; YS = Fireclass.default.YInaccuracy;
		if(!bIsAimed)
		{
			XS *= 2.5;
			YS *= 2.5;
		}
		RMin = FireClass.default.TraceRange.Min; RMax = FireClass.default.TraceRange.Max;
		Start = Instigator.Location + Instigator.EyePosition();
		for (i=0;i<FireClass.default.TraceCount;i++)
		{
			mHitActor = None;
			Range = Lerp(FRand(), RMin, RMax);
			R = Rotator(mHitLocation);
			switch (FireClass.default.FireSpreadMode)
			{
				case FSM_Scatter:
					fX = frand();
					R.Yaw +=   XS * (frand()*2-1) * sin(fX*1.5707963267948966);
					R.Pitch += YS * (frand()*2-1) * cos(fX*1.5707963267948966);
					break;
				case FSM_Circle:
					fX = frand();
					R.Yaw +=   XS * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
					R.Pitch += YS * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
					break;
				default:
					R.Yaw += ((FRand()*XS*2)-XS);
					R.Pitch += ((FRand()*YS*2)-YS);
					break;
			}
			End = Start + Vector(R) * Range;
			mHitActor = Trace (HitLocation, mHitNormal, End, Start, false,, HitMat);
			if (mHitActor == None)
			{
				TracerClass = class<BCTraceEmitter>(FireClass.default.TracerClass);
				DoWaterTrace(Mode, Start, End);
				SpawnTracer(Mode, End);
				TracerClass = default.TracerClass;
			}
			else
			{
				TracerClass = class<BCTraceEmitter>(FireClass.default.TracerClass);
				DoWaterTrace(Mode, Start, HitLocation);
				SpawnTracer(Mode, HitLocation);
				TracerClass = default.TracerClass;
			}

			if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None))
				continue;

			if (HitMat == None)
				mHitSurf = int(mHitActor.SurfaceType);
			else
				mHitSurf = int(HitMat.SurfaceType);

			if (FireClass.default.ImpactManager != None)
				FireClass.default.ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, self);
		}
	}
}

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
    local Coords C;
	local vector TheVect;

	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator && BallisticWeapon(Instigator.Weapon).bScopeView)
	{
		C = Instigator.Weapon.GetBoneCoords('tip');
		TheVect = C.XAxis + C.YAxis;
		C.Origin += (ScopedTracerOffset >> rotator(TheVect));
	}
	else if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords('tip');
	else
		C = GetBoneCoords('tip');
	if (Instigator != None && level.NetMode != NM_StandAlone && level.NetMode != NM_ListenServer && VSize(C.Origin - Instigator.Location) > 300)
		return Instigator.Location;
    return C.Origin;
}

defaultproperties
{
	 FireClass=Class'BWBP_SKC_Pro.AR23SecondaryFire'
     ScopedTracerOffset=(Y=-14.000000,Z=-2.000000)
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_BigBullet'
     AltFlashBone="tip2"
     BrassClass=Class'BallisticProV55.Brass_M46AR'
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.AR23_TPm'
	 FlashScale=0.4
     DrawScale=1.000000
	 Skins(0)=Shader'BWBP_SKC_Tex.AR23.AR23-MainShine'
	 Skins(1)=Shader'BWBP_SKC_Tex.AR23.AR23-MiscShine'
	 Skins(2)=Shader'BWBP_SKC_Tex.AR23.AR23-HoloShine'
	 Skins(3)=Texture'BWBP_SKC_Tex.AR23.Muzzle_2D_View'
}
