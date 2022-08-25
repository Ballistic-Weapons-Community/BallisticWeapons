//===========================================================================
// Akeron Warhead HE Burst
// 3 rockets in barrage mode
// 
// Repurposed Redeemer code.
//===========================================================================
class AkeronWarheadHEBurst extends AkeronWarhead;

var() Sound			RocketLaunchSound;

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
		SmokeTrail = Spawn(class'AkeronRocketTrailTriple',self,,Location - 40 * Dir);
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
		PlayOwnedSound(RocketLaunchSound,SLOT_Interact,1.0);
	}
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
		AmbientSound=None;
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
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_Grenade'
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

	 Damage=310.000000
     DamageRadius=350.000000
     MomentumTransfer=70000.000000
     MyDamageType=Class'BWBP_OP_Pro.DTAkeronGuided'
	 OutwardDamageRadius=96.000000
     ImpactManager=Class'BWBP_OP_Pro.IM_AkeronHETriple'
	 ArmThreshold=0.150000

     RocketLaunchSound=Sound'BWBP_SKC_Sounds.Misc.M202-FireDumbTriple'
	 AmbientSound=Sound'BWBP_SKC_Sounds.Misc.M202-ControlCritical'
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
