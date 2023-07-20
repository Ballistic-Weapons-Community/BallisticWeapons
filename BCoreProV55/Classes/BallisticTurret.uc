//=============================================================================
// BallisticTurret.
//
// This is a generic class for Ballistic deployable and ordinary stationary weapons where
// the old player pawn stands or crouches outside the turret and moves around as if turning
// it instead of just being attached to it.
// This system consists of:
//	A turret pawn (this class) which is possessed by the controller and is responsible for
//	3rd person appearance, camera, oldpawn handling,
// 	A weapon subclass which is given to the turret pawn and is responsible for all firing and weapon functions,
//	1st person appearance, 1st and 3rd person weapon and fire displaying and firing sounds.
//
// Features:
// -Stationary turret vehicle that rotates gun and camera
// -Extrernal driver pawn vulnerable to attack
// -Camera and gun controled by input and adjusted with many vars
// -Weapon subclass used for attack
// -Rotation limits and speeds
// -Camera and driver positional offsets
// -External driver handling (walking, animations, etc)
// -Deployability and undeployability
// -Quick Use and Abandon to grab deployed turrets or leave turret without removing it
//
// Azarael edits:
// -Turret fix for online play
// -Won't work properly without modified code in the various Turret weapons!
// -MG spawning fix for online play
// -Doesn't block traces
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTurret extends Vehicle Abstract placeable config(BallisticProV55);

/* Potential future developments ---------
	May be able to be damaged/destroyed. Control goes back to old pawn when destroyed.
	Bots should only target damageable turrets.
	ThirdPerson camera stuff
   ---------------------------------------
 */

/*
	Skeletal heirachy: Base->Pivot->Head
		Base is fixed and does not rotate
		Pivot only yaws
		Head only pitches, but uses pivot yaw to aim anywhere

	Pawn = Thirdpersonapearance
	Weapon = First person visual

	Vectors of Interest"
		Location				Central Location of turret. Should be in middle of cyliner and mesh
		EyePosition				Position of camera offset from Location by CameraOffset along CameraDirection which is interpolated to GunRotation.
		RightHandlePos			BoneLocation where OldPawn right hand should be pointed
		LeftHandlePos			BoneLocation where OldPawn left hand should be pointed
		DriverPosition			Position where OldPawn should be moved to when driving. Refpoint for drivers to 'Use'
*/

var() const int MinTurretEyeDepth;

// Info saved by weapons
var() int		AmmoAmount[2];
var() int		MagAmmoAmount;
var() byte		WeaponMode;
var   bool		bWeaponDeployed;		// Used by weapons so they don't need to play deploy when already deployed turret is grabbed on the fly
// ----------

// Deployment
var() string	UndeployedWeaponName;
var() string	WeaponClassName;		// The default weapon to spawn on this turret

// Cam, gun, rotation, offsets, driver, etc -----------
// Bounds
var() Range		GunYawBounds;			// The yaw limits for rotating gun (URR)
var() Range		GunPitchBounds;			// The pitch limits for rotating gun (URR)
var() Range		CamYawBounds;			// The yaw limits for camera rotation
var() Range		CamPitchBounds;			// The pitch limits for camera rotation
var   Range		GoalYawBounds;			// Yaw limits for goal rotation (Calculated as the greater of either GunYawBounds or GunPitchBounds)
var   Range		GoalPitchBounds;		// Same for pitch
// Speeds
var() float		YawSpeed;				// Speed at which GoalRotation can yaw
var() float		PitchSpeed;				// Speed at which GoalRotation can pitch
var() float		GunYawSpeed;			// Speed at which GunRotation can yaw
var() float		GunPitchSpeed;			// Speed at which GunRotation can pitch
var() float		CamTrackYawSpeed;		// Speed at which CameraDirection can yaw
var() float		CamTrackPitchSpeed;		// Speed at which CameraDirection can pitch
var() float		CamYawSpeed;			// Speed at which CameraRotation can yaw
var() float		CamPitchSpeed;			// Speed at which CameraRotation can pitch
// Misc
var() int		AbandonedPitch;			// Gun is pitched to this amount when not in use
var() float		TurretFOV;				// Player FOV when using this turret
var() Vector	CameraOffset;			// Offset for camera position, aligned to cam or gun rotation
var() float		CameraElevation;		// Extra Z height applied to camera position
var() name		GunBone;				// The main bone for gun / head piece that can pitch and follows pivot yaw
var() name		PivotBone;				// Bone for pivot piece that yaws
// Internal
var   rotator	WeaponPivot;			// Extra rotation of gun, usually sent from the weapon
var   rotator	GoalRotation;			// Rotation player wants. Gun and camera try to get there, but the limits set if, how and when they do
var   rotator	GunRotation;			// The gun aim relative to the base rotation
var   rotator	CameraRotation;			// Rotation of camera
var   rotator	CameraDirection;		// The direction in which the camera is located
// Driver related props
var() Vector	DriverOffset;			// General offset of driver, aligned to cam or gun rotation
var() float		DriverBackOff;			// How far back driver should be positioned
var() name		RightHandleBone;		// Name of bone marking rightt handle
var() name		LeftHandleBone;			// Name of bone marking left handle
var Rotator	SentViewRotation;		// Recoil and aim info sent by the weapon
//-----------------------------------------------------

