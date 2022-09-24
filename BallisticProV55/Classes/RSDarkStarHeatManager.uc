//===========================================================================
// Manages appearance of heat.
//===========================================================================
class RSDarkStarHeatManager extends BallisticEmitter;

var int ConsecutiveHits;
var float NextHeatDecayTime;

replication
{
	reliable if (Role == ROLE_Authority)
		ConsecutiveHits;
}

function Reset()
{
	Destroy();
}

simulated event TornOff()
{
	Kill();
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	if (Level.NetMode == NM_DedicatedServer)
		Emitters[0].Disabled=True;
	NextHeatDecayTime = Level.TimeSeconds + 0.16;
}

function AddHeat()
{
	if (ConsecutiveHits == 4)
		return;
	++ConsecutiveHits;
	NextHeatDecayTime = Level.TimeSeconds + 0.16;
}

simulated function Tick(float DT)
{
	Super.Tick(DT);
	
	if (Level.NetMode == NM_Client)
	{
		Emitters[0].Opacity = (ConsecutiveHits/4.0f);
		SoundVolume=(ConsecutiveHits/4.0f) * 150;
		return;
	}
	
	if (Level.TimeSeconds > NextHeatDecayTime)
	{
			SetBase(None);
			bTearOff=True;
			if (Level.NetMode == NM_DedicatedServer)
				Destroy();
			else Kill();
			return;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=RSDarkHeatSmoke
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=140.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.630000
         FadeOutStartTime=1.530000
         FadeInEndTime=0.300000
         MaxParticles=40
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=2.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.700000,Max=0.700000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSDarkStarHeatManager.RSDarkHeatSmoke'

     RemoteRole=ROLE_SimulatedProxy
     //AmbientSound=Sound'GeneralAmbience.firefx9'
     SoundVolume=15
     SoundRadius=256.000000
}
