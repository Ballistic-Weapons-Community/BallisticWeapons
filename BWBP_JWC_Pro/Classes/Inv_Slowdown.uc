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

var float	SlowdownFactor, MaxLifeSpan;

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	Super.GiveTo(Other, Pickup);
	
	CalcNewMoveSpeed();
}

function OwnerEvent(name EventName)
{
	if (EventName == 'ChangedWeapon')
		CalcNewMoveSpeed();
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
		NewSpeed *= SlowdownFactor;
	if (BallisticWeapon(Instigator.Weapon) != None)
		NewSpeed *= BallisticWeapon(Instigator.Weapon).PlayerSpeedFactor;
	if (BallisticWeapon(Instigator.Weapon).SprintControl != None && BallisticWeapon(Instigator.Weapon).SprintControl.bSprinting)
		NewSpeed *= BallisticWeapon(Instigator.Weapon).SprintControl.SpeedFactor;
	if (ComboSpeed(xPawn(Instigator).CurrentCombo) != None)
		NewSpeed *= 1.4;
	if (Instigator.GroundSpeed != NewSpeed)
		Instigator.GroundSpeed = NewSpeed;
}

function ExtendDuration(float TimeToAdd)
{
	LifeSpan = Min(LifeSpan + TimeToAdd, MaxLifeSpan);
}

simulated function Destroyed()
{
	if (Role == ROLE_Authority)
		CalcNewMoveSpeed(true);
	Super.Destroyed();
}

defaultproperties
{
     SlowdownFactor=0.650000
     MaxLifeSpan=6.000000
     LifeSpan=2.000000
}
