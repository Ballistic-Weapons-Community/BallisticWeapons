//=============================================================================
// BG_BulletWoundSpurterAlien.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_BulletWoundSpurterAlien extends DGVEmitter;

var bool  bKillingTime;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	SetTimer(0.1, true);
}

simulated event Timer()
{
	if (bKillingTime)
	{
		Destroy();
		return;
	}
	super.Timer();
	Emitters[0].InitialParticlesPerSecond -= Rand(2);
	if (Emitters[0].InitialParticlesPerSecond < 12 || Pawn(Owner) == None || Pawn(Owner).Health < 1)
	{
		SetTimer(6.0, false);
		bKillingTime=true;
		Kill();
	}
}

defaultproperties
{
     bAutoAlignVelocity=True
     DisableDGV(1)=1
     DisableDGV(2)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseDirectionAs=PTDU_Up
         UseCollision=True
         UseMaxCollisions=True
         UseSpawnedVelocityScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-140.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         SpawnFromOtherEmitter=1
         SpawnAmount=1
         SpawnedVelocityScaleRange=(X=(Min=-0.100000,Max=-0.100000),Y=(Min=-0.100000,Max=-0.100000),Z=(Min=-0.100000,Max=-0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.400000,Max=0.700000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.250000
         MaxParticles=24
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
         InitialParticlesPerSecond=24.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Particles.BloodDrip1'
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=12.000000,Max=16.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=10.000000,Max=20.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_BulletWoundSpurterAlien.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseDirectionAs=PTDU_Forward
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=9.000000
         MaxParticles=12
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=0.900000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=4.000000,Max=5.000000),Y=(Min=4.000000,Max=5.000000),Z=(Min=4.000000,Max=5.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticBloodPro.Alien.Alien-Splat3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BG_BulletWoundSpurterAlien.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         FadeOut=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.120000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=7.000000,Max=7.000000),Y=(Min=7.000000,Max=7.000000),Z=(Min=7.000000,Max=7.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticBloodPro.Decals.Splat4'
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.BG_BulletWoundSpurterAlien.SpriteEmitter10'

     AutoDestroy=True
     bHardAttach=True
}
