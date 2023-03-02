//=============================================================================
// DCTVThorTank.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DCTVThorTank extends ONSHoverTank;

var() float TreadTurnScale;
var() Sound	MovingIdleSound;
var   float	StartIdleTime;
var   DCTVThorDust	ThorDust[4];
var   vector		ThorDustOffSets[4];
var() name		WheelBones[12];
var() int		WheelTurn[12];
var() float		WheelCirc[12];
var() float		WheelTurnCirc;
var() name		BendBones[8];
var() vector	WheelOffsets[8];
var() Range		WheelLimits[8];
var   InterpCurvePoint		WheelExtention[8];
var() float		WheelTraceBuffer;
var   float		NextCrushTime;

var() config bool	bThorTrackSuspension;
var() config bool	bThorCrushing;

// 54	339.3	50	-170,96,-28		16,32
// 51	320.4	48	-76,96,-20		24,32
// 51	320.4	48	13,96,-20		24,32
// 51	320.4	48	103,96,-20		24,32
// 40	251.3
// 24	150.8

simulated function SetupTreads()
{
	local int i;
	local rotator R;

	LeftTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( LeftTreadPanner != None )
	{
		LeftTreadPanner.Material = Skins[2];
		LeftTreadPanner.PanDirection = rot(0, 0, 0);
		LeftTreadPanner.PanRate = 0.0;
		Skins[2] = LeftTreadPanner;
	}
	RightTreadPanner = VariableTexPanner(Level.ObjectPool.AllocateObject(class'VariableTexPanner'));
	if ( RightTreadPanner != None )
	{
		RightTreadPanner.Material = Skins[1];
		RightTreadPanner.PanDirection = rot(0, 0, 0);
		RightTreadPanner.PanRate = 0.0;
		Skins[1] = RightTreadPanner;
	}

	for (i=0;i<12;i++)
	{
		WheelTurn[i] = Rand(65536);
		R.Pitch = WheelTurn[i];
		SetBoneRotation(WheelBones[i], R, 0, 1.0);
	}
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

simulated function Tick(float DeltaTime)
{
    local float EnginePitch;
	local float LinTurnSpeed;
	local float Spd, TrackSpeed;
    local KRigidBodyState BodyState;
    local KarmaParams KP;
    local bool bOnGround, bFwrd;
    local int i;
    local rotator R;

    KGetRigidBodyState(BodyState);

	KP = KarmaParams(KParams);

	// Increase max karma speed if falling
	bOnGround = false;
	for(i=0; i<KP.Repulsors.Length; i++)
	{
        //log("Checking Repulsor "$i);
		if( KP.Repulsors[i] != None && KP.Repulsors[i].bRepulsorInContact )
			bOnGround = true;
		//log("bOnGround: "$bOnGround);
	}

	if (bOnGround)
	   KP.kMaxSpeed = MaxGroundSpeed;
	else
	   KP.kMaxSpeed = MaxAirSpeed;

	if ( Level.NetMode != NM_DedicatedServer )
	{
		Spd = VSize(Velocity);
		LinTurnSpeed = BodyState.AngVel.Z / TreadTurnScale;
		EnginePitch = 32.0 + (Spd+abs(BodyState.AngVel.Z*WheelTurnCirc))/MaxPitchSpeed * 96.0;
//		SoundPitch = FClamp(EnginePitch, 64, 128);
		SoundPitch = FClamp(EnginePitch, 32, 128);
		bFwrd = Velocity Dot Vector(Rotation) > 0;
		if (AmbientSound != None || (StartIdleTime != 0 && level.TimeSeconds >= StartIdleTime))
		{
			if (EnginePitch > 64)
				AmbientSound = MovingIdleSound;
			else
				AmbientSound = IdleSound;
		}

		if ( LeftTreadPanner != None )
		{
			LeftTreadPanner.PanRate = Spd / TreadVelocityScale;
			if (bFwrd)
				LeftTreadPanner.PanRate = -1 * LeftTreadPanner.PanRate;
			LeftTreadPanner.PanRate += LinTurnSpeed;
		}

		if ( RightTreadPanner != None )
		{
			RightTreadPanner.PanRate = Spd / TreadVelocityScale;
			if (bFwrd)
				RightTreadPanner.PanRate = -1 * RightTreadPanner.PanRate;
			RightTreadPanner.PanRate -= LinTurnSpeed;
		}
		if (Role == ROLE_Authority)
			UpdateWheelHeight(Spd, DeltaTime, level.DetailMode < DM_SuperHigh || !bThorTrackSuspension, bThorCrushing);
		else if (level.DetailMode == DM_SuperHigh && bThorTrackSuspension)
			UpdateWheelHeight(Spd, DeltaTime, false, false);

		if (!bFwrd)
			Spd *= -1;

		for (i=0;i<12;i++)
		{
			if (i < 6)
				TrackSpeed = Spd + BodyState.AngVel.Z * WheelTurnCirc;
			else
				TrackSpeed = Spd - BodyState.AngVel.Z * WheelTurnCirc;
			WheelTurn[i] += DeltaTime * 65536 * (TrackSpeed / WheelCirc[i]);
			R.Pitch = WheelTurn[i];
			SetBoneRotation(WheelBones[i], R, 0, 1.0);
		}
		for (i=0;i<4;i++)
			if (ThorDust[i] != None)
			{
				TrackSpeed = Spd - BodyState.AngVel.Z * ThorDustOffsets[i].Y * 6.283185/*pi * 2*/;
				ThorDust[i].UpdateDust(abs(TrackSpeed), bOnGround && ( (i < 2) ^^ (TrackSpeed < 0) ), 1 + abs(BodyState.AngVel.Z*2));
			}
	}
	else
		UpdateWheelHeight(Spd, DeltaTime, true, bThorCrushing);

    Super(ONSTreadCraft).Tick( DeltaTime );
}

simulated function UpdateWheelHeight(float Speed, float DT, bool bFast, bool bDamage)
{
	local actor T;
	local vector HitLoc, HitNorm, Start, End, X, Y, Z, V;
	local float WheelInterpLimit, Dist;
	local int i;

	if (bDamage && level.TimeSeconds < NextCrushTime)
	{
		if (bFast)
			return;
		bDamage = false;
	}

	WheelInterpLimit = FMax(Speed, 1) * DT * 0.4;

	GetAxes(Rotation, X,Y,Z);
	for (i=0;i<8;i++)
	{
		Start = Location + (WheelOffsets[i] >> Rotation);
		End = Start - Z * (WheelLimits[i].Max - WheelLimits[i].Min);
		Start += Z * WheelTraceBuffer;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(8,8,8));
		if (T != None)
		{
			if (bDamage && T.bCanBeDamaged)
			{
				T.TakeDamage(30, Instigator, HitLoc, vect(0,0,-1), CrushedDamageType);
				NextCrushTime = level.TimeSeconds + 0.2;
			}

			if (bFast)
				continue;

			Dist = VSize(HitLoc-Start);
			if (Dist < WheelTraceBuffer)
				WheelExtention[i].InVal = WheelLimits[i].Max;
			else
				WheelExtention[i].InVal = WheelLimits[i].Max - (Dist - WheelTraceBuffer);
//				WheelExtention[i].InVal = WheelLimits[i].Max - Dist;

			WheelExtention[i].OutVal += FClamp(WheelExtention[i].InVal - WheelExtention[i].OutVal, -WheelInterpLimit, WheelInterpLimit);
			V.Z = WheelExtention[i].OutVal;
			SetBoneLocation(BendBones[i], V, 1.0);
			if (i < 4)
				SetBoneLocation(WheelBones[i], V, 1.0);
			else
				SetBoneLocation(WheelBones[i+2], V, 1.0);
		}
		else if (!bFast)
		{
			WheelExtention[i].InVal = WheelLimits[i].Min;

			WheelExtention[i].OutVal += FClamp(WheelExtention[i].InVal - WheelExtention[i].OutVal, -WheelInterpLimit, WheelInterpLimit);
			V.Z = WheelExtention[i].OutVal;

			SetBoneLocation(BendBones[i], V, 1.0);
			if (i < 4)
				SetBoneLocation(WheelBones[i], V, 1.0);
			else
				SetBoneLocation(WheelBones[i+2], V, 1.0);
		}
	}
}

