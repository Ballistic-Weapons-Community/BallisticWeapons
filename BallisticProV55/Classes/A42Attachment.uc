//=============================================================================
// A42Attachment.
//
// 3rd person weapon attachment for A42 Skrith Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A42Attachment extends HandgunAttachment;

var Actor GlowFX;

// The glow, muzzle flashes, beam and the beam's impact have the colour of the layout. The layout is known here, not yet
// in PostBeginPlay
simulated function ApplyModel()
{
	local class<Actor> GlowClass;

	super.ApplyModel();

	if (LayoutIndex == 1)
	{
		GlowClass = class'A42AmbientFXRed';
		ModeInfos[0].MuzzleFlashClass = class'A42FlashEmitterBal';
		ModeInfos[1].MuzzleFlashClass = class'A42FlashEmitterBal';
		TracerClass = class'TraceEmitter_A42BeamRed';
		// mode 0 as well: clients do the beam's direct hits with it
		ModeInfos[0].ImpactManager = class'IM_A42ProjectileBal';
		ModeInfos[1].ImpactManager = class'IM_A42ProjectileBal';
	}
	else if (LayoutIndex == 2)
		GlowClass = class'A42AmbientFXGreen';
	else
		GlowClass = class'A42AmbientFX';

    if (level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, GlowClass, DrawScale, self, 'tip');
}


simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local float Dist;
	if (Level.DetailMode < DM_High)
		return;
	if (TracerMode == MU_None || (TracerMode == MU_Secondary && Mode == 0) || (TracerMode == MU_Primary && Mode != 0))
		return;
	if (TracerClass == None)
		return;
	if (TracerChance < 1 && FRand() > TracerChance)
		return;
	if (VSize(V) < 2)
		V = Instigator.Location + Instigator.EyePosition() + V * 5000;
	Dist = VSize(V - GetModeTipLocation(Mode));
	if (Dist > 25)
	{
		Tracer = Spawn(TracerClass, self, , GetModeTipLocation(Mode), Rotator(V - GetModeTipLocation(Mode)));
		Tracer.Initialize(Dist);
	}
}

defaultproperties
{
	WeaponClass=class'A42SkrithPistol'
	MuzzleFlashClass=class'A42FlashEmitter'
	AltMuzzleFlashClass=class'A42FlashEmitter'
	ImpactManager=class'IM_A42Projectile'
	BrassMode=MU_None
	TracerMode=MU_Secondary
	InstantMode=MU_Secondary
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=class'TraceEmitter_A42Beam'
	MeleeImpactManager=class'IM_GunHit'
	bRapidFire=True
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.A42_TPm'
	DrawScale=0.080000
}
