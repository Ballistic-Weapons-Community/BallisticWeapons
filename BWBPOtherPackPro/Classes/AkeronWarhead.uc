//===========================================================================
// Akeron Warhead
// 
// Repurposed Redeemer code.
//===========================================================================
class AkeronWarhead extends Pawn;

var float Damage, DamageRadius, MomentumTransfer;
var class<DamageType> MyDamageType;
var Pawn OldPawn;
var	BallisticEmitter SmokeTrail;
var float YawAccel, PitchAccel;
var float OutwardDamageRadius;

//var Texture ScopeViewTex;

// banking related
var Shader InnerScopeShader, OuterScopeShader, OuterEdgeShader;
var FinalBlend AltitudeFinalBlend;
var float YawToBankingRatio, BankingResetRate, BankingToScopeRotationRatio;
var int Banking, BankingVelocity, MaxBanking, BankingDamping;

var float VelocityToAltitudePanRate, MaxAltitudePanRate;

var float Fuel;

// camera shakes //
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view

var 	Rotator	InitialControllerRotation;

var bool bStaticScreen;
var bool	bFireForce;

var() class<BCImpactManager>ImpactManager;			// Impact manager to spawn on final hit
var Vector TearOffHitNormal;
var bool bExploded;
var Actor HitActor;

var AkeronLauncher Master;

var float FiredAt, ArmThreshold;

var TeamInfo MyTeam;

replication
{
	reliable if (bNetOwner && Role == ROLE_Authority)
		bStaticScreen, InitialControllerRotation;
    reliable if ( Role < ROLE_Authority )
		ServerBlowUp;
}

function PlayerChangedTeam()
{
	Died( None, class'DamageType', Location );
	OldPawn.Died(None, class'DamageType', OldPawn.Location);
}

function TeamInfo GetTeam()
{
	if ( PlayerReplicationInfo != None )
		return PlayerReplicationInfo.Team;
	return MyTeam;
}

simulated function Destroyed()
{
	if ( SmokeTrail != None )
		SmokeTrail.Kill();
	Super.Destroyed();
}

simulated function bool IsPlayerPawn()
{
	return false;
}

event bool EncroachingOn( actor Other )
{
	if (Level.TimeSeconds - FiredAt > ArmThreshold)
	{
		if ( Other.bWorldGeometry )
			return true;
	}

	return false;
}

event EncroachedBy( actor Other )
{
	if (Level.TimeSeconds - FiredAt > ArmThreshold)
	{
		if (Pawn(Other) != None)
			class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
		HitActor = Other;
		BlowUp(Location);
	}
}

function RelinquishController()
{

}

simulated function PostBeginPlay()
{
	local vector Dir;

	Dir = Vector(Rotation);
	InitialControllerRotation = Rotation; //Save this so we can reset the view of the player.
    Velocity = AirSpeed * Dir;
    Acceleration = Velocity;
	
	FiredAt = Level.TimeSeconds;

	if ( Level.NetMode != NM_DedicatedServer)
	{
		SmokeTrail = Spawn(class'G5RocketTrail',self,,Location - 40 * Dir);
		SmokeTrail.SetBase(self);
	}
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if ( PlayerController(Controller) != None )
	{
		Controller.SetRotation(Rotation);
		PlayerController(Controller).SetViewTarget(self);
		Controller.GotoState(LandMovementState);
		PlayOwnedSound(Sound'BallisticSounds3.G5.G5-Fire1',SLOT_Interact,1.0);
	}
}

simulated function FaceRotation( rotator NewRotation, float DeltaTime )
{
}

