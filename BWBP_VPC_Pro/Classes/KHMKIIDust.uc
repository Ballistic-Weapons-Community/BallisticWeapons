//=============================================================================
// The KHMKII Cobra's blade dust that is spawned on the ground.
// It spawns the particles constantly, and relative to the location of the Chopper,
// but that is set and ajusted by the functions under the vehicle's class.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================

class KHMKIIDust extends Emitter
	placeable;

var(Dust)		byte		GrassVariance, DirtVariance;
var(Dust)		int			MaxParticleSpawnRate;
var(Dust)		sound		GroundSound, WaterSound;
var				byte		DustType;

simulated function SetDustColor(color DustColor, bool bOverWater)
{
	if(DustColor.R == 0 && DustColor.G == 0 && DustColor.B == 0)
	{
		DustColor.R=192;
		DustColor.G=160;// If the 'Dust Color' is black it will be changed to this.
		DustColor.B=96;
	}
	DustColor.A = 255;

// Depending on the color of a map's "Dust Color" certain emmitters are turned off, and other's on.

// Grass, this statement is used to create a Grass emitter when the map's "Dust Color" is Green looking.
    if((Level.DustColor.R & Level.DustColor.B) < (Level.DustColor.G -GrassVariance) && !bOverWater)
		 DustType = 1;
// Dirt, this statement is used to create a Dirt emitter when the map's "Dust Color" is Brown looking.
    else if(Level.DustColor.B <= (Level.DustColor.R & Level.DustColor.G -DirtVariance) && !bOverWater)
		 DustType = 2;
// Rock, this statement is used to create a Rock emitter when the map's "Dust Color" is dark Grey to Black.
    else if((Level.DustColor.R & Level.DustColor.G & Level.DustColor.B) <= 48 && !bOverWater)
		 DustType = 0;
// Water, If the Chopper is over water then it will deactivate all the emitters.
    else if(bOverWater)
		 DustType = 4;
// Snow, this statement is used to create a Snow emitter when the map's "Dust Color" is not equal to any of the above.
    else
		 DustType = 3;

	Emitters[0].ColorScale[0].Color = DustColor;
	Emitters[0].ColorScale[1].Color = DustColor;
	Emitters[0].ColorScale[2].Color = DustColor;
	Emitters[0].ColorScale[3].Color = DustColor;

	Emitters[5].ColorScale[0].Color = DustColor;
	Emitters[5].ColorScale[1].Color = DustColor;

	Emitters[6].ColorScale[0].Color = DustColor;
	Emitters[6].ColorScale[1].Color = DustColor;
	Emitters[6].ColorScale[2].Color = DustColor;
	Emitters[6].ColorScale[3].Color = DustColor;
}

