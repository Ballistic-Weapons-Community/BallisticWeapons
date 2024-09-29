//=============================================================================
// DragonsToothSword.
//
// A very large and powerful sword capable of one hit kills.
// It is incredibly strong but attacks slower than all other melee weapons.
// Has a secondary lunge capable of extreme damage.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FlameSword extends BallisticMeleeWeapon;

struct DeployableInfo
{
	var class<Actor> 		dClass;
	var float				WarpInTime;
	var int					SpawnOffset;
	var bool				CheckSlope; // should block unless placed on flat enough area
	var string				dDescription; 	//A simple explanation of what this mode does.
};

var DeployableInfo 	AltDeployable;
const 				DeployRange = 256;
var Sound      		ShieldHitSound;

var float			NextShieldCreateTime;

var Sound			LoopAmbientSound;

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	Instigator.AmbientSound = LoopAmbientSound;
	Instigator.SoundVolume = 32;
	Instigator.SoundPitch = 48;
	Instigator.SoundRadius = 128;
	Instigator.bFullVolume = true;
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;

		return true;
	}
	return false;
}

simulated function Destroyed()
{
	if (Instigator.AmbientSound != None)
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
	}

	super.Destroyed();
}	

exec function Offset(int index, int value)
{
	if (Level.NetMode != NM_Standalone)
		return;

	AltDeployable.SpawnOffset = value;
}

//===========================================================================
// OrientToSlope
//
// Returns a rotator with the correct Pitch and Roll values to orient the 
// deployable to the detected HitNormal.
//===========================================================================
function Rotator GetSlopeRotator(Rotator deploy_rotation_yaw, vector hit_normal)
{
	local float pitch_degrees, roll_degrees;
	local Rotator result;
	
	//log("GetSlopeRotator: Input yaw rotator: "$deploy_rotation_yaw$" HitNormal: "$hit_normal);
	
	// get hitnormal orientation as global coordinate relative to direction of deployable
	hit_normal = hit_normal << deploy_rotation_yaw;
	
	//log("GetSlopeRotator: Rotated HitNormal: "$hit_normal);
	
	// x value determines pitch adjustment and is equal to the sine of the pitch angle
	// if x is positive, we need to pitch down (negative)
	pitch_degrees = Asin(hit_normal.X) * 180/pi;
	
	//log("GetSlopeRotator: Pitch degrees: "$pitch_degrees);
	
	result.Pitch = -(pitch_degrees * (65536 / 360));
	
	// y factor is the same for roll, but directionality is a problem (I think right is positive)
	roll_degrees = Asin(hit_normal.Y) * 180/pi;
	
	//log("GetSlopeRotator: Roll degrees: "$roll_degrees);

	result.Roll = (roll_degrees * (65536 / 360));
	
	//log("GetSlopeRotator: Result: "$result);
		
	return result;
}

