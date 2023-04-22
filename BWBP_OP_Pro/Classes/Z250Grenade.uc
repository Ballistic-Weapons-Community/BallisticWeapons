class Z250Grenade extends BallisticGrenade;

var Z250FireControl	FireControl;

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
	local Z250GasBurst GF;

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

			GF = Spawn(class'Z250GasBurst',self,,HitLoc, Direction);
		}
		else
			GF = Spawn(class'Z250GasBurst',self,,Start, rot(16384,0,0));
		
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

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.Z250Minigun'
	ModeIndex=1
	ArmingDelay=0.2
	UnarmedDetonateOn=DT_ImpactTimed
	UnarmedPlayerImpactType=PIT_Bounce
	ArmedDetonateOn=DT_Impact
	ArmedPlayerImpactType=PIT_Detonate
	bNoInitialSpin=True
	bAlignToVelocity=True
	DetonateDelay=1.000000
	ImpactDamage=20
	ImpactDamageType=Class'BWBP_OP_Pro.DTZ250Grenade'
	ImpactManager=Class'BWBP_OP_Pro.IM_Z250Grenade'
	TrailClass=Class'BallisticProV55.M50GrenadeTrail'
	TrailOffset=(X=-8.000000)
	MyRadiusDamageType=Class'BWBP_OP_Pro.DTZ250GrenadeRadius'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=512.000000
	MotionBlurRadius=384.000000
	MotionBlurFactor=3.000000
	MotionBlurTime=4.000000
	Speed=4000.000000
	Damage=30.000000
	DamageRadius=64.000000
	MyDamageType=Class'BWBP_OP_Pro.DTZ250GrenadeRadius'
	ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade'
	bIgnoreTerminalVelocity=True
}
