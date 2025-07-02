//=============================================================================
// BCSprintControl.
//
// A special inventory actor used to control player sprinting. Key events must
// be sent from somewhere like a mutator.
//
// TODO/FIXME: Replicate drain/charge from server?
//
// by Nolan "Dark Carnivour" Richert and Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
// Updates by YoYoBatty:
// - Added crouch sliding functionality
class BCSprintControl extends Inventory;

//const RECHARGE_DELAY = 1.5f; //This really should be customizable, but for now it's hardcoded

//=============================================================================
// STAMINA VARIABLES
//=============================================================================
var 	float		Stamina;				// Stamina level of player (percentage). Players can't sprint when this is out
var   	float    	MaxStamina;				// should always be 100
var() 	float		StaminaDrainRate;		// Amount of stamina lost each second when sprinting
var() 	float		StaminaChargeRate;		// Amount of stamina gained each second when not sprinting
var() 	float		StaminaRechargeDelay;	// From RECHARGE_DELAY

//=============================================================================
// SPRINT VARIABLES
//=============================================================================
var		bool		bSprinting;				// Currently sprinting
var		bool		bSprintActive;			// Sprint key is held down
var()	float		SpeedFactor;			// Player speed multiplied by this when sprinting
var		float		SprintRechargeDelay; 	// Retrigger delay
var		float		NextAlignmentCheckTime;	// Next time to check player's facing
var		float       JumpDrain;

//=============================================================================
// SLOW VARIABLES
//=============================================================================
struct SlowInfo
{
	var float Factor;
	var float Duration;
};

var array<SlowInfo> ActiveSlows;			// Effects which slow movement
var float SlowFactor; 
var float NextTimerPop;				// Next time to check for slow expiry

// Sliding Variables
var bool bIsSliding;			 // Is the player currently sliding?
var float LastSlideEndTime;		// Time when the last slide ended
var float LastLandTime;			// Time when the player last landed
var vector SlideVelocity;		// Velocity during the slide
var float SlideStartSpeed;		 // Speed required to start sliding
var float SlideStopSpeed;		 // Speed below which sliding stops
var float MaxSlideSpeed;		// Maximum speed during sliding, our groundspeed becomes this in order to move faster
var float BaseGroundSpeed;		 // Base ground speed of the player when not sliding
var float SlideEyeHeight;		 // Eye height during sliding, used to adjust camera position

// --- Slide/Movement Parameters ---
var() float SlideFriction;		 // Friction applied during sliding, affects how quickly the player slows down
var() float SlideCooldownTime;	// Time before the player can slide again after a slide ends
var() float SlidePower;			 // Initial burst power when starting a slide, affects how fast the player accelerates at the start of the slide

// Slope/Physics Calculations
var float SlopeAngleRad;		 // Angle of the slope in radians
var float SlopeAngleDeg;		 // Angle of the slope in degrees
var vector DownSlopeVect;		 // Direction vector pointing down the slope
var vector LastFallingVelocity;	 // Velocity of the player when they last fell, used to determine sliding behavior
var float GravityAlongSlope;	 // Gravity component acting along the slope, used to calculate acceleration during sliding

replication
{
	reliable if (Role == ROLE_Authority)
		bSprintActive, bIsSliding, SlideVelocity,
		ClientJumped, ClientDelayRecharge;
}

simulated function PostBeginPlay()
{
	StaminaChargeRate = class'BallisticReplicationInfo'.default.StaminaChargeRate;
	StaminaDrainRate = class'BallisticReplicationInfo'.default.StaminaDrainRate;
	StaminaRechargeDelay = class'BallisticReplicationInfo'.default.StaminaRechargeDelay;
	SpeedFactor = class'BallisticReplicationInfo'.default.SprintSpeedFactor;
	JumpDrain = class'BallisticReplicationInfo'.default.JumpDrain;
}

simulated function PostNetBeginPlay()
{
	local Inventory Inv;

    Super.PostNetBeginPlay();

    if (Instigator == None)
		return;
		
	for (Inv = Instigator.Inventory; Inv != None; Inv = Inv.Inventory)
	{
		if (BallisticWeapon(Inv) != None)
			BallisticWeapon(Inv).SprintControl = self;
	}
}

function GiveTo( pawn Other, optional Pickup Pickup )
{
	Super.GiveTo(Other, Pickup);

	UpdateSpeed();
}