function UpdateRocketAcceleration(float DeltaTime, float YawChange, float PitchChange)
{
    local vector X,Y,Z;
	local float PitchThreshold;
	local int Pitch;
    local rotator TempRotation;

	YawAccel = (1-2*DeltaTime)*YawAccel + DeltaTime*YawChange;
	PitchAccel = (1-2*DeltaTime)*PitchAccel + DeltaTime*PitchChange;
	SetRotation(rotator(Velocity));

	GetAxes(Rotation,X,Y,Z);
	PitchThreshold = 3000;
	Pitch = Rotation.Pitch & 65535;
	if ( (Pitch > 16384 - PitchThreshold) && (Pitch < 49152 + PitchThreshold) )
	{
		if ( Pitch > 49152 - PitchThreshold )
			PitchAccel = Max(PitchAccel,0);
		else if ( Pitch < 16384 + PitchThreshold )
			PitchAccel = Min(PitchAccel,0);
	}
	Acceleration = Velocity + 5*(YawAccel*Y + PitchAccel*Z);
	if ( Acceleration == vect(0,0,0) )
		Acceleration = Velocity;

	Acceleration = Normal(Acceleration) * AccelRate;

    BankingVelocity += DeltaTime * (YawToBankingRatio * YawChange - BankingResetRate * Banking - BankingDamping * BankingVelocity);
    Banking += DeltaTime * (BankingVelocity);
    Banking = Clamp(Banking, -MaxBanking, MaxBanking);
	TempRotation = Rotation;
	TempRotation.Roll = Banking;
	SetRotation(TempRotation);
	
	/*
    ScopeTexRotator = TexRotator(OuterScopeShader.Diffuse);
    if (ScopeTexRotator != None)
        ScopeTexRotator.Rotation.Yaw = Rotation.Roll;
    AltitudeTexPanner = VariableTexPanner(Shader(AltitudeFinalBlend.Material).Diffuse);
    if (AltitudeTexPanner != None)
        AltitudeTexPanner.PanRate = FClamp(Velocity.Z * VelocityToAltitudePanRate, -MaxAltitudePanRate, MaxAltitudePanRate);
	*/
}

simulated function PhysicsVolumeChange( PhysicsVolume Volume )
{
}

simulated function Landed( vector HitNormal )
{
	if (Level.TimeSeconds - FiredAt > ArmThreshold)
		BlowUp(Location);
}

simulated function HitWall(vector HitNormal, actor Wall)
{
	if (Level.TimeSeconds - FiredAt > ArmThreshold)
		BlowUp(Location);
}

simulated singular function Touch(Actor Other)
{
	if ( Other.bBlockActors && Level.TimeSeconds - FiredAt > ArmThreshold )
	{
		if (Pawn(Other) != None)
			class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
		HitActor = Other;
		BlowUp(Location);
	}
}

simulated singular function Bump(Actor Other)
{
	if (Other.bBlockActors && Level.TimeSeconds - FiredAt > ArmThreshold)
		BlowUp(Location);
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType)
{
	if ( (Damage > 0) && ((InstigatedBy == None) || (InstigatedBy.Controller == None) || (Instigator == None) || (Instigator.Controller == None) || !InstigatedBy.Controller.SameTeamAs(Instigator.Controller)) )
	{
		if ( (InstigatedBy == None) || DamageType.Default.bVehicleHit || (DamageType == class'Crushed') )
			BlowUp(Location);
		else
		{
			Health -= Damage;

			if (Health > 0)
				return;
			if ( PlayerController(Controller) != None )
				PlayerController(Controller).PlayRewardAnnouncement('Denied',1, true);
			if ( PlayerController(InstigatedBy.Controller) != None )
				PlayerController(InstigatedBy.Controller).PlayRewardAnnouncement('Denied',1, true);
	 		Spawn(class'SmallRedeemerExplosion');
			ServerBlowUp();
		}
	}
}

function Fire( optional float F )
{
	ServerBlowUp();
	if ( F == 1 )
	{
		OldPawn.Health = -1;
		OldPawn.KilledBy(OldPawn);
	}
}

function ServerBlowUp()
{
	BlowUp(Location);
}

