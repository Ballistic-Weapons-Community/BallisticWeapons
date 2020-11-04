//=============================================================================
// BCSprintControl.
//
// A special inventory actor used to control player sprinting. Key events must
// be sent from somewhere like a mutator.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BCSprintControl extends Inventory;

var() float		Stamina;			// Stamina level of player. Players can't sprint when this is out
var() float		MaxStamina;			// Max level of stamina
var() float		StaminaDrainRate;	// Amount of stamina lost each second when sprinting
var() float		StaminaChargeRate;	// Amount of stamina gained each second when not sprinting
var   bool		bSprinting;			// Currently sprinting
var   bool		bSprintActive;		// Sprint key is held down
var() float		SpeedFactor;		// Player speed multiplied by this when sprinting

replication
{
	reliable if (Role == ROLE_Authority)
		bSprintActive, ClientJumped;
}

//If Stamina's less than 0 or Sprint's active
//return
singular function StartSprint()
{
	local float NewSpeed;

	if (Stamina <= 0 || Instigator.bIsCrouched || bSprintActive)
		return;

	bSprintActive = true;
    
	if (Instigator != None)
	{
		NewSpeed = Instigator.default.GroundSpeed * SpeedFactor;
		if (BallisticWeapon(Instigator.Weapon) != None)
			NewSpeed *=  BallisticWeapon(Instigator.Weapon).PlayerSpeedFactor;
		if (ComboSpeed(xPawn(Instigator).CurrentCombo) != None)
			NewSpeed *= 1.4;
		Instigator.GroundSpeed = NewSpeed;
	}
}

// Sprint Key released. Used on Client and Server
singular function StopSprint()
{
	local float NewSpeed;
	
	if (!bSprintActive)
		return;
	bSprintActive = false;
	
	if (Instigator != None)
	{
		NewSpeed = Instigator.default.GroundSpeed;
		if (BallisticWeapon(Instigator.Weapon) != None)
			NewSpeed *=  BallisticWeapon(Instigator.Weapon).PlayerSpeedFactor;
		if (ComboSpeed(xPawn(Instigator).CurrentCombo) != None)
			NewSpeed *= 1.4;
		Instigator.GroundSpeed = NewSpeed;
	}
}

simulated function OwnerEvent(name EventName)
{
	super.OwnerEvent(EventName);
	if (EventName == 'Jumped' || EventName == 'Dodged')
	{
		ClientJumped();
		Stamina = FMax(0, Stamina - StaminaDrainRate * 0.5);
	}
}
simulated function ClientJumped()
{
	if (level.NetMode != NM_Client)
		return;
	Stamina = FMax(0, Stamina - StaminaDrainRate * 0.5);
}

simulated event Tick(float DT)
{
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
		Stamina -= StaminaDrainRate * DT;
		if (Role == ROLE_Authority)
		{
			if (Stamina <= 0 || Instigator.bIsCrouched || Instigator.Physics != PHYS_Walking)
				StopSprint();
		}
	}

	// Stamina charges when not sprinting
	else
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
			Stamina += StaminaChargeRate * DT;
	}
	Stamina = FClamp(Stamina, 0, MaxStamina);
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	Super.GiveTo(Other);

	if (Instigator != None && Instigator.Weapon != None && BallisticWeapon(Instigator.Weapon) != None && BallisticWeapon(Instigator.Weapon).SprintControl == None)
		BallisticWeapon(Instigator.Weapon).SprintControl = self;
}

defaultproperties
{
     Stamina=100.000000
     MaxStamina=100.000000
     StaminaDrainRate=10.000000
     StaminaChargeRate=7.000000
     SpeedFactor=1.350000
     bReplicateInstigator=True
}