// General
var() bool		bNoUndeploy;			// Turret cannot be undeployed (useful for placed in map turrets or when you want it to stay always)
var() bool		bIgnoreTurretLimit;		// This is a special turret (probably placed in map) and should be exempt from turret count limits
// Internal
var   Triggers	MyUseTrigger;			// The trigger spawned to make it easier for players to 'use' this turret
var   Pawn		OldDriver;				// Guy who was driving this turret
var   bool		bDriverOutOfRange;		// The driver has moved too far to ratate the gun properly
var   byte		GunRotationYaw,			// GunRotation form sent to non-owning clients
				GunRotationPitch;
// -------

// Lists and Limits
var   BCTurretList		TurretList;		// Link to turret list control
var   float				LastUsedTime;	// Time when this turret was last used
// ----------------
// Variants
var 	byte 			CamoIndex;
var 	byte 			LayoutIndex;
// AI Stuff
var   float			NextBotReaimTime;	// Time when bot aim error should be recalculated
var   rotator		BotAimError;		// Current bot inaccuracy offset
var   float			BotsNextDesireTime;	// Time when bots will desire this again. (Hopefully they've found some ammo since their last try!)
// --------

replication
{
	reliable if (Role == ROLE_Authority && !bNetOwner && bNetDirty)
		GunRotationYaw, GunRotationPitch;
	reliable if (Role < ROLE_Authority)
		ServerTurretRotation;
}

simulated function FixPCRotation(PlayerController PC)
{
	//PC.SetRotation(Rotation);
}

simulated function bool HasUDamage()
{
	return (Driver != None && Driver.HasUDamage());
}

function AdjustDriverDamage(out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
    local float DriverEyeZ, TurretBottomZ, DriverHeight;

	Momentum = vect(0,0,0);

	if ( InGodMode() )
 		Damage = 0;

	/*
	if (DamageType.default.bLocationalHit && CheckDefense(instigatedBy.Location))
    {
        DriverEyeZ = Driver.Location.Z + Driver.EyePosition().Z;
        TurretBottomZ = Location.Z - CollisionHeight;
        DriverHeight = 2 * Driver.CollisionHeight;

 		Damage *= DriverDamageMult;
    }
	*/
}

/*
function bool CheckDefense(Vector EnemyLocation)
{
    local Vector AttackDir;
    local Vector FaceDir;

    FaceDir = Vector(Rotation);
    AttackDir = Normal(Location - EnemyLocation);

    if ( FaceDir dot AttackDir < -0.2 )
        return true;

    return false;
}
*/

simulated function SetViewRotation (rotator NewRotation)
{
	SentViewRotation = NewRotation;
}

// Check how many turrets there are. If there are more than the limit, get rid of the one that has been unused for the longest
function CheckTurretLimit()
{
	if (TurretList != None)
		TurretList.CheckTurretLimit();
}

// Add new turret to the turret list
function AddToList()
{
	if (TurretList != None)
		TurretList.AddTurret(self);
}

// Remove this turret from the turret list
function RemoveFromList()
{
	if (TurretList != None)
		TurretList.RemoveTurret(self);
}

// There are too many turrets, this one has been chosen to be removed
function Retire()
{
	if (Controller != None)
		return;
	Destroy();
}

simulated event Destroyed()
{
	if (Role == ROLE_Authority)
		RemoveFromList();
	super.Destroyed();
}

// Driver pickued up some ammo. Return true to let him get it otherwise we can use it here
function bool DriverGetAmmo(Ammunition Ammo, int AmmoToAdd)
{
	if (Weapon == None)
		return true;
	if (Weapon.GetAmmoClass(0) == Ammo.Class && Weapon.AddAmmo(AmmoToAdd, 0))
		return false;
	else if (Weapon.GetAmmoClass(1) == Ammo.Class && Weapon.AddAmmo(AmmoToAdd, 1))
		return false;
	return true;
}

