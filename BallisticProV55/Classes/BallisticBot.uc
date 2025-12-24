class BallisticBot extends xBot;

function MaySlideToMoveTarget()
{
    local vector Dir, NewDir;
    local float Dist,NewDist;
    local Actor OldMoveTarget;

    if ( (Pawn.Physics != PHYS_Walking) || ((FRand() > 0.85) && (RoadPathNode(MoveTarget) == None)) )
        return;

    if ( (bTranslocatorHop || (Focus != MoveTarget)) && (Skill + Tactics < 4) )
        return;

    Dir = MoveTarget.Location - Pawn.Location;
    Dist = VSize(Dir);
    OldMoveTarget = MoveTarget;

    // only slide if far enough to destination
    if ( (Dist < 600) || (Dir.Z < 0) )
    {
        // maybe change movetarget
        if ( ((PathNode(MoveTarget) == None) && (PlayerStart(MoveTarget) == None)) || (MoveTarget != RouteCache[0]) || (RouteCache[0] == None) )
        {
            if ( Dist < 100 )
                return;
        }
        else if ( RouteCache[1] != None )
        {
            if ( Pawn.Location.Z + MAXSTEPHEIGHT < RouteCache[1].Location.Z )
            {
                if ( Dist < 100 )
                    return;
            }

            NewDir = RouteCache[1].Location - Pawn.Location;
            NewDist = VSize(NewDir);
            if ( (NewDist > 400) && CanMakePathTo(RouteCache[1]) )
            {
                Dist = NewDist;
                MoveTarget = RouteCache[1];
            }
            else if ( Dist < 100 )
                return;
        }
    }
    if ( Focus == OldMoveTarget )
        Focus = MoveTarget;
    Destination = MoveTarget.Location;
    BallisticPawn(Pawn).StartSlide();
}

function bool CanSprint()
{
    if(BallisticPawn(Pawn) != None && BallisticPawn(Pawn).Sprinter != none)
        if((Skill > 1 + 4.5 * FRand()) && (BallisticPawn(Pawn).Sprinter.Stamina >= 20.f) && FRand() > 0.2)
            return true;
    return false;
}

state Roaming
{
    event NotifyPostLanded()
    {
        super.NotifyPostLanded();
        //GoToState(,'Sliding');
    }

    function EndState()
    {
        super.EndState();
        Jumpiness -= 0.3;
        if(BallisticPawn(Pawn) != None && BallisticPawn(Pawn).Sprinter != none)
            BallisticPawn(Pawn).Sprinter.StopSprint();
    }

Begin:
	SwitchToBestWeapon();
	WaitForLanding();
	if ( Pawn.bCanPickupInventory && (InventorySpot(MoveTarget) != None) && (Squad.PriorityObjective(self) == 0) && (Vehicle(Pawn) == None) )
	{
		MoveTarget = InventorySpot(MoveTarget).GetMoveTargetFor(self,5);
		if ( (Pickup(MoveTarget) != None) && !Pickup(MoveTarget).ReadyToPickup(0) )
		{
			CampTime = MoveTarget.LatentFloat;
			GoalString = "Short wait for inventory "$MoveTarget;
			GotoState('RestFormation','ShortWait');
		}
	}
	MoveToward(MoveTarget,FaceActor(1),GetDesiredOffset(),ShouldStrafeTo(MoveTarget));
    if(CanSprint())
    {
        BallisticPawn(Pawn).Sprinter.StartSprint();
        //log("BallisticBot: Sprinting to MoveTarget");
        Jumpiness += 0.3;
    }
DoneRoaming:
	WaitForLanding();
	WhatToDoNext(12);
	if ( bSoaking )
		SoakStop("STUCK IN ROAMING!");
/* 
Sliding:
    GoalString = GoalString$" (Sliding)";
    WaitForLanding();
    MaySlideToMoveTarget();
	WhatToDoNext(67);
	if ( bSoaking )
		SoakStop("STUCK IN MOVETOGOAL (Sliding)!");
*/
}

state Fallback
{
    event NotifyPostLanded()
    {
        super.NotifyPostLanded();
        //GoToState(,'Sliding');
    }
    function EndState()
    {
        super.EndState();
        Jumpiness -= 0.3;
        if(BallisticPawn(Pawn) != None && BallisticPawn(Pawn).Sprinter != none)
            BallisticPawn(Pawn).Sprinter.StopSprint();
    }
Begin:
	WaitForLanding();

Moving:
	if ( Pawn.bCanPickupInventory && (InventorySpot(MoveTarget) != None) && (Vehicle(Pawn) == None) )
		MoveTarget = InventorySpot(MoveTarget).GetMoveTargetFor(self,0);
	MoveToward(MoveTarget,FaceActor(1),GetDesiredOffset(),ShouldStrafeTo(MoveTarget));
    if(CanSprint())
    {
        BallisticPawn(Pawn).Sprinter.StartSprint();
        //log("BallisticBot: Sprinting to MoveTarget");
        Jumpiness += 0.3;
    }
	WhatToDoNext(14);
	if ( bSoaking )
		SoakStop("STUCK IN FALLBACK!");
	goalstring = goalstring$" STUCK IN FALLBACK!";
/* 
Sliding:
    GoalString = GoalString$" (Sliding)";
    WaitForLanding();
    MaySlideToMoveTarget();
	WhatToDoNext(74);
	if ( bSoaking )
		SoakStop("STUCK IN MOVETOGOAL (Sliding)!");
*/
}


defaultproperties
{
    PawnClass=class'BallisticProV55.BallisticPawn'
}