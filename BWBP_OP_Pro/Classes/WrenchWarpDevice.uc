class WrenchWarpDevice extends BallisticMeleeWeapon;

const DEPLOYABLE_COUNT = 7;

struct DeployableInfo
{
	var class<Actor> 	dClass;
	var float				WarpInTime;
	var int					SpawnOffset;
	var int					AmmoReq;
	var int					Limit;
	var bool				CheckSlope;     // should block unless placed on flat enough area
	var string				dDescription; 	//A simple explanation of what this mode does.
};

var array<DeployableInfo> 	Deployables;
var int			  			DeployableCount[7];

var DeployableInfo AltDeployable;

var WrenchTeleporter Teleporters[2];

var bool bRemove;

const DeployRange = 512;

//Now adds initial ammo in all cases
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
    if ( FireMode[m] != None && FireMode[m].AmmoClass != None )
    {
		Ammo[m] = Ammunition(Instigator.FindInventoryType(FireMode[m].AmmoClass));
        if (Ammo[m] == None)
        {
            Ammo[m] = Spawn(FireMode[m].AmmoClass, instigator);
            Instigator.AddInventory(Ammo[m]);
			//Dropped pickup, just add ammo
			if ((WP != None) && (WP.bDropped || WP.AmmoAmount[m] > 0))
				Ammo[m].AddAmmo(WP.AmmoAmount[m]);
			//else add initial complement
			else if (bJustSpawned && (WP==None || !WP.bDropped) && (m == 0 || FireMode[m].AmmoClass != FireMode[0].AmmoClass))
			{
				if (Level.Game.MaxLives > 0)
					Ammo[m].AddAmmo(Ammo[m].MaxAmmo);
				else Ammo[m].AddAmmo(Ammo[m].InitialAmount);
			}
        }

		else
		{
			//Dropped pickup, just add ammo
			if ((WP != None) && (WP.bDropped || WP.AmmoAmount[m] > 0))
			Ammo[m].AddAmmo(WP.AmmoAmount[m]);
		}
        Ammo[m].GotoState('');
	}
}

simulated function PostBeginPlay()
{
	local WrenchTeleporter T;
	
	Super(BallisticWeapon).PostBeginPlay();
	
	if (Role == ROLE_Authority && !Level.Game.bAllowVehicles)
		Level.Game.bAllowVehicles = True;

	MeleeSpreadAngle = MeleeFireMode.GetCrosshairInaccAngle();
	
	foreach DynamicActors(class'WrenchTeleporter', T)
	{
		if (T.OwningController == Instigator.Controller)
		{
			if (Teleporters[0] == None)
			{
				Teleporters[0] = T;
				continue;
			}
			else if (Teleporters[1] == None)
			{
				Teleporters[1] = T;
				continue;
			}
			break;
		}
	}
}

exec function FastSpawn()
{
	local int i;
	
	if (Level.NetMode != NM_Standalone)
		return;
	
	for (i = 0; i < Deployables.Length; ++i)
		Deployables[i].WarpInTime = 1;
}

exec function Offset(int index, int value)
{
	if (Level.NetMode != NM_Standalone)
		return;

	Deployables[index].SpawnOffset = value;
}

exec simulated function SwitchWeaponMode(optional byte i)
{
	if (ClientState == WS_PutDown || ClientState == WS_Hidden)
		return;
	bRedirectSwitchToFiremode=True;
	PendingMode = CurrentWeaponMode;
}

exec simulated function WeaponModeRelease()
{
	bRedirectSwitchToFiremode=False;
	CurrentWeaponMode = PendingMode;
	ServerSwitchWeaponMode(PendingMode);
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (bRedirectSwitchToFiremode)
	{
		PendingMode--;
		if (PendingMode >= Deployables.Length)
			PendingMode = Deployables.Length-1;
		return None;
	}

	return Super.PrevWeapon(CurrentChoice, CurrentWeapon);
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (bRedirectSwitchToFiremode)
	{
		PendingMode++;
		if (PendingMode >= Deployables.Length)
			PendingMode = 0;
		return None;
	}

	return Super.NextWeapon(CurrentChoice, CurrentWeapon);
}