function BlowUp(vector HitLocation)
{
	if (bExploded || Owner != None && PlayerController(Controller).AcknowledgedPawn != self || Role != ROLE_Authority)
		return;

	ShakeView();
		
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, -vector(Rotation), 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, -vector(Rotation), 0, Instigator);
	}
	
	if (Master != None)
		Master.LostWarhead();

	Instigator = self;
    TargetedHurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation, HitActor);
	bExploded = True;
	
	GoToState('NetTrapped');
}

simulated function TornOff()
{
	ShakeView();
	
	if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(Location, -vector(Rotation), 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(Location, -vector(Rotation), 0, Instigator);
	}
	
	bHidden=True;
	Velocity = vect(0,0,0);
	SetCollision(false,false,false);;
	SetPhysics(PHYS_None);
	if ( SmokeTrail != None )
		SmokeTrail.Destroy();
	LifeSpan = 1;
}

state NetTrapped
{
ignores Trigger, Bump, HitWall, HeadVolumeChange, PhysicsVolumeChange, Falling, BreathTimer;

	function Fire( optional float F ) {}
	function BlowUp(vector HitLocation) {}
	function ServerBlowUp() {}
	function Timer() {}
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType) {}

    function BeginState()
    {
		bStaticScreen=True;
		bTearOff=True;
		bAlwaysRelevant=True;
		bHidden=True;
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);;
		SetPhysics(PHYS_None);
		if ( SmokeTrail != None )
			SmokeTrail.Destroy();
    }

Begin:
    Sleep(6);
    Destroy();
}

function bool DoJump( bool bUpdating )
{
	return false;
}

singular event BaseChange()
{
}

