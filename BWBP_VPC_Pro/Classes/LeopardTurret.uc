//=============================================================================
// The Main gun for the TMV Leopard.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.

// Additional work by Nolan "Dark Carnivour" Richert, who made the code that gives the turret a rotate sound.
//=============================================================================
class LeopardTurret extends ONSWeapon
	placeable
	config(BWBP_VPC_Pro);

var				vector 					OldDir;
var				rotator 				OldRot;
var(Turret) 	Sound 					TurretTurnSound;
var(Turret) 	float					VelocitySpreadFactor;
var   			float					TurretStopTurnSoundTime;
var   			float					DT;
var   			int						LastTurretYaw;
var   			float					InitialSpread;
var 			ShortLeopardSmoke		ShortSmoke[20];
var 			LongLeopardSmoke		LongSmoke[20];
var(Smoke)		int						ShortSmokerCount, SmokerCount;
var(Smoke) 		name					SmokeBoneNames[20], ShortSmokeBoneNames[20];
var(Smoke)		config bool				bAllowSmoke;

function byte BestMode()
{
	return 0;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	InitialSpread = Spread; // Gets the Initial Spread value so that setting the spread doesn't multiply it's value.

	OldDir = Vector(CurrentAim);
}
// Sets the smokers to on or off depending on function's status.
simulated function ToggleSmokers(bool bOn)
{
	local int i;

	if(bOn && bAllowSmoke)
	{
		for(i=0;i < ShortSmokerCount;i++)
			ShortSmoke[i].ActivateSmoke(true);

		for(i=0;i < SmokerCount;i++)
			LongSmoke[i].ActivateSmoke(true);
	}

	if(!bOn && bAllowSmoke)
	{
		for(i=0;i < ShortSmokerCount;i++)
			ShortSmoke[i].ActivateSmoke(false);

		for(i=0;i < SmokerCount;i++)
			LongSmoke[i].ActivateSmoke(false);
	}
}

// Spawns all the smokers, attaches them to bones, and sets their color to the owner's team color.
simulated function SpawnSmokers(byte OwnerTeam)
{
	local int i;

	if(bAllowSmoke)
	{
		for(i=0;i < ShortSmokerCount;i++)
		{
    		if (ShortSmoke[i] != None)
            	ShortSmoke[i].Destroy();

    		ShortSmoke[i] = spawn(class'ShortLeopardSmoke');

			ShortSmoke[i].SetTeamColor(OwnerTeam);

			AttachToBone(ShortSmoke[i], ShortSmokeBoneNames[i]);
		}
		for(i=0;i < SmokerCount;i++)
		{
    		if (LongSmoke[i] != None)
            	LongSmoke[i].Destroy();

    		LongSmoke[i] = spawn(class'LongLeopardSmoke');

			LongSmoke[i].SetTeamColor(OwnerTeam);

			AttachToBone(LongSmoke[i], SmokeBoneNames[i]);
		}
	}
}
// Increases the size of the shorter smoke as the vehicle gets faster.
simulated function GetSmokeScale(float Size)
{
	local int i;

	if(bAllowSmoke)
		for(i=0;i < ShortSmokerCount;i++)
			ShortSmoke[i].SmokeScale(Size);
}

// Destroys the Smoke.
simulated function Destroyed()
{
    local int i;

	Super.Destroyed();

	if (Level.NetMode != NM_DedicatedServer)
	{
		for(i=0;i < ShortSmokerCount;i++)
			if (ShortSmoke[i] != None)
				ShortSmoke[i].Destroy();

		for(i=0;i < SmokerCount;i++)
			if (LongSmoke[i] != None)
				LongSmoke[i].Destroy();
	}
}

