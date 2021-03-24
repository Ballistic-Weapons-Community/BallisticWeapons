//=============================================================================
// HVCMk9_TrackingZap.
//
// A special ligtning beam effect that tracks multiple targets and implements
// a hit effect at each target.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9_TrackingZapClassic extends BallisticEmitter;

struct LightningTarget
{
	var vector 	Lure;
	var actor	Vic;
	var HVCMk9_PlayerEffect	Flash;
};
var array<LightningTarget> Targets;

simulated function SetTargets(array<actor> Ts, array<vector> Vs)
{
	local int i;

	while (Targets.length > Ts.length+Vs.length)
	{
		Targets[Targets.length-1].Flash.StopSound();
		Targets[Targets.length-1].Flash.Kill();
		Targets.length = Targets.length - 1;
	}
	Targets.length = Ts.length + Vs.length;
	BeamEmitter(Emitters[0]).BeamEndPoints.length = Targets.length;
	BeamEmitter(Emitters[1]).BeamEndPoints.length = Targets.length;
	for(i=0;i<Ts.length;i++)
	{
		if (Ts[i] == None)
		{
			Targets[i].Vic = None;
			if (Targets[i].Flash != None)
			{	Targets[i].Flash.StopSound();
				Targets[i].Flash.Kill();
			}
			continue;
		}
		Targets[i].Vic = Ts[i];
		if (Targets[i].Flash == None)
			Targets[i].Flash = spawn(class'HVCMk9_PlayerEffect',Ts[i]);
	}
	for(i=0;i<Vs.length;i++)
	{
		Targets[i+Ts.length].Vic = None;
		Targets[i+Ts.length].Lure = Vs[i];
		if (Vs[i] == vect(0,0,0))
		{
			if (Targets[i+Ts.length].Flash != None)
			{	Targets[i+Ts.length].Flash.StopSound();
				Targets[i+Ts.length].Flash.Kill();
			}
			continue;
		}
		if (Targets[i+Ts.length].Flash == None)
			Targets[i+Ts.length].Flash = spawn(class'HVCMk9_PlayerEffect');
	}
}
simulated function UpdateTargets()
{
	local int i;
	local vector Dir;
	if (Targets.length < 1)
		return;
	for (i=0;i<Targets.length;i++)
	{
		if (Targets[i].Vic == None)
		{
			if (Targets[i].Lure == vect(0,0,0))
				continue;

			Dir = Normal(Targets[i].Lure - Location) * 300;
			BeamEmitter(Emitters[0]).BeamEndPoints[i].Offset = class'BallisticEmitter'.static.VtoRV(Targets[i].Lure, Targets[i].Lure);
			BeamEmitter(Emitters[0]).BeamEndPoints[i].Weight = 1;
			BeamEmitter(Emitters[1]).BeamEndPoints[i].Offset = class'BallisticEmitter'.static.VtoRV(Dir+Targets[i].Lure-vect(200,200,100), Dir+Targets[i].Lure+vect(200,200,100));
			BeamEmitter(Emitters[1]).BeamEndPoints[i].Weight = 1;

			if (Targets[i].Flash == None)
				Targets[i].Flash = spawn(class'HVCMk9_PlayerEffect');

			Dir = Normal(Location - Targets[i].Lure);
			Targets[i].Flash.SetLocation(Targets[i].Lure + Dir);
			Targets[i].Flash.SetRotation(rotator(Dir));
			continue;
		}
		Dir = Normal(Targets[i].Vic.Location - Location) * 300;
		BeamEmitter(Emitters[0]).BeamEndPoints[i].Offset = class'BallisticEmitter'.static.VtoRV(Targets[i].Vic.Location, Targets[i].Vic.Location);
		BeamEmitter(Emitters[0]).BeamEndPoints[i].Weight = 1;
		BeamEmitter(Emitters[1]).BeamEndPoints[i].Offset = class'BallisticEmitter'.static.VtoRV(Dir+Targets[i].Vic.Location-vect(200,200,100), Dir+Targets[i].Vic.Location+vect(200,200,100));
		BeamEmitter(Emitters[1]).BeamEndPoints[i].Weight = 1;

		if (Targets[i].Flash == None)
			Targets[i].Flash = spawn(class'HVCMk9_PlayerEffect',Targets[i].Vic);
		Dir = Normal(Location - Targets[i].Vic.Location);
		Targets[i].Flash.SetLocation(Targets[i].Vic.Location + Dir * Targets[i].Vic.CollisionRadius);
		Targets[i].Flash.SetRotation(rotator(Dir));
	}
	BeamEmitter(Emitters[2]).BeamEndPoints = BeamEmitter(Emitters[0]).BeamEndPoints;
}

simulated function KillFlashes()
{
	local int i;

	for (i=0;i<Targets.length;i++)
		if (Targets[i].Flash != None)
		{
			Targets[i].Flash.StopSound();
			Targets[i].Flash.Kill();
			Targets[i].Flash = None;
		}
}

simulated function Destroyed()
{
	local int i;
	for (i=0;i<Targets.length;i++)
		if (Targets[i].Flash != None)
			Targets[i].Flash.Destroy();
	super.Destroyed();
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(offset=(Z=(Min=-20.000000,Max=20.000000)),Weight=1.000000)
         BeamEndPoints(1)=(offset=(Y=(Min=-1000.000000,Max=-1000.000000),Z=(Min=-20.000000,Max=20.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         BeamTextureUScale=6.000000
         LowFrequencyNoiseRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         LowFrequencyPoints=5
         HighFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         UseBranching=True
         BranchProbability=(Min=0.200000,Max=0.200000)
         BranchEmitter=1
         BranchSpawnAmountRange=(Min=1.000000,Max=1.000000)
         LinkupLifetime=True
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=224,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.428571,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         FadeOutStartTime=0.032000
         MaxParticles=8
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=12.000000,Max=20.000000),Y=(Min=12.000000,Max=20.000000),Z=(Min=12.000000,Max=20.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.HVCMk9_TrackingZap.BeamEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=400.000000,Max=1000.000000)
         BeamEndPoints(0)=(offset=(X=(Max=400.000000),Y=(Max=400.000000),Z=(Min=-200.000000,Max=200.000000)),Weight=1.000000)
         BeamEndPoints(1)=(offset=(X=(Max=400.000000),Y=(Min=-1200.000000,Max=-800.000000),Z=(Min=-200.000000,Max=200.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         LowFrequencyNoiseRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
         HighFrequencyNoiseRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         NoiseDeterminesEndPoint=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.700000),Y=(Min=0.700000,Max=0.900000))
         MaxParticles=8
         DetailMode=DM_SuperHigh
         StartSizeRange=(X=(Min=8.000000,Max=14.000000),Y=(Min=8.000000,Max=14.000000),Z=(Min=8.000000,Max=14.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.HVCMk9_TrackingZap.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter2
         BeamEndPoints(0)=(offset=(Y=(Min=-1000.000000,Max=-1000.000000)),Weight=1.000000)
         BeamEndPoints(1)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.750000,Max=0.750000))
         FadeOutStartTime=0.036000
         MaxParticles=3
         DetailMode=DM_High
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(2)=BeamEmitter'BallisticProV55.HVCMk9_TrackingZap.BeamEmitter2'

     bNoDelete=False
}
