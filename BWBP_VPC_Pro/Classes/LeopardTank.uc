//=============================================================================
// The TMV Leopard, is a heavily armored Tank with a strong engine, powerfull cannon,
// and a Main Gun Sight for manual range finding.

// It also has a .50 Calibre machinegun ontop of it's turret, and smoke dispensers for signaling purposes.


// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.

// Additional work by Nolan "Dark Carnivour" Richert, Who was instrumental in making the dust work.
//=============================================================================
class LeopardTank extends ONSTreadCraft
	placeable
	config(BWBP_VPC_Pro);

var 				LeopardDust				Dust[20];
var(Leopard) 		name					DustBoneNames[20];
var(Leopard)   		float   				MaxPitchSpeed;// How long does it take for the sound pitch to increse.
var(Leopard)   		float   				MaxSoundPitch; // How high can the sound pitch go.
var(Leopard)   		float   				MinSoundPitch; // How low can the sound pitch go.
var(Leopard)   		float   				TireRotationScale; // How fast do the tires rotate depending on the velocity of the chassis.
var(Leopard) 		float 					TireTurnScale; // How fast do the tires rotate while turning the tank.
var 				VariableTexPanner 		LeftTreadPanner, RightTreadPanner;
var 				TexRotator 				Tires;
var(Leopard) 		float 					TreadVelocityScale; // How fast do the treads pan while the tank is moving.
var(Dust) 			float 					DustAmmountScale; // How much dust is there.
var(Dust) 			float 					DustVelocityScale; // How fast does the dust move upwards.
var(Dust) 			float 					DustSizeScale; // How big is the dust.
var(Dust) 			float 					DustLifeScale; // How long does the dust last.
var(Dust) 			float 					DustFadeScale; // When does the dust fade.
var(Dust) 			int 					DustEmittersCount; // How many emitters must be spawned.
var					float 					MaxGroundSpeed, MaxAirSpeed;
var(Leopard) 		float 					TreadTurnScale; // How fast do the treads pan while turning the tank.
var(Leopard) 		Sound					MovingIdleSound; // Sound to play while the tank is moving.
var   				float					StartIdleTime;
var					bool					bSightActive;
var(Sights)			config bool				bHasSight; // Does it have a GUI sight.
var(Sights)   		config float			MaxZoom; // Max ammount that you can zoom into.
var(Sights)			Material				SightTex; // Texture for the sight.
var					byte					ToggleCount; // Used to tell the smokers how many times you have alt fired.

/*
// Enumerator: Its a way of giving fancy names to a number. Looks nicer than using an int or byte.
enum EDustLevel
{
	DL_Off,		//0
	DL_Low,		//1
	DL_Med,		//2
	DL_High,	//3
	DL_Full		//4
};
*/
simulated function SpawnDust()
{
	local int i;

//This function spawns the Dust for the TMV Leopard Tracks and attaches it to specific bones.

	for (i=0;i<DustEmittersCount;i++)
	{
		Dust[i] = Spawn(class'LeopardDust');
	    AttachToBone(Dust[i], DustBoneNames[i]);
	}
}

// Activates the function that spawns the smoke and gives it the team number of the driver.
simulated event TeamChanged()
{
	local LeopardTurret Turret;

    Super.TeamChanged();

	Turret = LeopardTurret(Weapons[0]);

	if (Level.NetMode != NM_DedicatedServer)
		Turret.SpawnSmokers(Team);
}

