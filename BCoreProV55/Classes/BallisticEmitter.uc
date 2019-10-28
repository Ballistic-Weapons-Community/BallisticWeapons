//=============================================================================
// BallisticEmitter.
//
// A Base class for Ballistic Emitters. Includes some default functionality:
// -Disables individual particle emitters depedning on effects detail.
// -Use EmitterZTestSwitches to auto set ZTest if you want it to be different
//  depending on players seeing emitter or not.
// -Static function, VtoRV() can turn min and max vectors into a range vector
// -Static function, ScaleRV() scales a range vector
// -Static function, ScaleEmitter() scales an entire emitter (very handy!)
// -static function, KillEmitter() is can smoothly remove an emitter instead of
//  using Destroy(). Obsolete now since Kill() was added...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticEmitter extends Emitter
	placeable;

enum EZTestMode		// ZTest switch settings...
{
	ZM_None,			// Don't do anything
	ZM_OnWhenVisible,	// Set ZTest on if the emitter is visible
	ZM_OffWhenVisible	// Set ZTest off if this emitter is visible
};
var() array<EZTestMode>	EmitterZTestSwitches;		// Swithes to change ZTest of each emitter depending on LOS

simulated event PostBeginPlay()
{
	local int i;
	local bool bLOS;

	super.PostBeginPlay();
	if (class'BallisticMod'.default.EffectsDetailMode < 2)
	{
		for (i=0;i<Emitters.length;i++)
			if (Emitters[i].DetailMode > class'BallisticMod'.default.EffectsDetailMode)
				Emitters[i].Disabled=true;
	}
	if (EmitterZTestSwitches.length > 0)
	{
		bLOS = Level.GetLocalPlayerController().LineOfSightTo(self);
		for (i=0;i<Min(EmitterZTestSwitches.length, Emitters.length);i++)
		{
			if (EmitterZTestSwitches[i] == ZM_None)
				continue;
			if (bLOS)
				Emitters[i].ZTest = EmitterZTestSwitches[i] == ZM_OnWhenVisible;
			else
				Emitters[i].ZTest = EmitterZTestSwitches[i] == ZM_OffWhenVisible;
		}
	}
}

//FIXME
simulated function InvertY()
{
	local int i;
	for (i=0;i<Emitters.length;i++)
		Emitters[i].StartLocationOffset.Y *= -1;
}

// Returns a nice neat RangeVector made of two input vectors, Min and Max.
static function RangeVector VtoRV (Vector Max, Vector Min)
{
	local RangeVector RV;
	RV.X.Max = Max.X; RV.X.Min = Min.X; RV.Y.Max = Max.Y; RV.Y.Min = Min.Y; RV.Z.Max = Max.Z; RV.Z.Min = Min.Z;
	return RV;
}
// Scales a RangeVector
static function ScaleRV (out RangeVector RV, float Scale)
{
	RV.X.Max*=Scale;	RV.Y.Max*=Scale;	RV.Z.Max*=Scale;
	RV.X.Min*=Scale;	RV.Y.Min*=Scale;	RV.Z.Min*=Scale;
}

// Scales the parameters of an emitter to resize it
static function ScaleEmitter (Emitter TheOne, float Scale)
{
	local int i, j;

	for (i=0;i<TheOne.Emitters.Length;i++)
	{
		ScaleRV (TheOne.Emitters[i].StartVelocityRange, Scale);
		TheOne.Emitters[i].SphereRadiusRange.Min*=Scale; TheOne.Emitters[i].SphereRadiusRange.Max*=Scale;
		TheOne.Emitters[i].StartVelocityRadialRange.Min*=Scale; TheOne.Emitters[i].StartVelocityRadialRange.Max*=Scale;
		TheOne.Emitters[i].MaxAbsVelocity *= Scale;
		ScaleRV (TheOne.Emitters[i].StartSizeRange, Scale);
		TheOne.Emitters[i].Acceleration *= Scale;
		ScaleRV (TheOne.Emitters[i].StartLocationRange, Scale);
		TheOne.Emitters[i].StartLocationOffset *= Scale;
		ScaleRV (TheOne.Emitters[i].MeshScaleRange, Scale);
		ScaleRV (TheOne.Emitters[i].VelocityScaleRange, Scale);
		ScaleRV (TheOne.Emitters[i].VelocityLossRange, Scale);
		if (BeamEmitter(TheOne.Emitters[i]) != None)
		{
			for (j=0;j<BeamEmitter(TheOne.Emitters[i]).BeamEndPoints.length;j++)
				ScaleRV (BeamEmitter(TheOne.Emitters[i]).BeamEndPoints[j].Offset, Scale);
			ScaleRV (BeamEmitter(TheOne.Emitters[i]).LowFrequencyNoiseRange, Scale);
			ScaleRV (BeamEmitter(TheOne.Emitters[i]).HighFrequencyNoiseRange, Scale);
			ScaleRV (BeamEmitter(TheOne.Emitters[i]).DynamicHFNoiseRange, Scale);
			BeamEmitter(TheOne.Emitters[i]).BeamDistanceRange.Max *= Scale;	BeamEmitter(TheOne.Emitters[i]).BeamDistanceRange.Min *= Scale;
		}
	}
}

// Instead of destroying emitters, we can use this to gracefully make them go away
static function KillEmitter (Emitter TheOne)
{
	local int i;

	TheOne.AutoDestroy = True;
	for (i=0; i<TheOne.Emitters.Length; i++)
	{
		TheOne.Emitters[i].AutoDestroy = True;
		TheOne.Emitters[i].AutomaticInitialSpawning = False;
		TheOne.Emitters[i].RespawnDeadParticles = False;
		TheOne.Emitters[i].InitialParticlesPerSecond = 0;
		TheOne.Emitters[i].ParticlesPerSecond = 0;
		TheOne.Emitters[i].TriggerDisabled=true;
	}
}

// Make the emitter stop producing particles
static function StopParticles (Emitter TheOne)
{
	local int i;

	TheOne.AutoDestroy = false;
	for (i=0; i<TheOne.Emitters.Length; i++)
	{
		TheOne.Emitters[i].AutoDestroy = false;
		TheOne.Emitters[i].AutomaticInitialSpawning = false;
		TheOne.Emitters[i].RespawnDeadParticles = false;
		TheOne.Emitters[i].InitialParticlesPerSecond = 0;
		TheOne.Emitters[i].ParticlesPerSecond = 0;
		TheOne.Emitters[i].TriggerDisabled=true;
	}
}

// Make the emitter start producing particles again
static function ResumeParticles (Emitter TheOne)
{
	local int i;

	for (i=0; i<TheOne.Emitters.Length; i++)
	{
		TheOne.Emitters[i].AutomaticInitialSpawning		= TheOne.Emitters[i].default.AutomaticInitialSpawning;
		TheOne.Emitters[i].RespawnDeadParticles			= TheOne.Emitters[i].default.RespawnDeadParticles;
		TheOne.Emitters[i].InitialParticlesPerSecond	= TheOne.Emitters[i].default.InitialParticlesPerSecond;
		TheOne.Emitters[i].ParticlesPerSecond			= TheOne.Emitters[i].default.ParticlesPerSecond;
		TheOne.Emitters[i].TriggerDisabled				= TheOne.Emitters[i].default.TriggerDisabled;
	}
}

defaultproperties
{
     bNoDelete=False
     bGameRelevant=True
}
