//===========================================================================
// Inv_Slowdown.
//
// Inventory item given to a player when hit by a slowdown weapon.
// Recalculates the player's speed from its components on spawn
// and on weapon change.
//
// by Azarael.
//===========================================================================
class Inv_Slowdown extends Inventory;

struct SlowInfo
{
	var float Factor;
	var float Duration;
};

var array<SlowInfo> ActiveSlows;

var float CurrentSlowFactor, NextTimerPop;

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	Super.GiveTo(Other, Pickup);
	
	CalcNewMoveSpeed();
}

function OwnerEvent(name EventName)
{	
	if (EventName == 'ChangedWeapon')
		CalcNewMoveSpeed();
	if (EventName == 'SpeedChange')
		Instigator.GroundSpeed *= CurrentSlowFactor;
	if( Inventory != None )
		Inventory.OwnerEvent(EventName);
}

//===========================================================================
// CalcNewMoveSpeed
// Recalculates the speed from known base components.
// FIXME:
// Disregards Sprint if the player's weapon is not a BallisticWeapon or doesn't exist.
// Won't account for Dark Star speedups or any similarly undeclared boosts (possibly from ICIS 
// stimpack variants). These speed modifications will be neutralised!
//===========================================================================
function CalcNewMoveSpeed(optional bool bReset)
{
	local float NewSpeed;
	
	NewSpeed = Instigator.default.GroundSpeed;
	
	if (!bReset)
		NewSpeed *= CurrentSlowFactor;

	if (BallisticWeapon(Instigator.Weapon) != None)
	{
		NewSpeed *= BallisticWeapon(Instigator.Weapon).PlayerSpeedFactor;
		if (BallisticWeapon(Instigator.Weapon).SprintControl != None && BallisticWeapon(Instigator.Weapon).SprintControl.bSprinting)
			NewSpeed *= BallisticWeapon(Instigator.Weapon).SprintControl.SpeedFactor;
	}

	if (ComboSpeed(xPawn(Instigator).CurrentCombo) != None)
		NewSpeed *= 1.4;
        
	if (Instigator.GroundSpeed != NewSpeed)
		Instigator.GroundSpeed = NewSpeed;
}

function AddSlow(float myFactor, float myDuration)
{
	local int i;
	local float LowestDuration, LowestFactor;
	
	//Seek existing slows of the same factor.
	for (i=0; i<ActiveSlows.Length && ActiveSlows[i].Factor != myFactor; i++);
	
	//If none, add a new slow and adjust the timer and durations here.
	if (i == ActiveSlows.Length)
	{
		LowestDuration = myDuration;
		LowestFactor = myFactor;
		
		for (i=0; i<ActiveSlows.Length; i++)
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
		CurrentSlowFactor = LowestFactor;
		
		CalcNewMoveSpeed();
	}
	
	//Otherwise just add duration to the existing slow.
	else ActiveSlows[i].Duration += myDuration;
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
		Destroy();
	else
	{
		if (bRemovedSlow)
		{
			CurrentSlowFactor = LowestFactor;
			CalcNewMoveSpeed();
		}
		NextTimerPop = LowestDuration;
		SetTimer(LowestDuration, false);
	}
}

function AddNewSlow()
{
	local SlowInfo S;
	
	ActiveSlows[ActiveSlows.Length] = S;
}

simulated function Destroyed()
{
	if (Role == ROLE_Authority)
		CalcNewMoveSpeed(true);
	Super.Destroyed();
}

defaultproperties
{
}
