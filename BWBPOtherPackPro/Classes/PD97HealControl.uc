//=============================================================================
// AS50's burner effect.
//=============================================================================
class PD97HealControl extends PD97DartControl
	placeable;

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
	
	DartDurations[0] = BaseDuration;
	SetBase(Victim);
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
			bTearOff=True;
		else Kill();
	}

	else
	{
		if (Instigator != None)
		{
			if (Victim.bProjTarget && InstigatorController != None && Victim.Controller != None)
			{
				if(BallisticPawn(Victim) != None)
					BallisticPawn(Victim).GiveAttributedHealth(Damage * DartDurations.Length, Victim.HealthMax, Instigator);
				else Victim.GiveHealth(Damage,100);
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

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=150,R=150,A=200))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=255,G=150,R=150,A=200))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=58,R=58,A=64))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Z=(Min=0.900000,Max=0.900000))
         Opacity=0.250000
         FadeOutStartTime=0.050000
         MaxParticles=12
         StartLocationRange=(X=(Min=-4.000000,Max=4.000000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
         SpinCCWorCW=(X=0.490000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=-75.000000,Max=75.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=-75.000000,Max=75.000000))
         ParticlesPerSecond=4.000000
         InitialParticlesPerSecond=20.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1g'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.500000,Max=0.750000)
         StartVelocityRange=(X=(Min=-45.000000,Max=45.000000),Y=(Min=-45.000000,Max=45.000000),Z=(Min=-45.000000,Max=45.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.PD97HealControl.SpriteEmitter1'

}
