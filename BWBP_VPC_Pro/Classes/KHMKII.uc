//=============================================================================
// KH MarkII, A fast attack chopper with an auto cannon, and dual rocket packs.
// It resembles the Cobra Millitary Helicopter.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.

// Additional work by Nolan "Dark Carnivour" Richert, Who was instrumental in making the HUD work.
//=============================================================================
class KHMKII extends ONSChopperCraft
	placeable
	config(BWBP_VPC_Pro);

var(Chopper)   	float   				MaxPitchSpeed; // How long does it take for the sound pitch to increse.
var(Chopper)   	float   				MaxSoundPitch, MinSoundPitch; // How high and low can the sound pitch go.
var(Chopper)   	float   				MinBladeRotationRate; // How low can the blades rotation rate get.
var(Chopper)   	float   				BladeRotationScale; // How fast do the blades rotate depending on the velocity of the chassis.
var 			TexRotator 				Blades;
var 			Shader 					BladeShader;
var 			Emitter                 Steam[2], Lights[5];
var(Effects)	class<Emitter>			GreenLightClass, RedLightClass, BlueLightClass, WhiteLightClass, SteamClass;
var(Effects)	array<vector>			ChopperDustOffset; // sets the offset of the Dust, but also sets how many emitters are spawned depending on how many offsets you have.
var(Effects)	float					ChopperDustTraceDistance; // Max distance Chopper can be from the ground for dust to appear.
var				array<KHMKIIDust>	    ChopperDust;
var				array<vector>			ChopperDustLastNormal;
var     		bool                    bOverWater;
var(Effects) 	name					SteamBones[2], GreenLightBones[2], TeamLightBones[2], WhiteLightBone;
var(HUD)		Material				RocketCounterTex, VehicleIconTex; // Texture for the rocket ammo counter and the decorative Vehicle Icon.
var(HUD)		float					CounterXDimension, CounterYDimension, IconXDimension, IconYDimension; // Image dimensions.
var(HUD)     	config bool             bUseAmmoDisplay; // Does it place an Ammo counter on the HUD.
var(HUD)		float					AmmoDisplaySizeX, AmmoDisplaySizeY, IconDisplaySizeX,IconDisplaySizeY; // Draw size of tiles.
var     		bool                    bAmmoCounterActive;
var				bool					bPackRequiresReloading;
var				int						AmmoCount;
var 			float 					PackDFOffset;

replication
{
	unreliable if (Role < ROLE_Authority || Role == ROLE_Authority)
		AmmoCount, bAmmoCounterActive, PackDFOffset;
}

// Get some info to set the font size for the KHMKII HUD.
simulated static function Font GetBEFontSize(Canvas Canvas, int FontSize)
{
    if ( Canvas.ClipX >= 512 )
		FontSize++;
	if ( Canvas.ClipX >= 640 )
		FontSize++;
	if ( Canvas.ClipX >= 800 )
		FontSize++;
	if ( Canvas.ClipX >= 1024 )
		FontSize++;
	if ( Canvas.ClipX >= 1280 )
		FontSize++;
	if ( Canvas.ClipX >= 1600 )
		FontSize++;

	return class'HudBase'.static.LoadFontStatic(Clamp( 8-FontSize, 0, 8));
}