function UpdateSpeed()
{
	local float NewSpeed;

	NewSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed;
    
	if (BallisticWeapon(Instigator.Weapon) != None)
    {
        NewSpeed *= BallisticWeapon(Instigator.Weapon).PlayerSpeedFactor;
        //log("SC UpdateSpeed: "$class'BallisticReplicationInfo'.default.PlayerGroundSpeed$" * "$BallisticWeapon(Instigator.Weapon).PlayerSpeedFactor);
    }

	if (ComboSpeed(xPawn(Instigator).CurrentCombo) != None)
    {
        //log("SC UpdateSpeed: "$NewSpeed$" * 1.4");
		NewSpeed *= 1.4;
    }

    if (bSprintActive)
    {
        //log("SC UpdateSpeed: "$NewSpeed$" * "$SpeedFactor);
        NewSpeed *= SpeedFactor;
    }

	NewSpeed *= SlowFactor;

	if (Instigator.GroundSpeed != NewSpeed)
		Instigator.GroundSpeed = NewSpeed;

	BaseGroundSpeed = NewSpeed;

}

simulated event Tick(float DT)
{
	if (Instigator == None)
		Destroy();

	TickSprint(DT);

	TickSlopeCalculation(DT);
}

//=============================================================================
// SPRINT
//=============================================================================

//If Stamina's less than 0 or Sprint's active
//return
function StartSprint()
{
	if (!class'BallisticReplicationInfo'.default.bEnableSprint)
		return;
		
	if (Stamina <= 0  || Instigator.Physics != PHYS_Walking || Instigator.bIsCrouched || bSprintActive || !CheckDirection())
		return;

	bSprintActive = true;

	if (Instigator != None)
        UpdateSpeed();

	//Level.Game.Broadcast(self, "Started sprint, ground speed: " $ Instigator.GroundSpeed);
}

// Sprint Key released. Used on Client and Server
function StopSprint()
{
	if (!class'BallisticReplicationInfo'.default.bEnableSprint)
		return;

	if (!bSprintActive)
		return;

	bSprintActive = false;
	
	if (Instigator != None)
		UpdateSpeed();

    DelayRecharge();
    ClientDelayRecharge();

	//Level.Game.Broadcast(self, "Stopped sprint, ground speed: " $ Instigator.GroundSpeed);
}

function OwnerEvent(name EventName)
{
	super.OwnerEvent(EventName);

	if (Role == ROLE_Authority)
	{
		if (EventName == 'Jumped' || EventName == 'Dodged')
		{
			Jumped();
			ClientJumped();
		}
		if(EventName == 'Crouched')
		{
			TryStartSlide();
		}
		if(EventName == 'Landed')
		{
			DoLand();
		}
	}
}

simulated function DelayRecharge()
{
	SprintRechargeDelay = Level.TimeSeconds + StaminaRechargeDelay;
}

simulated function Jumped()
{
	DelayRecharge();
	Stamina = FMax(0, Stamina - JumpDrain);
}

simulated function ClientDelayRecharge()
{
	if (Level.NetMode == NM_Client)
		DelayRecharge();
}

simulated function ClientJumped()
{
	if (Level.NetMode == NM_Client)
		Jumped();
}

simulated function bool CheckDirection()
{
	if (Normal(Instigator.Velocity) Dot Vector(Instigator.Rotation) < 0.2)
		return false;

	NextAlignmentCheckTime=Level.TimeSeconds + 0.35;
	return true;	
}

