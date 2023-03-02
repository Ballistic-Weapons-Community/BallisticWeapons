//=============================================================================
// The emitter for the Leopard tank's Long smoke dispensers.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================

class LongLeopardSmoke extends Emitter
	placeable;

simulated function SetTeamColor(byte Team)
{
	local color BlueColor, RedColor;

	RedColor.R=112;
	RedColor.G=64;
	RedColor.B=64;
	RedColor.A=255;

	BlueColor.R=64;
	BlueColor.G=64;
	BlueColor.B=112;
	BlueColor.A=255;

	if (Team == 1)
	{
		Emitters[0].ColorScale[0].Color = BlueColor;
		Emitters[0].ColorScale[1].Color = BlueColor;

		Emitters[1].ColorScale[0].Color = BlueColor;
		Emitters[1].ColorScale[1].Color = BlueColor;
	}

	if (Team == 0)
	{
		Emitters[0].ColorScale[0].Color = RedColor;
		Emitters[0].ColorScale[1].Color = RedColor;

		Emitters[1].ColorScale[0].Color = RedColor;
		Emitters[1].ColorScale[1].Color = RedColor;
	}
}

simulated function ActivateSmoke(bool bActive)
{
	if(!bActive)
	{
		Emitters[0].ParticlesPerSecond = 0.0;
		Emitters[0].InitialParticlesPerSecond = 0.0;

		Emitters[1].ParticlesPerSecond = 0.0;
		Emitters[1].InitialParticlesPerSecond = 0.0;
	}
	else
	{
		Emitters[0].AllParticlesDead = false;
		Emitters[0].ParticlesPerSecond = 1.0;
		Emitters[0].InitialParticlesPerSecond = 1.0;

		Emitters[1].AllParticlesDead = false;
		Emitters[1].ParticlesPerSecond = 5.0;
		Emitters[1].InitialParticlesPerSecond = 5.0;
	}
	if(Level.DetailMode == DM_Low)
	{
		Emitters[0].Disabled = false;
		Emitters[1].SpinParticles = false;
	}
	else if(Level.DetailMode == DM_High)
	{
		Emitters[0].Disabled = false;
		Emitters[1].SpinParticles = true;
	}
	else if(Level.DetailMode == DM_SuperHigh)
	{
		Emitters[0].Disabled = false;
		Emitters[1].SpinParticles = true;
	}
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_Vehicles_Static.Effects.Volumetric1'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=1.000000,Max=2.000000))
         StartSpinRange=(Y=(Min=0.200000,Max=0.200000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         DrawStyle=PTDS_Brighten
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=MeshEmitter'BWBP_VPC_Pro.LongLeopardSmoke.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.900000),Z=(Min=0.900000))
         Opacity=0.500000
         FadeOutStartTime=5.000000
         MaxParticles=100
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EpicParticles.Smoke.Smokepuff'
         LifetimeRange=(Min=8.000000,Max=8.000000)
         StartVelocityRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=60.000000,Max=80.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_VPC_Pro.LongLeopardSmoke.SpriteEmitter0'

     bNoDelete=False
     bHardAttach=True
}
