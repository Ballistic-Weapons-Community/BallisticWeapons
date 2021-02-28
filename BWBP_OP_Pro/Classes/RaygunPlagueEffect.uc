//=============================================================================
// Visuals and damage for raygun plague.
//=============================================================================
class RaygunPlagueEffect extends BallisticEmitter
	placeable;

var   Actor							Victim;
var   float							Duration, MaxDuration, Damage;
var   Controller					InstigatorController;
var 	RaygunPlagueTrigger		PlagueTrigger;
var	class<DamageType>	DamageType;

function Reset()
{
	Destroy();
}

simulated event TornOff()
{
	Kill();
}

simulated function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	
	if (Role == ROLE_Authority)
		SetTimer(0.5, true);

	if (level.netMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
	}
	
	else if (xPawn(Victim) != None && xPawn(Victim).IsLocallyControlled())
	{
		Emitters[1].Disabled = true;
		Emitters[2].Disabled = true;
	}
	
	SetBase(Victim);
	
	//Spawn the associated trigger here and track it.
	PlagueTrigger = Spawn(class'RaygunPlagueTrigger',Victim,,Victim.Location);
	PlagueTrigger.Instigator = Instigator;
	PlagueTrigger.InstigatorController = InstigatorController;
	PlagueTrigger.PlagueEffect = self;
	if(BallisticPawn(Victim) != None)
		BallisticPawn(Victim).bPreventHealing = True;
}

function ExtendDuration(float Amount)
{
	if (bTearOff)
		return;
	Duration = FMin(Duration+Amount, MaxDuration);
}

event Tick (float DT)
{
	if (bTearOff)
		return;

	Duration -= DT;
	if (Victim == none || Duration <= 0)
	{
		if (level.netMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
			bTearOff=True;
		else Kill();
		return;
	}
}

event Timer()
{
	if (bTearOff)
		Destroy();
		
	if (Victim != None && Role ==ROLE_Authority && Duration > 0)
	{
		if ( Instigator == None || Instigator.Controller == None )
			Victim.SetDelayedDamageInstigatorController( InstigatorController );

		class'BallisticDamageType'.static.GenericHurt (Victim, Damage, Instigator, Location, vect(0,0,0), DamageType);
	}
}

simulated function Destroyed()
{
	if (BallisticPawn(Victim) != None)
		BallisticPawn(Victim).bPreventHealing = False;
	Super.Destroyed();
	
	PlagueTrigger.Destroy();
}


defaultproperties
{
	Duration=8.000000
	MaxDuration=16.000000
	Damage=5.000000
	DamageType=Class'BWBP_OP_Pro.DTRaygunPlague'
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseColorScale=True
        FadeOut=True
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=5,G=54,R=248,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=52,G=52,R=139,A=255))
        FadeOutStartTime=0.750000
        MaxParticles=60
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=1.000000,Max=5.000000)
        SpinsPerSecondRange=(X=(Max=1.000000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        ParticlesPerSecond=60.000000
        InitialParticlesPerSecond=500.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'BW_Core_WeaponTex.Particles.SmokeWisp-Alpha'
        TextureUSubdivisions=4
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRadialRange=(Min=20.000000,Max=250.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
     Emitters(0)=SpriteEmitter'BWBP_OP_Pro.RaygunPlagueEffect.SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        FadeIn=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(G=128,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.350000,Max=0.250000),Z=(Min=0.000000,Max=0.000000))
        Opacity=0.630000
        FadeOutStartTime=0.077500
        FadeInEndTime=0.027500
        MaxParticles=5
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=1.000000,Max=5.000000)
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
        InitialParticlesPerSecond=5.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'BW_Core_WeaponTex.Particles.NewSmoke1f'
        LifetimeRange=(Min=0.500000,Max=0.500000)
        StartVelocityRadialRange=(Min=20.000000,Max=250.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
     Emitters(1)=SpriteEmitter'BWBP_OP_Pro.RaygunPlagueEffect.SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=146,G=235,R=248,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=49,G=119,R=183,A=255))
        FadeOutStartTime=0.510000
        FadeInEndTime=0.090000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        InitialParticlesPerSecond=2.000000
        Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
        LifetimeRange=(Min=1.000000,Max=1.000000)
    End Object
     Emitters(2)=SpriteEmitter'BWBP_OP_Pro.RaygunPlagueEffect.SpriteEmitter2'

     AutoDestroy=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     AmbientSound=Sound'BW_Core_WeaponSound.RX22A.RX22A-PackBurn'
     bFullVolume=True
     SoundVolume=64
     SoundRadius=128.000000
     bNotOnDedServer=False
}