// Turret has just been deployed. Chance to get info from a weapon that spawned the turret. (e.g. Get ammo from machinegun when its deployed)
function InitDeployedTurretFor(Weapon Weap)
{
	local int i;
	local WeaponCamo WC;
	local Material M;
	
	if (BallisticWeapon(Weap) != None)
	{
		MagAmmoAmount = BallisticWeapon(Weap).MagAmmo;
		WeaponMode = 	BallisticWeapon(Weap).CurrentWeaponMode;
		CamoIndex = BallisticWeapon(Weap).CamoIndex;
		LayoutIndex = BallisticWeapon(Weap).LayoutIndex;
		if (BallisticWeapon(Instigator.Weapon) != None && BallisticWeapon(Instigator.Weapon).WeaponCamo != None)
		{
			WC = BallisticWeapon(Weap).WeaponCamo;
			for (i = 0; i < WC.WeaponMaterialSwaps.Length; ++i)
			{
				if (WC.WeaponMaterialSwaps[i].AIndex != -1)
				{				
					if (WC.WeaponMaterialSwaps[i].Material != None)
					{
						Skins[WC.WeaponMaterialSwaps[i].AIndex] = WC.WeaponMaterialSwaps[i].Material;
					}
					if (WC.WeaponMaterialSwaps[i].MaterialName != "")
					{
						M = Material(DynamicLoadObject(WC.WeaponMaterialSwaps[i].MaterialName, class'Material'));
						if (M != None)
							Skins[WC.WeaponMaterialSwaps[i].AIndex] = M;
					}
				}
			}
		}
	}
	AmmoAmount[0] = Weap.AmmoAmount(0);
	AmmoAmount[1] = Weap.AmmoAmount(1);
}
// Turret based weapon has been spawned. Give it the info it needs.
function InitTurretWeapon(Weapon Weap)
{
	if (BallisticWeapon(Weap) != None)
	{
		BallisticWeapon(Weap).MagAmmo = 			MagAmmoAmount;
		BallisticWeapon(Weap).CurrentWeaponMode =	WeaponMode;
		//BallisticWeapon(Weap).GenerateLayout(LayoutIndex);
		//BallisticWeapon(Weap).GenerateCamo(CamoIndex);
		BallisticWeapon(Weap).InitTurretWeapon(self);
	}
//	Weap.AddAmmo(AmmoAmount[0]-Weap.AmmoAmount(0), 0);
//	Weap.AddAmmo(AmmoAmount[1]-Weap.AmmoAmount(1), 1);
}
// A weapon is given to a player when this turret is undeployed. Chance to send some info to that weapon.
function InitUndeployedWeapon(Weapon Weap)
{
	if (BallisticWeapon(Weap) != None)
	{
		//turrets now have different firemodes when (un)mounted, so we'll be setting params to the default from now on
		//BallisticWeapon(Weap).CurrentWeaponMode =		WeaponMode;
		BallisticWeapon(Weap).ParamsClasses[BallisticWeapon(Weap).GameStyleIndex].static.OverrideFireParams(BallisticWeapon(Weap),0);
		BallisticWeapon(Weap).MagAmmo =					MagAmmoAmount;
		//BallisticWeapon(Weap).GenerateLayout(LayoutIndex);
		//BallisticWeapon(Weap).GenerateCamo(CamoIndex);
		BallisticWeapon(Weap).InitWeaponFromTurret(self);
	}
//	Weap.AddAmmo(AmmoAmount[0]-Weap.AmmoAmount(0), 0);
//	Weap.AddAmmo(AmmoAmount[1]-Weap.AmmoAmount(1), 1);
}
// Turret is being abandoned and weapon destroyed. Chance to save important info about the weapon.
function SaveTurretWeaponInfo()
{
	if (Weapon != None)
		InitDeployedTurretFor(Weapon);
}

function UpdateWeaponRotation()
{
    local rotator HeadRot, NeckRot;

	if (Weapon != None)
	{
		NeckRot.Yaw = -GunRotation.Yaw;
		HeadRot.Pitch = -GunRotation.Pitch;

		NeckRot.Yaw -= WeaponPivot.Yaw;
		HeadRot.Pitch -= WeaponPivot.Pitch;

		if (Weapon.Hand < 0)
			NeckRot.Yaw = 0 - NeckRot.Yaw;
		Weapon.SetBoneRotation(PivotBone, NeckRot);
		Weapon.SetBoneRotation(GunBone, HeadRot);
	}
}

function PreBeginPlay()
{
	Super(Pawn).PreBeginPlay();
	MyUseTrigger = Spawn(class'BallisticTurretTrigger',self,,Location-vector(Rotation)*60);
	LastUsedTime = Level.TimeSeconds;
	class'BCTurretList'.static.AutoInitTurret(self);
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
	if (Weapon != None)
		Weapon.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType );
}

function GiveWeapon(string aClassName )
{
	local class<Weapon> WeaponClass;
	local Weapon NewWeapon;

	WeaponClass = class<Weapon>(DynamicLoadObject(aClassName, class'Class'));

	if( FindInventoryType(WeaponClass) != None )
		return;
	newWeapon = Spawn(WeaponClass,,,Location);
	if( newWeapon != None )
	{
		if (BallisticWeapon(newWeapon) != None)
		{
			BallisticWeapon(newWeapon).GenerateLayout(LayoutIndex);
			BallisticWeapon(newWeapon).GenerateCamo(CamoIndex);
		}
		newWeapon.GiveTo(self);
	}
	InitTurretWeapon(newWeapon);
}

function AddDefaultInventory()
{
	if (Weapon == None)
	{
		GiveWeapon(WeaponClassName);
	}
	else
	{
		Weapon.GiveAmmo(0,None, false);
		Weapon.GiveAmmo(1,None, false);
	}
	
	/*
	if ( Controller != None )
		Controller.ClientSwitchToBestWeapon();
	*/
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	GoalYawBounds.Min = Min(GunYawBounds.Min, CamYawBounds.Min);
	GoalYawBounds.Max = Max(GunYawBounds.Max, CamYawBounds.Max);
	GoalPitchBounds.Min = Min(GunPitchBounds.Min, CamPitchBounds.Min);
	GoalPitchBounds.Max = Max(GunPitchBounds.Max, CamPitchBounds.Max);
}

function rotator BotError ()
{
	local float f;
	if (level.TimeSeconds >= NextBotReaimTime)
	{
		f = (frand()*2.0-1.0) * (256.0 + 4096.0 * ( 1.0 - AIController(Controller).Skill / 6.0) );
		BotAimError.yaw = f;
		f = (frand()*2.0-1.0) * (256.0 + 4096.0 * ( 1.0 - AIController(Controller).Skill / 6.0) );
		BotAimError.pitch = f;
		NextBotReaimTime = level.TimeSeconds + 0.5 + frand();
	}
	return BotAimError;
}

