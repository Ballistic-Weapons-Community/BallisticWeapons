class Misc_Bot extends xBot;

function Possess(Pawn aPawn)
{
	Super.Possess(aPawn);
	if (Vehicle(aPawn) != None && Vehicle(aPawn).Driver != None)
		Misc_PRI(PlayerReplicationInfo).PawnReplicationInfo.SetMyPawn(Vehicle(aPawn).Driver);
	else Misc_PRI(PlayerReplicationInfo).PawnReplicationInfo.SetMyPawn(aPawn);
}

function Unpossess()
{
	Super.Unpossess();
	Misc_PRI(PlayerReplicationInfo).PawnReplicationInfo.SetMyPawn(None);
}

function Reset()
{
    local NavigationPoint P;
    local float Adren;

    Adren = Adrenaline;

    P = StartSpot;
    Super.Reset();
    StartSpot = P;

    if(Pawn == None || !Pawn.InCurrentCombo())
        Adrenaline = Adren;
    else
        Adrenaline = 0.1;
}

function SetPawnClass(string inClass, string inCharacter)
{
	local class<Misc_Pawn> pClass;

	if(inClass != "")
	{
		pClass = class<Misc_Pawn>(DynamicLoadObject(inClass, class'Class'));
		if(pClass != None)
			PawnClass = pClass;
	}

	PawnSetupRecord = class'xUtil'.static.FindPlayerRecord(inCharacter);
	PlayerReplicationInfo.SetCharacterName(inCharacter);
}

function PawnDied(Pawn P)
{
    local float Adren;

    Adren = Adrenaline;
    Super.PawnDied(P);
    Adrenaline = Adren;

    if(PlayerReplicationInfo != None && TAM_TeamInfo(PlayerReplicationInfo.Team) != None)
        TAM_TeamInfo(PlayerReplicationInfo.Team).PlayerDied(self);
}

function TryCombo(string ComboName)
{
    local class<Combo> ComboClass;

    if(TAM_GRI(Level.GRI) == None || TAM_GRI(Level.GRI).bDisableTeamCombos)
    {
        Super.TryCombo(ComboName);
        return;
    }

    if(!Pawn.InCurrentCombo() && !NeedsAdrenaline())
	{
		if ( ComboName ~= "Random" )
			ComboName = ComboNames[Rand(ArrayCount(ComboNames))];
		else if ( ComboName ~= "DMRandom" )
			ComboName = ComboNames[1 + Rand(ArrayCount(ComboNames) - 1)];
		ComboName = Level.Game.NewRecommendCombo(ComboName, self);
        if(ComboName ~= "xGame.Combo")
            return;

        ComboClass = class<Combo>(DynamicLoadObject(ComboName, class'Class'));
        if(ComboClass != None)
            if(TAM_TeamInfo(PlayerReplicationInfo.Team) != None)
                TAM_TeamInfo(PlayerReplicationInfo.Team).PlayerUsedCombo(self, ComboClass);
	}
}

function AwardAdrenaline(float amount)
{
    if(bAdrenalineEnabled)
    {
        if((TAM_GRI(Level.GRI) == None || TAM_GRI(Level.GRI).bDisableTeamCombos) && (Pawn != None && Pawn.InCurrentCombo()))
            return;
        Adrenaline = FClamp(Adrenaline + amount, 0.1, AdrenalineMax);
    }
}

defaultproperties
{
     PlayerReplicationInfoClass=Class'3SPNv3141BW.Misc_PRI'
     Adrenaline=0.100000
}
