//=============================================================================
// BCSprintControl.
//
// A special inventory actor used to control player sprinting. Key events must
// be sent from somewhere like a mutator.
//
// TODO/FIXME: Replicate drain/charge from server?
//
// Net behaviour of sprinting:
// The server decides whether the player is sprinting and the engine replicates
// the resulting GroundSpeed to the owning client, which gets there a round trip
// after the key was pressed. Until then the client would be running its moves
// at the old speed and get corrected for every one of them. So the client
// predicts the outcome of its own key presses (PredictSprint), holds on to that
// until the server has answered (ClientSprintReply) and takes the server's word
// from there on.
//
// by Nolan "Dark Carnivour" Richert and Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
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

// --- Slide/Movement Parameters ---
var float BaseGroundSpeed;		 // Ground speed of the player without the sprint boost

//=============================================================================
// SPRINT PREDICTION
//=============================================================================
var		bool		bPredictedSprint;		// Client: bSprintActive as predicted from the player's own key presses
var		float		PredictEndTime;			// Client: the prediction stands in for bSprintActive until this time
var		int			PendingReplies;			// Client: sprint requests the server hasn't answered yet
var		int			JumpEchoes;				// Client: ClientJumped calls on their way for stamina costs already paid here
var		float		JumpEchoTime;			// Client: they are no longer expected after this time
var		float		RechargeEchoTime;		// Client: a ClientDelayRecharge is on its way for a sprint stop already predicted here, until this time
var		float		CancelEndTime;			// Client: the holder's weapon ended the sprint. Until this time it counts as over here, whatever the server last said

//=============================================================================
// SPRINT AND FIRE
//=============================================================================
var		bool		bWasSprintActive;		// The sprint key counted as held on the last tick
var		bool		bStaleFire;				// Local player: fire has been down since before the sprint began, so it is no press to end the sprint with
var		bool		bStaleAltFire;			// Local player: the same for alt fire

var byte	SettingsChecksLeft;			// Client: spawned before the BallisticReplicationInfo carrying the server's settings arrived. Times left to look for it
var float	NextSettingsCheckTime;


replication
{
	reliable if (Role == ROLE_Authority)
		bSprintActive, BaseGroundSpeed,
		ClientJumped, ClientDelayRecharge, ClientSprintReply;
	reliable if (Role < ROLE_Authority)
		ServerCancelSprint;
}

simulated function PostBeginPlay()
{
	ApplyServerSettings();

	// A client can receive this before the BallisticReplicationInfo. Apply the settings again once it turns up
	if (Role < ROLE_Authority && class'BallisticReplicationInfo'.static.GetInstance(self) == None)
		SettingsChecksLeft = 20;
}

simulated function ApplyServerSettings()
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

simulated function UpdateSpeed(optional float NewSpeedFactor)
{
	local float NewSpeed;

	// Slows and weapon speed changes only exist on the server, which sends their outcome as BaseGroundSpeed
	if (Role < ROLE_Authority)
	{
		ClientUpdateSpeed();
		return;
	}

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

	NewSpeed *= SlowFactor;

	if (NewSpeedFactor > 0.0)
		NewSpeed *= NewSpeedFactor;

	BaseGroundSpeed = NewSpeed;

    if (bSprintActive)
    {
        //log("SC UpdateSpeed: "$NewSpeed$" * "$SpeedFactor);
        NewSpeed *= SpeedFactor;
    }

	if (Instigator.GroundSpeed != NewSpeed)
		Instigator.GroundSpeed = NewSpeed;

	//Level.Game.Broadcast(self, "SpeedUpdated:"@Instigator.GroundSpeed@" (Factor:"@SpeedFactor@", Slow:"@SlowFactor@", "@NewSpeedFactor@")");
}

// The GroundSpeed the server has, or will have once it catches up with a predicted sprint change
simulated function float SprintGroundSpeed(bool bSprint)
{
	if (bSprint)
		return BaseGroundSpeed * SpeedFactor;
	return BaseGroundSpeed;
}

simulated function ClientUpdateSpeed()
{
	if (Instigator != None && BaseGroundSpeed > 0)
		Instigator.GroundSpeed = SprintGroundSpeed(IsSprintActive());
}

