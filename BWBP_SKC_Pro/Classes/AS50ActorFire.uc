//=============================================================================
// AS50's burner effect.
//=============================================================================
class AS50ActorFire extends BallisticEmitter
	placeable;

var   Actor				Victim;
var   float				Fuel, MaxFuel, Damage;
var   Controller		InstigatorController;
var class<DamageType> DamageType;

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
		SetTimer(0.75, true);

	if (level.netMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
		Emitters[3].Disabled=true;
		Emitters[4].Disabled=true;
	}
	SetBase(Victim);
}

function AddFuel(float Amount)
{
	if (Fuel == -1)
		return;
	Fuel = FMin(Fuel+Amount, MaxFuel);
}

event Tick (float DT)
{
	if (Fuel == -1)
		return;

	Fuel -= DT;
	if (Victim == none || Fuel <= 0 || Victim.PhysicsVolume.bWaterVolume || (Pawn(Victim)!= None && Pawn(Victim).Health < 1))
	{
		Fuel=-1;
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
		
	if (Fuel == -1)
		return;

	if (Victim != None && Role ==ROLE_Authority && Fuel > 0)
	{
		if ( Instigator == None || Instigator.Controller == None )
			Victim.SetDelayedDamageInstigatorController( InstigatorController );

		class'BallisticDamageType'.static.GenericHurt (Victim, Damage, Instigator, Location, vect(0,0,0), DamageType);
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
     Fuel=3.000000
     MaxFuel=5.000000
     Damage=7.000000
     DamageType=Class'BWBP_SKC_Pro.DT_AS50Immolation'
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
         MaxParticles=30
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Max=30.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         UseSkeletalLocationAs=PTSU_Location
         SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
         RelativeBoneIndexRange=(Min=0.700000)
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         BlendBetweenSubdivisions=True
         Acceleration=(Z=40.000000)
         ColorScale(0)=(Color=(B=255,G=64,A=255))
         ColorScale(1)=(RelativeTime=0.428571,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.504000
         FadeInEndTime=0.208000
         CoordinateSystem=PTCS_Relative
         MaxParticles=40
         StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         UseSkeletalLocationAs=PTSU_Location
         SkeletalScale=(X=0.380000,Y=0.380000,Z=0.380000)
         RelativeBoneIndexRange=(Max=0.700000)
         Texture=Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=80.000000)
         ColorScale(0)=(Color=(B=255,G=64,A=255))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.504000
         FadeInEndTime=0.189000
         CoordinateSystem=PTCS_Relative
         MaxParticles=50
         StartLocationOffset=(Z=20.000000)
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=40.000000))
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=1.000000,Max=15.000000),Y=(Min=1.000000,Max=15.000000),Z=(Min=1.000000,Max=15.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=40.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter1'

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
         Opacity=0.630000
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
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=140.000000,Max=180.000000))
         VelocityLossRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.700000,Max=0.700000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter6'

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
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.500000)
         StartVelocityRange=(Z=(Max=20.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter3'

     AutoDestroy=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     AmbientSound=Sound'BW_Core_WeaponSound.FP7.FP7FireLoop'
     bFullVolume=True
     SoundVolume=255
     SoundRadius=128.000000
     bNotOnDedServer=False
}
