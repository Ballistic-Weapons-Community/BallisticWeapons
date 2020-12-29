//=============================================================================
// IE_KnifeConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_KnifeConcrete extends DGVEmitter
	placeable;

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[0].Disabled=true;
	Super.PreBeginPlay();
}

simulated event PostBeginPlay()
{
	local Rotator R;
	local int SliceAnim;

//	SetRotation(Rotation + Rot(0,0,1) * Owner.Rotation.Yaw * Abs(Vector(Rotation).Z));

	R = Rotation;
	R.Roll = -R.Yaw + Rotator(Owner.Location - Location).Yaw;
	if (Owner != None && Pawn(Owner) != None && Pawn(Owner).Weapon != None && Pawn(Owner).Weapon.GetFireMode(0) != None && X3PrimaryFire(Pawn(Owner).Weapon.GetFireMode(0)) != None)
	{
		SliceAnim = X3PrimaryFire(Pawn(Owner).Weapon.GetFireMode(0)).SliceAnim;
		if (SliceAnim == 0)
			R.Roll -= 24768;
//		else if (SliceAnim == 1)
//			R.Roll += 0;
		else if (SliceAnim == 2)
			R.Roll += 32768;
		else if (SliceAnim == 3)
			R.Roll -= 8192;
	}
	else
		R.Roll = Rand(65536);

	SetRotation (R);
	Super.PostBeginPlay();
}

defaultproperties
{
     bVerticalZ=False
     Begin Object Class=MeshEmitter Name=MeshEmitter8
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip2'
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         FadeOutFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeOutStartTime=0.800000
         FadeInEndTime=0.100000
         StartLocationRange=(Y=(Max=30.000000))
         SpinCCWorCW=(Z=1.000000)
         SpinsPerSecondRange=(X=(Max=3.000000),Y=(Max=3.000000),Z=(Max=3.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=0.100000,Max=0.500000),Y=(Min=0.100000,Max=0.500000),Z=(Min=0.100000,Max=0.500000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Regular
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=50.000000,Max=100.000000),Y=(Min=50.000000,Max=200.000000),Z=(Min=20.000000,Max=100.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.IE_KnifeConcrete.MeshEmitter8'

     Begin Object Class=SparkEmitter Name=SparkEmitter7
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBeforeVisibleRange=(Min=5.000000,Max=5.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.100000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         FadeOutFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeOutStartTime=0.300000
         StartLocationRange=(Y=(Max=100.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=50.000000,Max=200.000000),Y=(Max=500.000000),Z=(Max=50.000000))
     End Object
     Emitters(1)=SparkEmitter'BallisticProV55.IE_KnifeConcrete.SparkEmitter7'

     AutoDestroy=True
}
