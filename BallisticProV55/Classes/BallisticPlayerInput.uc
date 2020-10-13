//=================================================================
// BallisticPlayerInput.
//
// This class exists to provide the ability to dodge 
// by holding down a single key.
//=================================================================
class BallisticPlayerInput extends PlayerInput
	transient;
	
var bool bDodgeHeld;
	
// check for double click move
// this version allows a single-button dodge,
// and the game setting to disable dodging disables the double-tap version
function Actor.eDoubleClickDir CheckForDoubleClickMove(float DeltaTime)
{
	local Actor.eDoubleClickDir DoubleClickMove, OldDoubleClick;

    if ( DoubleClickDir == DCLICK_Active )
		DoubleClickMove = DCLICK_Active;
	else
		DoubleClickMove = DCLICK_None;
		
	if (DoubleClickTime > 0.0)
	{
		if ( DoubleClickDir == DCLICK_Active )
		{
			if ( (Pawn != None) && (Pawn.Physics == PHYS_Walking) )
			{
				DoubleClickTimer = 0;
				DoubleClickDir = DCLICK_Done;
			}
		}
		else if ( DoubleClickDir != DCLICK_Done )
		{
			OldDoubleClick = DoubleClickDir;
			DoubleClickDir = DCLICK_None;

			if (((bEnableDodging && bEdgeForward) || BallisticPlayer(Outer).bDodgeHeld) && bWasForward)
				DoubleClickDir = DCLICK_Forward;
			else if (((bEnableDodging && bEdgeBack) || BallisticPlayer(Outer).bDodgeHeld) && bWasBack)
				DoubleClickDir = DCLICK_Back;
			else if (((bEnableDodging && bEdgeLeft) || BallisticPlayer(Outer).bDodgeHeld) && bWasLeft)
				DoubleClickDir = DCLICK_Left;
			else if (((bEnableDodging && bEdgeRight) || BallisticPlayer(Outer).bDodgeHeld) && bWasRight)
				DoubleClickDir = DCLICK_Right;

			if ( DoubleClickDir == DCLICK_None)
				DoubleClickDir = OldDoubleClick;
			else if ( DoubleClickDir != OldDoubleClick )
				DoubleClickTimer = DoubleClickTime + 0.5 * DeltaTime;
			else
			{
				DoubleClickMove = DoubleClickDir;
				BallisticPlayer(Outer).bDodgeHeld = false;
			}
		}

		if (DoubleClickDir == DCLICK_Done)
		{
			DoubleClickTimer = FMin(DoubleClickTimer-DeltaTime,0);
			if (DoubleClickTimer < -0.35)
			{
				DoubleClickDir = DCLICK_None;
				DoubleClickTimer = DoubleClickTime;
			}
		}
		else if ((DoubleClickDir != DCLICK_None) && (DoubleClickDir != DCLICK_Active))
		{
			DoubleClickTimer -= DeltaTime;
			if (DoubleClickTimer < 0)
			{
				DoubleClickDir = DCLICK_None;
				DoubleClickTimer = DoubleClickTime;
			}
		}
	}
	return DoubleClickMove;
}

defaultproperties
{
}