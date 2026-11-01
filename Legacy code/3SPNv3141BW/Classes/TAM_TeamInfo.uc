class TAM_TeamInfo extends xTeamRoster;

var Misc_DynComboManager ComboManager;  // this team's dynamic combo manager
var Misc_DynComboReplicationInfo ComboRI;

var int StartingHealth;                 // this team's starting health (health + armor) this round

replication
{
    reliable if(bNetDirty && Role == ROLE_Authority)
        StartingHealth, ComboRI;
}

function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(TeamArenaMaster(Level.Game) != None && !TeamArenaMaster(Level.Game).bDisableTeamCombos)
    {
        ComboManager = Spawn(class'Misc_DynComboManager');
        ComboRI = Spawn(class'Misc_DynComboReplicationInfo');
        ComboManager.ComboRI = ComboRI;
    }
}

function PlayerUsedCombo(Controller Player, class<Combo> ComboClass)
{
    if(ComboManager != None && Player.GetTeamNum() == TeamIndex)
        ComboManager.PlayerUsedCombo(Player, ComboClass);
}

function PlayerDied(Controller Player)
{
    if(ComboManager != None && Player.GetTeamNum() == TeamIndex)
        ComboManager.PlayerDied(Player);
}

defaultproperties
{
}