function KDriverEnter(Pawn p)
{
    local int x;

    ResetTime = Level.TimeSeconds - 1;
    Instigator = self;

    super(SVehicle).KDriverEnter( P );

    if ( Weapons.Length > 0 )
        Weapons[ActiveWeapon].bActive = True;

	StartIdleTime = level.TimeSeconds + 1.0;
//    if ( IdleSound != None )
  //      AmbientSound = IdleSound;

    if ( StartUpSound != None )
        PlaySound(StartUpSound, SLOT_None, 1.5);

    if (xPawn(Driver) != None && Driver.HasUDamage())
    	for (x = 0; x < Weapons.length; x++)
		Weapons[x].SetOverlayMaterial(xPawn(Driver).UDamageWeaponMaterial, xPawn(Driver).UDamageTime - Level.TimeSeconds, false);

    Driver.bSetPCRotOnPossess = false; //so when driver gets out he'll be facing the same direction as he was inside the vehicle

	for (x = 0; x < Weapons.length; x++)
	{
		if (Weapons[x] == None)
		{
			Weapons.Remove(x, 1);
			x--;
		}
		else
		{
			Weapons[x].NetUpdateFrequency = 20;
			ClientRegisterVehicleWeapon(Weapons[x], x);
		}
	}

    SVehicleUpdateParams();
}