simulated event Tick(float DT)
{
	// A client can't destroy it (it also has the one of a player it spectates, without an Instigator), so stop here
	if (Instigator == None)
	{
		Destroy();
		return;
	}

	if (SettingsChecksLeft > 0 && Level.TimeSeconds >= NextSettingsCheckTime)
	{
		NextSettingsCheckTime = Level.TimeSeconds + 0.25;
		SettingsChecksLeft--;
		if (class'BallisticReplicationInfo'.static.GetInstance(self) != None)
		{
			SettingsChecksLeft = 0;
			ApplyServerSettings();
		}
	}

	if (PredictEndTime > 0)
	{
		// The window is long enough for the server's answer. Without one, go back to what the server last said
		if (Level.TimeSeconds >= PredictEndTime)
		{
			PredictEndTime = 0;
			PendingReplies = 0;
		}
		// Speeds from before the server heard of the change may still be arriving
		ClientUpdateSpeed();
	}

	// The server never paid the costs it hasn't echoed by now, so they were predicted wrongly
	if (JumpEchoes > 0 && Level.TimeSeconds >= JumpEchoTime)
	{
		Stamina = FMin(MaxStamina, Stamina + JumpDrain * JumpEchoes);
		JumpEchoes = 0;
	}

	TrackSprintKey();
	TickSprint(DT);
}

//=============================================================================
// SPRINT
//=============================================================================

// Whether the sprint key counts as held down. The owning client goes by its
// own prediction for as long as the server's answer can still be on its way.
simulated function bool IsSprintActive()
{
	if (Role < ROLE_Authority)
	{
		// ended by the holder's weapon, and the server's word of that may still be on its way
		if (Level.TimeSeconds < CancelEndTime)
			return false;
		if (Level.TimeSeconds < PredictEndTime)
			return bPredictedSprint;
	}
	return bSprintActive;
}

// How long the client waits for the server's word on something it predicted. An answer that got lost
// and was sent again takes about three round trips.
simulated function float PredictionWindow()
{
	local PlayerController PC;

	if (Instigator != None)
		PC = PlayerController(Instigator.Controller);
	if (PC == None)
		return 0.5;
	return FClamp(3.0 * PC.ExactPing + 0.25, 0.3, 1.5);
}

// Client: whether the server's GroundSpeed can be worked out from BaseGroundSpeed. Something else than
// this sprint control may have set it, like a round start lock, and predicting would undo that.
simulated function bool CanPredictSpeed()
{
	if (Role == ROLE_Authority || Instigator == None || BaseGroundSpeed <= 0)
		return false;

	// Already predicting. GroundSpeed can be anything the server sent since, it gets set again every tick
	if (Level.TimeSeconds < PredictEndTime)
		return true;

	return Abs(Instigator.GroundSpeed - SprintGroundSpeed(bSprintActive)) < 0.5;
}

// Client: the player pressed or released the sprint key, and the server is being asked
// to StartSprint or StopSprint. Work out what it will do with that and do it here already.
// True if that was done, and the server's answer to the request is now waited for.
simulated function bool PredictSprint(bool bWantSprint)
{
	// a new sprint is asked for: the one the weapon ended is done with
	if (bWantSprint)
		CancelEndTime = 0;

	if (!class'BallisticReplicationInfo'.default.bEnableSprint || !CanPredictSpeed())
		return false;

	if (bWantSprint && !IsSprintActive())
		bWantSprint = Stamina > 0 && Instigator.Physics == PHYS_Walking && !Instigator.bIsCrouched && CheckDirection();
	else if (!bWantSprint && IsSprintActive())
		PredictDelayRecharge();

	bPredictedSprint = bWantSprint;
	PendingReplies++;
	PredictEndTime = Level.TimeSeconds + PredictionWindow();
	ClientUpdateSpeed();
	return true;
}

// Client: the server is about to stop the sprint on its own, because a slide started or stamina ran out
simulated function PredictStopSprint()
{
	if (!IsSprintActive() || !CanPredictSpeed())
		return;

	PredictDelayRecharge();
	bPredictedSprint = false;
	PredictEndTime = Level.TimeSeconds + PredictionWindow();
	ClientUpdateSpeed();
}

// Client: the move that predicted a stamina cost is being run again and will predict it once more
simulated function UnpredictJumped()
{
	if (JumpEchoes <= 0)
		return;

	JumpEchoes--;
	Stamina = FMin(MaxStamina, Stamina + JumpDrain);
}

// Client: StopSprint delays the recharge. Start that delay with the predicted stop
simulated function PredictDelayRecharge()
{
	DelayRecharge();
	RechargeEchoTime = Level.TimeSeconds + PredictionWindow();
}

// Server to owning client: a sprint request has been dealt with and this is what came of it
simulated function ClientSprintReply(bool bActive)
{
	if (Role == ROLE_Authority)
		return;

	bSprintActive = bActive;
	if (PendingReplies > 0)
		PendingReplies--;
	// Answers to older requests don't count while a newer one is under way
	if (PendingReplies == 0 && PredictEndTime > 0)
	{
		PredictEndTime = 0;
		ClientUpdateSpeed();
	}
}

