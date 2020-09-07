//=============================================================================
// AS50's burner effect.
//=============================================================================
class PD97DartControl extends BallisticEmitter
	placeable;

var   	Pawn					Victim;
var   	float					Damage, BaseDuration;
var 	PD97Bloodhound			Master;
var   	Controller				InstigatorController;
var 	class<DamageType> 		DamageType;

var 	array<float>			DartDurations;

const 							EffectInterval = 1;
const 							MaxDarts = 6;

function Reset()
{
	Destroy();
}

simulated event TornOff()
{
	Kill();
}

simulated function Initialize(Pawn V, PD97Bloodhound Gun)
{
	if (V == None)
		return;

	Victim = V;
	if (Role == ROLE_Authority)
	{
		SetTimer(EffectInterval, true);
		Master = Gun;
	}


	if (Level.NetMode == NM_DedicatedServer || (V.PlayerReplicationInfo.Team.TeamIndex != 255 && V.PlayerReplicationInfo.Team.TeamIndex == Instigator.PlayerReplicationInfo.Team.TeamIndex))
		Emitters[0].Disabled=true;
	
	DartDurations[0] = BaseDuration;
	SetBase(Victim);
}

function AddDart()
{
	if (bTearOff || DartDurations.Length >= MaxDarts)
		return;
	DartDurations[DartDurations.Length] = BaseDuration;
}

event Timer()
{
	local int i;
	//Can only be called on client when torn off
	if (bTearOff)
	{
		Destroy();
		return;
	}
		
	if (Victim == None || Victim.Health < 1 || DartDurations.Length == 0)
	{
		if (level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
		{
			bTearOff=True;
			GoToState('NetWait');
		}
		else Kill();
	}

	else
	{
		if (Instigator != None)
		{
			if (InstigatorController != None && Victim.Controller != None && InstigatorController.SameTeamAs(Victim.Controller))
			{
				if(BallisticPawn(Victim) != None)
					BallisticPawn(Victim).GiveAttributedHealth(Damage * DartDurations.Length, Victim.HealthMax, Instigator);
				else Victim.GiveHealth(Damage,Victim.HealthMax);
			}
			else 
			{
				Victim.SetDelayedDamageInstigatorController( InstigatorController );
				class'BallisticDamageType'.static.GenericHurt (Victim, Damage * DartDurations.Length, Instigator, Location, vect(0,0,0), DamageType);
			}
		}
	
		for (i=0; i < DartDurations.Length; i++)
		{
			if(DartDurations[i] <= EffectInterval)
			{
				DartDurations.Remove(i, 1);
				i--;
			}
			else DartDurations[i] -= EffectInterval;
		}
	}
}

state NetWait
{
	function BeginState()
	{
		bHidden=True;
		bAlwaysRelevant=True;
		SetBase(None);
		SetTimer(1, false);
	}
	
	function Timer()
	{
		Destroy();
	}
}

simulated function Destroyed()
{
	if (Role == ROLE_Authority && Master != None)
		Master.LostControl(self);
	Super.Destroyed();
}

defaultproperties
{
     Damage=4.000000
     BaseDuration=8.000000
     DamageType=Class'BWBPOtherPackPro.DTPD97Poison'
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.250000,Max=0.250000),Z=(Min=0.25,Max=0.25))
         Opacity=0.350000
         FadeOutStartTime=0.750000
         MaxParticles=80
         StartLocationRange=(X=(Min=-4.000000,Max=4.000000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
         SpinCCWorCW=(X=0.490000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=-75.000000,Max=75.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=-75.000000,Max=75.000000))
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1g'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         StartVelocityRange=(X=(Min=-45.000000,Max=45.000000),Y=(Min=-45.000000,Max=45.000000),Z=(Min=-45.000000,Max=45.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.PD97DartControl.SpriteEmitter0'

     AutoDestroy=True
     bReplicateInstigator=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     AmbientSound=Sound'BallisticSounds2.FP7.FP7FireLoop'
     SoundRadius=128.000000
     bNotOnDedServer=False
}