// This function is used to spawn the right dust emitters for the KHMKII on a constant basis.
simulated function UpdateBladeDust(bool bActive, float HoverHeight)
{
	local float Force;
	local byte i;

	Force = 1 - HoverHeight;

	if(bActive && DustType == 4)
	{
		if(Level.DetailMode == DM_SuperHigh)
		{
			AmbientSound = WaterSound;
			SoundVolume = Force * 255 / 1.5;
			SoundPitch = 32;
		}
		else if(Level.DetailMode == DM_High)
		{
			AmbientSound = WaterSound;
			SoundVolume = Force * 255 / 4.5;
			SoundPitch = 32;
		}
		else if(Level.DetailMode == DM_Low)
		{
			AmbientSound = None;
			SoundVolume = Force * 255 / 4.5;
			SoundPitch = 32;
		}

		Emitters[0].StartSizeRange.X.Min = Force * 60.0;
		Emitters[0].StartSizeRange.X.Max = Force * 60.0;
		Emitters[0].StartSizeRange.Y.Min = Force * 60.0;
		Emitters[0].StartSizeRange.Y.Max = Force * 60.0;
		Emitters[0].StartSizeRange.Z.Min = Force * 60.0;
		Emitters[0].StartSizeRange.Z.Max = Force * 60.0;
	}
	else if(bActive && DustType < 4)
	{
		if(Level.DetailMode == DM_SuperHigh)
		{
			AmbientSound = GroundSound;
			SoundVolume = Force * 255 / 1.5;
			SoundPitch = 64;
		}
		else if(Level.DetailMode == DM_High)
		{
			AmbientSound = GroundSound;
			SoundVolume = Force * 255 / 1.5;
			SoundPitch = 64;
		}
		else if(Level.DetailMode == DM_Low)
		{
			AmbientSound = None;
			SoundVolume = Force * 255 / 2.5;
			SoundPitch = 64;
		}

		Emitters[0].StartSizeRange.X.Min = Force * 40.0;
		Emitters[0].StartSizeRange.X.Max = Force * 40.0;
		Emitters[0].StartSizeRange.Y.Min = Force * 40.0;
		Emitters[0].StartSizeRange.Y.Max = Force * 40.0;
		Emitters[0].StartSizeRange.Z.Min = Force * 40.0;
		Emitters[0].StartSizeRange.Z.Max = Force * 40.0;
	}
	else if (!bActive)
	{
		AmbientSound = None;
		SoundVolume = Force * 255;
		SoundPitch = 64;
	}
	if(!bActive)
	{
		for(i=0;i<7;i++)
		{
			Emitters[i].ParticlesPerSecond = 0;
			Emitters[i].InitialParticlesPerSecond = 0;
		}
	}
	else
	{
		for(i=0;i<5;i++)
		{
			Emitters[i].ParticlesPerSecond = MaxParticleSpawnRate * Force;
			Emitters[i].InitialParticlesPerSecond = MaxParticleSpawnRate * Force;
			Emitters[i].AllParticlesDead = false;
		}
        Emitters[5].ParticlesPerSecond = 20.0;
        Emitters[5].InitialParticlesPerSecond = 20.0;
		Emitters[5].AllParticlesDead = false;

       	Emitters[0].Opacity = 0.35 * Force;
		for(i=1;i<6;i++)
        	Emitters[i].Opacity = Force;
       	Emitters[6].Opacity = Force;

        Emitters[6].ParticlesPerSecond = MaxParticleSpawnRate * Force;
        Emitters[6].InitialParticlesPerSecond = MaxParticleSpawnRate * Force;
		Emitters[6].AllParticlesDead = false;
	}
	if(Level.DetailMode == DM_Low)
	{
		Emitters[0].Disabled = true;
		Emitters[0].SpinParticles = false;
		Emitters[1].Disabled = true;
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
		Emitters[5].Disabled = true;
		Emitters[6].Disabled = true;
	}
	else if(Level.DetailMode == DM_High)
	{
		Emitters[0].Disabled = false;
		Emitters[0].SpinParticles = true;
		Emitters[1].Disabled = true;
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
		Emitters[5].Disabled = true;
		Emitters[6].Disabled = true;
	}
	else if(Level.DetailMode == DM_SuperHigh)
	{
		if(DustType == 0)
		{
			Emitters[1].Disabled = false;
			Emitters[2].Disabled = true;
			Emitters[3].Disabled = true;
			Emitters[4].Disabled = true;
			Emitters[5].Disabled = true;
			Emitters[6].Disabled = true;
		}

		else if(DustType == 1)
		{
			Emitters[1].Disabled = true;
			Emitters[2].Disabled = false;
			Emitters[3].Disabled = true;
			Emitters[4].Disabled = true;
			Emitters[5].Disabled = true;
			Emitters[6].Disabled = true;
		}

		else if(DustType == 2)
		{
			Emitters[1].Disabled = true;
			Emitters[2].Disabled = true;
			Emitters[3].Disabled = false;
			Emitters[4].Disabled = true;
			Emitters[5].Disabled = true;
			Emitters[6].Disabled = true;
		}

		else if(DustType == 3)
		{
			Emitters[1].Disabled = true;
			Emitters[2].Disabled = true;
			Emitters[3].Disabled = true;
			Emitters[4].Disabled = false;
			Emitters[5].Disabled = true;
			Emitters[6].Disabled = true;
		}

		else if(DustType == 4)
		{
			Emitters[1].Disabled = true;
			Emitters[2].Disabled = true;
			Emitters[3].Disabled = true;
			Emitters[4].Disabled = true;
			Emitters[5].Disabled = false;
			Emitters[6].Disabled = false;
		}
		Emitters[0].Disabled = false;
		Emitters[0].SpinParticles = true;
	}
}