simulated function SpawnEffects()
{

	if ( Level.NetMode == NM_DedicatedServer )
		return;

//This function spawns the Lights and Steam for the KHMKII, and attaches them to specific bones.

	Steam[0] = spawn(SteamClass);
	Steam[1] = spawn(SteamClass);

    Lights[0] = spawn(GreenLightClass);
    Lights[1] = spawn(GreenLightClass);
    Lights[4] = spawn(WhiteLightClass);

	AttachToBone(Steam[0], SteamBones[0]);
	AttachToBone(Steam[1], SteamBones[1]);

	AttachToBone(Lights[0], GreenLightBones[0]);
	AttachToBone(Lights[1], GreenLightBones[1]);
	AttachToBone(Lights[4], WhiteLightBone);
}
// This sets the right type of team colored lights depending on the Team Number of the driver.
simulated event TeamChanged()
{
    Super.TeamChanged();

    if (Team == 0) // This 'if' statement obviously gets the 'Team Number' of the owner, red in this case, then it does the following.
    {
    	if (Lights[2] != None) // First it destroys the lights, basically like resetting it.
            	Lights[2].Destroy();

    	if (Lights[3] != None)
            	Lights[3].Destroy();

    	Lights[2] = spawn(RedLightClass); // Then it spawns the lights, this is the red one.
    	Lights[3] = spawn(RedLightClass);
    }
    else if (Team == 1) // This is just the same as the above but it's for Blue.
    {
    	if (Lights[2] != None)
            	Lights[2].Destroy();

    	if (Lights[3] != None)
            	Lights[3].Destroy();

    	Lights[2] = spawn(BlueLightClass);
    	Lights[3] = spawn(BlueLightClass);
    }

 // Here it attaches the lights to the 'TeamLightBones', which are set under the default properties.
	AttachToBone(Lights[2], TeamLightBones[0]);
    AttachToBone(Lights[3], TeamLightBones[1]);
}
// This messy lot does certain things after the vehicle is spawned, like spawning the actual dust itself.
simulated function PreBeginPlay()
{
	local int i;

	Super.PreBeginPlay();

	AmbientSound = IdleSound;

    SpawnEffects(); // this activates the function above the previous one after the vehicle has spawned, or respawned.

	if ( Level.NetMode != NM_DedicatedServer )
		SetupBlades();

    if(Level.NetMode != NM_DedicatedServer && ChopperDust.Length == 0 && !bDropDetail)
	{
		ChopperDust.Length = ChopperDustOffset.Length; // This is used to simplify the number of dust emitters spawned by making it's number depend on how many arrays of ChopperDustOffset exist.
		ChopperDustLastNormal.Length = ChopperDustOffset.Length;

		for(i=0; i<ChopperDustOffset.Length; i++)
		{
    		if (ChopperDust[i] == None)
    		{
    			ChopperDust[i] = spawn(class'BWBP_VPC_Pro.KHMKIIDust', self,, Location + (ChopperDustOffset[i] >> Rotation) );
    			ChopperDust[i].SetDustColor(Level.DustColor, false);// This Activates and sets the Dust Emitter's SetDustColor function's color variable to be the same color as the Level Info's dust color.
		        ChopperDust[i].UpdateBladeDust(True, 1); //This activates the function UpdateBladeDust under the Dust Emitter's Code.
    			ChopperDustLastNormal[i] = vect(0,0,1);
    		}
		}
	}
}

// Destroys the Dust, Steam, and Lights for the KHMKII when it is destroyed.
simulated function Destroyed()
{
	local int i;

	if ( Blades != None )
	{
		Level.ObjectPool.FreeObject(Blades);
		Blades = None;
	}

	if ( BladeShader != None )
	{
		Level.ObjectPool.FreeObject(BladeShader);
		BladeShader = None;
	}

	if (Level.NetMode != NM_DedicatedServer)
	{
		for (i = 0; i < ChopperDust.Length; i++)
			ChopperDust[i].Destroy();

		ChopperDust.Length = 0;
	}
    if (Steam[0] != None)
            Steam[0].Destroy();

    if (Steam[1] != None)
            Steam[1].Destroy();

	for(i=0;i<5;i++)
    {
		if (Lights[i] != None)
                Lights[i].Destroy();
	}
    Super.Destroyed();

	AmbientSound = None;
}
// More Destroy related stuff
simulated function DestroyAppearance()
{
	local int i;

	if (Level.NetMode != NM_DedicatedServer)
	{
		for (i = 0; i < ChopperDust.Length; i++)
			ChopperDust[i].Destroy();

		ChopperDust.Length = 0;
	}

	Super.DestroyAppearance();

	AmbientSound = None;
}