simulated function DrawHUD(Canvas Canvas)
{
    local float Offset;
    local Plane SavedCM;
    
    SavedCM = Canvas.ColorModulate;
    Canvas.ColorModulate.X = 1;
    Canvas.ColorModulate.Y = 1;
    Canvas.ColorModulate.Z = 1;
    Canvas.ColorModulate.W = 1;
    Canvas.Style = 255;
	Canvas.SetPos(0,0);
	Canvas.DrawColor = class'Canvas'.static.MakeColor(255,255,255);
	if ( bStaticScreen )
		Canvas.DrawTile( Material'ScreenNoiseFB', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 512, 512 );
	else if ( !Level.IsSoftwareRendering() )
	{
		
	    if (Canvas.ClipX >= Canvas.ClipY)
	    {
            Offset = Canvas.ClipX / Canvas.ClipY;
	        Canvas.DrawTile( OuterEdgeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512 * (1 - Offset), 0, Offset * 512, 512 );
     	    Canvas.SetPos(0.5*Canvas.SizeX,0);
      	    Canvas.DrawTile( OuterEdgeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512, 0, -512 * Offset, 512 );
         	Canvas.SetPos(0,0.5* Canvas.SizeY);
            Canvas.DrawTile( OuterEdgeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512 * (1 - Offset), 512, Offset * 512, -512);
            Canvas.SetPos(0.5*Canvas.SizeX,0.5* Canvas.SizeY);
            Canvas.DrawTile( OuterEdgeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512, 512, -512 * Offset, -512 );
            Canvas.SetPos(0, 0);
	        Canvas.DrawTile( InnerScopeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512 * (1 - Offset), 0, Offset * 512, 512 );
     	    Canvas.SetPos(0.5* Canvas.SizeX,0);
      	    Canvas.DrawTile( InnerScopeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512, 0, -512 * Offset, 512 );
       	    Canvas.SetPos(0,0.5* Canvas.SizeY);
            Canvas.DrawTile( InnerScopeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512 * (1 - Offset), 512, Offset * 512, -512 );
            Canvas.SetPos(0.5* Canvas.SizeX,0.5* Canvas.SizeY);
            Canvas.DrawTile( InnerScopeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512, 512, -512 * Offset, -512 );
            Canvas.SetPos(0.5 * (Canvas.SizeX - Canvas.SizeY), 0);
            Canvas.DrawTile( OuterScopeShader, Canvas.SizeX, Canvas.SizeY, 0, 0, 1024 * Offset, 1024 );
            Canvas.SetPos((512 * (Offset - 1) + 383) * (Canvas.SizeX / (1024 * Offset)), Canvas.SizeY *(451.0/(1024.0)));
            Canvas.DrawTile( AltitudeFinalBlend, Canvas.SizeX / (8 * Offset), Canvas.SizeY / 8, 0, 0, 128, 128);
            Canvas.SetPos((512 * (Offset - 1) + 383 + 2*(512-383) - 128) * (Canvas.SizeX / (1024 * Offset)), Canvas.SizeY *(451.0/1024.0));
            Canvas.DrawTile( AltitudeFinalBlend, Canvas.SizeX / (8 * Offset), Canvas.SizeY / 8, 128, 0, -128, 128);
        }
        else
        {
            Offset = Canvas.ClipY / Canvas.ClipX;
	        Canvas.DrawTile( OuterEdgeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 0, 512 * (1 - Offset), 512, 512 * Offset);
     	    Canvas.SetPos(0.5*Canvas.SizeX,0);
      	    Canvas.DrawTile( OuterEdgeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512, 512 * (1 - Offset), -512, 512 * Offset);
         	Canvas.SetPos(0,0.5* Canvas.SizeY);
            Canvas.DrawTile( OuterEdgeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 0, 512, 512, -512 * Offset);
            Canvas.SetPos(0.5*Canvas.SizeX,0.5* Canvas.SizeY);
            Canvas.DrawTile( OuterEdgeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512, 512, -512, -512 * Offset);
            Canvas.SetPos(0, 0);
	        Canvas.DrawTile( InnerScopeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 0, 512 * (1 - Offset), 512, 512 * Offset);
     	    Canvas.SetPos(0.5*Canvas.SizeX,0);
      	    Canvas.DrawTile( InnerScopeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512, 512 * (1 - Offset), -512, 512 * Offset);
         	Canvas.SetPos(0,0.5* Canvas.SizeY);
            Canvas.DrawTile( InnerScopeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 0, 512, 512, -512 * Offset);
            Canvas.SetPos(0.5*Canvas.SizeX,0.5* Canvas.SizeY);
            Canvas.DrawTile( InnerScopeShader, 0.5 * Canvas.SizeX, 0.5 * Canvas.SizeY, 512, 512, -512, -512 * Offset);
            Canvas.SetPos(0, 0.5 * (Canvas.SizeY - Canvas.SizeX));
            Canvas.DrawTile( OuterScopeShader, Canvas.SizeX, Canvas.SizeY, 0, 0, 1024, 1024 * Offset );
            Canvas.SetPos(Canvas.SizeX * (383.0/1024.0), (512 * (Offset - 1) + 451) * (Canvas.SizeY / (1024 * Offset)));
            Canvas.DrawTile( AltitudeFinalBlend, Canvas.SizeX / 8, Canvas.SizeY / (8 * Offset), 0, 0, 128, 128);
            Canvas.SetPos(Canvas.SizeX * ((383 + 2*(512-383) - 128)) / 1024, (512 * (Offset - 1) + 451) * (Canvas.SizeY / (1024 * Offset)));
            Canvas.DrawTile( AltitudeFinalBlend, Canvas.SizeX / 8, Canvas.SizeY / (8 * Offset), 128, 0, -128, 128);
        }
		/*
		Canvas.SetPos(Canvas.OrgX, Canvas.OrgY);
		
		Canvas.DrawTile(ScopeViewTex, (Canvas.SizeX - (Canvas.SizeY))/2, Canvas.SizeY, 0, 0, 1, 1024);

		Canvas.SetPos((Canvas.SizeX - (Canvas.SizeY))/2, Canvas.OrgY);
		Canvas.DrawTile(ScopeViewTex, (Canvas.SizeY), Canvas.SizeY, 0, 0, 1024, 1024);

		Canvas.SetPos(Canvas.SizeX - (Canvas.SizeX - (Canvas.SizeY))/2, Canvas.OrgY);
		Canvas.DrawTile(ScopeViewTex, (Canvas.SizeX - (Canvas.SizeY))/2, Canvas.SizeY, 0, 0, 1, 1024);
		*/
   	}
	

   	Canvas.ColorModulate = SavedCM;
}

