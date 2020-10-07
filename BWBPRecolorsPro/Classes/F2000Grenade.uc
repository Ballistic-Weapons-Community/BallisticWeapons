//=============================================================================
// Cryo grenade.
//=============================================================================
class F2000Grenade extends BallisticGrenade;

var array<Actor> PokedControls;

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
	BlowUp(HitLocation);
    	if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	Destroy();
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
		if (ReflectImpactManager != None)
		{
			if (Instigator == None)
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Instigator);			
		}
    }
}

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	local float BoneDist;

	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Other == HitActor)
		return;
	if (Base != None)
		return;


	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );
	if (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact)
	{
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
		HitActor = Other;
		if (Pawn(Other) != None)
			ApplySlowdown(Pawn(Other), Damage/8);
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		return;
	}
	if ( PlayerImpactType == PIT_Bounce || (PlayerImpactType == PIT_Stick && (VSize (Velocity) < MinStickVelocity)) )
	{
		HitWall (Normal(HitLocation - Other.Location), Other);
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
	}
	else if ( PlayerImpactType == PIT_Stick && Base == None )
	{
		SetPhysics(PHYS_None);
		if (DetonateOn == DT_ImpactTimed)
			SetTimer(DetonateDelay, false);
		HitActor = Other;
		if (Other != Instigator && Other.DrawType == DT_Mesh)
			Other.AttachToBone( Self, Other.GetClosestBone( Location, Velocity, BoneDist) );
		else
			SetBase (Other);
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
		SetRotation (Rotator(Velocity));
		Velocity = vect(0,0,0);
	}
}

// Special HurtRadius function. This will hurt everyone except the chosen Excluded.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Excluded )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local int i;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		//Put out fires.
		//We do this by notifying the FireControl for every fire we hit.
		//The FireControl will then use the info internally to remove the fires, and replicate
		//a function to the client so that the client may also remove the fires.
		if (FP7GroundFire(Victims) != None)
		{
			for (i=0; i < PokedControls.Length && FP7GroundFire(Victims).FireControl != PokedControls[i]; i++);
			
			if (i == PokedControls.Length)
			{
				PokedControls[PokedControls.Length] = FP7GroundFire(Victims).FireControl;
				FP7GroundFire(Victims).FireControl.NotifyPutOut(HitLocation, DamageRadius);
			}
		}
		/* RX22A shit */
		
		
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		else if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Excluded && Victims != HurtWall)
		{
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
			if (Pawn(Victims) != None)
				ApplySlowdown(Pawn(Victims), Damage/8);
		 }
		 
	}
	bHurtEntry = false;
}

function ApplySlowdown(pawn Other, float Damage)
{
	local Inv_Slowdown Slow;
	
	Slow = Inv_Slowdown(Other.FindInventoryType(class'Inv_Slowdown'));
	
	if (Slow == None)
	{
		Other.CreateInventory("BallisticProV55.Inv_Slowdown");
		Slow = Inv_Slowdown(Other.FindInventoryType(class'Inv_Slowdown'));
	}
	
	Slow.AddSlow(0.7, Damage);
}

defaultproperties
{
     DetonateOn=DT_ImpactTimed
     PlayerImpactType=PIT_Detonate
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=1.000000
     ImpactDamage=75
     ImpactDamageType=Class'BWBPRecolorsPro.DTCryoGrenade'
     ImpactManager=Class'BWBPRecolorsPro.IM_CryoGrenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BWBPRecolorsPro.ChaffTrail'
     TrailOffset=(X=1.600000,Z=6.400000)
     MyRadiusDamageType=Class'BWBPRecolorsPro.DTCryoGrenade'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=256.000000
     MotionBlurRadius=768.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=10.000000
     ShakeRotMag=(X=512.000000,Y=400.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
     Speed=3500.000000
     Damage=75.000000
     DamageRadius=300.000000
     MomentumTransfer=1000.000000
     MyDamageType=Class'BWBPRecolorsPro.DTCryoGrenade'
     ImpactSound=SoundGroup'BallisticSounds2.NRP57.NRP57-Concrete'
     StaticMesh=StaticMesh'BallisticHardware2.M900.M900Grenade'
     bUnlit=False
     bIgnoreTerminalVelocity=True
}
