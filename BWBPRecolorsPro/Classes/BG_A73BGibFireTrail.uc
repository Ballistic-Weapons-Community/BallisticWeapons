//=============================================================================
// BG_A73GibFireTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_A73BGibFireTrail extends BallisticEmitter;

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
     Begin Object Class=SpriteEmitter Name=SpriteEmitter29
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         BlendBetweenSubdivisions=True
         Acceleration=(Z=12.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.385714,Color=(B=255,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=6.500000,Max=0.700000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.488000
         FadeInEndTime=0.112000
         MaxParticles=2
         StartLocationOffset=(Z=4.000000)
         StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.BG_A73BGibFireTrail.SpriteEmitter29'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter33
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.142857,Color=(B=255,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.285714,Color=(B=255,G=64,R=64,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.153000
         FadeInEndTime=0.027000
         MaxParticles=60
         StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.200000,Max=0.300000)
         StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.BG_A73BGibFireTrail.SpriteEmitter33'

     AutoDestroy=True
}
