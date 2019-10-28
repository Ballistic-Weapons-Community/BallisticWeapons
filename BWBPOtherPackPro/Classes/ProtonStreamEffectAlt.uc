class ProtonStreamEffectAlt extends ProtonStreamEffect;

simulated function SetAltColor(bool bColorAlt)
{
	bAltColor = bColorAlt;
	if(bAltColor)
	{
		BeamEmitter(Emitters[2]).ColorScale[0].Color.B	= 255;
		BeamEmitter(Emitters[2]).ColorScale[0].Color.G	= 64;
		BeamEmitter(Emitters[2]).ColorScale[0].Color.R	= 0;
		BeamEmitter(Emitters[1]).ColorScale[0].Color.B	= 255;
		BeamEmitter(Emitters[1]).ColorScale[0].Color.G	= 64;
		BeamEmitter(Emitters[1]).ColorScale[0].Color.R	= 0;	
		BeamEmitter(Emitters[0]).ColorScale[0].Color.B	= 255;
		BeamEmitter(Emitters[0]).ColorScale[0].Color.G	= 64;
		BeamEmitter(Emitters[0]).ColorScale[0].Color.R	= 0;		

		BeamEmitter(Emitters[2]).ColorScale[1].Color.B	= 255;
		BeamEmitter(Emitters[2]).ColorScale[1].Color.G	= 64;
		BeamEmitter(Emitters[2]).ColorScale[1].Color.R	= 0;
		BeamEmitter(Emitters[1]).ColorScale[1].Color.B	= 255;
		BeamEmitter(Emitters[1]).ColorScale[1].Color.G	= 64;
		BeamEmitter(Emitters[1]).ColorScale[1].Color.R	= 0;	
		BeamEmitter(Emitters[0]).ColorScale[1].Color.B	= 255;
		BeamEmitter(Emitters[0]).ColorScale[1].Color.G	= 64;
		BeamEmitter(Emitters[0]).ColorScale[1].Color.R	= 0;			
	}
}

simulated function UpdateEndpoint()
{
	SetRotation(rot(0,0,0));
	
	if (Instigator.IsLocallyControlled())
	{
		if (!Instigator.IsFirstPerson())
		{
			bHidden = False;
			SetLocation(ProtonAttachment.GetTipLocation());
		}
	}
	else
	{
		if (ProtonAttachment != None)
			SetLocation(ProtonAttachment.GetBoneCoords('tip').Origin);
		else SetLocation(StartPoint);
	}
	
	if (Target != None)
	{
		BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(Target.Location - Location, Target.Location - Location);
	}
	
	else
	{
		if (ProtonAttachment != None)
			BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset = VtoRV(ProtonAttachment.mHitLocation - Location, ProtonAttachment.mHitLocation - Location);
		else BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset = VtoRV(EndPoint - Location, EndPoint - Location);
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
		else EndPoint = ProtonAttachment.mHitLocation;
	}
	
	if (Instigator.IsLocallyControlled() && Instigator.IsFirstPerson())
		return;
	UpdateEndpoint();
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=CoreBeam
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         RotatingSheets=3
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
         ColorScale(0)=(Color=(B=64,G=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=128,A=255))
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         UseRotationFrom=PTRS_Normal
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         Texture=Texture'BWBPOtherPackTex2.ProtonPack.StreamCoreAlt'
         LifetimeRange=(Min=0.050000,Max=0.050000)
     End Object
     Emitters(0)=BeamEmitter'BWBPOtherPackPro.ProtonStreamEffectAlt.CoreBeam'

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
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.ProtonStreamEffectAlt.Sparks'

     Emitters(2)=None

     Emitters(3)=None

}