simulated event PlayDying(class<DamageType> DamageType, vector HitLoc);

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	BlowUp(Location);
}

function bool CheatWalk()
{
	return false;
}

function bool CheatGhost()
{
	return false;
}

function bool CheatFly()
{
	return false;
}

function ShouldCrouch(bool Crouch) {}

event SetWalking(bool bNewIsWalking) {}

function Suicide()
{
	Blowup(Location);
	if ( (OldPawn != None) && (OldPawn.Health > 0) )
		OldPawn.KilledBy(OldPawn);
}

auto state Flying
{
	function Tick(float DeltaTime)
	{
		if ( !bFireForce && (PlayerController(Controller) != None) )
		{
			bFireForce = true;
			PlayerController(Controller).ClientPlayForceFeedback("FlakCannonAltFire");  // jdf
		}
		
		Fuel -= DeltaTime;
		
		if ( Fuel < 0 || (OldPawn == None) || (OldPawn.Health <= 0) )
			BlowUp(Location);
		/*
		else if ( Controller == None )
		{
			if ( OldPawn.Controller == None )
				OldPawn.KilledBy(OldPawn);
			BlowUp(Location);
		}
		*/
	}
}

function ShakeView()
{
	local Controller C;
	local PlayerController PC;
	local float Dist, Scale;

	for ( C=Level.ControllerList; C!=None; C=C.NextController )
	{
		PC = PlayerController(C);
		if ( PC != None && PC.ViewTarget != None && AkeronWarhead(PC.ViewTarget) == None)
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

// Useful if you want to spare a directly hit enemy from the radius damage
simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, DmgRadiusScale, dist;
	local vector dir, ClosestLinePoint;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && Victims != OldPawn && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != HitActor)
		{
			dir = Victims.Location - HitLocation;
			if (Vector(Rotation) dot Normal(Dir) < 0.75)
				continue;
			ClosestLinePoint = Location + vector(Rotation) * (( Vector(Rotation) * DamageRadius ) dot ( Victims.Location - Location )) / DamageRadius;
			if (VSize(Victims.Location - ClosestLinePoint) > OutwardDamageRadius)
				continue;
			if (!FastTrace(Victims.Location, Location))
			{
				DmgRadiusScale = (DamageRadius - GetCoverReductionFor(Victims.Location)) / DamageRadius;
				
				if (DamageRadius * DmgRadiusScale < 16)
					continue;
			}
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - 0.65 * FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);	
			if (!FastTrace(Location, Victims.Location))
				Damage *= 0.5;	
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( Controller );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		 }
	}
	bHurtEntry = false;
}

// Returns the amount by which MaxWallSize should be scaled for each surface type. Override in subclasses to change...
function float SurfaceScale (int Surf, out byte bHard) //hurp durp you can't have an out bool.
{
	switch (Surf)
	{
		Case 0:/*EST_Default*/	bHard = 1; return 0.5;
		Case 1:/*EST_Rock*/		bHard = 1; return 0.5;
		Case 2:/*EST_Dirt*/			return 0.35;
		Case 3:/*EST_Metal*/		bHard = 1; return 0.25;
		Case 4:/*EST_Wood*/		return 0.55;
		Case 5:/*EST_Plant*/		return 0.5;
		Case 6:/*EST_Flesh*/		return 1;
		Case 7:/*EST_Ice*/			bHard=1;return 0.75;
		Case 8:/*EST_Snow*/		return 1;
		Case 9:/*EST_Water*/		return 1;
		Case 10:/*EST_Glass*/		return 1;
		default:								bHard = 1; return 0.5;
	}
}