function BotUpdateAcceleration(float DT)
{
    local Rotator R;

	if (Controller.Target != None)
	{
		// FIXME: Add bot abandon if gets bored...
		R = normalize(rotator(Controller.Target.Location - (Location + EyePosition())) - Rotation);
		if (R.Yaw < GunYawBounds.Min || R.Yaw > GunYawBounds.Max || R.Pitch < GunPitchBounds.Min || R.Pitch > GunPitchBounds.Max)
		{
			KDriverLeave(false);
		}
		GoalRotation = R + BotError();
//		GoalRotation = normalize(rotator(Controller.Target.Location - (Location + EyePosition())) - Rotation) + BotError();
	}
	else if (Controller.Focus != None)
		GoalRotation = normalize(rotator(Controller.Focus.Location - (Location + EyePosition())) - Rotation) + BotError();
	else
		GoalRotation = normalize(rotator(Controller.FocalPoint - (Location + EyePosition())) - Rotation) + BotError();
}

function UpdateRocketAcceleration(float DT, float YawChange, float PitchChange)
{
    local rotator TempRot;

	if (AIController(Controller) == None)
	{
		GoalRotation.Yaw = Clamp(GoalRotation.Yaw + DT * YawChange * YawSpeed, GoalYawBounds.Min, GoalYawBounds.Max) ;
		GoalRotation.Pitch = Clamp(GoalRotation.Pitch + DT * PitchChange * PitchSpeed, GoalPitchBounds.Min, GoalPitchBounds.Max);
		GoalRotation += SentViewRotation;
	}
	else
		BotUpdateAcceleration(DT);

	if (!bDriverOutOfRange || Normal(Driver.Location - Location) Dot Vector(Rotation+GoalRotation) < Normal(Driver.Location - Location) Dot vector(Rotation+CameraDirection))
	{
		GunRotation.Yaw += Clamp(GoalRotation.Yaw - GunRotation.Yaw, DT * -GunYawSpeed, DT * GunYawSpeed);
		GunRotation.Yaw = Clamp(GunRotation.Yaw, GunYawBounds.Min, GunYawBounds.Max);

		CameraRotation.Yaw += Clamp(GoalRotation.Yaw - CameraRotation.Yaw, DT * -CamYawSpeed, DT * CamYawSpeed);
		CameraRotation.Yaw = Clamp(CameraRotation.Yaw, CamYawBounds.Min, CamYawBounds.Max);

		TempRot.Yaw = CameraDirection.Yaw + Clamp(GunRotation.Yaw - CameraDirection.Yaw, DT * -CamTrackYawSpeed, DT * CamTrackYawSpeed);
	}
	GunRotation.Pitch += Clamp(GoalRotation.Pitch - GunRotation.Pitch, DT * -GunPitchSpeed, DT * GunPitchSpeed);
	GunRotation.Pitch = Clamp(GunRotation.Pitch, GunPitchBounds.Min, GunPitchBounds.Max);

	UpdateSimulatedGunRotation();
	UpdateWeaponRotation();

	CameraRotation.Pitch += Clamp(GoalRotation.Pitch - CameraRotation.Pitch, DT * -CamPitchSpeed, DT * CamPitchSpeed);
	CameraRotation.Pitch = Clamp(CameraRotation.Pitch, CamPitchBounds.Min, CamPitchBounds.Max);

	TempRot.Pitch = CameraDirection.Pitch + Clamp(GunRotation.Pitch - CameraDirection.Pitch, DT * -CamTrackPitchSpeed, DT * CamTrackPitchSpeed);
	if (FastTrace(Location + class'BUtil'.static.AlignedOffset(Rotation+TempRot, CameraOffset) + CameraElevation * vect(0,0,1), Location + CameraElevation * vect(0,0,1)))
	{
		CameraDirection = TempRot;
	}

	if (AIController(Controller) == None)
		Controller.SetRotation(CameraRotation + Rotation);
	// GunRotation must be sent from here for listenservers
	if (level.NetMode == NM_ListenServer)
		SendGunRotationToClients();
	// Server needs to know the new gunrotation
	else if (Role < ROLE_Authority && IsLocallyControlled())
	{
		//log("UpdateRocketAcceleration, GunRotation:"@GunRotation);
		//log("Base rotation:"@Rotation);
		ServerTurretRotation(GunRotation.Pitch, GunRotation.Yaw);
	}
}
// Compress gun rotation and send to clients
function SendGunRotationToClients()
{
	local float f;
	f = ((float(GunRotation.Yaw) + 32768.0) / 65536) * 254.0;
	GunRotationYaw = f;
	f = ((float(GunRotation.Pitch) + 32768.0) / 65536) * 254.0;
	GunRotationPitch = f;
}
// Receive gun rotation from owning client server
function ServerTurretRotation(int GunPitch, int GunYaw)
{
	//log("Server Turret Rotation");
	GunRotation.Pitch = GunPitch;
	GunRotation.Yaw = GunYaw;
	//log("NewGunRot:"@GunRotation);
	//log("Base rotation:"@Rotation);
	// Send it on to the other clients
	SendGunRotationToClients();
	// Apply new gun rotation so local player can see it
	if (level.NetMode != NM_dedicatedServer && bDriving)
		UpdateSimulatedGunRotation();
}
// Apply rotation settings for appearance
simulated function UpdateSimulatedGunRotation()
{
    local rotator HeadRot, NeckRot;

	NeckRot.Yaw = -GunRotation.Yaw;
	HeadRot.Pitch = -GunRotation.Pitch;

	SetBoneRotation(PivotBone, NeckRot);
	SetBoneRotation(GunBone, HeadRot);
}

