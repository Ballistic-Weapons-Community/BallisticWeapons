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
	var class<Actor> 	dClass;
	var float				WarpInTime;
	var int					SpawnOffset;
	var bool				CheckSlope; // should block unless placed on flat enough area
	var string				dDescription; 	//A simple explanation of what this mode does.
};

var DeployableInfo AltDeployable;
const DeployRange = 256;
var Sound      	ShieldHitSound;

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
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBPOtherPackSound.Wrench.EnergyStationError', ,1);
		return;
	}*/
		
	if (HitActor == None || !HitActor.bWorldGeometry)
	{
		Instigator.ClientMessage("Must target an unoccupied surface.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBPOtherPackSound.Wrench.EnergyStationError', ,1);
		return;
	}
	
	if (HitLoc == vect(0,0,0))
	{
		Instigator.ClientMessage("Out of range.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBPOtherPackSound.Wrench.EnergyStationError', ,1);
		return;
	}
	
	// Use HitNormal value to attempt to reorient actor.
	SlopeInputYaw.Yaw = Instigator.Rotation.Yaw;
	SlopeRotation = GetSlopeRotator(SlopeInputYaw, HitNorm);
	
	Start = HitLoc + HitNorm; // offset from the floor by 1 unit, it's already normalized
	
	if (!SpaceToDeploy(HitLoc, HitNorm, SlopeRotation, AltDeployable.dClass.default.CollisionHeight, AltDeployable.dClass.default.CollisionRadius))
	{
		Instigator.ClientMessage("Insufficient space for construction.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBPOtherPackSound.Wrench.EnergyStationError', ,1);
		return;
	}
	
	SlopeRotation.Yaw = Instigator.Rotation.Yaw;
		
	FSP = Spawn(class'FlameSwordPreconstructor', Instigator, , Start + HitNorm * AltDeployable.dClass.default.CollisionRadius, SlopeRotation);
	
	FSP.GroundPoint = Start + (HitNorm * (AltDeployable.SpawnOffset + AltDeployable.dClass.default.CollisionRadius));

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

//=====================================================
//			HEAT MANAGEMENT CODE
//=====================================================

function int ManageHeatInteraction(Pawn P, int HeatPerShot)
{
	local XM20HeatManager HM;
	local int HeatBonus;
	
	foreach P.BasedActors(class'XM20HeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'XM20HeatManager',P,,P.Location + vect(0,0,-30));
		HM.SetBase(P);
	}
	
	if (HM != None)
	{
		HeatBonus = HM.Heat;
		if (Vehicle(P) != None)
			HM.AddHeat(HeatPerShot/4);
		else HM.AddHeat(HeatPerShot);
	}
	
	return heatBonus;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = 192;
	Instigator.SoundPitch = 64;
	Instigator.SoundRadius = 768;
	Instigator.bFullVolume = false;
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

        if (BDT.static.IsDamage(",DarkStar,")
        || BDT.static.IsDamage(",Flame,")
        || BDT.static.IsDamage(",Plasma,")
        || BDT.static.IsDamage(",Laser,")
        || BDT.static.IsDamage(",Explode,"))
        {
            Damage = Min(Damage * 0.50, 25);
            PlaySound(ShieldHitSound, SLOT_None);
            Momentum *= 2;    
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
     PlayerSpeedFactor=1.150000
	 ShieldHitSound=ProceduralSound'WeaponSounds.ShieldGun.ShieldReflection'
     AltDeployable=(dClass=Class'BWBPSomeOtherPack.FlameSwordBarrier',WarpInTime=0.0010000,SpawnOffset=18,CheckSlope=False,dDescription="A five-second barrier of infinite durability.")
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBPSomeOtherPackTex.FlameSword.BWsword_icon_512'
     BigIconCoords=(Y1=40,Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ManualLines(0)="Strikes for relatively weak damage"
     ManualLines(1)="Create a temporary barrier to block all incoming shots, but temporarily removes your hazard shielding."
     ManualLines(2)="Passively grants protection from explosions, fire, and other hazardous damage types."
     SpecialInfo(0)=(Info="420.0;20.0;-999.0;-1.0;-999.0;0.9;-999.0")
     BringUpSound=(Sound=Sound'BWBPSomeOtherPackSounds.FlameSword.FlameSword-Equip',Volume=2.000000)
	 PutDOwnSound=(Sound=Sound'BWBPSomeOtherPackSounds.FlameSword.FlameSword-Unequip',Volume=2.000000)
	 //UsedAmbientSound=(Sound=Sound'BallisticSounds2.RX22A.RX22A-AmbientFire')
     MagAmmo=1
     bNoMag=True
     GunLength=0.000000
     bAimDisabled=True
     FireModeClass(0)=Class'BWBPSomeOtherPack.FlameSwordPrimaryFire'
     FireModeClass(1)=Class'BWBPSomeOtherPack.FlameSwordSecondaryFire'
     SelectAnim="PulloutFancy"
     SelectAnimRate=1.250000
     PutDownTime=0.500000
     BringUpTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     bMeleeWeapon=True
     Description="During Operation: Chalkboard Firefly, UTC troopers had discovered a strange sword being developed in secret in an underground arctic facility by an unknown manufacturer. While having the appearance of a Medieval arming sword, the blade itself seems to be made out of a strange nano-material, and is covered in a bright fire when held. UTC scientists have yet to find out more about the weapon due to resources being tight due to fighting the Skrith. However what has been found is this weapon was intended to be some sort of psionic enhancing focii, capable of shielding the user from explosions and flames alike."
     DisplayFOV=65.000000
     Priority=12
     HudColor=(B=255,G=125,R=75)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     GroupOffset=5
     PickupClass=Class'BWBPSomeOtherPack.FlameSwordPickup'
     BobDamping=1.000000
     AttachmentClass=Class'BWBPSomeOtherPack.FlameSwordAttachment'
     IconMaterial=Texture'BWBPSomeOtherPackTex.FlameSword.BWsword_icon_128'
     IconCoords=(X2=127,Y2=31)
     ItemName="PSI-56 Fire Sword"
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.Sword_FP_Flame'
     DrawScale=1.250000
     SoundRadius=32.000000
	 PlayerViewOffset=(X=20.000000,Y=10.000000,Z=-20.000000)
}