simulated function bool PutDown()
{
	if (Instigator.IsLocallyControlled())
	{
		bRedirectSwitchToFiremode = False;
		PendingMode = CurrentWeaponMode;
	}
	
	bRemove=False;
	
	return Super.PutDown();
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local float		ScaleFactor, XL, YL, YL2;
	local string	Temp;
	local int i;
	local byte StartMode;

	Super(Weapon).NewDrawWeaponInfo (C, YPos);
	
	DrawCrosshairs(C);
	
	if (bSkipDrawWeaponInfo)
		return;

	ScaleFactor = C.ClipY / 900;

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		if (!bRedirectSwitchToFiremode)
		{
			// Draw the spare ammo amount
			C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
			C.DrawColor = class'hud'.default.WhiteColor;
			Temp = string(Ammo[0].AmmoAmount);
			if (Temp == "0")
				C.DrawColor = class'hud'.default.RedColor;
			C.TextSize(Temp, XL, YL);
			C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
			C.CurY = C.ClipY - 200 * ScaleFactor * class'HUD'.default.HudScale - YL;
			C.DrawText(Temp, false);
			C.DrawColor = class'hud'.default.WhiteColor;
	
			C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
			C.TextSize(WeaponModes[CurrentWeaponMode].ModeName @ "(" $Deployables[CurrentWeaponMode].AmmoReq$")", XL, YL2);
			C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
			C.CurY = C.ClipY - (130 * ScaleFactor * class'HUD'.default.HudScale) - YL2 - YL;
			C.DrawText(WeaponModes[CurrentWeaponMode].ModeName @ "(" $Deployables[CurrentWeaponMode].AmmoReq$")", false);
			C.Font = GetFontSizeIndex(C, -5 + int(2* class'HUD'.default.HudScale));
			C.TextSize(Deployables[CurrentWeaponMode].dDescription, XL, YL);
			C.CurY += YL/2;
			C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
			C.DrawText(Deployables[CurrentWeaponMode].dDescription);
		}
		
		else
		{
			StartMode = PendingMode - 2;
			if (StartMode >= Deployables.Length)
				StartMode = (Deployables.Length-1) - (255 - StartMode);
				
				//case -2: desire 3
				//case -1: desire 2
				//case 0: desire 1
				//case 1: desire 0
				//case 2: desire -1
				
				
			for (i=-2; i<3; i++)
			{
				if (i != 0)
					C.SetDrawColor(255,128,128,255 - (75 * Abs(i)));
				else C.SetDrawColor(255,255,255,255);
				C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
				C.TextSize(WeaponModes[StartMode].ModeName, XL, YL2);
				C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
				C.CurY = C.ClipY - (130 * ScaleFactor * class'HUD'.default.HudScale) - (YL2 * (-i +1)) - YL;
				C.DrawText(WeaponModes[StartMode].ModeName, false);
				
				StartMode++;
				if (StartMode >= Deployables.Length)
					StartMode = 0;
			}
		}
	}
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	AnimBlendParams(2, 1, 0, 0, 'HammerBase');
	AnimBlendParams(1, 1, 0, 0, 'Mouth');
	LoopAnim('HammerLoop', 1, 0, 2);
	LoopAnim('JawsLoop', 1, 0, 1);
}

//===========================================================================
// AmmoStatus
//
// Called from HUD, so it's used to call the alt timer.
//===========================================================================
simulated function float AmmoStatus(optional int Mode) 
{
	if ( Instigator == None || Instigator.Weapon != self )
	{
		if ( (FireMode[0].TimerInterval != 0.f) && (FireMode[0].NextTimerPop < Level.TimeSeconds) )
		{
			FireMode[0].Timer();
  			if ( FireMode[0].bTimerLoop )
				FireMode[0].NextTimerPop = FireMode[0].NextTimerPop + FireMode[0].TimerInterval;
			else
				FireMode[0].TimerInterval = 0.f;
		}
	}
	return Super.AmmoStatus(Mode);
}

//===========================================================================
// Weapon Special act as dedicated removal.
//===========================================================================
exec simulated function WeaponSpecial(optional byte i)
{
	if (Level.TimeSeconds < FireMode[0].NextFireTime)
		return;
	PlayAnim(FireMode[0].FireAnim, FireMode[0].FireAnimRate, 0.1);
	ServerWeaponSpecial(i);
	FireMode[0].NextFireTime = Level.TimeSeconds + FireMode[0].FireRate;
}

