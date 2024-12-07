//=============================================================================
// FLASHActorBurner.
//
// Fire attached to players. This is spawned on server to do damage and on
// client for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FLASHActorBurner extends BallisticEmitter
	placeable;

var   Actor				Victim;			// The guy on fire
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;			// Damage done every 0.5 seconds
var() float				BurnTime;		// How to burn for
var Controller	InstigatorController;

function Reset()
{
	Destroy();
}

simulated function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(0.5, true);

	if (level.netMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
	}
	else
	{
		// Attach emitters properly
		Emitters[0].SkeletalMeshActor = Victim;
		Emitters[1].SkeletalMeshActor = Victim;
		Emitters[2].SkeletalMeshActor = Victim;
	}
	SetLocation(Victim.Location - vect(0, 0, 1)*Victim.CollisionHeight);
	SetRotation(Victim.Rotation + rot(0, -16384, 0));
	SetBase(Victim);
}

simulated event Timer()
{
	if (BurnTime == -1)
		return;
	BurnTime-=0.5;
	if (BurnTime <= 2 || Victim.PhysicsVolume.bWaterVolume)
	{
		BurnTime=-1;
		Kill();
		bDynamicLight=false;
	}
	if (Victim != None && Level.NetMode != NM_Client && BurnTime > 1)
	{
		if ( Instigator == None || Instigator.Controller == None )
			Victim.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt (Victim, Damage, Instigator, Location, vect(0,0,0), DamageType);
//		Victim.TakeDamage(Damage, Instigator, Location, vect(0,0,0), DamageType);
	}
}

simulated event Tick(float DT)
{
	Super.Tick(DT);
	if (Victim == None || Victim.bDeleteMe)
		Destroy();
	if (level.netMode == NM_DedicatedServer && BurnTime <= 1)
		Destroy();
	if (BurnTime == -1)
		return;
	else if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		Emitters[0].SkeletalMeshActor = None;
		Emitters[1].SkeletalMeshActor = None;
		Emitters[2].SkeletalMeshActor = None;
		SetBase(None);
		Kill();
		BurnTime=-1;
	}
}

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
	{
		if (level.netMode == NM_DedicatedServer)
			Destroy();
		else
			Kill();
	}
}

defaultproperties
{
    DamageType=Class'BWBP_SKC_Pro.DT_M202Immolation'
    Damage=15
    BurnTime=6.000000
    
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        UniformSize=True
        ColorScale(0)=(Color=(B=255,G=255,R=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=192))
        FadeOutStartTime=0.500000
        FadeInEndTime=0.400000
        MaxParticles=10
        CoordinateSystem=PTCS_Relative
        Name="SpriteEmitter0"
        StartSizeRange=(X=(Min=10.000000,Max=20.000000))
        UseSkeletalLocationAs=PTSU_Location
        SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
        Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.600000,Max=2.000000)
    End Object
    Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.FLASHActorBurner.SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.580000
        FadeOutStartTime=1.000000
        FadeInEndTime=0.920000
        MaxParticles=50
        Name="SpriteEmitter1"
        DetailMode=DM_SuperHigh
        StartLocationOffset=(Z=80.000000)
        StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=20.000000,Max=20.000000))
        SpinsPerSecondRange=(X=(Max=0.300000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=8.000000,Max=20.000000))
        UseSkeletalLocationAs=PTSU_SpawnOffset
        SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
        DrawStyle=PTDS_Darken
        Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
        SecondsBeforeInactive=0.000000
        StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=140.000000,Max=160.000000))
        VelocityLossRange=(Z=(Min=0.500000,Max=0.500000))
    End Object
    Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.FLASHActorBurner.SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.800000,Max=0.900000),Z=(Min=0.500000,Max=0.600000))
        FadeOutStartTime=0.530000
        FadeInEndTime=0.280000
        CoordinateSystem=PTCS_Relative
        MaxParticles=30
        Name="SpriteEmitter2"
        StartLocationOffset=(Y=8.000000)
        StartLocationRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=20.000000,Max=70.000000))
        StartSpinRange=(X=(Min=0.450000,Max=0.550000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
        SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
        Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
        TextureUSubdivisions=4
        TextureVSubdivisions=2
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=80.000000))
        VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
    End Object
    Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.FLASHActorBurner.SpriteEmitter2'

    AutoDestroy=True
    LightType=LT_SubtlePulse
    LightEffect=LE_QuadraticNonIncidence
    LightHue=25
    LightSaturation=100
    LightBrightness=200.000000
    LightRadius=15.000000
    bDynamicLight=True
    AmbientSound=Sound'BW_Core_WeaponSound.FP7.FP7FireLoop'
    bFullVolume=True
    bHardAttach=True
    SoundVolume=255
    SoundRadius=128.000000
    bNotOnDedServer=False
}
