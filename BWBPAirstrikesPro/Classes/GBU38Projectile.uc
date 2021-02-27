//=============================================================================
// rocket.
//=============================================================================
// Tick() takes care of bomb adjustment
class GBU38Projectile extends AirstrikeProjectile;

var	NewTracer SmokeTrail;
var	ONSPowerNodeNeutral PowerNode;

// camera shakes //
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view
var() vector speedconst;
var() bool alreadyexploded;
var class<Emitter> ExplosionEffectClass;
var() vector target;
var byte Team;
var() vector Velocity1;
var() float impacttime,speed2;
var() vector startpos;

simulated function Destroyed()
{
	if ( SmokeTrail != None )
		SmokeTrail.Destroy();
		PowerNode.PowerCoreDestroyed();
	Super.Destroyed();
}

function BeginPlay()
{
	startpos = location;
	Super.BeginPlay();

	if (Instigator != None)
		Team = Instigator.GetTeamNum();
	SetTimer(0.5, true);
}

simulated function PostBeginPlay()
{
	local vector Dir;
	
	velocity1 = velocity;
	if ( bDeleteMe || IsInState('Dying') )
		return;
	SetPhysics(PHYS_Falling);
	Dir = vector(Rotation);
	//Velocity = speed * Dir;

	if ( Level.NetMode != NM_DedicatedServer)
	{
		SmokeTrail = Spawn(class'NewTracer',self,,Location - 40 * Dir, Rotation);
		SmokeTrail.SetBase(self);
	}

	Super.PostBeginPlay();
}

event bool EncroachingOn( actor Other )
{
	if ( Other.bWorldGeometry )
		return true;

	return false;
}

simulated event Tick( float DT )
{
	local float tempspeed,tangtargetdir,tangveldir,rotmult;
	local vector tvector,vvector,Trot,tempvel,tloc;
	SetRotation(Rotator(Velocity));
	SetPhysics(PHYS_Falling);
	vvector=velocity;
	vvector=vvector/vsize(vvector);
	tangveldir=((vvector.x*vvector.x+vvector.y*vvector.y)/(vvector.z*vvector.z + 1));
	log("tangveldir");
	log(string(tangveldir));
	impacttime=impacttime-dt;
	log("impacttime");
	log(string(impacttime));
	tvector=(target-location);
	tvector=tvector/vsize(tvector);
	speed2=velocity.x*velocity.x+velocity.y*velocity.y;
	tangtargetdir=((tvector.x*tvector.x+tvector.y*tvector.y)/(tvector.Z*tvector.z));
	Log("tangtargetdir");
	Log(string(tangtargetdir));
	//lets adjust bomb if it seem to go beyond target, you can change 0.031 for earlier adjustment (its the square of tangent actually)
	if ((tangtargetdir < 0.22) && (tangtargetdir < tangveldir))
	{
		tloc=location;
		Log("conditions met");
		tempvel=Velocity;
		Trot=tvector-vvector;
		tangveldir=sqrt(tangveldir);
		//tangtargetdir=sqrt(tangtargetdir);
		log("Trot");
		log(string(Trot));
		//lets modify the bomb direction/velocity, depending on some factors, here 
		// you change the constant for the speed of adjustment
		rotmult=40/(sqrt( ( ( (target.x-tloc.x)*(target.x-tloc.x)+(target.y-tloc.y)*(target.y-tloc.y) ) + abs(impacttime))/(speed2) )+1);
		log("rotmult");
		log(string(rotmult));
		Velocity=Velocity+Trot*rotmult;
		Log("velocity");
		tempvel=velocity;
		log(string(sqrt(tempvel.x*tempvel.x+tempvel.y*tempvel.y)));
	}
	super.Tick(DT);
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
	if ( Other != instigator && alreadyexploded == false )
	{
		Log(string(velocity));
		alreadyexploded=true;
		Explode(HitLocation,Vect(0,0,1));
	}
}

simulated function PhysicsVolumeChange( PhysicsVolume Volume )
{
}