function float GetCoverReductionFor(vector TargetLoc)
{
	local Vector HitLocation, HitLocationTwo, HitNormal;
	local Material HitMat;
	local float MatScale, Dist;
	local byte bHard;
	
	Trace(HitLocation, HitNormal, TargetLoc, Location, false, , HitMat);
	
	Trace(HitLocationTwo, HitNormal, Location, TargetLoc, false);
	
	MatScale = SurfaceScale(int(HitMat.SurfaceType), bHard);
	
	Dist = VSize(HitLocation - HitLocationTwo);
	
	if (bHard == 0)
		return Dist / MatScale;
	else if (Dist / MatScale > DamageRadius)
		return 0;
	return 1;
}

defaultproperties
{
	 Health=25
	 HealthMax=25

	 LandMovementState="PlayerRocketing"
	 NetPriority=3.000000
	 bGameRelevant=True
	 bReplicateInstigator=True
	 bSimulateGravity=false
	 Physics=PHYS_Flying
     AirSpeed=1000.000000
	 AccelRate=3000.000000
	 	 
	 bStasis=False
	 bCanCrouch=false
	 bCanClimbLadders=false
	 bCanPickupInventory=false
	 bNoTeamBeacon=True
	 bNetNotify=True

	 BaseEyeHeight=0.000000
     EyeHeight=0.000000

	 DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BallisticHardware_25.BOGP.BOGP_Grenade'
	 DrawScale=0.500000
	 AmbientGlow=96

     bNetInitialRotation=True
	 bSpecialHUD=True
     bHideRegularHUD=True
	 bCanUse=False
	 bDynamicLight=True
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightBrightness=255.000000
	 LightRadius=6.000000
	 
	 ForceType=FT_DragAlong
     ForceRadius=100.000000
	 ForceScale=5.000000

	 Damage=110.000000
     DamageRadius=300.000000
     MomentumTransfer=20000.000000
     MyDamageType=Class'BWBPOtherPackPro.DTAkeronGuided'
	 OutwardDamageRadius=96.000000
     ImpactManager=Class'BWBPOtherPackPro.IM_Akeron'
	 ArmThreshold=0.070000

	 AmbientSound=Sound'BallisticSounds2.G5.G5-RocketFly'
     SoundRadius=100.000000

	 bCanTeleport=False
	 bDirectHitWall=True
	 bCollideActors=true
	 bCollideWorld=true
	 bBlockActors=False
	 CollisionRadius=24.000000
     CollisionHeight=12.000000

	 ShakeRotMag=(Z=250.000000)
     ShakeRotRate=(Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Z=10.000000)
     ShakeOffsetRate=(Z=200.000000)
     ShakeOffsetTime=10.000000
	 
	 TransientSoundVolume=1.000000
	 TransientSoundRadius=5000.000000
	 
	 InnerScopeShader=Shader'2K4Hud.ZoomFX.RDM_InnerScopeShader'
     OuterScopeShader=Shader'2K4Hud.ZoomFX.RDM_OuterScopeShader'
     OuterEdgeShader=Shader'2K4Hud.ZoomFX.RDM_OuterEdgeShader'
	 AltitudeFinalBlend=FinalBlend'2K4Hud.ZoomFX.RDM_AltitudeFinal'
	 
	 YawToBankingRatio=60.000000
	 BankingResetRate=15.000000
	 BankingDamping=10
     MaxBanking=20000
     BankingToScopeRotationRatio=8.000000
     VelocityToAltitudePanRate=0.001750
     MaxAltitudePanRate=10.000000
     Fuel=12.000000
}
