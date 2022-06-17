//=============================================================================
// Supercharger_ActorFire.
//
// Fire attached to players. This is spawned on server to do damage and on
// client for effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_ActorFire extends BW_FuelPatch
	placeable;

var   Actor				Victim;			// The guy on fire
var() class<DamageType>	DamageType;		// DamageType done to player
var() int				Damage;			// Damage done every 0.5 seconds

var Controller	InstigatorController;
var   bool				DeadMode;		// Guy is dead and using karma ragdoll. Emitters don't like ragdolls, so use flat emitter shape
var   RX22AFireControl	GasControl;
var   Pawn				Ignitioneer;	// Pawn responsible for igniting the fire
var   actor				MyAmbientSoundActor;

replication
{
	reliable if (Role == ROLE_Authority)
		Victim;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (Role < Role_Authority && Victim != None)
		Initialize(Victim);
}

function PreBeginPlay()
{
	super.PreBeginPlay();
	Instigator = Pawn(Owner);
	if (Instigator!= None)
		InstigatorController = Instigator.Controller;
}

simulated event Destroyed()
{
	if (MyAmbientSoundActor != None)
		MyAmbientSoundActor.Destroy();
	if (GasControl != None)
		GasControl.PatchRemove(self);
	super.Destroyed();
}

simulated function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	SetTimer(0.5, true);

	// Attach emitters properly
	Emitters[0].SkeletalMeshActor = Victim;
	Emitters[1].SkeletalMeshActor = Victim;
	SetLocation(Victim.Location - vect(0, 0, 1)*Victim.CollisionHeight);
	SetRotation(Victim.Rotation + rot(0, -16384, 0));
	SetBase(Victim);

	if (level.netMode != NM_DedicatedServer)
	{
		MyAmbientSoundActor=Spawn(class'RX22ABurnerSound',,,location);
		MyAmbientSoundActor.SetBase(Victim);
	}
}

simulated function FuelOut()
{
	super.FuelOut();
	bDynamicLight=false;
}

simulated event Timer()
{
	if (Victim != None && Victim.PhysicsVolume.bWaterVolume)
		FuelOut();
	if (Level.NetMode != NM_Client && Fuel > 0)
	{
		if (Victim != None && !DeadMode)
			BurnRadius(4+(Fuel/30)*Damage, 80, DamageType, 0, Victim.Location);
		else
			BurnRadius(Damage, 80, DamageType, 0, Location);
	}
	super.Timer();
}

simulated function BurnRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation)
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local pawn InstigatedBy;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')))
		{
			if (Ignitioneer != None && Victims == Instigator)
				InstigatedBy = Ignitioneer;
			else
				InstigatedBy = Instigator;
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				InstigatedBy,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	bHurtEntry = false;
}

simulated event Tick(float DT)
{
	Super.Tick(DT);
	if (Victim == None || Victim.bDeleteMe)
	{
		Emitters[0].SkeletalMeshActor = None;
		Emitters[0].UseSkeletalLocationAs = PTSU_None;
		Emitters[1].SkeletalMeshActor = None;
		Emitters[1].UseSkeletalLocationAs = PTSU_None;
		if (Role == ROLE_Authority)
			Destroy();
		else
		{
			Emitters[0].Disabled = true;
			Emitters[1].Disabled = true;
			bHidden=true;
		}
		return;
	}
	if (bHidden)
	{
		Emitters[0].Disabled = false;
		Emitters[1].Disabled = false;
		bHidden=false;
	}
	if (Fuel < 1)
		return;
    if (Victim.Physics == PHYS_KarmaRagdoll)
    {
    	if (!DeadMode)
		{
			SetBase(None);
	    	DeadMode = true;
			Emitters[0].SkeletalMeshActor = None;
			Emitters[0].UseSkeletalLocationAs = PTSU_None;
			Emitters[1].SkeletalMeshActor = None;
			Emitters[1].UseSkeletalLocationAs = PTSU_None;

			Emitters[0].StartLocationRange.X.Min = -30;
			Emitters[0].StartLocationRange.X.Max = 30;
			Emitters[0].StartLocationRange.Y = Emitters[0].StartLocationRange.X;
			Emitters[0].StartLocationRange.Z.Max = 16;

			Emitters[1].StartLocationRange.X = Emitters[0].StartLocationRange.X;
			Emitters[1].StartLocationRange.Y = Emitters[1].StartLocationRange.X;

			Emitters[2].StartLocationRange.Z.Max = 10;
			Emitters[2].StartLocationOffset.Z = 0;

			Emitters[4].StartLocationOffset.Z = 16;
		}
    	SetLocation(Victim.GetBoneCoords('Spine').Origin);
    	SetRotation(Rot(0,1,0)*Victim.Rotation.Yaw);
    }
	if (xPawn(Victim) != None && xPawn(Victim).bDeRes)
	{
		Emitters[0].SkeletalMeshActor = None;
		Emitters[1].SkeletalMeshActor = None;
//		SetBase(Victim);
		SetBase(None);
		Fuel=0;
		Kill();
	}
}

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
		Kill();
}