simulated function Landed( vector HitNormal )
{
	if (alreadyexploded == false)
	{
		Log(string(velocity));
		alreadyexploded=true;
		Explode(Location + ExploWallOut * HitNormal, HitNormal);
	}
}

simulated function HitWall(vector HitNormal, actor Wall)
{
	if (alreadyexploded == false)
	{
		Log(string(velocity));
		alreadyexploded=true;
		Explode(Location + ExploWallOut * HitNormal, HitNormal);
	}
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType)
{
	if ( (Damage > 150000) && ((InstigatedBy == None) || (InstigatedBy.Controller == None) || (Instigator == None) || (Instigator.Controller == None) || !InstigatedBy.Controller.SameTeamAs(Instigator.Controller)) )
	{
		if ( (InstigatedBy == None) || DamageType.Default.bVehicleHit || (DamageType == class'Crushed') )
			BlowUp(Location);
		else
		{
	 		Spawn(class'SmallRedeemerExplosion');
		    SetCollision(false,false,false);
		    HurtRadius(Damage, DamageRadius*0.125, MyDamageType, MomentumTransfer, Location);
		    Destroy();
		}
	}
}

simulated event FellOutOfWorld(eKillZType KillType)
{
	BlowUp(Location);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Emitter E;
	//local Actor li;
	//local Vector Hit;
	//local Vector Norm;

	//li=Trace(Hit,Norm,Location + Velocity,Location,,);
	//TerrainInfo(li).PokeTerrain(Location,350,150);
    E = Spawn(ExplosionEffectClass,,, HitLocation - 100 * Normal(Velocity), Rot(0,16384,0));
	Spawn(class'GBU38Dirt',,,HitLocation + HitNormal*16, rotator(HitNormal) + rot(-16384,0,0));
		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));


	MakeNoise(1.0);
	SetPhysics(PHYS_None);
	bHidden = true;
    GotoState('Dying');
}

function Timer()
{
	local Controller C;
	local vector targetdir;
	local float velh,velv;
	//Enemies who don't have anything else to shoot at will try to shoot WiCNuke down
	for (C = Level.ControllerList; C != None; C = C.NextController)
		if ( AIController(C) != None && C.Pawn != None && C.GetTeamNum() != Team && AIController(C).Skill >= 2.0
		     && !C.Pawn.IsFiring() && (C.Enemy == None || !C.LineOfSightTo(C.Enemy)) && C.Pawn.CanAttack(self) )
		{
			C.Focus = self;
			C.FireWeaponAt(self);
		}
	
}

simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if ( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Hurtwall != Victims) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo') )
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			if ( Victims == LastTouched )
				LastTouched = None;
			Victims.TakeDamage
			(
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
			if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);

		}
	}
	if ( (LastTouched != None) && (LastTouched != self) && (LastTouched.Role == ROLE_Authority) && !LastTouched.IsA('FluidSurfaceInfo') )
	{
		Victims = LastTouched;
		LastTouched = None;
		dir = Victims.Location - HitLocation;
		dist = FMax(1,VSize(dir));
		dir = dir/dist;
		damageScale = FMax(Victims.CollisionRadius/(Victims.CollisionRadius + Victims.CollisionHeight),1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius));
		if ( Instigator == None || Instigator.Controller == None )
			Victims.SetDelayedDamageInstigatorController(InstigatorController);
		Victims.TakeDamage
		(
			damageScale * DamageAmount,
			Instigator,
			Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
			(damageScale * Momentum * dir),
			DamageType
		);
		if (Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
			Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, InstigatorController, DamageType, Momentum, HitLocation);
	}

	bHurtEntry = false;
}

