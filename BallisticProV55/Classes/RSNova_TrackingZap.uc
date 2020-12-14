//=============================================================================
// RSNova_TrackingZap.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNova_TrackingZap extends BallisticEmitter;

var actor	Vic;
var RSNova_PlayerEffect	Flash;
var bool bHealing;

simulated function SetTarget(actor Targ, bool bHeal)
{
	if (Targ == None)
	{
		if (Flash != None)
		{
			Flash.StopSound();
			Flash.Kill();
		}
		Vic = None;
		return;
	}
	if (bHealing != bHeal)
	{
		bHealing = bHeal;
		if (bHeal)
		{
			Emitters[0].ColorScale[1].Color.G = 255;
			Emitters[0].ColorScale[1].Color.B = 192;
			Emitters[0].ColorScale[2].Color.G = 255;
			Emitters[0].ColorScale[2].Color.B = 64;
			Emitters[1].ColorMultiplierRange.Y.Min = 1.0;
			Emitters[1].ColorMultiplierRange.Y.Max = 1.0;
			Emitters[1].ColorMultiplierRange.Z.Min = 0.6;
			Emitters[1].ColorMultiplierRange.Z.Max = 0.6;
		}
		else
		{
			Emitters[0].ColorScale = default.Emitters[0].ColorScale;
			Emitters[1].ColorMultiplierRange = default.Emitters[1].ColorMultiplierRange;
		}
	}
	Vic = Targ;
	if (Flash == None)
		Flash = spawn(class'RSNova_PlayerEffect',Targ);
}
simulated function UpdateTargets()
{
	local vector Dir;
	if (Vic == None)
		return;
	Dir = Normal(Vic.Location - Location) * 300;
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(Vic.Location, Vic.Location);
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Weight = 1;

	if (Flash == None)
		Flash = spawn(class'RSNova_PlayerEffect',Vic);
	Dir = Normal(Location - Vic.Location);
	Flash.SetLocation(Vic.Location + Dir * Vic.CollisionRadius);
	Flash.SetRotation(rotator(Dir));

	BeamEmitter(Emitters[1]).BeamEndPoints = BeamEmitter(Emitters[0]).BeamEndPoints;
	BeamEmitter(Emitters[2]).BeamEndPoints = BeamEmitter(Emitters[0]).BeamEndPoints;
	BeamEmitter(Emitters[3]).BeamEndPoints = BeamEmitter(Emitters[0]).BeamEndPoints;
}

simulated function KillFlashes()
{
	if (Flash != None)
	{
		Flash.StopSound();
		Flash.Kill();
		Flash = None;
	}
}

simulated function Destroyed()
{
	if (Flash != None)
		Flash.Destroy();
	super.Destroyed();
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter5
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=-1100.000000,Max=-1100.000000),Z=(Min=-25.000000,Max=25.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         BeamTextureUScale=6.000000
         LowFrequencyNoiseRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         LowFrequencyPoints=5
         HighFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         BranchProbability=(Min=0.200000,Max=0.200000)
         BranchEmitter=1
         BranchSpawnAmountRange=(Min=1.000000,Max=1.000000)
         LinkupLifetime=True
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.214286,Color=(B=255,G=192,R=64,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=64,A=255))
         FadeOutStartTime=0.032000
         MaxParticles=3
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=12.000000,Max=20.000000),Y=(Min=12.000000,Max=20.000000),Z=(Min=12.000000,Max=20.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.RSNova_TrackingZap.BeamEmitter5'

     Begin Object Class=BeamEmitter Name=BeamEmitter7
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=-1100.000000,Max=-1100.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.600000,Max=0.600000))
         Opacity=0.630000
         FadeOutStartTime=0.036000
         MaxParticles=2
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.RSNova_TrackingZap.BeamEmitter7'

     Begin Object Class=BeamEmitter Name=BeamEmitter8
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=-1100.000000,Max=-1100.000000),Z=(Min=-25.000000,Max=25.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         BeamTextureUScale=6.000000
         LowFrequencyNoiseRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         LowFrequencyPoints=5
         HighFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         BranchProbability=(Min=0.200000,Max=0.200000)
         BranchEmitter=1
         BranchSpawnAmountRange=(Min=1.000000,Max=1.000000)
         LinkupLifetime=True
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.214286,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=192,R=255,A=255))
         FadeOutStartTime=0.030000
         MaxParticles=3
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=12.000000,Max=20.000000),Y=(Min=12.000000,Max=20.000000),Z=(Min=12.000000,Max=20.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(2)=BeamEmitter'BallisticProV55.RSNova_TrackingZap.BeamEmitter8'

     Begin Object Class=BeamEmitter Name=BeamEmitter9
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=-1100.000000,Max=-1100.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         BeamTextureUScale=2.000000
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.300000
         FadeOutStartTime=0.036000
         MaxParticles=2
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(3)=BeamEmitter'BallisticProV55.RSNova_TrackingZap.BeamEmitter9'

}