simulated function SetupBlades()
{
	Blades = TexRotator(Level.ObjectPool.AllocateObject(class'TexRotator'));
	if ( Blades != None )
	{
		Blades.Material = Skins[1];
		Blades.Rotation.Yaw = 0.0;
		Blades.TexRotationType = TR_ConstantlyRotating;
		Blades.UOffset = 256.0;
		Blades.VOffset = 256.0;
		Skins[1] = Blades;
	}
	BladeShader = Shader(Level.ObjectPool.AllocateObject(class'Shader'));
	if ( BladeShader != None )
	{
		BladeShader.Diffuse = Skins[1];
		BladeShader.Opacity = Skins[1];
		BladeShader.TwoSided = true;
		BladeShader.DetailScale = 4.0;
		BladeShader.OutputBlending = OB_Normal;
		Skins[1] = BladeShader;
	}
}

// This is used to update lot's of important stuff every frame,(or 'tick' as it's called).
simulated function Tick(float DeltaTime)
{
	local KHMKIIRocketPack Pack;
    local float EnginePitch, HitDist, CurrentVehicleSpeed;
	local int i;
	local vector TraceStart, TraceEnd, HitLocation, HitNormal;
	local actor HitActor;
	local KarmaParams kp;

    Super.Tick(DeltaTime);

	Pack = KHMKIIRocketPack(Weapons[0]);

	AmmoCount = KHMKIIRocketPack(Weapons[0]).LoadedShotCount;
	bPackRequiresReloading = KHMKIIRocketPack(Weapons[0]).bRequiresReloading;
	PackDFOffset = KHMKIIRocketPack(Weapons[0]).NewDualFireOffset;

	if ( Level.NetMode != NM_DedicatedServer )
	{
		CurrentVehicleSpeed = VSize(Velocity) * DeltaTime;

		Pack.SetSpread(CurrentVehicleSpeed);

		EnginePitch = MinSoundPitch + VSize(Velocity)/MaxPitchSpeed * 64.0;
		SoundPitch = FClamp(EnginePitch, MinSoundPitch, MaxSoundPitch);

		if( !bDropDetail )
		{
        	// Check for water.
        	bOverWater = false;
        	kp = KarmaParams(KParams);
        	for(i=0;i<kp.Repulsors.Length;i++)
        	{
                if (kp.Repulsors[i].bRepulsorOnWater)
                {
                    bOverWater = true;
                	break;
                }
            }

			for(i=0;i<ChopperDust.Length ;i++)
			{
            	TraceStart = Location + (ChopperDustOffset[i] >> Rotation);
            	TraceEnd = TraceStart - ( ChopperDustTraceDistance * vect(0,0,1) );

            	HitActor = Trace(HitLocation, HitNormal, TraceEnd, TraceStart, true);

            	if(HitActor == None)
                 	ChopperDust[i].UpdateBladeDust(false, 0);
            	else
            	{
            		if ( bOverWater || ((PhysicsVolume(HitActor) != None) && PhysicsVolume(HitActor).bWaterVolume) )
                 		ChopperDust[i].SetDustColor(Level.WaterDustColor, true);
            		else
                 		ChopperDust[i].SetDustColor(Level.DustColor, false);

                 	HitDist = VSize(HitLocation - TraceStart);

                 	ChopperDust[i].SetLocation( HitLocation + 10*HitNormal);

                 	ChopperDustLastNormal[i] = Normal( 3*ChopperDustLastNormal[i] + HitNormal );
                 	ChopperDust[i].SetRotation( Rotator(ChopperDustLastNormal[i]) );

                 	ChopperDust[i].UpdateBladeDust(true, HitDist/ChopperDustTraceDistance);

						// If dust is just turning on, set OldLocation to current Location to avoid spawn interpolation.
				}
            }
		}
		if ( Blades != None )
			Blades.Rotation.Yaw = MinBladeRotationRate + (VSize(Velocity) * BladeRotationScale);
	}
}

