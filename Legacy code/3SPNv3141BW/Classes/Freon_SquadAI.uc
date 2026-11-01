class Freon_SquadAI extends SquadAI;

/*function name GetOrders()
{
    local name NewOrders;

    if(PlayerController(SquadLeader) != None && SquadLeader.PlayerReplicationInfo != None && SquadLeader.PlayerReplicationInfo.bOutOfLives)
        NewOrders = 'Human';
    else if(bFreelance && !bFreelanceAttack && !bFreelanceDefend)
        NewOrders = 'Freelance';
    else if(SquadObjective != None && SquadObjective.DefenderTeamIndex == Team.TeamIndex)
        NewOrders = 'Defend';
    else 
        NewOrders = 'Attack';

    if(NewOrders != CurrentOrders)
    {
        NetUpdateTime = Level.TimeSeconds - 1;
        CurrentOrders = NewOrders;
    }

    return CurrentOrders;
}*/

function bool ValidEnemy(Pawn NewEnemy)
{
    if(Freon_Pawn(NewEnemy) != None && Freon_Pawn(NewEnemy).bFrozen)
        return false;

    return Super.ValidEnemy(NewEnemy);
}

function bool TellBotToFollow(Bot B, Controller C)
{
    if(C != None && C.PlayerReplicationInfo != None && C.PlayerReplicationInfo.bOutOfLives)
        return false;

    return Super.TellBotToFollow(B, C);
}

function bool CheckSquadObjectives(Bot B)
{
    local int i;

    if(TryingToThaw(B))
        return true;

    if(Freon_Player(SquadLeader) != None && Freon_Player(SquadLeader).FrozenPawn != None)
        if(SetThawTarget(B, Freon_Player(SquadLeader).FrozenPawn))
            return true;

    if(Freon(Level.Game).FrozenPawns.Length > 0)
    {
        for(i = 0; i < Freon(Level.Game).FrozenPawns.Length; i++)
        {
            if(Freon(Level.Game).FrozenPawns[i] != None && Freon(Level.Game).FrozenPawns[i].GetTeamNum() == Team.TeamIndex)
            {
                if(SetThawTarget(B, Freon(Level.Game).FrozenPawns[i]))
                    return true;
            }
        }
    }

    return Super.CheckSquadObjectives(B);
}

function bool TryingToThaw(Bot B)
{
    /*if((B.MoveTarget != None && Freon_Trigger(B.MoveTarget) != None))
        return Freon_Trigger(B.MoveTarget).TellBotToThaw(B);*/

    if((B.MoveTarget != None && Freon_Pawn(B.MoveTarget) != None) && Freon_Pawn(B.MoveTarget).MyTrigger != None)
        return Freon_Pawn(B.MoveTarget).MyTrigger.TellBotToThaw(B);

    return false;
}

function bool SetThawTarget(Bot B, Freon_Pawn P)
{
    local Freon_Trigger FT;

    if(P != None && P.MyTrigger != None)
        FT = P.MyTrigger;
    else
        return false;

    return FT.TellBotToThaw(B);
}

defaultproperties
{
}