simulated event Tick(float DT)
{
    local float DriverXYDistance, DriverZDistance, f;
    local vector DriverPos;
    local rotator newRot;

	Super.Tick(DT);

	
	if (AIController(Controller) != None)
	{
		if (Weapon!=None && !Weapon.HasAmmo())
		{
			BotsNextDesireTime = level.timeseconds + 60;
			KDriverLeave(false);
			return;
		}
		else
			UpdateRocketAcceleration(DT, 0, 0);
	}

	// Non-owning clients use the gun rotation from server
	if (Role < ROLE_Authority && !IsLocallyControlled())
	{
		f = (float(GunRotationYaw)/254.0) * 65536 - 32768;
		GunRotation.Yaw = f;
		f = (float(GunRotationPitch)/254.0) * 65536 - 32768;
		GunRotation.Pitch = f;

		UpdateSimulatedGunRotation();
	}
	
	//Azarael log - arm direction code is here
	if (Driver != None && bDriving)
	{
		if (level.netMode != NM_DedicatedServer)
		{




			newRot = Rotator(LeftHandlePosition() - Driver.GetBoneCoords('lfarm').Origin);
			Driver.SetBoneDirection('lfarm', newRot,, 1.0, 1);
			newRot.Roll += 32768;
			Driver.SetBoneDirection(Driver.GetOffHandBoneFor(None), newRot,, 1.0, 1);

			newRot = Rotator(RightHandlePosition() - Driver.GetBoneCoords('rfarm').Origin);
			Driver.SetBoneDirection('rfarm', newRot,, 1.0, 1);

			Driver.SetBoneDirection(Driver.GetWeaponBoneFor(None), newRot,, 1.0, 1);
		}

		DriverPos = DriverPosition();
		DriverXYDistance = VSize((Driver.Location - DriverPos) * vect(1,1,0));
		DriverZDistance = Driver.Location.Z - Location.Z;
		if (Role == ROLE_Authority && (DriverXYDistance > 120 || DriverZDistance > 60 || DriverZDistance < -60))
		{
			KDriverLeave(true);
			return;
		}
		if (IsLocallyControlled() && (DriverXYDistance > 80/* || DriverZDistance > 60 || DriverZDistance < -80*/))
		{
			bDriverOutOfRange=true;
			Driver.Acceleration = Normal(DriverPos - Driver.Location) * 300;
			Driver.Acceleration.Z = 0;
		}
		else if (DriverXYDistance > 24)
		{
			bDriverOutOfRange=false;
			Driver.Acceleration = Normal(DriverPos - Driver.Location) * 300;
			Driver.Acceleration.Z = 0;
		}
		else
		{
			bDriverOutOfRange=false;
			Driver.Acceleration.X = 0;
			Driver.Acceleration.Y = 0;
		}
		if (Driver.bIsCrouched && (Driver.Location.Z+Driver.EyeHeight) < Location.Z+16)
			Driver.ShouldCrouch(false);
		else if (!Driver.bIsCrouched && (Driver.Location.Z+Driver.EyeHeight) > Location.Z+16)
			Driver.ShouldCrouch(true);

		if (!Driver.bPhysicsAnimUpdate)
			Driver.bPhysicsAnimUpdate=true;

		if (IsLocallyControlled())
			Driver.FaceRotation(Rotation+CameraRotation, DT);
		else
			Driver.FaceRotation(Rotation+GunRotation, DT);
	}
}

simulated function vector EyePosition()
{
	if (IsLocallyControlled())
	{
		if (AIController(Controller) != None)
			return CameraElevation * vect(0,0,1);
		return class'BUtil'.static.AlignedOffset(Rotation+CameraDirection, CameraOffset) + CameraElevation * vect(0,0,1)/* + GetBoneCoords(GunBone).Origin*/;
	}
	else
		return class'BUtil'.static.AlignedOffset(Rotation+GunRotation, CameraOffset) + CameraElevation * vect(0,0,1)/* + GetBoneCoords(GunBone).Origin*/;
}

simulated function vector RightHandlePosition()
{
	return GetBoneCoords(RightHandleBone).Origin;
//	return Location + vector(Rotation+CameraDirection) * 40 + 30 * vect(0,0,1);
}
simulated function vector LeftHandlePosition()
{
	return GetBoneCoords(LeftHandleBone).Origin;
}
simulated function vector DriverPosition()
{
	local Vector V;
	if (IsLocallyControlled())
	{
		V = Vector(Rotation+CameraDirection) * -DriverBackOff;
		V.Z = 0;
		Return Location + V + class'BUtil'.static.AlignedOffset(Rotation+CameraDirection, DriverOffset);
	}
	else
	{
		V = Vector(Rotation+GunRotation) * -DriverBackOff;
		V.Z = 0;
		Return Location + V + class'BUtil'.static.AlignedOffset(Rotation+GunRotation, DriverOffset);
	}
}
simulated function rotator GetViewRotation()
{
	return Rotation + GunRotation;
}

simulated function vector CalcDrawOffset(inventory Inv)
{
	if (Inv.DrawScale != DrawScale)
		return vect(0,0,1) * ((CollisionHeight * (Inv.DrawScale/DrawScale)) - CollisionHeight);
	return vect(0,0,0);
}