// Draws the Ammo Counter for the KHMKII.
simulated function DrawHUD(Canvas Canvas)
{
	local float	ScaleFactor;

	ScaleFactor = Canvas.ClipX / 1600;

	if ( Level.NetMode != NM_DedicatedServer )
	{
    	if (bUseAmmoDisplay && bPackRequiresReloading && bAmmoCounterActive)
    	{
			Canvas.Font = GetBEFontSize(Canvas, -2 + int(2 * class'HUD'.default.HudScale));

    		Canvas.Style = 1;
	   		Canvas.SetDrawColor(255,255,255,192);
    		Canvas.SetPos(Canvas.OrgX + 400 * ScaleFactor, Canvas.OrgY + 1000 * ScaleFactor);
    		Canvas.DrawTile(RocketCounterTex, AmmoDisplaySizeX, AmmoDisplaySizeY, 0, 0, -1 * CounterXDimension, CounterYDimension);

    		Canvas.Style = 1;
	   		Canvas.SetDrawColor(255,255,255,192);
    		Canvas.SetPos(Canvas.OrgX + 1072 * ScaleFactor, Canvas.OrgY + 1000 * ScaleFactor);
    		Canvas.DrawTile(RocketCounterTex, AmmoDisplaySizeX, AmmoDisplaySizeY, 0, 0, CounterXDimension, CounterYDimension);

    		Canvas.Style = 1;
	   		Canvas.SetDrawColor(255,255,255,192);
    		Canvas.SetPos(Canvas.OrgX + 597 * ScaleFactor, Canvas.OrgY + 892 * ScaleFactor);
    		Canvas.DrawTile(VehicleIconTex, IconDisplaySizeX, IconDisplaySizeY, 0, 0, IconXDimension, IconYDimension);

    		Canvas.Style = 1;
			Canvas.SetDrawColor(0,192,0,192);
    		Canvas.SetPos(Canvas.OrgX + 380 * ScaleFactor, Canvas.OrgY + 1065 * ScaleFactor);
			Canvas.DrawText("L", false);

    		Canvas.Style = 1;
			Canvas.SetDrawColor(0,192,0,192);
    		Canvas.SetPos(Canvas.OrgX + 1240 * ScaleFactor, Canvas.OrgY + 1065 * ScaleFactor);
			Canvas.DrawText("R", false);

			if (AmmoCount == 8 || AmmoCount == 6 || AmmoCount == 4 || AmmoCount == 2 || AmmoCount == 0)
			{
    			Canvas.Style = 1;
				Canvas.SetDrawColor(255,0,0,192);
    			Canvas.SetPos(Canvas.OrgX + 464 * ScaleFactor, Canvas.OrgY + 1065 * ScaleFactor);
				Canvas.DrawText(AmmoCount/2$ "", false);

    			Canvas.Style = 1;
				Canvas.SetDrawColor(255,0,0,192);
    			Canvas.SetPos(Canvas.OrgX + 1136 * ScaleFactor, Canvas.OrgY + 1065 * ScaleFactor);
				Canvas.DrawText(AmmoCount/2$ "", false);
			}
			else if (AmmoCount == 9 || AmmoCount == 7 || AmmoCount == 5 || AmmoCount == 3 || AmmoCount == 1)
			{
				if(PackDFOffset < 0)
				{
    				Canvas.Style = 1;
					Canvas.SetDrawColor(255,0,0,255);
    				Canvas.SetPos(Canvas.OrgX + 464 * ScaleFactor, Canvas.OrgY + 1065 * ScaleFactor);
					Canvas.DrawText(AmmoCount/2+1$ "", false);

    				Canvas.Style = 1;
					Canvas.SetDrawColor(255,0,0,255);
    				Canvas.SetPos(Canvas.OrgX + 1136 * ScaleFactor, Canvas.OrgY + 1065 * ScaleFactor);
					Canvas.DrawText(AmmoCount/2$ "", false);
				}

				else if(PackDFOffset > 0)
				{
    				Canvas.Style = 1;
					Canvas.SetDrawColor(255,0,0,255);
    				Canvas.SetPos(Canvas.OrgX + 464 * ScaleFactor, Canvas.OrgY + 1065 * ScaleFactor);
					Canvas.DrawText(AmmoCount/2$ "", false);

    				Canvas.Style = 1;
					Canvas.SetDrawColor(255,0,0,255);
    				Canvas.SetPos(Canvas.OrgX + 1136 * ScaleFactor, Canvas.OrgY + 1065 * ScaleFactor);
					Canvas.DrawText(AmmoCount/2+1$ "", false);
				}
			}
		}
	}
	Super.DrawHUD(Canvas);
}