/*
simulated function SetDustlevel(EDustLevel NewDustlevel)
{
	local int i;

	for (i=0;i<DustEmittersCount;i++)
	{
		if (Dust[i] != None)
		{
			switch (NewDustlevel)// Ok, switch statement: thats like a neater way of doing lots of if statements.
			{	// case things you need to use in a switch statement.
				case DL_Off: Dust[i].SetDustLevelOff(); break;	// it will do everything between the 'case' and the 'break'.
				case DL_Low: Dust[i].SetDustLevelLow(); break;	// Break exits the switch statement.
				case DL_Med: Dust[i].SetDustLevelMed(); break;
				case DL_High: Dust[i].SetDustLevelHigh(); break;
				case DL_Full: Dust[i].SetDustLevelFull(); break;
			}
		}
	}
}
*/
// Spawns the Dust and sets the Dust's color and its initial quantity.
simulated function PreBeginPlay()
{
    local int i;

	Super.PreBeginPlay();

	ToggleCount = 0; // Sets 'ToggleCount' to 0 to tell it that it is off (0 is off, 1 is on)

    if (Level.NetMode != NM_DedicatedServer && !bDropDetail)
    	SpawnDust();

	for (i=0;i<DustEmittersCount;i++)
		Dust[i].UpdateTrackDust(false);

    for (i=0;i<DustEmittersCount;i++)
        Dust[i].SetDustColor(Level.DustColor);

	if ( Level.NetMode != NM_DedicatedServer )
		SetupTreads();

	if ( Level.NetMode != NM_DedicatedServer )
		SetupTires();

}
// Spawns the Dust and sets the Dust's color and its initial quantity.
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	LeopardTurret(Weapons[0]).ToggleSmokers(false);
}
// Destroys the Dust and activates the 'DestroyTreads' function.
simulated function Destroyed()
{
    local int i;

	DestroyTreads();

	if ( Tires != None )
	{
		Level.ObjectPool.FreeObject(Tires);
		Tires = None;
	}

	if (Level.NetMode != NM_DedicatedServer)
    	for (i=0;i<DustEmittersCount;i++)
			if (Dust[i] != None)
				Dust[i].Destroy();

	Super.Destroyed();

	AmbientSound = None;
}

// More Destroy related stuff
simulated function DestroyAppearance()
{
	local int i;

	if (Level.NetMode != NM_DedicatedServer)
    	for (i=0;i<DustEmittersCount;i++)
			if (Dust[i] != None)
				Dust[i].Destroy();

	Super.DestroyAppearance();

	AmbientSound = None;
}

function bool ImportantVehicle()
{
	return true;
}
// Creates the basic settings for the Tracks.
simulated function SetupTreads()
{
	RightTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( RightTreadPanner != None )
	{
		RightTreadPanner.Material = Skins[2];
		RightTreadPanner.PanDirection = rot(0, 49152, 0);
		RightTreadPanner.PanRate = 0.0;
		Skins[2] = RightTreadPanner;
	}
	LeftTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( LeftTreadPanner != None )
	{
		LeftTreadPanner.Material = Skins[1];
		LeftTreadPanner.PanDirection = rot(0, 49152, 0);
		LeftTreadPanner.PanRate = 0.0;
		Skins[1] = LeftTreadPanner;
	}
}

simulated function SetupTires()
{
	Tires = TexRotator(Level.ObjectPool.AllocateObject(class'TexRotator'));
	if ( Tires != None )
	{
		Tires.Material = Skins[3];
		Tires.Rotation.Yaw = 0.0;
		Tires.TexRotationType = TR_FixedRotation;
		Tires.UOffset = -1.25;
		Tires.VOffset = 0.0;
		Skins[3] = Tires;
	}
}

// Destroys the Treads Panning Texture.
simulated function DestroyTreads()
{
	if ( LeftTreadPanner != None )
	{
		Level.ObjectPool.FreeObject(LeftTreadPanner);
		LeftTreadPanner = None;
	}
	if ( RightTreadPanner != None )
	{
		Level.ObjectPool.FreeObject(RightTreadPanner);
		RightTreadPanner = None;
	}
}