function DriverLeft()
{
	StartIdleTime = 0;

    Super.DriverLeft();
}

simulated event SVehicleUpdateParams()
{
	local KarmaParams kp;

	Super.SVehicleUpdateParams();

	kp = KarmaParams(KParams);

    kp.Repulsors[0].CheckDist = HoverCheckDist+22;
    kp.Repulsors[1].CheckDist = HoverCheckDist+22;
}

simulated event DestroyAppearance()
{
	super.DestroyAppearance();

	AmbientSound=None;
}

simulated event DrivingStatusChanged()
{
	local int i;

	Super.DrivingStatusChanged();

	if (bDriving && Level.NetMode != NM_DedicatedServer && !bDropDetail)
	{
		for(i=0; i<4; i++)
			if (ThorDust[i] == None)
			{
				ThorDust[i] = spawn (class'DCTVThorDust', self,, Location + (ThorDustOffsets[i] >> Rotation), Rotation);
				ThorDust[i].SetDustColor( Level.DustColor );
				ThorDust[i].OrientateDust(ThorDustOffsets[i].X > 0, ThorDustOffsets[i].Y > 0);
				ThorDust[i].SetBase(self);
			}
	}
	else
	{
		for(i=0; i<4; i++)
			if (ThorDust[i] != None)
			{
				ThorDust[i].Kill();
				ThorDust[i] = None;
			}
	}
}

simulated function Destroyed()
{
	local int i;

	for(i=0; i<4; i++)
		if (ThorDust[i] != None)
			ThorDust[i].Destroy();
	super.Destroyed();
}

/*
function bool ImportantVehicle()
{
	return false;
}
*/
function bool RecommendLongRangedAttack()
{
	return false;
}

