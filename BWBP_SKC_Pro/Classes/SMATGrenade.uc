//=============================================================================
// SMATGrenade.
//
// Suicidal grenade that explodes immediately!!
//
// by SK
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SMATGrenade extends BallisticGrenade;

var   Rotator					VelocityDir;
var bool bDestroyMe; //used to delay destruction until the clients replicate the proj

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	VelocityDir = Rotation;
	if (StartDelay > 0 && Role == ROLE_Authority || bAlwaysRelevant)
	{
		SetPhysics(PHYS_None);
		SetCollision (false, false, false);
		bHidden=true;
		SetTimer(StartDelay, false);
		return;
	}
	InitProjectile();

}

simulated function InitProjectile ()
{
    Velocity = Speed * Vector(VelocityDir);
    if (RandomSpin != 0 && !bNoInitialSpin)
        RandSpin(RandomSpin);
    if (DetonateOn == DT_Timer)
        SetTimer(DetonateDelay, false);
    Super.InitProjectile();
}
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Actor A;
	local Vector HitLoc, HitNorm, End;
	
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
	
	End.Z = -DamageRadius;
	
	A = Trace(HitLoc, HitNorm, End, , False);

    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if (bTearOnExplode && !bNetTemporary && Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
	{
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GotoState('NetTrapped');
	}
	else 
	{
		bDestroyMe=true;
		SetTimer(1, false);
	}
}

simulated event Timer()
{
	if (bDestroyMe)
	{
		Destroy();
		return;
	}
	Explode(Location, vect(0,0,1));
}

defaultproperties
{
	WeaponClass=Class'BWBP_SKC_Pro.SMATLauncher'
	bApplyParams=False
	bNoInitialSpin=True
	bAlignToVelocity=True
	bArmed=True
	ArmedDetonateOn=DT_Timer
	UnarmedDetonateOn=DT_Timer
	PlayerImpactType = PIT_Detonate
	ArmedPlayerImpactType = PIT_Detonate
	DetonateDelay=0.000001
	ImpactDamage=120
	ImpactManager=Class'BallisticProV55.IM_RPG'
	TrailClass=Class'BallisticProV55.M50GrenadeTrail'
	TrailOffset=(X=-8.000000)
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTSMATSuicide'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=2048.000000
	MotionBlurRadius=1768.000000
	MotionBlurFactor=3.000000
	MotionBlurTime=4.000000
	ShakeRotMag=(X=512.000000,Y=400.000000)
	ShakeRotRate=(X=3000.000000,Z=3000.000000)
	ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
	Speed=0.010000
	MaxSpeed=10000.000000
	Damage=1512.000000
	DamageRadius=768.000000
	MomentumTransfer=180000.000000
	MyDamageType=Class'BWBP_SKC_Pro.DTSMATSuicide'
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=200.000000
	LightRadius=15.000000
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5Rocket'
	bDynamicLight=True
	AmbientSound=Sound'BW_Core_WeaponSound.G5.G5-RocketFly'
	DrawScale=0.500000
	SoundVolume=192
	SoundRadius=128.000000
	RotationRate=(Roll=32768)
}