simulated function DmgRadius(vector flash, float dmgPctHard, float dmgPctThru, float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry || Role != ROLE_Authority)
		return;

	if(instigator==none)
	{
	    if(pawn(owner)!=none)
            instigator=pawn(owner);
	    else if(instigator.controller!=none && instigator.controller.pawn!=none)
	        instigator=instigator.controller.pawn;
	    else if(controller(owner)!=none && controller(owner).pawn!=none)
	        instigator=controller(owner).pawn;
	}

    bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( victims!=none && (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) )
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);

            if(!fasttrace(Victims.Location, hitlocation)) damagescale*=dmgPctThru;

            if(pawn(victims)!=none) damagescale=damagescale;
            else damagescale*=dmgPctHard;

            if(damage>0)
            {
                Victims.TakeDamage
			    (
				    damageScale * DamageAmount,
				    Instigator,
				    Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				    (damageScale * Momentum * dir),
				    DamageType
			    );

			    if(pawn(victims)!=none && pawn(victims).controller!=none && playercontroller(pawn(victims).controller)!=none && flash!=vect(0,0,0))
                    playercontroller(pawn(victims).controller).clientflash(0.1, flash*damagescale);
		    }
		}
	}
	bHurtEntry = false;
}

state Dying
{
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType) {}
	function Timer() {}

    function BeginState()
    {
		bHidden = true;
		SetPhysics(PHYS_None);
		SetCollision(false,false,false);
		Spawn(class'IonCore',,, Location, Rotation);
		ShakeView();
		InitialState = 'Dying';
		if ( SmokeTrail != None )
			SmokeTrail.Kill();
		SetTimer(0, false);
    }

    function ShakeView()
    {
        local Controller C;
        local PlayerController PC;
        local float Dist, Scale;

        for ( C=Level.ControllerList; C!=None; C=C.NextController )
        {
            PC = PlayerController(C);
            if ( PC != None && PC.ViewTarget != None )
            {
                Dist = VSize(Location - PC.ViewTarget.Location);
                if ( Dist < DamageRadius * 2.0)
                {
                    if (Dist < DamageRadius)
                        Scale = 1.0;
                    else
                        Scale = (DamageRadius*2.0 - Dist) / (DamageRadius);
                    C.ShakeView(ShakeRotMag*Scale, ShakeRotRate, ShakeRotTime, ShakeOffsetMag*Scale, ShakeOffsetRate, ShakeOffsetTime);
                }
            }
        }
    }

Begin:
    PlaySound(sound'WeaponSounds.Redeemer_explosionsound');
    HurtRadius(Damage, DamageRadius*0.125, MyDamageType, MomentumTransfer, Location);
    Sleep(0.1);
    HurtRadius(Damage, DamageRadius*0.300, MyDamageType, MomentumTransfer, Location);
    Sleep(0.1);
    HurtRadius(Damage, DamageRadius*0.475, MyDamageType, MomentumTransfer, Location);
    Sleep(0.1);
    HurtRadius(Damage, DamageRadius*0.650, MyDamageType, MomentumTransfer, Location);
    Sleep(0.1);
    HurtRadius(Damage, DamageRadius*0.825, MyDamageType, MomentumTransfer, Location);
    Sleep(0.1);
    HurtRadius(Damage, DamageRadius*1.000, MyDamageType, MomentumTransfer, Location);
    Destroy();
}

defaultproperties
{
     ShakeRotMag=(Z=250.000000)
     ShakeRotRate=(Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Z=10.000000)
     ShakeOffsetRate=(Z=200.000000)
     ShakeOffsetTime=10.000000
     ExplosionEffectClass=Class'BWBPAirstrikesPro.GBU38Explosion'
     Team=255
     MaxSpeed=0.000000
     Damage=200.000000
     DamageRadius=2048.000000
     MomentumTransfer=1.000000
     MyDamageType=Class'BWBPAirstrikesPro.DamTypeGBU38'
     ExplosionDecal=Class'BWBPAirstrikesPro.GBU38BlastMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightBrightness=255.000000
     LightRadius=6.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.RedeemerMissile'
     bDynamicLight=True
     bNetTemporary=False
     AmbientSound=Sound'WeaponSounds.Misc.redeemer_flight'
     LifeSpan=80.000000
     AmbientGlow=96
     bUnlit=False
     SoundVolume=255
     SoundRadius=100.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=5000.000000
     CollisionRadius=24.000000
     CollisionHeight=12.000000
     bProjTarget=True
     bFixedRotationDir=True
     RotationRate=(Roll=500000)
     DesiredRotation=(Roll=300000)
}