defaultproperties
{
     TreadTurnScale=8.000000
     MovingIdleSound=Sound'BWBP_Vehicles_Sound.ThorTank.ThorTankMove'
     ThorDustOffSets(0)=(X=-130.000000,Y=-130.000000,Z=-22.000000)
     ThorDustOffSets(1)=(X=-130.000000,Y=130.000000,Z=-22.000000)
     ThorDustOffSets(2)=(X=92.000000,Y=130.000000,Z=-22.000000)
     ThorDustOffSets(3)=(X=92.000000,Y=-130.000000,Z=-22.000000)
     WheelBones(0)="WheelL1"
     WheelBones(1)="WheelL2"
     WheelBones(2)="WheelL3"
     WheelBones(3)="WheelL4"
     WheelBones(4)="WheelL5"
     WheelBones(5)="WheelL6"
     WheelBones(6)="WheelR1"
     WheelBones(7)="WheelR2"
     WheelBones(8)="WheelR3"
     WheelBones(9)="WheelR4"
     WheelBones(10)="WheelR5"
     WheelBones(11)="WheelR6"
     WheelCirc(0)=339.299988
     WheelCirc(1)=320.399994
     WheelCirc(2)=320.399994
     WheelCirc(3)=320.399994
     WheelCirc(4)=251.300003
     WheelCirc(5)=150.800003
     WheelCirc(6)=339.299988
     WheelCirc(7)=320.399994
     WheelCirc(8)=320.399994
     WheelCirc(9)=320.399994
     WheelCirc(10)=251.300003
     WheelCirc(11)=150.800003
     WheelTurnCirc=230.000000
     BendBones(0)="TrackBendL1"
     BendBones(1)="TrackBendL2"
     BendBones(2)="TrackBendL3"
     BendBones(3)="TrackBendL4"
     BendBones(4)="TrackBendR1"
     BendBones(5)="TrackBendR2"
     BendBones(6)="TrackBendR3"
     BendBones(7)="TrackBendR4"
     WheelOffsets(0)=(X=-170.000000,Y=-96.000000,Z=-28.000000)
     WheelOffsets(1)=(X=-76.000000,Y=-96.000000,Z=-20.000000)
     WheelOffsets(2)=(X=13.000000,Y=-96.000000,Z=-20.000000)
     WheelOffsets(3)=(X=103.000000,Y=-96.000000,Z=-20.000000)
     WheelOffsets(4)=(X=-170.000000,Y=96.000000,Z=-28.000000)
     WheelOffsets(5)=(X=-76.000000,Y=96.000000,Z=-20.000000)
     WheelOffsets(6)=(X=13.000000,Y=96.000000,Z=-20.000000)
     WheelOffsets(7)=(X=103.000000,Y=96.000000,Z=-20.000000)
     WheelLimits(0)=(Min=-24.000000,Max=16.000000)
     WheelLimits(1)=(Min=-24.000000,Max=24.000000)
     WheelLimits(2)=(Min=-24.000000,Max=24.000000)
     WheelLimits(3)=(Min=-24.000000,Max=24.000000)
     WheelLimits(4)=(Min=-24.000000,Max=24.000000)
     WheelLimits(5)=(Min=-24.000000,Max=24.000000)
     WheelLimits(6)=(Min=-24.000000,Max=24.000000)
     WheelLimits(7)=(Min=-24.000000,Max=24.000000)
     WheelTraceBuffer=24.000000
     bThorTrackSuspension=True
     bThorCrushing=True
     MaxPitchSpeed=1100.000000
     TreadVelocityScale=1050.000000
     MaxGroundSpeed=1200.000000
     ThrusterOffsets(0)=(X=240.000000,Z=52.000000)
     ThrusterOffsets(1)=(X=240.000000,Y=-145.000000,Z=52.000000)
     ThrusterOffsets(2)=(X=160.000000)
     ThrusterOffsets(3)=(X=48.000000)
     ThrusterOffsets(4)=(X=-64.000000,Y=145.000000)
     ThrusterOffsets(5)=(X=-192.000000,Y=145.000000)
     ThrusterOffsets(6)=(X=160.000000)
     ThrusterOffsets(7)=(X=48.000000)
     ThrusterOffsets(8)=(X=-64.000000,Y=-145.000000,Z=10.000000)
     ThrusterOffsets(9)=(X=-192.000000,Y=-145.000000,Z=10.000000)
     HoverPenScale=3.000000
     HoverCheckDist=70.000000
     MaxThrust=120.000000
     LateralDampFactor=0.900000
     DriverWeapons(0)=(WeaponClass=Class'BWBP_VPC_Pro.DCTVThorTankCannon',WeaponBone="TurretWeapon")
     PassengerWeapons(0)=(WeaponPawnClass=Class'BWBP_VPC_Pro.DCTVThorTankMGPawn',WeaponBone="TankMGWeapon")
     RedSkin=Texture'BWBP_Vehicles_Tex.ThorTank.Tank'
     BlueSkin=Texture'BWBP_Vehicles_Tex.ThorTank.TankBlue'
     IdleSound=Sound'BWBP_Vehicles_Sound.ThorTank.ThorTankRun'
     StartUpSound=Sound'BWBP_Vehicles_Sound.ThorTank.ThorTankStart'
     ShutDownSound=Sound'BWBP_Vehicles_Sound.ThorTank.ThorTankStop'
     DestroyedVehicleMesh=StaticMesh'BWBP_Vehicles_Static.ThorTank.ThorBustedTank'
     DisintegrationEffectClass=Class'BWBP_VPC_Pro.DCTVThorDisintegration'
     DisintegrationHealth=-300.000000
     FireImpulse=(X=-150000.000000)
     bHasFireImpulse=True
     VehicleMass=16.000000
     ExitPositions(0)=(Y=-250.000000)
     ExitPositions(1)=(Y=250.000000)
     FPCamPos=(Z=200.000000)
     TPCamWorldOffset=(Z=300.000000)
     VehiclePositionString="in a Thor Tank"
     VehicleNameString="XC943B-22 Thor Tank"
     RanOverDamageType=Class'BWBP_VPC_Pro.DT_ThorRoadKill'
     CrushedDamageType=Class'BWBP_VPC_Pro.DT_ThorPanCake'
     MaxDesireability=0.900000
     FlagBone="FlagBone"
     WaterDamage=0.000000
     HealthMax=1200.000000
     Health=1200
     Mesh=SkeletalMesh'BWBP_Vehicles_Anim.ThorTank'
     Skins(1)=TexScaler'BWBP_Vehicles_Tex.ThorTank.TrackScaler'
     Skins(2)=TexScaler'BWBP_Vehicles_Tex.ThorTank.TrackScaler'
     bFullVolume=True
     SoundVolume=255
     Begin Object Class=KarmaParamsRBFull Name=KParams1
         KInertiaTensor(0)=7.284162
         KInertiaTensor(2)=-0.185795
         KInertiaTensor(3)=7.036122
         KInertiaTensor(5)=13.405293
         KCOMOffset=(X=-0.268800,Y=-0.000003,Z=1.071200)
         KLinearDamping=0.000000
         KAngularDamping=0.000000
         KStartEnabled=True
         KMaxSpeed=1200.000000
         bHighDetailOnly=False
         bClientOnly=False
         bKDoubleTickRate=True
         bKStayUpright=True
         bKAllowRotate=True
         bDestroyOnWorldPenetrate=True
         bDoSafetime=True
         KFriction=0.500000
     End Object
     KParams=KarmaParamsRBFull'BWBP_VPC_Pro.DCTVThorTank.KParams1'

}