function ServerWeaponSpecial(optional byte i)
{
	if (Level.TimeSeconds < FireMode[0].NextFireTime)
		return;
	bRemove=True;
	PlayAnim(FireMode[0].FireAnim, FireMode[0].FireAnimRate, 0.1);
	FireMode[0].NextFireTime = Level.TimeSeconds + FireMode[0].FireRate;
}

//===========================================================================
// Notify_WrenchDeploy
//
// Responsible for spawning the pre-warp effect for any given deployable.
// Traces out from the view to hit something, then does an extent trace to check for room.
// If OK, spawns the pre-warp at the required height.
//===========================================================================
function Notify_WrenchDeploy()
{
	local Actor HitActor;
	local Vector Start, End, HitNorm, HitLoc;
	local WrenchPreconstructor WP;
	local WrenchDeployable D;
	local ASTurret_Minigun MT;
	
	Start = Instigator.Location + Instigator.EyePosition();
	End = Start + vector(Instigator.GetViewRotation()) * DeployRange;
	
	HitActor = Trace(HitLoc, HitNorm, End, Start, true);
	
	if (HitActor == None)
		HitActor = Trace(HitLoc, HitNorm, End - vect(0,0,256), End, true);
		
	if (WrenchDeployable(HitActor) != None && WrenchDeployable(HitActor).OwningController == Instigator.Controller)
	{
		WrenchDeployable(HitActor).bWarpOut=True;
		WrenchDeployable(HitActor).GoToState('Destroying');
		if (Ammo[0].AmmoAmount <= 40)	// XAVEDIT
			Ammo[0].AddAmmo(Min(40 - Ammo[0].AmmoAmount, 10));
		return;
	}
	
	if (bRemove)
	{
		bRemove = False;
		return;
	}

	if (CurrentWeaponMode == 2 && Level.Game.GameName == "Jailbreak")
	{
		Instigator.ClientMessage("You're not allowed to place teleporters in this gametype.");
		return;
	}
	
	//Safety for mode switch during attack
	if (Deployables[CurrentWeaponMode].AmmoReq > Ammo[0].AmmoAmount)
	{
		Instigator.ClientMessage("Not enough charge to warp in"@WeaponModes[CurrentWeaponMode].ModeName$".");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
		
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
	
	if (Deployables[CurrentWeaponMode].CheckSlope && HitNorm dot vect(0,0,1) < 0.9)
	{
		Instigator.ClientMessage("Surface is too steep for construction.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	Start = HitLoc + HitNorm; // offset from the floor by 1 unit, it's already normalized
	
	if (!SpaceToDeploy(HitLoc + HitNorm, HitNorm, rot(0,0,0), Deployables[CurrentWeaponMode].dClass.default.CollisionHeight, Deployables[CurrentWeaponMode].dClass.default.CollisionRadius))
	{
		Instigator.ClientMessage("Insufficient space for construction.");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}

	if (Deployables[CurrentWeaponMode].Limit > 0 && DeployableCount[CurrentWeaponMode] >= Deployables[CurrentWeaponMode].Limit)
	{
		Instigator.ClientMessage("You have "$DeployableCount[CurrentWeaponMode]$" of this item and the limit is "$Deployables[CurrentWeaponMode].Limit$".");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
	
	if (CurrentWeaponMode != 4)
	{
		foreach RadiusActors(class'WrenchDeployable', D, 512, HitLoc)
		{
			Instigator.ClientMessage("Too close to a major deployable.");
			PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
			return;
		}

			foreach RadiusActors(class'ASTurret_Minigun', MT, 512, HitLoc)
		{
			Instigator.ClientMessage("Too close to a minigun turret.");
			PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
			return;
		}
		
		foreach RadiusActors(class'WrenchPreconstructor', WP, 512, HitLoc)
		{
			Instigator.ClientMessage("Too close to a warping deployable.");
			PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
			return;
		}
	}
	
	WP = Spawn(class'WrenchPreconstructor', Instigator, , Start + HitNorm * Deployables[CurrentWeaponMode].dClass.default.CollisionRadius, Instigator.Rotation);
	
	WP.GroundPoint = Start + HitNorm;
	WP.GroundPoint.Z += Deployables[CurrentWeaponMode].SpawnOffset;
	
	WP.Instigator = Instigator;
	WP.Wrench = self;
	WP.Initialize(Deployables[CurrentWeaponMode].dClass, CurrentWeaponMode, Deployables[CurrentWeaponMode].WarpInTime);

	++DeployableCount[CurrentWeaponMode];
	
	ConsumeAmmo(0, Deployables[CurrentWeaponMode].AmmoReq, true);
}

// fucking evil hack for minigun turrets
function LostChild(Actor lost)
{
	if (ASTurret_Minigun(lost) != None)
		--DeployableCount[5];
}

//===========================================================================
// LostDeployable
//
// Decrements active count for given deployable index
//===========================================================================
function LostDeployable(byte index)
{
	if (index < DEPLOYABLE_COUNT - 1)
		Instigator.ClientMessage("Your "$WeaponModes[index].ModeName$" was destroyed.");
	--DeployableCount[index];
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
	local WrenchPreconstructor WP;
	
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
		if (Ammo[0].AmmoAmount <= 40)	// XAVEDIT
			Ammo[0].AddAmmo(Min(40 - Ammo[0].AmmoAmount, 10));
		return;
	}
	
	//Safety for mode switch during attack
	if (AltDeployable.AmmoReq > Ammo[0].AmmoAmount)
	{
		Instigator.ClientMessage("Not enough charge to warp in"@WeaponModes[0].ModeName$".");
		PlayerController(Instigator.Controller).ClientPlaySound(Sound'BWBP_OP_Sounds.Wrench.EnergyStationError', ,1);
		return;
	}
		
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
		
	WP = Spawn(class'WrenchPreconstructor', Instigator, , Start + HitNorm * AltDeployable.dClass.default.CollisionRadius, SlopeRotation);
	
	WP.GroundPoint = Start + (HitNorm * (AltDeployable.SpawnOffset + AltDeployable.dClass.default.CollisionRadius));

	WP.Instigator = Instigator;
	WP.Wrench = self;
	WP.Initialize(AltDeployable.dClass, 6, AltDeployable.WarpInTime);

	DeployableCount[6]++;
	
	ConsumeAmmo(0, AltDeployable.AmmoReq, true);
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

// choose between regular or alt-fire
function byte BestMode()
{
	return 1;
}

simulated function AnimEnd(int Channel)
{
	if (Channel == 0)
		Super.AnimEnd(Channel);
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = AIRating;
	// Enemy too far away
	if (Dist > 1500)
		return 0.1;			// Enemy too far away
	// Better if we can get him in the back
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0)
		Result += 0.08 * B.Skill;
	// If the enemy has a knife too, a gun looks better
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result = FMax(0.0, Result *= 0.7 - (Dist/1000));
	// The further we are, the worse it is
	else
		Result = FMax(0.0, Result *= 1 - (Dist/1000));

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 4;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/1500));
    return FClamp(Result, -1.0, -0.3);
}

/*
simulated function float ChargeBar()
{
	if (Ammo[0].AmmoAmount == 4 || Level.TimeSeconds > FireMode[0].NextTimerPop)
		return 1;
	return (30.0f - (FireMode[0].NextTimerPop - Level.TimeSeconds)) / 30.0f;
}
*/
// End AI Stuff =====

defaultproperties
{
     Deployables(0)=(dClass=Class'WrenchBoostPad',SpawnOffset=4,WarpInTime=1.000000,AmmoReq=50,Limit=0,CheckSlope=True,dDescription="A pad which propels players through the air in the direction they were moving.")
     Deployables(1)=(dClass=Class'WrenchTeleporter',SpawnOffset=1,WarpInTime=1.000000,AmmoReq=50,Limit=2,CheckSlope=True,dDescription="A teleporter. Only two may be placed.")
     Deployables(2)=(dClass=Class'Sandbag',SpawnOffset=8,WarpInTime=1.000000,AmmoReq=10,Limit=0,CheckSlope=False,dDescription="A unit of three sandbags which can be used as cover.")
     Deployables(3)=(dClass=Class'WrenchShieldGeneratorB',SpawnOffset=0,WarpInTime=1.000000,AmmoReq=30,Limit=1,CheckSlope=True,dDescription="Places a dome shield generator which lasts 12 seconds.")
     Deployables(4)=(dClass=Class'WrenchAmmoCrate',SpawnOffset=16,WarpInTime=3.000000,AmmoReq=30,CheckSlope=True,dDescription="A crate which restocks ammunition to initial levels.")
     Deployables(5)=(dClass=Class'WrenchMinigunTurret',SpawnOffset=36,WarpInTime=35.000000,AmmoReq=100,Limit=1,CheckSlope=True,dDescription="A static minigun turret. Resistant to attacks. Only one may be placed.")
     AltDeployable=(dClass=Class'WrenchEnergyBarrier',WarpInTime=0.100000,SpawnOffset=52,AmmoReq=10,Limit=0,CheckSlope=False,dDescription="A three-second barrier of infinite durability.")
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_OP_Tex.Wrench.BigIcon_Wrench'
     BigIconCoords=(Y2=240)
     bAllowWeaponInfoOverride=False
     
     ManualLines(0)="Constructs various deployables. Will deploy to the aim point. A description of each deployable is given underneath the fire mode text. Holding Weapon Function allows the user to scroll through the modes."
     ManualLines(1)="Constructs an energy barrier, regardless of the currently active mode."
     ManualLines(2)="Grants a 10% speed increase."
     SpecialInfo(0)=(Info="180.0;6.0;-999.0;-1.0;-999.0;-999.0;-999.0")
     MeleeFireClass=Class'WrenchMeleeFire'
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifePullOut')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifePutaway')
     bNoMag=True
     WeaponModes(0)=(ModeName="Boost Pad",bUnavailable=False,ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Teleporter",bUnavailable=False,ModeID="WM_SemiAuto")
     WeaponModes(2)=(ModeName="Sandbag Stack")
     WeaponModes(3)=(ModeName="Shield Generator",ModeID="WM_FullAuto")
     WeaponModes(4)=(ModeName="Ammo Crate",ModeID="WM_FullAuto")
     WeaponModes(5)=(ModeName="Minigun Turret",ModeID="WM_SemiAuto")
     GunLength=0.000000
     bAimDisabled=True
	 ParamsClasses(0)=Class'WrenchWeaponParamsComp'
	 ParamsClasses(1)=Class'WrenchWeaponParamsComp'
	 ParamsClasses(2)=Class'WrenchWeaponParamsTactical'
	 ParamsClasses(3)=Class'WrenchWeaponParamsTactical'
     FireModeClass(0)=Class'WrenchPrimaryFire'
     FireModeClass(1)=Class'WrenchSecondaryFire'
	 PutDownTime=1.750000
	 PutDownAnimRate=0.650000
	 BringUpTime=1.750000
	 SelectAnimRate=0.750000	 
     SelectForce="SwitchToAssaultRifle"
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M763InA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc8',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=0,R=0,A=198),Color2=(B=85,G=246,R=250,A=255),StartSize1=141,StartSize2=38)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     AIRating=0.200000
     CurrentRating=0.200000
     bMeleeWeapon=True
     Description="Nanoforge Uplink Device 'Combat Wrench'||Manufacturer: Apollo Industries||An oft overlooked tool paramount in keeping a mobile army moving and establishing and fortifying forward bases, the Nanoforge Uplink Device allows a combat engineer to deploy protective fortifications, repair just about anything, and utilize off-site nanoforge plants to rapidly construct key structures and vehicles. Nick-named 'The Attitude Adjuster' by many an engineer, it gained a certain reverence after a single injured combat engineer stayed at his squad's machine gun nest to slow the enemy Cryon forces while the rest of the UFC forces retreated. When his body was recovered, he was found with a Combat Wrench in hand and 14 armored Cryon gunners laying about him, their cause of death - blunt force trauma."
     Priority=13
     HudColor=(G=100,R=200)
     CenteredOffsetY=7.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     PickupClass=Class'BWBP_OP_Pro.WrenchPickup'
     PlayerViewOffset=(X=10.000000,Z=-7.000000)
     AttachmentClass=Class'BWBP_OP_Pro.WrenchAttachment'
     IconMaterial=Texture'BWBP_OP_Tex.Wrench.Icon_Wrench'
     IconCoords=(X2=128,Y2=32)
     ItemName="NFUD Combat Wrench"
     Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_Techwrench'
     DrawScale=0.300000
}