// Resets the Tread's PanRate.
simulated event DrivingStatusChanged()
{
	local int i;

    Super.DrivingStatusChanged();

    if (!bDriving)
    {
		ToggleCount = 0;
		LeopardTurret(Weapons[0]).ToggleSmokers(false);

		for (i=0;i<DustEmittersCount;i++)
			Dust[i].UpdateTrackDust(false);

        if ( LeftTreadPanner != None )
            LeftTreadPanner.PanRate = 0.0;

        if ( RightTreadPanner != None )
            RightTreadPanner.PanRate = 0.0;
    }
}
// Updates lots of important stuff for the vehicle.
simulated function Tick(float DeltaTime)
{
    local float EnginePitch;
	local float LinTurnSpeed, TireTurnSpeed;
    local KRigidBodyState BodyState;
    local KarmaParams KP;
    local bool bOnGround;
    local int i;
	local float CurrentDustSize, CurrentDustVelocity, CurrentDustLife, CurrentDustFade, CurrentDustAmmount, CurrentVehicleSpeed;

    Super.Tick( DeltaTime );

    KGetRigidBodyState(BodyState);

	KP = KarmaParams(KParams);

	CurrentVehicleSpeed = VSize(Velocity) * DeltaTime;

	LeopardTurret(Weapons[0]).SetSpread(CurrentVehicleSpeed);

	bOnGround = false;
	for(i=0; i<KP.Repulsors.Length; i++)
	{
        //log("Checking Repulsor "$i);
		if( KP.Repulsors[i] != None && KP.Repulsors[i].bRepulsorInContact )
			bOnGround = true;
		//log("bOnGround: "$bOnGround);
	}

	if (bOnGround)
    {
	   KP.kMaxSpeed = MaxGroundSpeed;
    }
	else
	   KP.kMaxSpeed = MaxAirSpeed;

	if(Level.NetMode != NM_DedicatedServer)
	{
		LinTurnSpeed = BodyState.AngVel.Z / TreadTurnScale;
		TireTurnSpeed = (BodyState.AngVel.Z * TireTurnScale) * DeltaTime;
		EnginePitch = 62.0 + VSize(Velocity) / MaxPitchSpeed * 96.0;
		CurrentDustSize = 5.0 + VSize(Velocity) / DustSizeScale;
		CurrentDustLife = 2.0 + VSize(Velocity) / DustLifeScale;
		CurrentDustFade = 1.5 + VSize(Velocity) / DustFadeScale;
		CurrentDustVelocity = 5.0 + VSize(Velocity) / DustVelocityScale;
		CurrentDustAmmount = VSize(Velocity) / DustAmmountScale;
		SoundPitch = FClamp(EnginePitch, MinSoundPitch, MaxSoundPitch);
		if (AmbientSound != None || (StartIdleTime != 0 && level.TimeSeconds >= StartIdleTime))
		{
			if (EnginePitch > 62)
				AmbientSound = MovingIdleSound;
			else
				AmbientSound = IdleSound;
		}
		if ((!bOnGround)||(EnginePitch <= 62)||(VSize(Velocity) <= 0))
			CurrentDustAmmount = 0.0;

		else if ((EnginePitch <= 64)||( VSize(Velocity) <= 10))
			CurrentDustAmmount = 2.5;

    	for (i=0;i<DustEmittersCount;i++)
        	Dust[i].DustScale(CurrentDustSize, CurrentDustVelocity, CurrentDustLife, CurrentDustFade, CurrentDustAmmount);

		for (i=0;i<DustEmittersCount;i++)
			Dust[i].UpdateTrackDust(true);

        LeopardTurret(Weapons[0]).GetSmokeScale(CurrentDustSize);

		if(ToggleCount == 2)
			ToggleCount = 0; // Unsures that the variable loops, otherwise it would never go off.

		if (ToggleCount >= 1)
			LeopardTurret(Weapons[0]).ToggleSmokers(true); // If 1 it sets 'true'.

		else if (ToggleCount < 1)
			LeopardTurret(Weapons[0]).ToggleSmokers(false); // If 0 it sets 'false'.

		if ( LeftTreadPanner != None )
		{
			LeftTreadPanner.PanRate = VSize(Velocity) / TreadVelocityScale;
			if (Velocity Dot Vector(Rotation) > 0)
				LeftTreadPanner.PanRate = -1 * LeftTreadPanner.PanRate;
			LeftTreadPanner.PanRate += LinTurnSpeed;
		}

		if ( RightTreadPanner != None )
		{
			RightTreadPanner.PanRate = VSize(Velocity) / TreadVelocityScale;
			if (Velocity Dot Vector(Rotation) > 0)
				RightTreadPanner.PanRate = -1 * RightTreadPanner.PanRate;
			RightTreadPanner.PanRate -= LinTurnSpeed;
		}

		if ( Tires != None )
		{
			if (Velocity Dot Vector(Rotation) > 0)
				Tires.Rotation.Yaw += (VSize(Velocity) * TireRotationScale) * DeltaTime; // Increases the rotation of the tires.
			else
				Tires.Rotation.Yaw -= (VSize(Velocity) * TireRotationScale) * DeltaTime; // Decreases the rotation of the tires.

			if ((VSize(Velocity) > 0)||(EnginePitch > 62))
				Tires.Rotation.Yaw += TireTurnSpeed; // Adds the turning speed value to the rotation, ONLY if the tank is moving.
		}

		if (Tires.Rotation.Yaw >= 65536) // When the Yaw of the tires reaches 360 -
			Tires.Rotation.Yaw -= 65536; 									//- degrees '65536' it sets it back to 0 to ensure it never goes over 360 degrees.
		else if (Tires.Rotation.Yaw <= -65536)
			Tires.Rotation.Yaw += 65536;

		if ((VSize(Velocity) <= 0)||(EnginePitch <= 62)) // This ensures that the tracks stop moving when the tank does.
		{
			LeftTreadPanner.PanRate = 0.0;
			RightTreadPanner.PanRate = 0.0;
		}
	}

	
}
// Checks to see if you are in first person or third person view, and sets certain things acordingly.
simulated function POVChanged(PlayerController PC, bool bBehindViewChanged)
{
	Super.POVChanged(PC, bBehindViewChanged);

	if (PC.bBehindView)
	{
		bSightActive = false;

		bWeaponIsAltFiring = false;
		PC.EndZoom(); // Resets your view from a zoom if you change your view to third person.
	}
	else
		bSightActive = true;
}
// Draws the sight for the tank if you are in first person.
simulated function DrawHUD(Canvas Canvas)
{
    if (SightTex != None && bSightActive && bHasSight)
    {
    	Canvas.Style = 1;
    	Canvas.DrawColor.R = 200;
		Canvas.DrawColor.G = 200;
		Canvas.DrawColor.B = 200;
		Canvas.DrawColor.A = 255;

    	Canvas.SetPos(Canvas.OrgX, Canvas.OrgY);
    	Canvas.DrawTile(SightTex, Canvas.SizeX, Canvas.SizeY, 0, 0, 1024, 1024);
	}
	else if (!bSightActive || !bHasSight)
		super.DrawHud(Canvas);
}

