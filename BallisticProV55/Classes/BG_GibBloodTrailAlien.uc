//=============================================================================
// BG_GibBloodTrailAlien.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_GibBloodTrailAlien extends BallisticEmitter;

simulated event Tick(float DT)
{
	super.Tick(DT);
	if (Owner == None)
	{
		Destroy();
		return;
	}
	Emitters[0].StartVelocityRange = default.Emitters[0].StartVelocityRange;
	Emitters[0].StartVelocityRange.X.Max += Owner.Velocity.X*0.25;
	Emitters[0].StartVelocityRange.X.Min += Owner.Velocity.X*0.25;
	Emitters[0].StartVelocityRange.Y.Max += Owner.Velocity.Y*0.25;
	Emitters[0].StartVelocityRange.Y.Min += Owner.Velocity.Y*0.25;
	Emitters[0].StartVelocityRange.Z.Max += Owner.Velocity.Z*0.25;
	Emitters[0].StartVelocityRange.Z.Min += Owner.Velocity.Z*0.25;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.400000,Max=0.700000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.504000
         MaxParticles=40
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Particles.BloodDrip1'
         LifetimeRange=(Min=0.700000,Max=0.800000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_GibBloodTrailAlien.SpriteEmitter26'

     AutoDestroy=True
}
