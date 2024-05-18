class FM13Grenade extends BallisticGrenade;

var bool bArmed;
var FM13FireControl	FireControl;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	SetTimer(0.20, False);
}

simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	if (!bHasImpacted)
		DetonateOn=DT_Impact;
		
	else Explode(Location, vect(0,0,1));
}

simulated function Explode(vector HitLocation, vector HitNormal)
{	
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	if (Role == ROLE_Authority)
		OilBlowUp(HitLocation, HitNormal);
	
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
	
	else Destroy();
}

function OilBlowUp(vector HitLocation, vector HitNormal)
{
    local int i, Count;
	local vector Start, End, HitLoc, HitNorm;
	local Rotator Direction;
	local Actor T;
	local FM13GasBurst GF;

	// Spawn all the pools to set up an area of destruction
	Start = Location+(HitNormal*16);
	Count = 0;
	for(i=0;i<50 && Count < 24;i++)
	{
		if(Count > 0)
		{
			End = VRand();
			if (End.Z < 0.25)
				End.Z = FMax(Abs(End.Z), 0.25);
			Direction = Rotator(End);
			End = Start + End * DamageRadius;
			T = Trace(HitLoc, HitNorm, End, Start,,);
			if (T==None) 
				HitLoc=End;

			GF = Spawn(class'FM13GasBurst',self,,HitLoc, Direction);
		}
		else
			GF = Spawn(class'FM13GasBurst',self,,Start, rot(16384,0,0));
		
		if (GF!=None)
		{
			Count++;
			GF.Instigator = Instigator;
			if ( Role == ROLE_Authority && Instigator != None && Instigator.Controller != None )
				GF.InstigatorController = Instigator.Controller;
				GF.FireControl = FireControl;
		}
	}
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;
	
	if (DetonateOn == DT_Impact)
	{
		Explode(Location, HitNormal);
		return;
	}
	else if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
	{
		SetTimer(DetonateDelay, false);
	}
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.2;
		DampenFactorParallel *= 0.2;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	
	Speed = VSize(Velocity/2);

	if (Speed < 20)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc, 1.5);
		if (ImpactManager != None)
			ImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Owner);
    	}
}

defaultproperties
{
	WeaponClass=class'FM13Shotgun'
     ModeIndex=1
	 DetonateOn=DT_Impact
     PlayerImpactType=PIT_Detonate
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=1.000000
     ImpactDamage=20
     ImpactDamageType=Class'BWBP_OP_Pro.DT_FM13Shotgun'
     ImpactManager=Class'BWBP_OP_Pro.IM_FM13Grenade'
     TrailClass=Class'BallisticProV55.M50GrenadeTrail'
     TrailOffset=(X=-8.000000)
     MyRadiusDamageType=Class'BWBP_OP_Pro.DT_FM13Shotgun'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Speed=3500.000000
     Damage=30.000000
     DamageRadius=64.000000
     MyDamageType=Class'BWBP_OP_Pro.DT_FM13Shotgun'
     ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade'
     bIgnoreTerminalVelocity=True
}