function KDriverEnter(Pawn p)
{
	Super.KDriverEnter(p);

	ToggleCount = 0;

    SVehicleUpdateParams();
}
// Switches off the Dust when the driver leaves the vehicle.
simulated function DriverLeft()
{
	local int i;

    Super.DriverLeft();

	ToggleCount = 0;

	for (i=0;i<DustEmittersCount;i++)
		Dust[i].UpdateTrackDust(false);

    SVehicleUpdateParams();
}

// Zooms the view if you alt fire and are in first person view.
function AltFire(optional float F)
{
	local PlayerController PC;

	PC = PlayerController(Controller);
	if (PC == None)
		return;

	if (!PC.bBehindView)
	{
		bWeaponIsAltFiring = true;
		PC.ToggleZoomWithMax(MaxZoom);
	}
	if (PC.bBehindView)
		ToggleCount ++; // Everytime you alt fire this adds a 1 to the 'ToggleCount' variable.

}
// Stops zooming if you stop alt firing.
function ClientVehicleCeaseFire(bool bWasAltFire)
{
	local PlayerController PC;

	if (!bWasAltFire)
	{
		Super.ClientVehicleCeaseFire(bWasAltFire);
		return;
	}

	PC = PlayerController(Controller);
	if (PC == None)
		return;


	if (!PC.bBehindView)
	{
		bWeaponIsAltFiring = false;
		PC.StopZoom();
	}
}
// Resets your view from a zoom when you exit the vehicle.
simulated function ClientKDriverLeave(PlayerController PC)
{
	Super.ClientKDriverLeave(PC);

	bWeaponIsAltFiring = false;
	PC.EndZoom();
}

function bool RecommendLongRangedAttack()
{
	return true;
}