simulated function TickSprint(float DT)
{	
	// Add a check here to see if sprint can continue
	// Timed, based on dot product of rotation
	// Drain stamina while sprinting
	if (bSprintActive && Instigator.Physics != PHYS_Falling && VSize(Instigator.Acceleration) > 100 && VSize(Instigator.Velocity) > 50)
	{
		if (!bSprinting)
		{
			bSprinting=true;

			if (BallisticWeapon(Instigator.Weapon) != None)
				BallisticWeapon(Instigator.Weapon).PlayerSprint(true);

			if (Instigator != None && Instigator.Inventory != None)
				Instigator.Inventory.OwnerEvent('StartSprint');
		}
		
		if (Instigator.bIsCrouched)
			Stamina -= StaminaDrainRate * DT * 1.5;

		else 
            Stamina -= StaminaDrainRate * DT;

		if (Role == ROLE_Authority)
		{
			if (Stamina <= 0 || Instigator.Physics != PHYS_Walking ||(Level.TimeSeconds >= NextAlignmentCheckTime && !CheckDirection()))
				StopSprint();
		}
	}
	// Stamina charges when not sprinting
	else if (Instigator.Physics != PHYS_Falling) // if (VSize(RV) < class'BallisticReplicationInfo'.default.PlayerGroundSpeed * 0.8)
	{
		if (bSprinting)
		{
			bSprinting=False;

			if (BallisticWeapon(Instigator.Weapon) != None)
				BallisticWeapon(Instigator.Weapon).PlayerSprint(false);

			if (Instigator != None && Instigator.Inventory != None)
				Instigator.Inventory.OwnerEvent('StopSprint');
		}
		if (Stamina < MaxStamina)
		{
			if (VSize(Instigator.Velocity) == 0)
				Stamina += StaminaChargeRate * DT;
			else if (Instigator.bIsCrouched && !bIsSliding)
				Stamina += StaminaChargeRate * DT/2;
			if (Level.TimeSeconds > SprintRechargeDelay)
				Stamina += StaminaChargeRate * DT;
		}
	}
	Stamina = FClamp(Stamina, 0, MaxStamina);
	if (Instigator.Physics == PHYS_Falling)
    	LastFallingVelocity = Instigator.Velocity;
	SlideEyeHeight = Instigator.BaseEyeHeight;

	if (bIsSliding)
    {
        HandleSliding(DT);
		Instigator.EyeHeight = SlideEyeHeight * 0.6; // Lower eye height while sliding
    }
    else
    {
        if (Instigator.Physics == PHYS_Walking)
        {
            SlideStartSpeed = class'BallisticReplicationInfo'.default.PlayerGroundSpeed*1.1;
            SlideStopSpeed = BaseGroundSpeed*0.2;
            MaxSlideSpeed = BaseGroundSpeed*2.5;
			if(Level.TimeSeconds > LastLandTime + 0.1)
				LastFallingVelocity = vect(0,0,0); 
        }
		if (Instigator.bIsCrouched)
		{
        	Instigator.CrouchedPct = Instigator.default.CrouchedPct;
			Instigator.EyeHeight = Lerp(DT * 1.5, Instigator.EyeHeight, SlideEyeHeight, true); 
		}
    }
}

simulated event RenderOverlays( canvas C )
{
	local float	ScaleFactor, SprintFactor;

	ScaleFactor = C.ClipX / 1600;

	if (Stamina < MaxStamina)
	{
		SprintFactor = Stamina / MaxStamina;
		C.CurX = C.OrgX  + 5    * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 330  * ScaleFactor * class'HUD'.default.HudScale;

		if (SprintFactor < 0.2)
			C.SetDrawColor(255, 0, 0);
		else if (SprintFactor < 0.5)
			C.SetDrawColor(64, 128, 255);
		else
			C.SetDrawColor(0, 0, 255);

		C.DrawTile(Texture'Engine.MenuWhite', 200 * ScaleFactor * class'HUD'.default.HudScale * SprintFactor, 30 * ScaleFactor * class'HUD'.default.HudScale, 0, 0, 1, 1);
	}
}

//=============================================================================
// SLOW
//=============================================================================

static function AddSlowTo(Pawn P, float myFactor, float myDuration)
{
	local BCSprintControl Control;

	Control = BCSprintControl(P.FindInventoryType(class'BCSprintControl'));

	if (Control != None)
		Control.AddSlow(myFactor, myDuration);
}

static function SetSlowTo(Pawn P, float myFactor, float myDuration)
{
	local BCSprintControl Control;

	Control = BCSprintControl(P.FindInventoryType(class'BCSprintControl'));

	if (Control != None)
		Control.SetSlow(myFactor, myDuration);
}

