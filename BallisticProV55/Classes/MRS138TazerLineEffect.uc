class MRS138TazerLineEffect extends BallisticEmitter;

var Pawn					Target;
var MRS138TazerPlayerEffect	Flash;

var int 					MaxRange;
var float 					EffectInterval;

simulated function SetTarget(Pawn Targ)
{
	if (Targ == None)
	{
		if (Flash != None)
		{
			Flash.StopSound();
			Flash.Kill();
		}
		SetTimer(0.0, false);
		Target = None;
		return;
	}

	Target = Targ;

	if (Instigator.Role == ROLE_Authority)
	{
		SetTimer(EffectInterval, True);

		class'BCSprintControl'.static.AddSlowTo(Target, 0.4, EffectInterval * 1.5);
	}
		
	// don't spawn this shit for the player who has been hit
	// it's blinding
	if (!Target.IsLocallyControlled() && Flash == None)
		Flash = spawn(class'MRS138TazerPlayerEffect',Targ);
}

function Timer()
{
	local vector HitLocation, HitNormal;
	if (Target == None || 
	Target.Health < 1 || 
	!Target.bProjTarget ||
	!FastTrace(Target.Location, Instigator.Location) || 
	BallisticShield(Trace(HitLocation, HitNormal, Target.Location, Instigator.Location, true)) != None || 
	VSize(Target.Location - Instigator.Location) > MaxRange || 
	BallisticWeapon(Instigator.Weapon) == None ||
	BallisticWeapon(Instigator.Weapon).IsDisplaced()	
	)
	{
		MRS138Attachment(Owner).PlayerTazeEnd();
		return;
	}
	
	class'BallisticDamageType'.static.GenericHurt (Target, 7, Instigator, Target.Location + (Normal(Target.Location - Instigator.Location))*-24, vect(0,0,0), class'DTMRS138TazerLine');
	
	class'BCSprintControl'.static.AddSlowTo(Target, 0.4, EffectInterval);
}

simulated function UpdateTargets()
{
	local vector Dir;
	if (Target == None)
		return;
	Dir = Normal(Target.Location - Location) * 300;
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(Target.Location-Location, Target.Location-Location);
	SetRotation(rot(0,0,0));
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Weight = 1;
	
	/*
	if (Level.NetMode == NM_Client)
		log("UpdateTargets: Target Loc:"@Target.Location@"MyLoc:"@Location@"Rotation:"@Rotation);
	*/

	if (Target.IsLocallyControlled())
		return;

	if (Flash == None)
		Flash = spawn(class'MRS138TazerPlayerEffect',Target);

	Dir = Normal(Location - Target.Location);

	Flash.SetLocation(Target.Location + Dir * Target.CollisionRadius);
	Flash.SetRotation(rotator(Dir));
}

simulated function Tick(float dt)
{
	UpdateTargets();
}

simulated function KillFlashes()
{
	if (Flash != None)
	{
		Flash.StopSound();
		Flash.Kill();
		Flash = None;
	}
}

simulated function Destroyed()
{
	if (Flash != None)
		Flash.Destroy();
	super.Destroyed();
}

defaultproperties
{
     MaxRange=2048
     EffectInterval=0.200000
     Begin Object Class=BeamEmitter Name=MRS138TazerLineEffectEmitter
         BeamDistanceRange=(Min=500.000000,Max=500.000000)
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=-1100.000000,Max=-1100.000000),Z=(Min=-25.000000,Max=25.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=6.000000
         LowFrequencyNoiseRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
         LowFrequencyPoints=5
         HighFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         BranchProbability=(Min=0.200000,Max=0.200000)
         BranchEmitter=1
         BranchSpawnAmountRange=(Min=1.000000,Max=1.000000)
         LinkupLifetime=True
         UseColorScale=True
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.214286,Color=(B=255,G=192,R=64,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=64,A=255))
         FadeOutStartTime=0.032000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=6.000000,Max=10.000000),Y=(Min=6.000000,Max=10.000000),Z=(Min=6.000000,Max=10.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.MRS138TazerLineEffect.MRS138TazerLineEffectEmitter'

     bNotOnDedServer=False
}
