//=============================================================================
// RSDarkImmolateBurner.
//
// Fire attached to darkstar plasma victims
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkImmolateBurner extends BallisticEmitter
	placeable;

var   Actor				Victim;
var   float				Power;
var   Controller		InstigatorController;

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
    SetBase(Victim);
    
    if (Role == ROLE_Authority && BallisticPawn(Victim) != None)
        BallisticPawn(Victim).HealBlock(Instigator, class'RSDarkHealBlockMessage');
}

function AddPower(float Amount)
{
	if (Power == -1)
		return;
	Power = FMin(Power+Amount, 10);
}

event Tick (float DT)
{
	if (Power == -1)
		return;

	Power -= DT;
	if (Victim == none || Power <= 0 || Victim.PhysicsVolume.bWaterVolume || (Pawn(Victim)!= None && Pawn(Victim).Health < 1))
	{
		Power=-1;
		if (level.netMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
			bTearOff=True;
		else Kill();
		return;
	}
}

    
simulated function Destroyed()
{
	if (Role == ROLE_Authority && BallisticPawn(Victim) != None)
        BallisticPawn(Victim).ReleaseHealBlock();

	Super.Destroyed();
}

event Timer()
{
	//local bool bWasAlive;

	if (bTearOff)
		Destroy();
		
	if (Power == -1)
		return;

	if (Victim != None && Role ==ROLE_Authority && Power > 0)
	{
		if ( Instigator == None || Instigator.Controller == None )
			Victim.SetDelayedDamageInstigatorController( InstigatorController );

		/*if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
		{
			if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
				bWasAlive = true;
		}
		else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
            bWasAlive = true;
        */

		class'BallisticDamageType'.static.GenericHurt (Victim, 10, Instigator, Location, vect(0,0,0), class'DT_RSDarkImmolate');

        /*
		if (bWasAlive && Pawn(Victim).Health <= 0)
			class'RSDarkSoul'.static.SpawnSoul(Victim.Location, Instigator, Pawn(Victim), self);
        */
    }
}

function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
	{
		if (level.netMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
			bTearOff=True;
			
		else Kill();
	}
}

defaultproperties
{
     Power=5.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=32,G=64,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.471429,Color=(B=192,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.330000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         StartLocationOffset=(Z=25.000000)
         StartLocationRange=(X=(Min=-8.000000,Max=8.000000),Y=(Min=-8.000000,Max=8.000000))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=11.000000,Max=11.000000)
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.900000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=50.000000,Max=50.000000))
         StartVelocityRadialRange=(Min=-10.000000,Max=-10.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSDarkImmolateBurner.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=128,R=160,A=255))
         ColorScale(1)=(RelativeTime=0.646429,Color=(A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(A=255))
         Opacity=0.450000
         FadeOutStartTime=1.120000
         FadeInEndTime=0.500000
         MaxParticles=30
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=64.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1f'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=75.000000,Max=150.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDarkImmolateBurner.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.340000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(Z=20.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=35.000000,Max=50.000000),Y=(Min=35.000000,Max=50.000000),Z=(Min=35.000000,Max=50.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDarkImmolateBurner.SpriteEmitter1'

     AutoDestroy=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     AmbientSound=Sound'BallisticSounds2.FP7.FP7FireLoop'
     bFullVolume=True
     SoundVolume=255
     SoundRadius=128.000000
     bNotOnDedServer=False
}
