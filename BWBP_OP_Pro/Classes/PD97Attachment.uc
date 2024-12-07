class PD97Attachment extends HandgunAttachment;

var Pawn TazerHit, OldTazerHit;
var PD97TazerEffect TazerEffect;
var() class<BallisticShotgunFire>	FireClass;
var bool	bShotgunMode;
var bool	bOldShotgunMode;


replication
{
	reliable if (Role == ROLE_Authority)
		TazerHit, bShotgunMode;
}

function InitFor(Inventory I)
{
	Super.InitFor(I);
	
	if (PD97Bloodhound(I) != None && PD97Bloodhound(I).bShotgunMode)
	{
		bShotgunMode=True;
	}
}

//===========================================================================
// PostNetReceive
//
// Notifies clients of targets
//===========================================================================
simulated function PostNetReceive()
{
	if (TazerHit != OldTazerHit)
	{
		OldTazerHit = TazerHit;
		if (TazerHit != None)
			GotTarget(TazerHit);
		else
		{
			TazerEffect.Kill();
			TazerEffect = None;
			if (PD97Bloodhound(Instigator.Weapon) != None)
				PD97Bloodhound(Instigator.Weapon).TazerEffect = None;
		}
	}
	
	if (bShotgunMode != bOldShotgunMode)
	{
		bOldShotgunMode = bShotgunMode;
		InstantMode=MU_Primary;
	}
	Super.PostNetReceive();
}

//===========================================================================
 // GotTarget
 //
 // Called from secondary fire on tazer hit.
//===========================================================================
simulated function GotTarget(Pawn A)
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		TazerHit = A;
	if (TazerEffect == None)
	{
		TazerEffect = spawn(class'PD97TazerEffect', self,,,rot(0,0,0));
		if (PD97Bloodhound(Instigator.Weapon) != None)
			PD97Bloodhound(Instigator.Weapon).TazerEffect = TazerEffect;
		TazerEffect.SetTarget(A);
		TazerEffect.Instigator = Instigator;
		TazerEffect.UpdateTargets();
	}
	else
		TazerEffect.SetTarget(A);
}

//===========================================================================
 // TazeEnd
 //
 // Called from secondary fire on release of altfire key or from tazereffect on loss of target.
//===========================================================================
simulated function TazeEnd()
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		TazerHit = None;
	if (TazerEffect != None)
	{
		TazerEffect.KillFlashes();
		TazerEffect.SetTimer(0.0, false);
		TazerEffect.Kill();

		if (PD97Bloodhound(Instigator.Weapon) != None)
			PD97Bloodhound(Instigator.Weapon).TazerEffect = None;
	}
}
//===========================================================================
 // Shotgun Mode
 //
 // Realisim calls shotgun effects
//===========================================================================
simulated function InstantFireEffects(byte Mode)
{
	if (bShotgunMode)
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

simulated function Tick(float DT)
{
	super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	
	if (TazerEffect != None && !Instigator.IsFirstPerson())
		TazerEffect.SetLocation(GetBoneCoords('tip2').Origin);
}

simulated function Destroyed()
{
	if (TazerEffect != None)
	{
		TazerEffect.KillFlashes();
		TazerEffect.SetTimer(0.0, false);
		TazerEffect.Kill();
	}
	
	Super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'PD97Bloodhound'
     FireClass=Class'BWBP_OP_Pro.PD97PrimaryShotgunFire'
     MuzzleFlashClass=class'D49FlashEmitter'
     ImpactManager=class'IM_BigBullet'
     AltFlashBone="ejector"
     BrassClass=class'Brass_Pistol'
     InstantMode=MU_None
     FlashMode=MU_None
     TracerClass=class'TraceEmitter_Pistol'
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     WaterTracerMode=MU_None
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_BreakOpen"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.850000
     CockAnimRate=1.300000
     Mesh=SkeletalMesh'BWBP_OP_Anim.PD97_TPm'
     RelativeLocation=(Z=11.000000)
     DrawScale=0.200000
}
