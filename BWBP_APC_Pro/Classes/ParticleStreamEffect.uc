class ParticleStreamEffect extends BallisticEmitter;

var Actor Target;
var ParticleStreamer pPack;
var ParticleStreamAttachment ParticleAttachment;
var	bool	bAltColor;
var vector StartPoint, EndPoint;

replication
{
	reliable if (Role == ROLE_Authority)
		StartPoint, EndPoint, ParticleAttachment, Target, bAltColor;
}

/*simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if (Instigator.IsLocallyControlled())
	{
		if (ParticleStreamer(Instigator.Weapon) != None)
		{
			pPack = ParticleStreamer(Instigator.Weapon);
			pPack.StreamEffect = self;
		}
		if (ParticleStreamAttachment(Instigator.Weapon.ThirdPersonActor) != None)
			ParticleAttachment = ParticleStreamAttachment(Instigator.Weapon.ThirdPersonActor);
	}
	
	if (Role < ROLE_Authority && bAltColor)
		SetAltColor(bAltColor);
}*/

simulated function SetAltColor(bool bColorAlt)
{
	bAltColor = bColorAlt;
	if(bAltColor)
	{
		BeamEmitter(Emitters[2]).ColorScale[0].Color.B	= 0;
		BeamEmitter(Emitters[2]).ColorScale[0].Color.G	= 50;
		BeamEmitter(Emitters[2]).ColorScale[0].Color.R	= 255;
		BeamEmitter(Emitters[1]).ColorScale[0].Color.B	= 0;
		BeamEmitter(Emitters[1]).ColorScale[0].Color.G	= 50;
		BeamEmitter(Emitters[1]).ColorScale[0].Color.R	= 255;	
		BeamEmitter(Emitters[0]).ColorScale[0].Color.B	= 251;
		BeamEmitter(Emitters[0]).ColorScale[0].Color.G	= 124;
		BeamEmitter(Emitters[0]).ColorScale[0].Color.R	= 87;		

		BeamEmitter(Emitters[2]).ColorScale[1].Color.B	= 0;
		BeamEmitter(Emitters[2]).ColorScale[1].Color.G	= 50;
		BeamEmitter(Emitters[2]).ColorScale[1].Color.R	= 255;
		BeamEmitter(Emitters[1]).ColorScale[1].Color.B	= 0;
		BeamEmitter(Emitters[1]).ColorScale[1].Color.G	= 128;
		BeamEmitter(Emitters[1]).ColorScale[1].Color.R	= 255;	
		BeamEmitter(Emitters[0]).ColorScale[1].Color.B	= 251;
		BeamEmitter(Emitters[0]).ColorScale[1].Color.G	= 124;
		BeamEmitter(Emitters[0]).ColorScale[1].Color.R	= 87;	
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
			SetLocation(ParticleAttachment.GetTipLocation());
		}
	}
	else
	{
		if (ParticleAttachment != None)
			SetLocation(ParticleAttachment.GetBoneCoords('tip').Origin);
		else SetLocation(StartPoint);
	}
	
	if (Target != None)
	{
		for (i=0; i<3; i++)
			BeamEmitter(Emitters[i]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(Target.Location - Location, Target.Location - Location);
	}
	
	else if (!Instigator.IsLocallyControlled() || !Instigator.IsFirstPerson())
	{
		for (i=0; i<3; i++)
		{
			if (ParticleAttachment != None)
				BeamEmitter(Emitters[i]).BeamEndPoints[0].Offset = VtoRV(ParticleAttachment.mHitLocation - Location, ParticleAttachment.mHitLocation - Location);
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
		else EndPoint = ParticleAttachment.mHitLocation;
	}
		
	if (Instigator.IsLocallyControlled() && Instigator.IsFirstPerson())
		return;
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
     Begin Object Class=BeamEmitter Name=CoreBeam
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         RotatingSheets=1
         LowFrequencyNoiseRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         LowFrequencyPoints=10
         HighFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         HighFrequencyPoints=3
         DynamicHFNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         DynamicHFNoisePointsRange=(Max=2.000000)
         DynamicTimeBetweenNoiseRange=(Min=0.010000,Max=0.030000)
         LinkupLifetime=True
         UseColorScale=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(G=50,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=50,R=255,A=255))
         FadeOutStartTime=0.250000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         Texture=Texture'BWBP_OP_Tex.ProtonPack.StreamCore'
         LifetimeRange=(Min=0.050000,Max=0.050000)
     End Object
     Emitters(0)=BeamEmitter'BWBP_APC_Pro.ParticleStreamEffect.CoreBeam'

     Begin Object Class=BeamEmitter Name=Offshoot1
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         RotatingSheets=2
         LowFrequencyNoiseRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
         LowFrequencyPoints=6
         HighFrequencyNoiseRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         HighFrequencyPoints=3
         DynamicHFNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         DynamicHFNoisePointsRange=(Max=2.000000)
         DynamicTimeBetweenNoiseRange=(Min=0.010000,Max=0.030000)
         LinkupLifetime=True
         UseColorScale=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=251,G=124,R=87,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=251,G=124,R=87,A=255))
         FadeOutStartTime=0.250000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         Texture=Texture'BWBP_OP_Tex.ProtonPack.StreamCore'
         LifetimeRange=(Min=0.050000,Max=0.050000)
     End Object
     Emitters(1)=BeamEmitter'BWBP_APC_Pro.ParticleStreamEffect.Offshoot1'

     Begin Object Class=BeamEmitter Name=Offshoot2
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         RotatingSheets=2
         LowFrequencyNoiseRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
         LowFrequencyPoints=6
         HighFrequencyNoiseRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         HighFrequencyPoints=3
         DynamicHFNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         DynamicHFNoisePointsRange=(Max=2.000000)
         DynamicTimeBetweenNoiseRange=(Min=0.010000,Max=0.030000)
         LinkupLifetime=True
         UseColorScale=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=251,G=124,R=87,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=251,G=124,R=87,A=255))
         FadeOutStartTime=0.250000
         CoordinateSystem=PTCS_Relative
         MaxParticles=0
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         Texture=Texture'BWBP_OP_Tex.ProtonPack.StreamCore'
         LifetimeRange=(Min=0.050000,Max=0.050000)
     End Object
     Emitters(2)=BeamEmitter'BWBP_APC_Pro.ParticleStreamEffect.Offshoot2'

     Begin Object Class=SpriteEmitter Name=Sparks
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=64,G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=50
         StartLocationRange=(X=(Max=500.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'EpicParticles.Flares.FlickerFlare'
         LifetimeRange=(Min=2.000000,Max=3.000000)
         StartVelocityRange=(X=(Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_APC_Pro.ParticleStreamEffect.Sparks'

     AutoDestroy=True
     bAlwaysRelevant=True
     bReplicateInstigator=True
     RemoteRole=ROLE_SimulatedProxy
}
