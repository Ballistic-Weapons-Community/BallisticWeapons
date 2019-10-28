class XOXOStreamEffect extends BallisticEmitter;

var Actor Target;
var XOXOAttachment StaffAttachment;

var vector StartPoint, EndPoint;

replication
{
	reliable if (Role == ROLE_Authority)
		StartPoint, EndPoint, StaffAttachment, Target;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if (Instigator.IsLocallyControlled())
	{
		if (XOXOStaff(Instigator.Weapon) != None)
			XOXOStaff(Instigator.Weapon).StreamEffect = self;
		if (XOXOAttachment(Instigator.Weapon.ThirdPersonActor) != None)
			StaffAttachment = XOXOAttachment(Instigator.Weapon.ThirdPersonActor);
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
			SetLocation(StaffAttachment.GetTipLocation());
		}
	}
	else
	{
		if (StaffAttachment != None)
			SetLocation(StaffAttachment.GetBoneCoords('tip').Origin);
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
			if (StaffAttachment != None)
				BeamEmitter(Emitters[i]).BeamEndPoints[0].Offset = VtoRV(StaffAttachment.mHitLocation - Location, StaffAttachment.mHitLocation - Location);
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
		else EndPoint = StaffAttachment.mHitLocation;
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
     Begin Object Class=BeamEmitter Name=XOXOPinkBeamEmitter
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(offset=(Z=(Min=-20.000000,Max=20.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=6.000000
         RotatingSheets=5
         LowFrequencyNoiseRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         LowFrequencyPoints=12
         HighFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         BranchProbability=(Min=0.200000,Max=0.200000)
         BranchSpawnAmountRange=(Min=1.000000,Max=1.000000)
         LinkupLifetime=True
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=80,G=1,R=186,A=255))
         ColorScale(1)=(RelativeTime=0.428571,Color=(B=252,G=147,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=5,R=210,A=255))
         Opacity=0.050000
         FadeOutStartTime=0.032000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(Y=(Min=12.000000,Max=20.000000),Z=(Min=12.000000,Max=20.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=BeamEmitter'BWBPOtherPackPro.XOXOStreamEffect.XOXOPinkBeamEmitter'

     Begin Object Class=BeamEmitter Name=XOXOWhiteBeamEmitter
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         LowFrequencyNoiseRange=(X=(Min=-60.000000,Max=60.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=-60.000000,Max=60.000000))
         HighFrequencyNoiseRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
         BranchHFPointsRange=(Max=0.000000)
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000))
         Opacity=0.250000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         DetailMode=DM_SuperHigh
         StartSizeRange=(X=(Min=8.000000,Max=14.000000),Y=(Min=8.000000,Max=14.000000),Z=(Min=8.000000,Max=14.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(1)=BeamEmitter'BWBPOtherPackPro.XOXOStreamEffect.XOXOWhiteBeamEmitter'

     Begin Object Class=BeamEmitter Name=XOXORedCoreBeam
         BeamEndPoints(0)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.750000,Max=0.000000))
         Opacity=0.350000
         FadeOutStartTime=0.036000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(2)=BeamEmitter'BWBPOtherPackPro.XOXOStreamEffect.XOXORedCoreBeam'

     AutoDestroy=True
     bAlwaysRelevant=True
     bReplicateInstigator=True
     RemoteRole=ROLE_SimulatedProxy
}
