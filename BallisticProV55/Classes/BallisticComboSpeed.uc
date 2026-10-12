//=============================================================================
// BallisticComboSpeed.
//
// The speed combo for a BallisticPawn (see BallisticPawn.DoCombo).
//
// The stock one ends with Level.Game.SetPlayerDefaults. That sets the pawn's
// speeds to its class defaults, and the default ground speed of a
// BallisticPawn is a figure for the animations, not the game style's speed.
// It then runs every mutator's ModifyPlayer again, which for this mod is the
// set-up of a fresh spawn: health back to the starting health, starting
// armour and ammunition added, the loadout handed out once more.
//
// This one takes back what it gave, and has the ground speed worked out
// afresh at both ends, so the weapon in hand, a sprint and slows are in it
// and the sprint control's base speed, which the owner's client predicts
// with, has the combo's share while it lasts.
//=============================================================================
class BallisticComboSpeed extends ComboSpeed;

function StartEffect(xPawn P)
{
	Super.StartEffect(P);

	// xPawn.DoCombo only sets this when the spawn that called us returns, and the speed is worked out from it
	P.CurrentCombo = self;
	UpdateGroundSpeed(P, 1.4);
}

function StopEffect(xPawn P)
{
	if (LeftTrail != None)
		LeftTrail.Destroy();

	if (RightTrail != None)
		RightTrail.Destroy();

	P.AirControl /= 1.4;
	P.WaterSpeed /= 1.4;
	P.AirSpeed /= 1.4;
	P.JumpZ /= 1.5;

	// Combo.Destroyed only clears this after us
	if (P.CurrentCombo == self)
		P.CurrentCombo = None;
	UpdateGroundSpeed(P, 1.0 / 1.4);
}

// The sprint control (or, without one, the weapon) knows what goes into the ground speed and asks whether a speed
// combo is on. A pawn with neither just gets or loses the combo's own share: Factor
function UpdateGroundSpeed(xPawn P, float Factor)
{
	local BCSprintControl SC;

	SC = BCSprintControl(P.FindInventoryType(class'BCSprintControl'));
	if (SC != None)
		SC.UpdateSpeed();
	else if (BallisticWeapon(P.Weapon) != None)
		BallisticWeapon(P.Weapon).UpdateSpeed();
	else if (Factor < 1.0)
		P.GroundSpeed *= Factor;
}

defaultproperties
{
}