function bool NeedToTurn(vector targ)
{
	return !(Normal(targ-(Location+EyePosition())) Dot vector(Rotation+GunRotation) > 0.98);
}

function UndeployTurret ()
{
	local Weapon W;
	local class<BallisticWeapon> WC;
	local BallisticTurretIntermediary BTI;

	if (bNoUndeploy)
		return;

	OldDriver = Driver;
	if (!KDriverLeave(false))
		return;

	if (OldDriver != None)
	{
		WC = class<BallisticWeapon>(DynamicLoadObject(UndeployedWeaponName, class'class'));
	 	W = Weapon(OldDriver.FindInventoryType(WC));
		if (W != None)
		{
			W.AddAmmo(MagAmmoAmount, 0);
			Destroy();
			return;
		}
		
		if (Level.NetMode == NM_Standalone) //single player worked fine
		{
			W = spawn(WC,OldDriver,,,rot(0,0,0));
			if (W != None)
			{
				if (BallisticWeapon(W) != None)
				{
					BallisticWeapon(W).GenerateLayout(LayoutIndex);
					BallisticWeapon(W).GenerateCamo(CamoIndex);
				}
				W.GiveTo(OldDriver);

				InitUndeployedWeapon(W);
				Destroy();
			}
		}
		
		else
		{
			BTI = spawn(class'BallisticTurretIntermediary', OldDriver.Controller);
			BTI.myPawn = OldDriver;
			BTI.GunClass = WC;
			BTI.MagAmmo = MagAmmoAmount;
			BTI.LayoutIndex = LayoutIndex;
			BTI.CamoIndex = CamoIndex;
			BTI.TurretAmmoAmount = AmmoAmount[0];
			BTI.WeaponMode = WeaponMode;
			if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
				GotoState('NetTrapped');
			else
				Destroy();
		}
	}
}

state NetTrapped
{
	function BeginState()
	{
		bAlwaysRelevant=True;
		bHidden=true;
		SetTimer(0.15, false);
	}
	event Timer()
	{
		Destroy();
	}
}

function PossessedBy(Controller C)
{
	super.PossessedBy( C );
	
	LastUsedTime = Level.TimeSeconds;
	CheckTurretLimit();
	
	NetUpdateTime = Level.TimeSeconds - 1;
	bStasis = false;
	C.Pawn	= Self;
	AddDefaultInventory();
	
	if ( Weapon != None )
	{
		Weapon.NetUpdateTime = Level.TimeSeconds - 1;
		Weapon.Instigator = Self;
		PendingWeapon = None;
		InitTurretWeapon(Weapon);
		Weapon.BringUp();
	}	
}

function UnPossessed()
{
	if ( Weapon != None )
	{
		Weapon.PawnUnpossessed();
		Weapon.ImmediateStopFire();
		Weapon.ServerStopFire( 0 );
		Weapon.ServerStopFire( 1 );
	}
	
	SaveTurretWeaponInfo();
	
	Level.Game.DiscardInventory( Self );
	
	LastUsedTime = Level.TimeSeconds;

	NetUpdateTime = Level.TimeSeconds - 1;
	super.UnPossessed();
}

function Actor GetBestEntry(Pawn P)
{
	if (MyUseTrigger != None)
		return MyUseTrigger;
	return self;
}

simulated event DrivingStatusChanged()
{
	super.DrivingStatusChanged();

	if (bDriving)
	{
		OldDriver = Driver;
		if (IsLocallyControlled())
		{
			if (Driver != None)
			{
				Driver.Controller = Controller;
				Driver.PlayerReplicationInfo = Controller.PlayerReplicationInfo;
			}
			if (Weapon != None)
			{
				PendingWeapon = None;
				Weapon.BringUp();
			}
			
			//else if (PlayerController(Controller)!=None)
			//	PlayerController(Controller).SwitchToBestWeapon();
		}
		if (Driver != None)
		{
			Driver.bNoWeaponFiring = true;
			Driver.bPhysicsAnimUpdate = true;
			Driver.bIgnoreForces=false;
		}
	}
	else
	{
		SetAbandoned();
		if (OldDriver != None)
		{
			OldDriver.bNoWeaponFiring = false;

			OldDriver.SetBoneDirection('lfarm', Rotation,, 0, 0);
			OldDriver.SetBoneDirection(OldDriver.GetOffHandBoneFor(None), Rotation,, 0, 0);
			OldDriver.SetBoneDirection('rfarm', Rotation,, 0, 0);
			OldDriver.SetBoneDirection(OldDriver.GetWeaponBoneFor(None), Rotation,, 0, 0);
			
			/*
			if (OldDriver != None && OldDriver.IsLocallyControlled() && OldDriver.Weapon == None && OldDriver.PendingWeapon == None)
				OldDriver.Controller.SwitchToBestWeapon();
			*/
		}
	}
}


simulated function ClientKDriverEnter(PlayerController PC)
{
	PC.bFreeCamera = true;

	if (Driver != None)
	{
		Driver.Controller = PC;
		Driver.PlayerReplicationInfo = PC.PlayerReplicationInfo;
	}

	super.ClientKDriverEnter(PC);

	// force controller here, because it's not replicated yet...
	PC.Pawn = Self;
	Controller = PC;
	SetOwner( PC );
	
	if ( PC != None )
	{
		if (TurretFOV > 0)
			PC.DesiredFOV = TurretFOV;
	}
}