// These two functions are very important, they ensures that the Dust doesn't turn off when you'r not in the vehicle.
simulated event SetInitialState()
{
    Super.SetInitialState();

    Enable('Tick');
}

simulated event DrivingStatusChanged()
{
    if (!bDriving)
	{
        Enable('Tick');

        if ( Blades != None )
            Blades.Rotation.Yaw = MinBladeRotationRate;

		bAmmoCounterActive = false;
		AmbientSound = IdleSound;
    }
	else
		bAmmoCounterActive = true;
}

defaultproperties
{
     MaxPitchSpeed=7000.000000
     MaxSoundPitch=74.000000
     MinSoundPitch=48.000000
     MinBladeRotationRate=50000.000000
     BladeRotationScale=45.000000
     GreenLightClass=Class'BWBP_VPC_Pro.KHMKIILightGreen'
     RedLightClass=Class'BWBP_VPC_Pro.KHMKIILightRed'
     BlueLightClass=Class'BWBP_VPC_Pro.KHMKIILightBlue'
     WhiteLightClass=Class'BWBP_VPC_Pro.KHMKIILightWhite'
     SteamClass=Class'BWBP_VPC_Pro.KHMKIIEngineSteam'
     ChopperDustOffset(0)=(X=32.000000)
     ChopperDustTraceDistance=1750.000000
     SteamBones(0)="Vent1"
     SteamBones(1)="Vent2"
     GreenLightBones(0)="Light1"
     GreenLightBones(1)="Light2"
     TeamLightBones(0)="Light3"
     TeamLightBones(1)="Light4"
     WhiteLightBone="Light5"
     RocketCounterTex=Texture'BWBP_Vehicles_Tex.ui.KHMKIIAmmoIcon'
     VehicleIconTex=Texture'BWBP_Vehicles_Tex.ui.KHMKIIHUDIcon'
     CounterXDimension=128.000000
     CounterYDimension=128.000000
     IconXDimension=256.000000
     IconYDimension=256.000000
     bUseAmmoDisplay=True
     AmmoDisplaySizeX=64.000000
     AmmoDisplaySizeY=64.000000
     IconDisplaySizeX=160.000000
     IconDisplaySizeY=160.000000
     UprightStiffness=500.000000
     UprightDamping=300.000000
     MaxThrustForce=50.000000
     LongDamping=0.050000
     MaxStrafeForce=40.000000
     LatDamping=0.050000
     MaxRiseForce=40.000000
     UpDamping=0.100000
     TurnTorqueFactor=600.000000
     TurnTorqueMax=200.000000
     TurnDamping=50.000000
     MaxYawRate=1.000000
     PitchTorqueFactor=100.000000
     PitchTorqueMax=30.000000
     PitchDamping=20.000000
     RollTorqueTurnFactor=30.000000
     RollTorqueStrafeFactor=100.000000
     RollTorqueMax=30.000000
     RollDamping=30.000000
     StopThreshold=100.000000
     MaxRandForce=3.000000
     RandForceInterval=0.750000
     DriverWeapons(0)=(WeaponClass=Class'BWBP_VPC_Pro.KHMKIIRocketPack',WeaponBone="RocketBone")
     PassengerWeapons(0)=(WeaponPawnClass=Class'BWBP_VPC_Pro.KHMKIINoseGunPawn',WeaponBone="NoseBone")
     RedSkin=Texture'BWBP_Vehicles_Tex.Cobra.KHMKIIChasisRed'
     BlueSkin=Texture'BWBP_Vehicles_Tex.Cobra.KHMKIIChasisBlue'
     IdleSound=Sound'BWBP_Vehicles_Sound.Cobra.ChopperAmbient'
     StartUpForce="AttackCraftStartUp"
     ShutDownForce="AttackCraftShutDown"
     DestroyedVehicleMesh=StaticMesh'BWBP_Vehicles_Static.Cobra.KHMKIIDead'
     DestructionEffectClass=Class'BWBP_VPC_Pro.KHMKIIExplosionEffect'
     DisintegrationEffectClass=Class'Onslaught.ONSVehDeathAttackCraft'
     DisintegrationHealth=-4096.000000
     DestructionLinearMomentum=(Min=50000.000000,Max=150000.000000)
     DestructionAngularMomentum=(Min=100.000000,Max=300.000000)
     DamagedEffectOffset=(X=-64.000000,Z=350.000000)
     ImpactDamageMult=0.001000
     VehicleMass=4.000000
     bVehicleShadows=False
     bTurnInPlace=True
     bShowDamageOverlay=True
     bDriverHoldsFlag=False
     bCanCarryFlag=False
     ExitPositions(0)=(X=275.000000,Y=-280.000000,Z=128.000000)
     ExitPositions(1)=(X=275.000000,Y=280.000000,Z=128.000000)
     EntryRadius=400.000000
     FPCamPos=(X=176.000000,Z=288.000000)
     TPCamDistance=1250.000000
     TPCamLookat=(X=0.000000,Z=0.000000)
     TPCamWorldOffset=(Z=512.000000)
     TPCamDistRange=(Min=1250.000000,Max=2500.000000)
     MomentumMult=0.200000
     DriverDamageMult=0.000000
     VehiclePositionString="Flying a KH MarkII"
     VehicleNameString="KH MarkII Cobra"
     RanOverDamageType=Class'BWBP_VPC_Pro.KHMKIIDamTypeRoadKill'
     CrushedDamageType=Class'BWBP_VPC_Pro.KHMKIIDamTypePancake'
     MaxDesireability=0.700000
     FlagBone="NoseBone"
     FlagOffset=(Z=140.000000)
     WaterDamage=50.000000
     GroundSpeed=2000.000000
     WaterSpeed=1500.000000
     HealthMax=750.000000
     Health=750
     Mesh=SkeletalMesh'BWBP_Vehicles_Anim.KHMKII'
     Skins(1)=Texture'BWBP_Vehicles_Tex.Cobra.KHMKIIBlades'
     ScaleGlow=0.750000
     bFullVolume=True
     SoundRadius=850.000000
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.000000
         KInertiaTensor(3)=3.000000
         KInertiaTensor(5)=3.000000
         KLinearDamping=0.000000
         KAngularDamping=0.000000
         KStartEnabled=True
         bKNonSphericalInertia=True
         KActorGravScale=0.000000
         KMaxSpeed=3500.000000
         bHighDetailOnly=False
         bClientOnly=False
         bKDoubleTickRate=True
         bKStayUpright=True
         bKAllowRotate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.500000
         KImpactThreshold=300.000000
     End Object
     KParams=KarmaParamsRBFull'BWBP_VPC_Pro.KHMKII.KParams0'

     bTraceWater=True
}