//===========================================================================
// XAVEDIT
// Notify_BarrierDeploy
//
// Responsible for spawning the pre-warp effect for any given deployable.
// Traces out from the view to hit something, then does an extent trace to check for room.
// If OK, spawns the pre-warp at the required height.
//===========================================================================
function Notify_BarrierDeploy()
{
	local Actor HitActor;
	local Vector Start, End, HitNorm, HitLoc;
	local FlameSwordPreconstructor FSP;
	
	local Rotator SlopeInputYaw, SlopeRotation;

	if (Level.TimeSeconds < NextShieldCreateTime)
		return; 

	Start = Instigator.Location + Instigator.EyePosition();
	End = Start + vector(Instigator.GetViewRotation()) * DeployRange;
	
	HitActor = Trace(HitLoc, HitNorm, End, Start, true);
	
	if (HitActor == None)
		HitActor = Trace(HitLoc, HitNorm, End - vect(0,0,256), End, true);
		
	if (WrenchDeployable(HitActor) != None && WrenchDeployable(HitActor).OwningController == Instigator.Controller)
	{
		WrenchDeployable(HitActor).bWarpOut=True;
		WrenchDeployable(HitActor).GoToState('Destroying');
		return;
	}
	
	//Safety for mode switch during attack
	/*if (AltDeployable.AmmoReq > Ammo[0].AmmoAmount)
	{
		Instigator.ClientMessage("Not enough charge to warp in"@WeaponModes[0].ModeName$".");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}*/
		
	if (HitActor == None || !HitActor.bWorldGeometry)
	{
		Instigator.ClientMessage("Must target an unoccupied surface.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	if (HitLoc == vect(0,0,0))
	{
		Instigator.ClientMessage("Out of range.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	// Use HitNormal value to attempt to reorient actor.
	SlopeInputYaw.Yaw = Instigator.Rotation.Yaw;
	SlopeRotation = GetSlopeRotator(SlopeInputYaw, HitNorm);
	
	Start = HitLoc + HitNorm; // offset from the floor by 1 unit, it's already normalized
	
	if (!SpaceToDeploy(HitLoc, HitNorm, SlopeRotation, AltDeployable.dClass.default.CollisionHeight, AltDeployable.dClass.default.CollisionRadius))
	{
		Instigator.ClientMessage("Insufficient space for construction.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	SlopeRotation.Yaw = Instigator.Rotation.Yaw;

	NextShieldCreateTime = Level.TimeSeconds + 1;
		
	FSP = Spawn(class'FlameSwordPreconstructor', Instigator, , Start + HitNorm * AltDeployable.dClass.default.CollisionHeight, SlopeRotation);
	
	FSP.GroundPoint = Start + (HitNorm * (AltDeployable.SpawnOffset + AltDeployable.dClass.default.CollisionHeight));

	FSP.Instigator = Instigator;
	FSP.Master = self;
	FSP.Initialize(AltDeployable.dClass,AltDeployable.WarpInTime);
}

//===========================================================================
// SpaceToDeploy
//
// Verifies that there is enough room to spawn the given deployable.
// Traces out from the center in the X and Y directions, 
// corresponding to the collision cylinder.
// 
// Imperfect - but functional enough for this game
//===========================================================================
function bool SpaceToDeploy(Vector hit_location, Vector hit_normal, Rotator slope_rotation, float collision_height, float collision_radius)
{
	local Vector center_point;
	
	// n.b: collision height property is actually half the collision height - do not halve the input value
	center_point = hit_location + hit_normal * collision_height;
	
	return (
	FastTrace(center_point, center_point + collision_radius * (vect(1,0,0) >> slope_rotation)) &&
	FastTrace(center_point, center_point + collision_radius * (vect(-1,0,0) >> slope_rotation)) &&
	FastTrace(center_point, center_point + collision_radius * (vect(0,-1,0) >> slope_rotation)) &&
	FastTrace(center_point, center_point + collision_radius * (vect(0,1,0) >> slope_rotation))
	);
}

/*function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
    local vector HitNormal;
    local float DF;

	if( DamageType.default.bCausedByWorld || HitLocation.Z < Instigator.Location.Z - 22)
        super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);

    else if ( CheckReflect(HitLocation, HitNormal, 0.2) )
    {
		if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bMetallic)
		{
			Damage = Max(Damage, 25);
			PlaySound(ShieldHitSound, SLOT_None);
			Momentum *= 4;
		}
		
		DF = FMin(1, float(Damage)/AimDamageThreshold);
		ApplyDamageFactor(DF);
		ClientPlayerDamaged(255*DF);
		bForceReaim=true;
    }

	else super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}*/

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local class<BallisticDamageType> BDT;

    if (Instigator != InstigatedBy && class<BallisticDamageType>(DamageType) != None)
    {
        BDT = class<BallisticDamageType>(DamageType);

        if (BDT.static.IsDamage(",Flame,"))
        {
            Damage = 0;
            PlaySound(ShieldHitSound, SLOT_None);
			Momentum = vect(0,0,0);    
        }
    }

    super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}


// AI Interface =====
function bool CanAttack(Actor Other)
{
	return true;
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (VSize(B.Enemy.Location - Instigator.Location) > FireMode[0].MaxRange()*1.5)
		return 1;
	Result = FRand();
	if (vector(B.Enemy.Rotation) dot Normal(Instigator.Location - B.Enemy.Location) < 0.0)
		Result += 0.3;
	else
		Result -= 0.3;

	if (Result > 0.5)
		return 1;
	return 0;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 1;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -1;
}
// End AI Stuff =====

defaultproperties
{
	ShieldHitSound=ProceduralSound'WeaponSounds.ShieldGun.ShieldReflection'
	AltDeployable=(dClass=Class'BWBP_OP_Pro.FlameSwordBarrier',WarpInTime=0.0010000,SpawnOffset=18,CheckSlope=False,dDescription="A five-second barrier of infinite durability.")
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_OP_Tex.FlameSword.BWsword_icon_512'
	BigIconCoords=(Y1=40,Y2=240)

	ManualLines(0)="Swings the sword. Inflicts heavy damage and has a long range and wide swing arc."
	ManualLines(1)="Creates a temporary barrier to block all incoming shots, but temporarily removes your hazard shielding."
	ManualLines(2)="Passively grants immunity to fire damage."
	SpecialInfo(0)=(Info="420.0;20.0;-999.0;-1.0;-999.0;0.9;-999.0")
	BringUpSound=(Sound=Sound'BWBP_OP_Sounds.FlameSword.FlameSword-Equip',Volume=0.200000)
	PutDownSound=(Sound=Sound'BWBP_OP_Sounds.FlameSword.FlameSword-Unequip',Volume=0.200000)
	LoopAmbientSound=Sound'BW_Core_WeaponSound.RX22A.RX22A.RX22A-FireLoop'
	bNoMag=True
	GunLength=0.000000
	bAimDisabled=True
	ParamsClasses(0)=Class'FlameSwordWeaponParamsComp'
	ParamsClasses(1)=Class'FlameSwordWeaponParamsClassic'
	ParamsClasses(2)=Class'FlameSwordWeaponParamsRealistic'
	ParamsClasses(3)=Class'FlameSwordWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_OP_Pro.FlameSwordPrimaryFire'
	FireModeClass(1)=Class'BWBP_OP_Pro.FlameSwordSecondaryFire'
	MeleeFireClass=Class'BWBP_OP_Pro.FlameSwordMeleeFire'
	SelectAnim="PulloutFancy"
	SelectAnimRate=1.250000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.PentagramOutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.PentagramInA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=104,R=255,A=160),Color2=(B=0,G=169,R=255,A=67),StartSize1=91,StartSize2=96)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	PutDownTime=0.500000
	BringUpTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	BlockIdleAnim="bLock"	 
	AIRating=0.800000
	CurrentRating=0.800000
	bMeleeWeapon=True
	Description="During Operation: Chalkboard Firefly, UTC troopers had discovered a strange sword being developed in secret in an underground arctic facility by an unknown manufacturer. While having the appearance of a Medieval arming sword, the blade itself seems to be made out of a strange nano-material, and is covered in a bright fire when held. UTC scientists have yet to find out more about the weapon due to resources being tight due to fighting the Skrith. However what has been found is this weapon was intended to be some sort of psionic enhancing focii, capable of shielding the user from explosions and flames alike."
	Priority=12
	HudColor=(G=50)
	CenteredOffsetY=7.000000
	CenteredRoll=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	GroupOffset=5
	PickupClass=Class'BWBP_OP_Pro.FlameSwordPickup'
	AttachmentClass=Class'BWBP_OP_Pro.FlameSwordAttachment'
	IconMaterial=Texture'BWBP_OP_Tex.FlameSword.BWsword_icon_128'
	IconCoords=(X2=127,Y2=31)
	ItemName="PSI-56 Fire Sword"
	Mesh=SkeletalMesh'BWBP_OP_Anim.FlameSword_FPm'
	DrawScale=0.3
	SoundRadius=32.000000
	PlayerViewOffset=(X=5.000000,Y=2.500000,Z=-5.000000)
}