simulated function ClientKDriverLeave(PlayerController PC)
{
	PC.bFreeCamera = false;

	if (Driver != None)
		Driver.bNoWeaponFiring = false;
		
	if ( PC != None )
	{
		if (TurretFOV > 0)
			PC.DesiredFOV = PC.DefaultFOV;
	}
		
	if (BallisticWeapon(Weapon) != None)
	{
		if(BallisticWeapon(Weapon).bScopeView)
		{
			PC.EndZoom();
		}
	}

	super.ClientKDriverLeave(PC);
}

function KDriverEnter(Pawn P)
{
	local Controller C;

	bDriving = True;
	StuckCount = 0;

	// We don't have pre-defined exit positions here, so we use the original player location as an exit point
	if ( !bRelativeExitPos )
	{
		PlayerEnterredRotation = P.Rotation;
		ExitPositions[0] =  P.Location + Vect(0,0,16);
	}

	// Set pawns current controller to control the vehicle pawn instead
	C = P.Controller;
	if ( !bCanCarryFlag && (C.PlayerReplicationInfo.HasFlag != None)  )
		P.DropFlag();

	Driver = P;
	Driver.StartDriving( Self );

	Driver.ShouldCrouch(true);
	//Overwriting StartDriving() changes...

	// Disconnect PlayerController from Driver and connect to SVehicle.
	C.bVehicleTransition = true; // to keep Bots from doing Restart()
	C.Unpossess();
	Driver.SetOwner( Self ); // This keeps the driver relevant.
	C.Possess( Self );
	C.bVehicleTransition = false;

	SetPhysics(default.Physics);

	DrivingStatusChanged();

	if ( PlayerController(C) != None )
	{
		if (TurretFOV > 0)
			PlayerController(C).DesiredFOV = TurretFOV;
		VehicleLostTime = 0;
	}

	Driver.Controller = C;
	Driver.PlayerReplicationInfo = C.PlayerReplicationInfo;

	Driver.bNoWeaponFiring = true;

	Level.Game.DriverEnteredVehicle(self, P);
}

function bool PlaceExitingDriver()
{
	if ( Driver == None )
		return false;

	return true;
}

event bool KDriverLeave( bool bForceLeave )
{
	local Controller C;
	local PlayerController	PC;
	local bool havePlaced;

	if( !bForceLeave && !Level.Game.CanLeaveVehicle(self, Driver) )
		return false;

	if ( (PlayerReplicationInfo != None) && (PlayerReplicationInfo.HasFlag != None) )
		Driver.HoldFlag(PlayerReplicationInfo.HasFlag);

	// Do nothing if we're not being driven
	if (Controller == None )
		return false;

	MyUseTrigger.SetLocation(Location-vector(Rotation+GunRotation)*vect(1,1,0)*60);
	// Before we can exit, we need to find a place to put the driver.
	// Iterate over array of possible exit locations.

	if ( (Driver != None) && (!bRemoteControlled || bHideRemoteDriver) )
    {
	    Driver.bHardAttach = false;
	    Driver.bCollideWorld = true;
	    Driver.SetCollision(true, true);
	    havePlaced = PlaceExitingDriver();

	    // If we could not find a place to put the driver, leave driver inside as before.
	    if (!havePlaced && !bForceLeave )
	    {
	        Driver.bHardAttach = true;
	        Driver.bCollideWorld = false;
	        Driver.SetCollision(false, false);
	        return false;
	    }
	}

	bDriving = False;

	// Reconnect Controller to Driver.
	C = Controller;
	if (C.RouteGoal == self)
		C.RouteGoal = None;
	if (C.MoveTarget == self)
		C.MoveTarget = None;
	C.bVehicleTransition = true;
	Controller.UnPossess();

	if ( (Driver != None) && (Driver.Health > 0) )
	{
		Driver.SetOwner( C );
		C.Possess( Driver );

		PC = PlayerController(C);
		if ( PC != None )
			PC.ClientSetViewTarget( Driver ); // Set playercontroller to view the person that got out

		Driver.StopDriving( Self );
	}
	C.bVehicleTransition = false;

	if ( C == Controller )	// If controller didn't change, clear it...
		Controller = None;

	if ( PlayerController(C) != None )
	{
		if (TurretFOV > 0)
			PlayerController(C).DesiredFOV = PlayerController(C).DefaultFOV;
	}

	//SaveTurretWeaponInfo();
	
	Driver.bNoWeaponFiring = false;
	
	if (BallisticWeapon(Weapon) != None)
	{				
		if(BallisticWeapon(Weapon).bScopeView)
		{
			PC.EndZoom();
		}
	}
	
	Level.Game.DriverLeftVehicle(self, Driver);

	// Car now has no driver
	Driver = None;

	DriverLeft();
	
	// Put brakes on before you get out :)
    Throttle	= 0;
    Steering	= 0;
	Rise		= 0;
	
	AmbientSound = None;
	if (Weapon != None)
		Weapon.AmbientSound = None;


    return true;
}

simulated function SetAbandoned()
{
	GunRotation.Pitch = AbandonedPitch;
	UpdateSimulatedGunRotation();
}

