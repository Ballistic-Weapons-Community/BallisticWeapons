class ProtonStreamEffect extends BallisticEmitter;

var Actor Target;
var ProtonStreamer pPack;
var	bool	bAltColor;
var vector StartPoint, EndPoint;

replication
{
	reliable if (Role == ROLE_Authority)
		StartPoint, EndPoint, Target, bAltColor;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if (Instigator.IsLocallyControlled())
	{
		if (ProtonStreamer(Instigator.Weapon) != None)
		{
			pPack = ProtonStreamer(Instigator.Weapon);
			pPack.StreamEffect = self;
		}
	}
	
	if (Role < ROLE_Authority && bAltColor)
		SetAltColor(bAltColor);
}

simulated function PostNetReceive()
{
	UpdateEndpoint();
}


simulated function SetAltColor(bool bColorAlt)
{
	bAltColor = bColorAlt;
	if(bAltColor)
	{
		BeamEmitter(Emitters[2]).ColorScale[0].Color.B	= 0;
		BeamEmitter(Emitters[2]).ColorScale[0].Color.G	= 64;
		BeamEmitter(Emitters[2]).ColorScale[0].Color.R	= 255;
		BeamEmitter(Emitters[1]).ColorScale[0].Color.B	= 0;
		BeamEmitter(Emitters[1]).ColorScale[0].Color.G	= 64;
		BeamEmitter(Emitters[1]).ColorScale[0].Color.R	= 255;	
		BeamEmitter(Emitters[0]).ColorScale[0].Color.B	= 0;
		BeamEmitter(Emitters[0]).ColorScale[0].Color.G	= 64;
		BeamEmitter(Emitters[0]).ColorScale[0].Color.R	= 255;		

		BeamEmitter(Emitters[2]).ColorScale[1].Color.B	= 0;
		BeamEmitter(Emitters[2]).ColorScale[1].Color.G	= 128;
		BeamEmitter(Emitters[2]).ColorScale[1].Color.R	= 255;
		BeamEmitter(Emitters[1]).ColorScale[1].Color.B	= 0;
		BeamEmitter(Emitters[1]).ColorScale[1].Color.G	= 128;
		BeamEmitter(Emitters[1]).ColorScale[1].Color.R	= 255;	
		BeamEmitter(Emitters[0]).ColorScale[1].Color.B	= 0;
		BeamEmitter(Emitters[0]).ColorScale[1].Color.G	= 128;
		BeamEmitter(Emitters[0]).ColorScale[1].Color.R	= 255;			
	}
}

simulated function UpdateEndpoint()
{
	local byte i;
	local ProtonStreamAttachment Attachment;
	local vector OffsetVector;
	
	if (Instigator != None && Instigator.Weapon != None && Instigator.Weapon.ThirdPersonActor != None)	
		Attachment = ProtonStreamAttachment(Instigator.Weapon.ThirdPersonActor);
	
	SetRotation(rot(0,0,0));
	
	if (Instigator != None && Instigator.IsLocallyControlled())
	{
		if (!Instigator.IsFirstPerson())
		{
			bHidden = False;
			
			if (Attachment != None)
				SetLocation(Attachment.GetModeTipLocation());
		}
	}
	else if (Attachment != None)
		SetLocation(Attachment.GetBoneCoords('tip').Origin);
	else 
		SetLocation(StartPoint);
	
	if (Target != None)
		OffsetVector = Target.Location - Location;
	else
		OffsetVector = EndPoint - Location;
	
	for (i=0; i<3; i++)
		BeamEmitter(Emitters[i]).BeamEndPoints[0].Offset = VtoRV(OffsetVector, OffsetVector);
}

simulated function Tick(float dt)
{
	if (Role < ROLE_Authority)
		return;
		
	if  (Instigator == None || Instigator.Controller == None || Instigator.Weapon == None)
	{
		Destroy();
		return;
	}
	
	StartPoint = Instigator.Location + Instigator.EyePosition();
	
	if (Target != None)
		EndPoint = Target.Location;

	else 
		EndPoint = xWeaponAttachment(Instigator.Weapon.ThirdPersonActor).mHitLocation;
		
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
         LowFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
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
     Emitters(0)=BeamEmitter'BWBP_OP_Pro.ProtonStreamEffect.CoreBeam'

     Begin Object Class=BeamEmitter Name=Offshoot1
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         RotatingSheets=2
         LowFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         LowFrequencyPoints=6
         HighFrequencyNoiseRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         HighFrequencyPoints=6
         LinkupLifetime=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=251,G=124,R=87,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=251,G=124,R=87,A=255))
         FadeOutStartTime=0.047000
         FadeInEndTime=0.047000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         Texture=Texture'EpicParticles.Beams.BeamFalloff'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(1)=BeamEmitter'BWBP_OP_Pro.ProtonStreamEffect.Offshoot1'

     Begin Object Class=BeamEmitter Name=Offshoot2
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         RotatingSheets=2
         LowFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         LowFrequencyPoints=6
         HighFrequencyNoiseRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         HighFrequencyPoints=6
         LinkupLifetime=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=251,G=124,R=87,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=251,G=124,R=87,A=255))
         FadeOutStartTime=0.047000
         FadeInEndTime=0.047000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         Texture=Texture'EpicParticles.Beams.BeamFalloff'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(2)=BeamEmitter'BWBP_OP_Pro.ProtonStreamEffect.Offshoot2'

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
     Emitters(3)=SpriteEmitter'BWBP_OP_Pro.ProtonStreamEffect.Sparks'

     AutoDestroy=True
     bAlwaysRelevant=True
     bReplicateInstigator=True
     RemoteRole=ROLE_SimulatedProxy
	 
	 bNetNotify=True
}