event TakeDamage(int Damage, Pawn instigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> DamageType)
{
	if (DamageType == class'DamTypeONSVehicleExplosion')
	{
		Damage *= 0.4;
		Momentum *= 0.3;
	}

	Super.TakeDamage(Damage, instigatedBy, Hitlocation, Momentum, damageType);
}


function ShouldTargetMissile(Projectile P)
{
	if ( (WeaponPawns.Length > 0) && (WeaponPawns[0].Controller == None) )
		Super.ShouldTargetMissile(P);
}

defaultproperties
{
     DustBoneNames(0)="DustBone1"
     DustBoneNames(1)="DustBone2"
     DustBoneNames(2)="DustBone3"
     DustBoneNames(3)="DustBone4"
     DustBoneNames(4)="DustBone5"
     DustBoneNames(5)="DustBone6"
     DustBoneNames(6)="DustBone7"
     DustBoneNames(7)="DustBone8"
     DustBoneNames(8)="DustBone9"
     DustBoneNames(9)="DustBone10"
     MaxPitchSpeed=1000.000000
     MaxSoundPitch=128.000000
     MinSoundPitch=62.000000
     TireRotationScale=100.000000
     TireTurnScale=50000.000000
     TreadVelocityScale=600.000000
     DustAmmountScale=150.000000
     DustVelocityScale=12.000000
     DustSizeScale=15.000000
     DustLifeScale=150.000000
     DustFadeScale=250.000000
     DustEmittersCount=10
     MaxGroundSpeed=20000.000000
     MaxAirSpeed=50000.000000
     TreadTurnScale=0.600000
     MovingIdleSound=Sound'BWBP_Vehicles_Sound.Leopard.Leo-EngineMotion'
     bHasSight=True
     MaxZoom=0.800000
     SightTex=Texture'BWBP_Vehicles_Tex.ui.LeopardSight'
     ThrusterOffsets(0)=(X=-186.000000,Y=-134.000000,Z=-3.500000)
     ThrusterOffsets(1)=(X=-186.000000,Y=134.000000,Z=-3.500000)
     ThrusterOffsets(2)=(X=151.000000,Y=-109.000000,Z=-10.000000)
     ThrusterOffsets(3)=(X=151.000000,Y=109.000000,Z=-10.000000)
     ThrusterOffsets(4)=(X=-135.000000,Y=-109.000000,Z=-26.000000)
     ThrusterOffsets(5)=(X=-135.000000,Y=109.000000,Z=-26.000000)
     ThrusterOffsets(6)=(X=98.000000,Y=-109.000000,Z=-26.000000)
     ThrusterOffsets(7)=(X=98.000000,Y=109.000000,Z=-26.000000)
     ThrusterOffsets(8)=(X=-76.000000,Y=-109.000000,Z=-26.000000)
     ThrusterOffsets(9)=(X=-76.000000,Y=109.000000,Z=-26.000000)
     ThrusterOffsets(10)=(X=40.000000,Y=-109.000000,Z=-26.000000)
     ThrusterOffsets(11)=(X=40.000000,Y=109.000000,Z=-26.000000)
     ThrusterOffsets(12)=(X=-17.000000,Y=-109.000000,Z=-26.000000)
     ThrusterOffsets(13)=(X=-17.000000,Y=109.000000,Z=-26.000000)
     HoverSoftness=0.050000
     HoverPenScale=7.500000
     HoverCheckDist=32.000000
     UprightStiffness=500.000000
     UprightDamping=300.000000
     MaxThrust=80.000000
     MaxSteerTorque=100.000000
     ForwardDampFactor=0.100000
     LateralDampFactor=0.800000
     ParkingDampFactor=0.300000
     SteerDampFactor=200.000000
     InvertSteeringThrottleThreshold=-0.100000
     DriverWeapons(0)=(WeaponClass=Class'BWBP_VPC_Pro.LeopardTurret',WeaponBone="TurretBone")
     PassengerWeapons(0)=(WeaponPawnClass=Class'BWBP_VPC_Pro.LeopardMGPawn',WeaponBone="MGBone")
     bHasAltFire=False
     RedSkin=Texture'BWBP_Vehicles_Tex.Leopard.LeopardChasisRed'
     BlueSkin=Texture'BWBP_Vehicles_Tex.Leopard.LeopardChasisBlue'
     IdleSound=Sound'BWBP_Vehicles_Sound.Leopard.Leo-EngineIdle'
     StartUpSound=Sound'ONSVehicleSounds-S.Tank.TankStart01'
     ShutDownSound=Sound'ONSVehicleSounds-S.Tank.TankStop01'
     StartUpForce="TankStartUp"
     ShutDownForce="TankShutDown"
     ViewShakeRadius=600.000000
     ViewShakeOffsetMag=(X=0.500000,Z=2.000000)
     ViewShakeOffsetFreq=7.000000
     DestroyedVehicleMesh=StaticMesh'BWBP_Vehicles_Static.Leopard.LeopardDead'
     DestructionEffectClass=Class'BWBP_VPC_Pro.LeopardExplosionEffect'
     DisintegrationHealth=-4096.000000
     DestructionLinearMomentum=(Min=250000.000000,Max=400000.000000)
     DestructionAngularMomentum=(Min=100.000000,Max=300.000000)
     DamagedEffectScale=1.500000
     DamagedEffectOffset=(X=-192.000000,Y=76.000000,Z=64.000000)
     bEnableProximityViewShake=True
     VehicleMass=13.000000
     bVehicleShadows=False
     bTurnInPlace=True
     bDrawMeshInFP=True
     bPCRelativeFPRotation=False
     bSeparateTurretFocus=True
     bDriverHoldsFlag=False
     bFPNoZFromCameraPitch=True
     DrivePos=(Z=130.000000)
     ExitPositions(0)=(Y=-200.000000,Z=100.000000)
     ExitPositions(1)=(Y=200.000000,Z=100.000000)
     EntryRadius=375.000000
     FPCamPos=(X=-64.000000,Y=-8.000000,Z=120.000000)
     FPCamViewOffset=(X=90.000000)
     TPCamDistance=1024.000000
     TPCamLookat=(X=-50.000000,Z=0.000000)
     TPCamWorldOffset=(Z=250.000000)
     TPCamDistRange=(Min=700.000000,Max=1024.000000)
     MomentumMult=0.300000
     DriverDamageMult=0.000000
     VehiclePositionString="Driving a Leopard TM V"
     VehicleNameString="Leopard TankMaster V"
     RanOverDamageType=Class'BWBP_VPC_Pro.LeopardDamTypeRoadKill'
     CrushedDamageType=Class'BWBP_VPC_Pro.LeopardDamTypePancake'
     MaxDesireability=0.850000
     FlagBone="MGBone"
     FlagRotation=(Yaw=32768)
     HornSounds(0)=Sound'ONSVehicleSounds-S.Horns.Horn09'
     HornSounds(1)=Sound'ONSVehicleSounds-S.Horns.Horn02'
     WaterDamage=50.000000
     bCanStrafe=True
     GroundSpeed=20000.000000
     WaterSpeed=1000.000000
     HealthMax=1300.000000
     Health=1300
     Mesh=SkeletalMesh'BWBP_Vehicles_Anim.LeopardTank'
     Skins(1)=Texture'BWBP_Vehicles_Tex.Leopard.LeopardTracks'
     Skins(2)=Texture'BWBP_Vehicles_Tex.Leopard.LeopardTracks'
     Skins(3)=Texture'BWBP_Vehicles_Tex.Leopard.MetalTireRim'
     ScaleGlow=0.750000
     bFullVolume=True
     SoundRadius=250.000000
     CollisionRadius=260.000000
     CollisionHeight=60.000000
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.300000
         KInertiaTensor(3)=4.000000
         KInertiaTensor(5)=4.500000
         KLinearDamping=0.000000
         KAngularDamping=0.000000
         KStartEnabled=True
         KMaxSpeed=2000.000000
         bHighDetailOnly=False
         bClientOnly=False
         bKDoubleTickRate=True
         bKStayUpright=True
         bKAllowRotate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.500000
     End Object
     KParams=KarmaParamsRBFull'BWBP_VPC_Pro.LeopardTank.KParams0'

}
