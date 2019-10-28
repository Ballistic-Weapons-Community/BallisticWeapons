// Misc_DynComboManager:
// manages the running of multiple team-wide combos
// 1) keeps track of affected (alive) players
// 2) keeps track of each combo's adrenaline pool
// 3) keeps track of the number and types of combos running
class Misc_DynComboManager extends Info;

struct ComboData
{
    var float Adrenaline;    // adrenaline pools for the running combo(s)
    var float Cost;          // adrenaline cost (generally 100)
    var float Duration;      // combo duration (generally 30)
    var byte Type;           // combo type (0 = none, 1 = booster, 2 = speed, 
                             //       3 = berserk, 4 = invis, 7 = other)
    var class<Combo> Class;  // combo class
    var float LastUpdate;    // time of last update    
};

var Misc_DynComboReplicationInfo ComboRI;

var byte TeamIndex;          // owner team; 0 for red, 1 for blue

var bool bComboRunning;      // true if a dynamic combo is running for the team

var Array<ComboData> Combos; // combo data (brilliant!)
var byte Affected;           // number of players on team affected by this dynamic combo (keep updated)

var byte Count;              // number of combos running
var byte LastCount;          // number of combos running at the end of the last cycle
var float TotalTick;         // total running time
var byte NextCombo;          // the next combo to update

// 1) simply keep Affected updated
// 2) update clients
function Timer()
{
    if(!bComboRunning)
        return;

    CountAffected();
    UpdateClients();
}

// 1) update each client's combo data
function UpdateClients()
{
    local int i;

    ComboRI.bRunning = bComboRunning;

    if(bComboRunning)
    {
        if(Affected > 0)
        {
            for(i = 0; i < Combos.Length; i++)
            {
                if(i > ArrayCount(ComboRI.Combos))
                    break;

                ComboRI.Combos[i].Type = Combos[i].Type;
                ComboRI.Combos[i].Time = ((Combos[i].Adrenaline * Combos[i].Duration * 0.01) / Affected) + 1;
            }
        }

        while(i < ArrayCount(ComboRI.Combos))
        {
            ComboRI.Combos[i].Time = 0.0;
            ComboRI.Combos[i].Type = 0;
            i++;
        }
    }

    ComboRI.NetUpdateTime = Level.TimeSeconds - 1;
}

// a player has spawned, if a combo is running give it to them
function PlayerSpawned(Controller C)
{
    local int i;

    if(C == None || xPawn(C.Pawn) == None || C.PlayerReplicationInfo == None || C.GetTeamNum() != TeamIndex || Combos.Length == 0)
        return;

    if(xPawn(C.Pawn).CurrentCombo != None)
        return;

    xPawn(C.Pawn).CurrentCombo = Spawn(class'Misc_DynCombo', xPawn(c.Pawn));

    if(Misc_DynCombo(xPawn(c.Pawn).CurrentCombo) == None)
        return;

    Misc_DynCombo(xPawn(c.Pawn).CurrentCombo).ComboManager = self;

    for(i = 0; i < Combos.Length; i++)
        Misc_DynCombo(xPawn(c.Pawn).CurrentCombo).AddCombo(Combos[i].Class);

    CountAffected();
    UpdateClients();
}

// 1) count the players affected by the running combos
// 2) give the used combo to the team
// 3) replicate data to clients
function PlayerUsedCombo(Controller Player, class<Combo> ComboClass)
{
    local Controller c;
    local byte i;
    local byte type;

    if(ComboClass == None)
        return;

    if(TeamIndex == 255)
        TeamIndex = Player.GetTeamNum();
    
    // find the best spot for this combo in the list
    for(i = 0; i <= Combos.Length; i++)
    {
        if(i == Combos.Length)
        {
            Combos.Length = Combos.Length + 1;
            break;
        }

        if(Combos[i].Class == ComboClass)
            break;
    }

    // fill combo data for this combo
    if(class<ComboDefensive>(ComboClass) != None)
        type = 1;
    else if(class<ComboSpeed>(ComboClass) != None)
        type = 2;
    else if(class<ComboBerserk>(ComboClass) != None)
        type = 3;
    else if(class<ComboInvis>(ComboClass) != None)
        type = 4;
    else
        type = 7;

    Combos[i].Cost = ComboClass.default.AdrenalineCost;
    Combos[i].Adrenaline += Combos[i].Cost;
    Combos[i].Class = ComboClass;
    Combos[i].Type = type;
    Combos[i].Duration = ComboClass.default.Duration;

    // count affected players; give them the combo
    Affected = 0;
    for(c = Level.ControllerList; c != None; c = c.NextController)
    {
        if(c.PlayerReplicationInfo == None || c.PlayerReplicationInfo.Team == None || xPawn(c.Pawn) == None)
            continue;

        if(c.GetTeamNum() == TeamIndex)
        {
            Affected++;

            if(xPawn(c.Pawn).CurrentCombo == None)
            {
                xPawn(c.Pawn).CurrentCombo = Spawn(class'Misc_DynCombo', xPawn(c.Pawn));

                if(Misc_DynCombo(xPawn(c.Pawn).CurrentCombo) == None)
                {
                    ClearData();
                    return;
                }

                Misc_DynCombo(xPawn(c.Pawn).CurrentCombo).ComboManager = self;
            }

            Misc_DynCombo(xPawn(c.Pawn).CurrentCombo).AddCombo(ComboClass);
        }
    }

    Combos[i].LastUpdate = TotalTick;
    NextCombo = 0;
    Count = 0;

    if(!bComboRunning)
    {
        bComboRunning = true;
        Enable('Tick');
    }
    
    UpdateClients();
    Player.Adrenaline = FMax(0.1, Player.Adrenaline - Combos[i].Cost);

    SetTimer(3.0, true);
}

