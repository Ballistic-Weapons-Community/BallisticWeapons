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
class BCSprintControl extends Inventory;

const RECHARGE_DELAY = 1.5f;

//=============================================================================
// STAMINA VARIABLES
//=============================================================================
var 	float		Stamina;				// Stamina level of player (percentage). Players can't sprint when this is out
var   	float    	MaxStamina;				// should always be 100
var() 	float		StaminaDrainRate;		// Amount of stamina lost each second when sprinting
var() 	float		StaminaChargeRate;		// Amount of stamina gained each second when not sprinting

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

replication
{
	reliable if (Role == ROLE_Authority)
		bSprintActive, ClientJumped, ClientDelayRecharge;
}

simulated function PostBeginPlay()
{
	StaminaChargeRate = class'BallisticReplicationInfo'.default.StaminaChargeRate;
	StaminaDrainRate = class'BallisticReplicationInfo'.default.StaminaDrainRate;
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

    //log("SC UpdateSpeed: "$NewSpeed);
}

simulated event Tick(float DT)
{
	if (Instigator == None)
		Destroy();

	TickSprint(DT);
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
	}
}

simulated function DelayRecharge()
{
	SprintRechargeDelay = Level.TimeSeconds + RECHARGE_DELAY;
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
			else if (Instigator.bIsCrouched)
				Stamina += StaminaChargeRate * DT/2;
			if (Level.TimeSeconds > SprintRechargeDelay)
				Stamina += StaminaChargeRate * DT;
		}
	}
	Stamina = FClamp(Stamina, 0, MaxStamina);
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

defaultproperties
{
     Stamina=100.000000
     MaxStamina=100.000000
     StaminaDrainRate=25.000000
     StaminaChargeRate=25.000000
	 JumpDrain=10
     SpeedFactor=1.500000
	 SlowFactor=1.000000
     bReplicateInstigator=True
}