function bool TryToDrive(Pawn P)
{
	if (bNonHumanControl || (PlayerController(P.Controller) == None) || (Driver != None) || (P.DrivenVehicle != None) || !P.Controller.bIsPlayer
	     || P.IsA('Vehicle') || Health <= 0)
		return false;

	// check on ground
	if (P.Physics != PHYS_Walking)
		return false;
		
	// check not too high
	if (MyUseTrigger.Location.Z - CollisionHeight > P.Location.Z + P.EyePosition().Z - MinTurretEyeDepth)
		return false;
	
	// check not too low
	if (MyUseTrigger.Location.Z < P.Location.Z - P.CollisionHeight)
		return false;

	if (VSize((P.Location - MyUseTrigger.Location) * vect(1,1,0)) > 40)
	{
		if (VSize((P.Location - MyUseTrigger.Location) * vect(1,1,0)) > 120)
			return false;
		if (vector(Rotation) Dot Normal(Location - P.Location) < 0.2)
			return false;
	}
	
	if (vector(P.GetViewRotation()) Dot Normal(Location - P.Location) < 0.5)
		return false;

	if( !Level.Game.CanEnterVehicle(self, P) )
		return false;

	// Check vehicle Locking....
	if ( !bTeamLocked || P.GetTeamNum() == Team )
	{
		if ( bEnterringUnlocks && bTeamLocked )
			bTeamLocked = false;

		PlayerController(P.Controller).DesiredFOV = PlayerController(P.Controller).DefaultFOV;
		PlayerController(P.Controller).bZooming = False;
		KDriverEnter( P );
		return true;
	}
	else
	{
		VehicleLocked( P );
		return false;
	}
}

function DriverDied()
{
	SaveTurretWeaponInfo();
	super.DriverDied();
}

simulated function bool StopWeaponFiring()
{
	if ( Weapon == None )
		return false;

//	Weapon.PawnUnpossessed();

	if ( Weapon.IsFiring() )
	{
		if ( Controller != None )
		{
			if ( !Controller.IsA('PlayerController') )
				Weapon.ServerStopFire( Weapon.BotMode );
			else
			{
				Controller.StopFiring();
				Weapon.ServerStopFire( 0 );
				Weapon.ServerStopFire( 1 );
			}
		}
		else
		{
			Weapon.ServerStopFire( 0 );
			Weapon.ServerStopFire( 1 );
		}
		return true;
	}

	return false;
}

//return a value indicating how useful this vehicle is to bots
function float BotDesireability(Actor S, int TeamIndex, Actor Objective)
{
	if (Health <= 0 || Occupied() /*|| (bTeamLocked && !bSameTeam)*/)
		return 0;

	if (Weapon!=None && !Weapon.HasAmmo())
		return 0;

	if (MagAmmoAmount < 1 && AmmoAmount[0] < 1 && AmmoAmount[1] < 1)
		return 0;

	if (bKeyVehicle)
		return 100;

	return ((MaxDesireability * 0.5) + (MaxDesireability * 0.5 * (float(Health) / HealthMax)));
}

simulated function bool PointOfView()
{
	if (!bAllowViewChange)
		return false;

	if (PlayerController(Controller) != None)
		return PlayerController(Controller).bBehindView;
	return default.bDesiredBehindView;
}

simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
	Canvas.SetDrawColor(255,128,0);
	Canvas.DrawText("GunRotation "$GunRotation);
	Canvas.SetPos(4,YPos);

	super.DisplayDebug(Canvas, YL, YPos);
}

defaultproperties
{
	MinTurretEyeDepth=10
     GunYawBounds=(Min=-16384.000000,Max=16384.000000)
     GunPitchBounds=(Min=-8192.000000,Max=11000.000000)
     CamYawBounds=(Min=-20000.000000,Max=20000.000000)
     CamPitchBounds=(Min=-10000.000000,Max=14000.000000)
     YawSpeed=40.000000
     PitchSpeed=40.000000
     GunYawSpeed=12000.000000
     GunPitchSpeed=8192.000000
     CamTrackYawSpeed=10000.000000
     CamTrackPitchSpeed=10000.000000
     CamYawSpeed=32768.000000
     CamPitchSpeed=32768.000000
     AbandonedPitch=-5000
     TurretFOV=80.000000
     CameraOffset=(X=-30.000000,Z=15.000000)
     CameraElevation=15.000000
     GunBone="Gun"
     PivotBone="Pivot"
     DriverOffset=(X=-40.000000)
     DriverBackOff=20.000000
     RightHandleBone="RightHandle"
     LeftHandleBone="LeftHandle"
     bRelativeExitPos=False
     bDefensive=True
     bRemoteControlled=True
     bDesiredBehindView=False
     DriveAnim="Idle_Rest"
     VehicleNameString="Ballistic Turret"
     MaxDesireability=2.000000
     bIgnoreForces=True
     bServerMoveSetPawnRot=False
     bStationary=True
     bNoTeamBeacon=True
     BaseEyeHeight=10.000000
     EyeHeight=10.000000
     LandMovementState="PlayerTurreting"
     WaterMovementState="PlayerTurreting"
     bStasis=False
     bIgnoreEncroachers=True
     bReplicateInstigator=True
     bNetInitialRotation=True
     NetPriority=3.000000
     bGameRelevant=True
     SoundRadius=100.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=5000.000000
     CollisionRadius=24.000000
     CollisionHeight=22.000000
     bCollideWorld=False
     bBlockActors=False
     bBlockZeroExtentTraces=False
     bBlockNonZeroExtentTraces=False
     bRotateToDesired=False
}
