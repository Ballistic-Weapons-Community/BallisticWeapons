class CBU78Mine extends CBU78MineBase;

var xEmitter ProjBeam;
var float mineTraceRange;
var bool bMinePlanted;
var bool bUseRealisticGrenade;

simulated function Destroyed()
{
    if ( ProjBeam != None )
	ProjBeam.Destroy();

    Super.Destroyed();
}

simulated function PostBeginPlay()
{
	local PlayerController PC;
	local float InstigatorPitch;
	local vector OwnerVelocity;

	Super(Projectile).PostBeginPlay();

	    if ( Level.NetMode != NM_DedicatedServer)
	    {
			PC = Level.GetLocalPlayerController();
			if ( (PC.ViewTarget != None) && VSize(PC.ViewTarget.Location - Location) < 65000 )
			Trail = Spawn(class'GrenadeSmokeTrail', self,, Location, Rotation);
	    }

	    Velocity = Speed * Vector(Rotation);
	//    RandSpin(25000);
	    if (PhysicsVolume.bWaterVolume)
		Velocity = 0.6*Velocity;

	    if (Role == ROLE_Authority && Instigator != None)
		Team = Instigator.GetTeamNum();

	if ( Role==Role_Authority )
	{
	   if ( Instigator != None )
	       OwnerVelocity=Instigator.Velocity;

	   If ( Instigator.IsHumanControlled() && Instigator != None && PlayerController(Instigator.Controller) != None )
	   {
	       InstigatorPitch=Instigator.Controller.Rotation.Pitch;
	    
	       if ( InstigatorPitch > 49152 && InstigatorPitch < 65536 )
	          InstigatorPitch = 65536 - InstigatorPitch;

               else
	          InstigatorPitch=0;
	    
	       if ( bUseRealisticGrenade )
	       {
	            Velocity.X += OwnerVelocity.X * 0.5;
	            Velocity.Y += OwnerVelocity.Y * 0.5;
	            Velocity.Z +=  0.9 * (( Sin ( pi * InstigatorPitch/16384 + 3*pi/2) + 1) * 0.5 )  * OwnerVelocity.Z;
               }
	      
	   }
        
	}

    
}
/*
simulated function PostNetBeginPlay()
{
	if (Team == 1)
		Beacon = spawn(class'ONSGrenadeBeaconBlue', self);
	else
		Beacon = spawn(class'ONSGrenadeBeaconRed', self);

	if (Beacon != None)
		Beacon.SetBase(self);

	Super.PostNetBeginPlay();
}
*/


simulated function Landed( vector HitNormal )
{
  if ( bMinePlanted )
	Explode(Location,vector(rotation));//  HitWall( HitNormal, None );
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{
    if (!bMinePlanted && !bPendingDelete && Base == None && Other != IgnoreActor && (!Other.bWorldGeometry && Other.Class != Class && (Other != Instigator || bCanHitOwner)))
	Stick(Other, HitLocation);
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    local PlayerController PC;
    local Actor HitActor;
    local Vector BeamHitLocation,BeamHitNormal;
    local Vector EndTrace;

    if (Vehicle(Wall) != None && !bMinePlanted)
    {
        Touch(Wall);
        return;
    }

    else if ( !bMinePlanted )
    {
	PlaySound(Sound'MenuSounds.Select3',,2.5*TransientSoundVolume);
	bBounce = False;
	SetPhysics(PHYS_None);
	bCollideWorld = False;
	SetRotation(rotator(HitNormal));
    
	EndTrace = Location + vector(Rotation) * mineTraceRange;
	HitActor=Instigator.Trace(BeamHitLocation,BeamHitNormal,EndTrace,Location,false);
	//log ("HitActor "$HitActor);
	if ( HitActor != None )
	{
		if ( Level.NetMode != NM_DedicatedServer )
		{

		}
		bMinePlanted = true;
	}

    }
    //else
	//
    
    

    
    if ( Trail != None )
          Trail.mRegen = false; // stop the emitter from regenerating

    else
    {
		if ( (Level.NetMode != NM_DedicatedServer) && (Speed > 250) )
			PlaySound(ImpactSound, SLOT_Misc );
        if ( !Level.bDropDetail && (Level.DetailMode != DM_Low) && (Level.TimeSeconds - LastSparkTime > 0.5) && EffectIsRelevant(Location,false) )
        {
			PC = Level.GetLocalPlayerController();
			if ( (PC.ViewTarget != None) && VSize(PC.ViewTarget.Location - Location) < 15000 )
				Spawn(HitEffectClass,,, Location, Rotator(HitNormal));
            LastSparkTime = Level.TimeSeconds;
        }
    }
}

simulated function tick ( float DeltaTime)
{
    local Actor HitActor;
    local Vector BeamHitLocation,BeamHitNormal;
    local Vector EndTrace;


    if ( Role == Role_Authority )
	{
		if ( bMinePlanted )
		{
		    EndTrace = Location + vector(Rotation) * mineTraceRange;
		    HitActor=Trace(BeamHitLocation,BeamHitNormal,EndTrace,Location,true);
			
		    //log ("HitActor "$HitActor);
		    
		    if ( Pawn(HitActor) != None && ( Pawn(HitActor).GetTeamNum() != Team || Pawn(HitActor).GetTeamNum() == 255) )
		    {
			DamageRadius*=1.15;
			if ( Vehicle(HitActor) != None )
				Damage*=2;
			SetRotation(rotator(BeamHitLocation-Location));
			setPhysics(PHYS_Falling);
			velocity=vector(Rotation)*2*Speed;
			bCollideWorld = True;
			Explode(Location,Vector(Rotation));
			//bMinePlanted=false;
		    }
		    //if ( vSize(Pawn(HitActor).Location - StartLocation) / 2 )
		}

	}

	if ( Level.NetMode != NM_DedicatedServer && ProjBeam != None )
		ProjBeam.SetLocation(Location);
		
	super.tick(DeltaTime);
}

/*
simulated function TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	local Actor A;

	if (Damage > 1500)
	{
		if (Base != None && DamageType != MyDamageType)
		{
			if (EventInstigator == None || EventInstigator != Instigator)
			{
				UnStick();
				return;
			}
		}
		else if (IgnoreActor != None) //just got knocked off something I was stuck to, so don't explode
			foreach VisibleCollidingActors(IgnoreActor.Class, A, DamageRadius)
				return;

		Explode(Location, vect(0,0,1));
	}
}

simulated function Stick(actor HitActor, vector HitLocation)
{
    if ( Trail != None )
        Trail.mRegen = false; // stop the emitter from regenerating

    bBounce = False;
    LastTouched = HitActor;
    SetPhysics(PHYS_None);
    SetBase(HitActor);
    if (Base == None)
    {
    	UnStick();
    	return;
    }
    bCollideWorld = False;
    bProjTarget = true;

	PlaySound(Sound'MenuSounds.Select3',,2.5*TransientSoundVolume);
}

simulated function UnStick()
{
	Velocity = vect(0,0,0);
	IgnoreActor = Base;
	SetBase(None);
	SetPhysics(PHYS_Falling);
	bCollideWorld = true;
	bProjTarget = false;
	LastTouched = None;
}
*/

defaultproperties
{
     mineTraceRange=65000.000000
     Speed=2000.000000
     MaxSpeed=2000.000000
     Damage=225.000000
     DamageRadius=250.000000
     DrawScale=0.120000
}
