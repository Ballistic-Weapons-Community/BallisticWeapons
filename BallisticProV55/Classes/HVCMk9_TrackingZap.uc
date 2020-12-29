//=============================================================================
// HVCMk9_TrackingZap.
//
// A special ligtning beam effect that tracks multiple targets and implements
// a hit effect at each target.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9_TrackingZap extends BallisticEmitter;

var Actor Target;
var HvCMk9Attachment GunAttachment;

var vector StartPoint, EndPoint;

replication
{
	reliable if (Role == ROLE_Authority)
		StartPoint, EndPoint, GunAttachment, Target;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if (Instigator.IsLocallyControlled())
	{
		if (HvCMk9LightningGun(Instigator.Weapon) != None)
			HvCMk9LightningGun(Instigator.Weapon).StreamEffect = self;
		if (HvCMk9Attachment(Instigator.Weapon.ThirdPersonActor) != None)
			GunAttachment = HvCMk9Attachment(Instigator.Weapon.ThirdPersonActor);
	}
}

simulated function UpdateEndpoint()
{
	local byte i;
	
	SetRotation(rot(0,0,0));
	
	if (Instigator.IsLocallyControlled())
	{
		if (!Instigator.IsFirstPerson())
		{
			bHidden = False;
			SetLocation(GunAttachment.GetTipLocation());
		}
	}
	else
	{
		if (GunAttachment != None)
			SetLocation(GunAttachment.GetBoneCoords('tip').Origin);
		else SetLocation(StartPoint);
	}
	
	if (Target != None)
	{
		for (i=0; i<3; i++)
			BeamEmitter(Emitters[i]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(Target.Location - Location, Target.Location - Location);
	}
	
	else
	{
		for (i=0; i<3; i++)
		{
			if (GunAttachment != None)
				BeamEmitter(Emitters[i]).BeamEndPoints[0].Offset = VtoRV(GunAttachment.mHitLocation - Location, GunAttachment.mHitLocation - Location);
			else BeamEmitter(Emitters[i]).BeamEndPoints[0].Offset = VtoRV(EndPoint - Location, EndPoint - Location);
		}
	}
}

simulated function Tick(float dt)
{
	if (Role == ROLE_Authority)
	{
	    if  (Instigator == None || Instigator.Controller == None)
		{
			Destroy();
			return;
		}
		StartPoint = Instigator.Location + Instigator.EyePosition();
		if (Target != None)
			EndPoint = Target.Location;
		else EndPoint = GunAttachment.mHitLocation;
	}
	UpdateEndpoint();
}

simulated function Terminate()
{
	local int i;
	
	for (i=0;i<3;i++)
		BeamEmitter(Emitters[i]).RespawnDeadParticles = False;
}

simulated function TornOff()
{
	Kill();
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(offset=(Z=(Min=-20.000000,Max=20.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
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
         CoordinateSystem=PTCS_Relative
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
         BeamDistanceRange=(Min=1000.000000,Max=1000.000000)
         BeamEndPoints(0)=(offset=(Z=(Min=-50.000000,Max=50.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         LowFrequencyNoiseRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
         HighFrequencyNoiseRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         NoiseDeterminesEndPoint=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=8
         DetailMode=DM_SuperHigh
         StartSizeRange=(X=(Min=8.000000,Max=14.000000),Y=(Min=8.000000,Max=14.000000),Z=(Min=8.000000,Max=14.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.HVCMk9_TrackingZap.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter2
         BeamEndPoints(0)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.750000,Max=0.750000))
         FadeOutStartTime=0.036000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(2)=BeamEmitter'BallisticProV55.HVCMk9_TrackingZap.BeamEmitter2'

     AutoDestroy=True
     bAlwaysRelevant=True
     bReplicateInstigator=True
     RemoteRole=ROLE_SimulatedProxy
}