// This cool function ensures that the shells will allways fire in the direction the Leopard's turret is facing.
function Tick(float Delta)
{
	local Rotator R;
	local int i;
	local xPawn P;
	local vector NewDir, PawnDir;
    local coords WeaponBoneCoords;


    Super.Tick(Delta);

	R = GetBoneRotation(YawBone);
	R = Normalize(R - Rotation);
	if (Abs(R.Yaw - LastTurretYaw) / DT > 2048)
		TurretStopTurnSoundTime = level.Timeseconds + 0.15; // Sets some stuff to give the turret a rotate sound-
	LastTurretYaw = R.Yaw;									//- Thanks to  Nolan "Dark Carnivour" Richert.

	if (level.Timeseconds >= TurretStopTurnSoundTime)
		AmbientSound = None;
	else
		AmbientSound = TurretTurnSound;

	if ( (Role == ROLE_Authority) && (Base != None) )
	{
	    WeaponBoneCoords = GetBoneCoords(YawBone);
		NewDir = WeaponBoneCoords.XAxis;
		if ( (Vehicle(Base).Controller != None) && (NewDir.Z < 0.9) )
		{
			for ( i=0; i<Base.Attached.Length; i++ )
			{
				P = XPawn(Base.Attached[i]);
				if ( (P != None) && (P.Physics != PHYS_None) && (P != Vehicle(Base).Driver) )
				{
					PawnDir = P.Location - WeaponBoneCoords.Origin;
					PawnDir.Z = 0;
					PawnDir = Normal(PawnDir);
					if ( ((PawnDir.X <= NewDir.X) && (PawnDir.X > OldDir.X))
						|| ((PawnDir.X >= NewDir.X) && (PawnDir.X < OldDir.X)) )
					{
						if ( ((PawnDir.Y <= NewDir.Y) && (PawnDir.Y > OldDir.Y))
							|| ((PawnDir.Y >= NewDir.Y) && (PawnDir.X < OldDir.Y)) )
						{
							P.SetPhysics(PHYS_Falling);
							P.Velocity = WeaponBoneCoords.YAxis;
							if ( ((NewDir - OldDir) Dot WeaponBoneCoords.YAxis) < 0 )
								P.Velocity *= -1;
							P.Velocity = 500 * (P.Velocity + 0.3*NewDir);
							P.Velocity.Z = 200;
						}
					}
				}
			}
		}
		OldDir = NewDir;
	}
}
// This cool function ajusts the 'spread' depending on the speed of the vehicle
simulated function SetSpread(float VehicleSpeed)
{
	Spread = InitialSpread + (VehicleSpeed / VelocitySpreadFactor);
}

// Muzzle flash stuff.
simulated function FlashMuzzleFlash()
{
	Super.FlashMuzzleFlash();

	if(Level.NetMode != NM_DedicatedServer && EffectEmitter != None)
		AttachToBone(EffectEmitter, WeaponFireAttachmentBone);
}

defaultproperties
{
     TurretTurnSound=Sound'BWBP_Vehicles_Sound.Leopard.Leo-TurretMove'
     VelocitySpreadFactor=3000.000000
     ShortSmokerCount=6
     SmokerCount=8
     SmokeBoneNames(0)="SmokeBone0"
     SmokeBoneNames(1)="SmokeBone1"
     SmokeBoneNames(2)="SmokeBone2"
     SmokeBoneNames(3)="SmokeBone3"
     SmokeBoneNames(4)="SmokeBone4"
     SmokeBoneNames(5)="SmokeBone5"
     SmokeBoneNames(6)="SmokeBone6"
     SmokeBoneNames(7)="SmokeBone7"
     ShortSmokeBoneNames(0)="SmokeBone8"
     ShortSmokeBoneNames(1)="SmokeBone9"
     ShortSmokeBoneNames(2)="SmokeBone10"
     ShortSmokeBoneNames(3)="SmokeBone11"
     ShortSmokeBoneNames(4)="SmokeBone12"
     ShortSmokeBoneNames(5)="SmokeBone13"
     bAllowSmoke=True
     YawBone="BaseBone"
     PitchBone="BarrelBone"
     PitchUpLimit=7000
     PitchDownLimit=64000
     WeaponFireAttachmentBone="FireBone"
     RotationsPerSecond=0.080000
     Spread=0.005000
     RedSkin=Texture'BWBP_Vehicles_Tex.Leopard.LeopardTurretRed'
     BlueSkin=Texture'BWBP_Vehicles_Tex.Leopard.LeopardTurretBlue'
     FireInterval=4.500000
     EffectEmitterClass=Class'BWBP_VPC_Pro.LeopardTankFireEffect'
     FireSoundClass=Sound'BWBP_Vehicles_Sound.Leopard.Leo-Fire'
     FireSoundVolume=1024.000000
     FireSoundRadius=800.000000
     FireSoundPitch=96.000000
     AltFireSoundClass=Sound'BWBP_Vehicles_Sound.Leopard.Leo-Fire'
     FireForce="Explosion05"
     ProjectileClass=Class'BWBP_VPC_Pro.LeopardShell'
     ShakeRotMag=(Z=250.000000)
     ShakeRotRate=(Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Z=4.000000)
     ShakeOffsetRate=(Z=200.000000)
     ShakeOffsetTime=10.000000
     AIInfo(0)=(bTrySplash=True,bLeadTarget=True,WarnTargetPct=0.750000,RefireRate=0.800000)
     Mesh=SkeletalMesh'BWBP_Vehicles_Anim.LeopardTurret'
     ScaleGlow=0.750000
     bFullVolume=True
     SoundVolume=75
     SoundRadius=50.000000
}