// 1) a player died, maybe running a dynamic combo
// if so, reallocate the remaining adrenaline between 
// the remaining players (count affected)
// 2) if no players are remaining, set bComboRunning to false
// 3) replicate data to clients
function PlayerDied(Controller Player)
{
    if(!bComboRunning || Player.Pawn != None)
        return;

    // counting the affected has the effect of redistributing the pool
    CountAffected(Player);

    // update the clients
    UpdateClients();
}

// 1) reduce adrenaline pools by the proper amount
// 2) if a combo reaches 0 adrenaline, destroy it
// 3) if all combos reach 0 adrenaline, destroy the DynCombo
// 4) if #2 or #3 occur, replicate data to clients
function Tick(float DeltaTime)
{    
    if(!bComboRunning)
    {
        Disable('Tick');
        SetTimer(0.0, false);
        TotalTick = 0.0;
        return;
    }

    TotalTick += DeltaTime;

    if(Combos[NextCombo].Adrenaline > 0.0)
    {
        DeltaTime = TotalTick - Combos[NextCombo].LastUpdate;
        Combos[NextCombo].Adrenaline -= (Combos[NextCombo].Cost * DeltaTime / Combos[NextCombo].Duration) * Affected;

        if(Combos[NextCombo].Adrenaline <= 0.0)
        {
            ClearDynCombosOf(Combos[NextCombo].Class);
            Combos[NextCombo].Class = None;
            Combos[NextCombo].Adrenaline = 0.0;
            Combos[NextCombo].Cost = 0;
            Combos[NextCombo].Duration = 0;
            Combos[NextCombo].Type = 0;
            Combos[NextCombo].LastUpdate = 0.0;
            Combos.Remove(NextCombo, 1);
        }
        else
        {
            Count++;
            Combos[NextCombo].LastUpdate = TotalTick;
            NextCombo++;
        }
    }

    //NextCombo++;
    if(NextCombo >= Combos.Length)
    {
        NextCombo = 0;

        if(Count == 0)
        {
            ClearData();
            return;
        }

        if(LastCount > Count)
            UpdateClients();
        LastCount = Count;
        Count = 0;
    }
}

function ClearDynCombosOf(class<Combo> ComboClass)
{
    local Controller C;

    for(C = Level.ControllerList; C != None; C = C.NextController)
    {
        if(xPawn(C.Pawn) != None)
        {
            if(Misc_DynCombo(xPawn(C.Pawn).CurrentCombo) != None && Misc_DynCombo(xPawn(C.Pawn).CurrentCombo).ComboManager == self)
                Misc_DynCombo(xPawn(C.Pawn).CurrentCombo).RemoveCombo(ComboClass);
        }
    }
}

function ClearDynCombos()
{
    local Controller C;

    for(C = Level.ControllerList; C != None; C = C.NextController)
    {
        if(xPawn(C.Pawn) != None)
        {
            if(Misc_DynCombo(xPawn(C.Pawn).CurrentCombo) != None && Misc_DynCombo(xPawn(C.Pawn).CurrentCombo).ComboManager == self)
                Misc_DynCombo(xPawn(C.Pawn).CurrentCombo).Destroy();
        }
    }
}

function ClearData()
{
    bComboRunning = false;
    NextCombo = 0;
    TotalTick = 0.0;
    Count = 0;
    LastCount = 0;
    SetTimer(0.0, false);

    ClearDynCombos();
    Combos.Remove(0, Combos.Length);
    
    UpdateClients();
}

function CountAffected(optional Controller Exclude)
{
    local Controller c;

    Affected = 0;
    for(c = Level.ControllerList; c != None; c = c.NextController)
    {
        if((Exclude != None && c == Exclude) || c.PlayerReplicationInfo == None || c.GetTeamNum() != TeamIndex || xPawn(c.Pawn) == None)
            continue;

        Affected++;
    }

    if(Affected == 0)
        ClearData();
}

defaultproperties
{
     TeamIndex=255
}