function AddSlow(float myFactor, float myDuration)
{
	local int i;
	local float LowestDuration, LowestFactor;
	
	//Seek existing slows of the same factor.
	for (i = 0; i < ActiveSlows.Length && ActiveSlows[i].Factor != myFactor; i++);
	
	//If none, add a new slow and adjust the timer and durations here.
	if (i == ActiveSlows.Length)
	{
		LowestDuration = myDuration;
		LowestFactor = myFactor;
		
		for (i = 0; i < ActiveSlows.Length; i++)
		{
			ActiveSlows[i].Duration -= TimerCounter;
			if (ActiveSlows[i].Duration < 0.1)
				ActiveSlows.Remove(i, 1);
			else
			{	
				if (ActiveSlows[i].Duration < LowestDuration)
					LowestDuration = ActiveSlows[i].Duration;
				if (ActiveSlows[i].Factor < LowestFactor)
					LowestFactor = ActiveSlows[i].Factor;
			}
		}

		AddNewSlow();

		ActiveSlows[ActiveSlows.Length-1].Factor = myFactor;
		ActiveSlows[ActiveSlows.Length-1].Duration = myDuration;
		
		SetTimer(LowestDuration, false);
		//log("Timer: TimerRate:"@TimerRate@"LowestDuration:"@LowestDuration);
		NextTimerPop = TimerRate;
		SlowFactor = LowestFactor;
		
		if (Instigator != None)
			UpdateSpeed();
	}
	
	//Otherwise just add duration to the existing slow.
	else 
		ActiveSlows[i].Duration += myDuration;
}

function SetSlow(float myFactor, float myDuration)
{
	local int i;
	local float LowestDuration, LowestFactor;
	
	//Seek existing slows of the same factor.
	for (i = 0; i < ActiveSlows.Length && ActiveSlows[i].Factor != myFactor; i++);
	
	//If none, add a new slow and adjust the timer and durations here.
	if (i == ActiveSlows.Length)
	{
		LowestDuration = myDuration;
		LowestFactor = myFactor;
		
		for (i = 0; i < ActiveSlows.Length; i++)
		{
			ActiveSlows[i].Duration -= TimerCounter;
			if (ActiveSlows[i].Duration < 0.1)
				ActiveSlows.Remove(i, 1);
			else
			{	
				if (ActiveSlows[i].Duration < LowestDuration)
					LowestDuration = ActiveSlows[i].Duration;
				if (ActiveSlows[i].Factor < LowestFactor)
					LowestFactor = ActiveSlows[i].Factor;
			}
		}

		AddNewSlow();

		ActiveSlows[ActiveSlows.Length-1].Factor = myFactor;
		ActiveSlows[ActiveSlows.Length-1].Duration = myDuration;
		
		SetTimer(LowestDuration, false);
		//log("Timer: TimerRate:"@TimerRate@"LowestDuration:"@LowestDuration);
		NextTimerPop = TimerRate;
		SlowFactor = LowestFactor;
		
		UpdateSpeed();
	}
	
	//Otherwise just set duration of the existing slow.
	else 
		ActiveSlows[i].Duration = myDuration;
}

function Timer()
{
	local int i;
	local float LowestDuration, LowestFactor;
	local bool bRemovedSlow;
		
	//Remove the timer interval's value from all the slows. Discard ones that are anyway close to expiring.
	for (i=0;i<ActiveSlows.Length; i++)
	{
		ActiveSlows[i].Duration -= NextTimerPop;
		if (ActiveSlows[i].Duration < 0.1)
		{
			ActiveSlows.Remove(i, 1);
			bRemovedSlow = True;
			i--;
		}
		else
		{	
			if (i == 0 || ActiveSlows[i].Duration < LowestDuration)
				LowestDuration = ActiveSlows[i].Duration;
			if (i == 0 || ActiveSlows[i].Factor < LowestFactor)
				LowestFactor = ActiveSlows[i].Factor;
		}
	}

	if (ActiveSlows.Length == 0)
	{
		SlowFactor  =1.0f;
		LowestDuration = 0.0f;
	}

	if (bRemovedSlow)
		UpdateSpeed();

	NextTimerPop = LowestDuration;
	SetTimer(LowestDuration, false);
}

function AddNewSlow()
{
	local SlowInfo S;
	
	ActiveSlows[ActiveSlows.Length] = S;
}

//=============================================================================
// SLIDING
//=============================================================================

function StartSlide()
{
    if (!bIsSliding 
	&& Instigator.Controller.bDuck > 0 
	&& (VSize(LastFallingVelocity) > SlideStartSpeed || VSize(Instigator.Velocity) > SlideStartSpeed || SlopeAngleDeg < 0.0)
	&& Instigator.Physics == PHYS_Walking 
	&& (Level.TimeSeconds - LastSlideEndTime > SlideCooldownTime))
    {
		DelayRecharge();
		StopSprint();
		SlideVelocity = Instigator.Velocity * 0.5 + LastFallingVelocity * 0.5; //Blend current velocity with last falling velocity
		SlideVelocity += Normal(SlideVelocity) * FMax(SlidePower*0.5,SlidePower * (Stamina / MaxStamina));
		// Clamp slide velocity to max speed
        if (VSize(SlideVelocity) > MaxSlideSpeed)
            SlideVelocity = Normal(SlideVelocity) * MaxSlideSpeed;
		LastFallingVelocity = vect(0,0,0); 
        bIsSliding = true;
        Instigator.GroundSpeed = MaxSlideSpeed;
    }
}