defaultproperties
{
     GrassVariance=48
     DirtVariance=24
     MaxParticleSpawnRate=30
     GroundSound=Sound'BWBP_Vehicles_Sound.Cobra.BladeWind'
     WaterSound=Sound'BWBP_Vehicles_Sound.Cobra.BladeSplash'
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=96,G=128,R=164))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=96,G=128,R=164,A=255))
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=64,G=100,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=68,G=104,R=125))
         Opacity=0.350000
         FadeOutStartTime=3.000000
         FadeInEndTime=0.300000
         MaxParticles=200
         StartLocationRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000))
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.300000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.750000,RelativeSize=10.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(Z=(Min=-30.000000))
         StartVelocityRadialRange=(Min=-750.000000,Max=-750.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIDust.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=96,G=128,R=164,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=96,G=128,R=164,A=255))
         Opacity=0.750000
         FadeOutStartTime=3.000000
         FadeInEndTime=0.300000
         MaxParticles=200
         StartLocationRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000))
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.300000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(Z=(Min=-30.000000))
         StartVelocityRadialRange=(Min=-750.000000,Max=-750.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(1)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIDust.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=96,G=128,R=164))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=96,G=128,R=164,A=255))
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=64,G=100,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=68,G=104,R=125))
         Opacity=0.750000
         FadeOutStartTime=3.000000
         FadeInEndTime=0.300000
         MaxParticles=200
         StartLocationRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000))
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.300000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTropical01.Texture.PalmLeafFX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(Z=(Min=-30.000000))
         StartVelocityRadialRange=(Min=-750.000000,Max=-750.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIDust.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=96,G=128,R=164))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=96,G=128,R=164,A=255))
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=64,G=100,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=68,G=104,R=125))
         Opacity=0.750000
         FadeOutStartTime=3.000000
         FadeInEndTime=0.300000
         MaxParticles=200
         StartLocationRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000))
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.300000))
         StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Explosions.Dirt.DirtClumps'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         StartVelocityRange=(Z=(Min=-30.000000))
         StartVelocityRadialRange=(Min=-750.000000,Max=-750.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(3)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIDust.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=96,G=128,R=164))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=96,G=128,R=164,A=255))
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=64,G=100,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=68,G=104,R=125))
         Opacity=0.750000
         FadeOutStartTime=3.000000
         FadeInEndTime=0.300000
         MaxParticles=200
         StartLocationRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000))
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.300000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'BenTex01.textures.SnowPuff'
         StartVelocityRange=(Z=(Min=-30.000000))
         StartVelocityRadialRange=(Min=-750.000000,Max=-750.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(4)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIDust.SpriteEmitter4'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_Vehicles_Static.Effects.SplashMesh'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=128,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=128,R=128,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=1.500000
         FadeInEndTime=0.500000
         StartLocationRange=(Z=(Min=-64.000000))
         RotationOffset=(Pitch=16201)
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Min=0.750000,Max=0.750000))
         RotationNormal=(Z=32768.000000)
         SizeScale(0)=(RelativeSize=70.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=70.000000)
         StartSizeRange=(X=(Min=0.100000,Max=0.250000),Y=(Min=0.800000),Z=(Min=0.800000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_Brighten
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(5)=MeshEmitter'BWBP_VPC_Pro.KHMKIIDust.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=64,G=64,R=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=64,G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=64,G=64,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=64,G=64,R=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=1.500000
         FadeInEndTime=0.300000
         MaxParticles=100
         StartLocationRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000))
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.300000))
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'EmitterTextures.SingleFrame.WaterDrop'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=-30.000000))
         StartVelocityRadialRange=(Min=-750.000000,Max=-750.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(6)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIDust.SpriteEmitter5'

     CullDistance=12000.000000
     bNoDelete=False
     bFullVolume=True
     bHardAttach=True
     SoundVolume=255
     SoundRadius=200.000000
}
