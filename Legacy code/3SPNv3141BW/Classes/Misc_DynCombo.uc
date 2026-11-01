// dynamic combo: a combo that maintains multiple combos
class Misc_DynCombo extends Combo;

var Array<Combo> Combos;

var Misc_DynComboManager ComboManager;    // manager for this combo

function StartEffect(xPawn P)
{
    if(Misc_Player(P.Controller) != None)
    {
        if(P.Controller.Adrenaline < 0.1)
            P.Controller.Adrenaline = 0.1;
    }
}

function AddCombo(class<Combo> ComboClass)
{
    local int i;

    if(ComboClass == None || Pawn(Owner) == None || Pawn(Owner).Controller == None)
        return;

    if(PlayerController(Pawn(Owner).Controller) != None && ComboClass.default.ExecMessage != "")
        PlayerController(Pawn(Owner).Controller).ReceiveLocalizedMessage(class'ComboMessage',,,, ComboClass);

    for(i = 0; i <= Combos.Length; i++)
    {
        if(i == Combos.Length)
        {
            Combos.Length = Combos.Length + 1;
            break;
        }

        if(Combos[i] != None && Combos[i].Class == ComboClass)
            break;
    }

    if(Combos[i] == None)
    {
        Combos[i] = Spawn(ComboClass, Pawn(Owner));
        Combos[i].AdrenalineCost = 0.0;
    }

    // Record stats for using the combo
    UnrealMPGameInfo(Level.Game).SpecialEvent(Pawn(Owner).PlayerReplicationInfo, ""$ComboClass);
	if(Combos[i].IsA('ComboSpeed'))
		i = 0;
	else if(Combos[i].IsA('ComboBerserk'))
		i = 1;
	else if(Combos[i].IsA('ComboDefensive'))
		i = 2;
	else if(Combos[i].IsA('ComboInvis'))
		i = 3;
	else
		i = 4;
	TeamPlayerReplicationInfo(Pawn(Owner).PlayerReplicationInfo).Combos[i] += 1;
}

function RemoveCombo(class<Combo> ComboClass)
{
    local int i;

    if(ComboClass == None)
        return;

    for(i = 0; i < Combos.Length; i++)
    {
        if(Combos[i] != None && Combos[i].Class == ComboClass)
        {
            Combos[i].Destroy();
            Combos.Remove(i, 1);
            break;
        }
    }

    if(Combos.Length == 0)
        Destroy();
}

function Tick(float DeltaTime)
{
    Disable('Tick');
}

function Destroyed()
{
    local int i;

    for(i = 0; i < Combos.Length; i++)
    {
        if(Combos[i] != None)
            Combos[i].Destroy();
    }

    Combos.Remove(0, Combos.Length);

    Super.Destroyed();
}

function AdrenalineEmpty()
{
}

defaultproperties
{
}