function EndSlide()
{
    bIsSliding = false;
    SlideVelocity = vect(0,0,0);
    LastSlideEndTime = Level.TimeSeconds;
    Instigator.GroundSpeed = BaseGroundSpeed;
}

simulated function TickSlopeCalculation(float DT)
{
	DownSlopeVect = Normal(vect(0,0,-1) - (Instigator.Floor dot vect(0,0,-1)) * Instigator.Floor);
	SlopeAngleRad = Acos(Instigator.Floor dot vect(0,0,1));
	SlopeAngleDeg = SlopeAngleRad * (180.0 / Pi);
	if (Normal(Instigator.Velocity) dot DownSlopeVect > 0)
		SlopeAngleDeg = -SlopeAngleDeg; // Negative when going downhill
}

simulated function HandleSliding(float DT)
{
	local float DynamicFriction;

	Instigator.CrouchedPct = 1.0; //Little hack so it doesn't mess with crouch speed/ground speed, etc...
	GravityAlongSlope = -PhysicsVolume.Gravity.Z * Sin(SlopeAngleRad);
	// Friction increases over time
	DynamicFriction = SlideFriction;
	// Reduce friction on steep slopes for more sliding
	if (SlopeAngleDeg < 0) // Downhill
		DynamicFriction *= FClamp(1.0 - (Abs(SlopeAngleDeg) / 60.0), 0.2, 1.0);
	else  // Uphill
		DynamicFriction *= FClamp(1.0 + (SlopeAngleDeg / 45.0), 1.0, 2.5);
	//Need to make sure we only apply this when on stairs, DetectStairDirection() might return an angle when on a slope that is not a stair
	
	//If we're on stairs, but not on a slope, adjust friction and gravity, hacky but it works!
	if(SlopeAngleDeg == 0.0 && Instigator.Floor != Vect(0,0,1)) 
	{
		if (PlayerController(Instigator.Controller).FindStairRotation(DT) < 0) 
		{
			DynamicFriction *= 0.5;
			GravityAlongSlope *= 1.5; 
		}
		else
		{
			DynamicFriction *= 1.5;
			GravityAlongSlope *= 0.5; 
		}
	}
	
	// If going downhill, accelerate; if uphill, decelerate
	SlideVelocity += DownSlopeVect * GravityAlongSlope * 1.5 * DT;

	// Friction force
	if (VSize(SlideVelocity) > 0.1)
		SlideVelocity -= Normal(SlideVelocity) * DynamicFriction * -PhysicsVolume.Gravity.Z * Cos(SlopeAngleRad) * DT;

	// End slide if crouch released, speed too low, or airborne
	if (!Instigator.bIsCrouched || VSize(SlideVelocity) < SlideStopSpeed || Instigator.Physics != PHYS_Walking)
	{
		EndSlide();
	}

	// Apply slide velocity to pawn
	if (Instigator.Physics == PHYS_Walking)
	{
		Instigator.Velocity = Instigator.Velocity * 0.3 + SlideVelocity * 0.7;
		if (VSize(Instigator.Velocity) > MaxSlideSpeed)
			Instigator.Velocity = Normal(Instigator.Velocity) * MaxSlideSpeed;
	}
}

simulated function TryStartSlide()
{
    if (Role < ROLE_Authority)
        ServerStartSlide();
    else
        StartSlide();
}

function ServerStartSlide()
{
    StartSlide();
}

simulated function DoLand()
{
	LastLandTime = Level.TimeSeconds;
}

defaultproperties
{
     Stamina=100.000000
     MaxStamina=100.000000
     StaminaDrainRate=25.000000
     StaminaChargeRate=25.000000
	 JumpDrain=10.000000
     SpeedFactor=1.500000
	 SlowFactor=1.000000
     bReplicateInstigator=True
	 SlideFriction=1.100000
     SlideCooldownTime=0.600000
	 SlidePower=300.000000
}
