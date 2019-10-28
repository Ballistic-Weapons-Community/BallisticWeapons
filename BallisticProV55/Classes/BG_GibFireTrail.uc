//=============================================================================
// BG_GibFireTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_GibFireTrail extends BallisticEmitter;

simulated event Tick(float DT)
{
	super.Tick(DT);
	if (Owner == None)
	{
		Destroy();
		return;
	}
	Emitters[0].StartVelocityRange = default.Emitters[0].StartVelocityRange;
	Emitters[0].StartVelocityRange.X.Max += Owner.Velocity.X;
	Emitters[0].StartVelocityRange.X.Min += Owner.Velocity.X;
	Emitters[0].StartVelocityRange.Y.Max += Owner.Velocity.Y;
	Emitters[0].StartVelocityRange.Y.Min += Owner.Velocity.Y;
	Emitters[0].StartVelocityRange.Z.Max += Owner.Velocity.Z;
	Emitters[0].StartVelocityRange.Z.Min += Owner.Velocity.Z;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         BlendBetweenSubdivisions=True
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.400000,Max=0.500000))
         FadeOutStartTime=0.700000
         FadeInEndTime=0.230000
         MaxParticles=2
         StartLocationOffset=(Z=4.000000)
         StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_GibFireTrail.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000),Z=(Min=0.000000,Max=0.600000))
         FadeOutStartTime=0.120000
         FadeInEndTime=0.033000
         MaxParticles=60
         StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         Texture=Texture'EmitterTextures.MultiFrame.LargeFlames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
         StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BG_GibFireTrail.SpriteEmitter2'

     AutoDestroy=True
}