// The holder's weapon ends the sprint, for a shot or for its sights, and its gun comes back within OffsetTime. As with
// the sprint key, the owner's machine goes ahead with it and the server is told.
simulated function CancelSprint(float OffsetTime)
{
	local bool bReply;

	if (Role == ROLE_Authority)
		StopSprint();
	else if (IsSprintActive())
	{
		// like the key being let go, where the speed can be told
		bReply = PredictSprint(false);
		CancelEndTime = Level.TimeSeconds + PredictionWindow();
		ServerCancelSprint(bReply, OffsetTime);
	}

	EndSprinting();
}

// Owning client to server: its weapon has ended the sprint
function ServerCancelSprint(bool bReply, float OffsetTime)
{
	StopSprint();
	EndSprinting();
	if (BallisticWeapon(Instigator.Weapon) != None)
		BallisticWeapon(Instigator.Weapon).HurrySprintOffset(OffsetTime);
	if (bReply)
		ClientSprintReply(bSprintActive);
}

// The holder is no longer seen sprinting: the weapon in hand comes back from where the sprint put it
simulated function EndSprinting()
{
	if (!bSprinting)
		return;

	bSprinting = false;

	if (BallisticWeapon(Instigator.Weapon) != None)
		BallisticWeapon(Instigator.Weapon).PlayerSprint(false);

	if (Instigator != None && Instigator.Inventory != None)
		Instigator.Inventory.OwnerEvent('StopSprint');
}

// Tells the weapon in hand that a sprint has begun, whoever began it, and keeps track of the fire keys for it: one
// that is down when the sprint begins is no press to end that sprint with (BallisticWeapon.SprintHoldsFire)
simulated function TrackSprintKey()
{
	local Controller C;
	local bool bActive;

	C = Instigator.Controller;
	bActive = IsSprintActive();

	if (PlayerController(C) != None && Instigator.IsLocallyControlled())
	{
		if (bActive && !bWasSprintActive)
		{
			bStaleFire = C.bFire != 0;
			bStaleAltFire = C.bAltFire != 0;
		}
		else
		{
			if (C.bFire == 0)
				bStaleFire = false;
			if (C.bAltFire == 0)
				bStaleAltFire = false;
		}
	}

	if (bActive && !bWasSprintActive && BallisticWeapon(Instigator.Weapon) != None)
		BallisticWeapon(Instigator.Weapon).SprintStarted();

	bWasSprintActive = bActive;
}

//If Stamina's less than 0 or Sprint's active
//return
function StartSprint()
{
	if (AIController(Instigator.Controller) == None && !class'BallisticReplicationInfo'.default.bEnableSprint)
		return;
		
	if (Stamina <= 0  || Instigator.Physics != PHYS_Walking || Instigator.bIsCrouched || bSprintActive || !CheckDirection())
		return;

	bSprintActive = true;

	if (Instigator != None)
        UpdateSpeed();

	//log("BCSprintControl: Started sprinting for bot " $ Instigator.PlayerReplicationInfo.PlayerName);

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
	if (Level.NetMode != NM_Client)
		return;

	// Already delayed when the stop was predicted. Doing it again now would let the server recharge first
	if (Level.TimeSeconds < RechargeEchoTime)
		RechargeEchoTime = 0;
	else
		DelayRecharge();
}

simulated function ClientJumped()
{
	if (Level.NetMode != NM_Client)
		return;

	if (JumpEchoes > 0 && Level.TimeSeconds < JumpEchoTime)
		JumpEchoes--;
	else
	{
		JumpEchoes = 0;
		Jumped();
	}
}

// Client: pay a stamina cost at the move it is predicted in. The server pays it when it runs that move,
// and for as long as only one of the two has paid, they recharge differently and drift apart.
simulated function PredictJumped()
{
	if (Role == ROLE_Authority)
		return;

	Jumped();
	JumpEchoes++;
	JumpEchoTime = Level.TimeSeconds + PredictionWindow();
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
	if (IsSprintActive() && Instigator.Physics != PHYS_Falling && VSize(Instigator.Acceleration) > 100 && VSize(Instigator.Velocity) > 50)
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
		else if (Stamina <= 0)
			PredictStopSprint();
	}
	// Stamina charges when not sprinting
	else if (Instigator.Physics != PHYS_Falling) // if (VSize(RV) < class'BallisticReplicationInfo'.default.PlayerGroundSpeed * 0.8)
	{
		EndSprinting();

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
	 JumpDrain=10.000000
     SpeedFactor=1.500000
	 SlowFactor=1.000000
     bReplicateInstigator=True
}