defaultproperties
{
     DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
     Damage=5
     bCanIgnite=False
     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UniformSize=True
        BlendBetweenSubdivisions=True
        Acceleration=(Z=30.000000)
        ColorScale(0)=(Color=(B=255,G=64,A=255))
        ColorScale(1)=(RelativeTime=0.414286,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=0.504000
        FadeInEndTime=0.216000
        CoordinateSystem=PTCS_Relative
        MaxParticles=5
      
        StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Max=30.000000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=5.000000,Max=10.000000))
        UseSkeletalLocationAs=PTSU_Location
        SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
        RelativeBoneIndexRange=(Min=0.700000)
        Texture=Texture'XEffects.LightningChargeT'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.200000,Max=0.300000)
        StartVelocityRange=(X=(Max=0.500000),Y=(Min=-4.000000,Max=4.000000))
    End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_ActorFire.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UniformSize=True
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        Acceleration=(Z=40.000000)
        ColorScale(0)=(Color=(B=255,G=64,A=255))
        ColorScale(1)=(RelativeTime=0.425000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=0.504000
        FadeInEndTime=0.208000
        CoordinateSystem=PTCS_Relative
        MaxParticles=5
      
        StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
        UseSkeletalLocationAs=PTSU_Location
        SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
        RelativeBoneIndexRange=(Max=0.700000)
        Texture=Texture'XEffects.LightningChargeT'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.800000,Max=0.800000)
    End Object
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_ActorFire.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UniformSize=True
        Acceleration=(Z=80.000000)
        ColorScale(0)=(Color=(B=255,G=64,A=255))
        ColorScale(1)=(RelativeTime=0.400000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.000000),Y=(Min=0.800000,Max=0.800000))
        Opacity=0.200000
        FadeOutStartTime=0.504000
        FadeInEndTime=0.189000
        CoordinateSystem=PTCS_Relative
        MaxParticles=50
      
        StartLocationOffset=(Z=20.000000)
        StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=40.000000))
        SpinsPerSecondRange=(X=(Max=0.200000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=1.000000,Max=15.000000),Y=(Min=1.000000,Max=15.000000),Z=(Min=1.000000,Max=15.000000))
        Texture=Texture'XEffects.Skins.LsBBT'
        TextureUSubdivisions=1
        TextureVSubdivisions=1
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.700000,Max=0.700000)
        StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=40.000000))
    End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_ActorFire.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        FadeOut=True
        FadeIn=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        Acceleration=(X=-20.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
        Opacity=0.400000
        FadeOutStartTime=1.530000
        FadeInEndTime=0.300000
        MaxParticles=40
      
        StartLocationOffset=(Z=110.000000)
        SpinsPerSecondRange=(X=(Max=0.100000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.200000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'BallisticEffects.Particles.Smoke4'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=3.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=140.000000,Max=180.000000))
        VelocityLossRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.700000,Max=0.700000))
    End Object
     Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_ActorFire.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        FadeOut=True
        FadeIn=True
        UniformSize=True
        UseRandomSubdivision=True
        Acceleration=(Z=60.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
        Opacity=0.740000
        FadeOutStartTime=0.140000
        FadeInEndTime=0.140000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
      
        StartLocationOffset=(Z=50.000000)
        StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-20.000000,Max=20.000000))
        StartSizeRange=(X=(Min=80.000000,Max=110.000000),Y=(Min=80.000000,Max=110.000000),Z=(Min=80.000000,Max=110.000000))
        Texture=Texture'BallisticEffects.Particles.FlareA1'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.250000,Max=0.500000)
        StartVelocityRange=(Z=(Max=20.000000))
    End Object
     Emitters(4)=SpriteEmitter'BWBP_SKC_Pro.Supercharger_ActorFire.SpriteEmitter3'

     Begin Object Class=BeamEmitter Name=BeamEmitter3
        BeamDistanceRange=(Max=250.000000)
        DetermineEndPointBy=PTEP_Distance
        LowFrequencyNoiseRange=(Y=(Max=50.000000))
        HighFrequencyNoiseRange=(Y=(Max=5.000000))
        FadeOut=True
        Acceleration=(Z=2.670000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.360000
        MaxParticles=12
      
        StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
        InitialParticlesPerSecond=20.000000
        Texture=Texture'EpicParticles.Beams.HotBolt04aw'
        LifetimeRange=(Min=2.720000,Max=2.720000)
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
    End Object
     Emitters(5)=BeamEmitter'BWBP_SKC_Pro.Supercharger_ActorFire.BeamEmitter3'

     AutoDestroy=True
     LightType=LT_Flicker
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     bNoDelete=False
     bDynamicLight=True
     RemoteRole=ROLE_SimulatedProxy
     bHardAttach=True
}
