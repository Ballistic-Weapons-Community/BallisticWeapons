//=============================================================================
// ClientTeamOutfittingInterface.
//
// Team Loadout's means of getting items to the clients.
//=============================================================================
class ClientTeamOutfittingInterface extends Actor
	config(BallisticProV55);

var Mut_TeamOutfitting Mut;		// The outfitting mutator
var PlayerController PC;	// PlayerController associated with this COI
var float				LastLoadoutTime;
var() config float	ChangeInterval;

//Groups of weapon names on the client's side.
var array<string>	RedGroup0;
var array<string>	RedGroup1;
var array<string>	RedGroup2;
var array<string>	RedGroup3;
var array<string>	RedGroup4;

//Blue.
var array<string>	BlueGroup0;
var array<string>	BlueGroup1;
var array<string>	BlueGroup2;
var array<string>	BlueGroup3;
var array<string>	BlueGroup4;

var bool			bWeaponsReady;

var string	LastLoadout[5];

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSetLoadout, ServerLoadoutChanged;
	reliable if (Role == ROLE_Authority)
		ClientStartLoadout, ClientOpenLoadoutMenu, ReceiveWeapon;
	reliable if (Role == ROLE_Authority)
		PC;
}

simulated function array<string> GetGroupForTeam(byte GroupNum, byte Team)
{
    if(Team == 1)
	{
		switch (GroupNum)
		{
		case	0:	return BlueGroup0;
		case	1:	return BlueGroup1;
		case	2:	return BlueGroup2;
		case	3:	return BlueGroup3;
		case	4:	return BlueGroup4;
		}
	}
	switch (GroupNum)
	{
		case	0:	return RedGroup0;
		case	1:	return RedGroup1;
		case	2:	return RedGroup2;
		case	3:	return RedGroup3;
		case	4:	return RedGroup4;
	}	
}

//Returns the weapon group.
simulated function array<string> GetGroup(byte GroupNum)
{
    return GetGroupForTeam(GroupNum, PC.GetTeamNum());
}

//Returns the weapon at the specific index.
simulated function string GetGroupItemForTeam(byte GroupNum, byte TeamNum, int ItemNum)
{
	if(TeamNum == 1)
	{
		switch (GroupNum)
		{
		case	0:	return BlueGroup0[ItemNum];
		case	1:	return BlueGroup1[ItemNum];
		case	2:	return BlueGroup2[ItemNum];
		case	3:	return BlueGroup3[ItemNum];
		case	4:	return BlueGroup4[ItemNum];
		}
	}
    else 
    {
        switch (GroupNum)
        {
        case	0:	return RedGroup0[ItemNum];
        case	1:	return RedGroup1[ItemNum];
        case	2:	return RedGroup2[ItemNum];
        case	3:	return RedGroup3[ItemNum];
        case	4:	return RedGroup4[ItemNum];
        }
    }
}

//Sets the weapon at the specific index. Because of sorting and shitty reference semantics.
simulated function string SetGroupItemForTeam(string str, byte GroupNum, byte TeamNum, int ItemNum)
{
	if(TeamNum == 1)
	{
		switch (GroupNum)
		{
		case 0:	BlueGroup0[ItemNum] = str; 
            break;
		case 1:	BlueGroup1[ItemNum] = str; 
            break;
		case 2:	BlueGroup2[ItemNum] = str; 
            break;
		case 3:	BlueGroup3[ItemNum] = str; 
            break;
		case 4:	BlueGroup4[ItemNum] = str; 
            break;
		}
	}
    else 
    {
        switch (GroupNum)
        {
            case 0:	RedGroup0[ItemNum] = str; 
                break;
            case 1:	RedGroup1[ItemNum] = str; 
                break;
            case 2:	RedGroup2[ItemNum] = str; 
                break;
            case 3:	RedGroup3[ItemNum] = str; 
                break;
            case 4:	RedGroup4[ItemNum] = str; 
                break;
        }
    }
}

//Sets the weapon at the specific index. Because of sorting and shitty reference semantics.
simulated function string PushWeaponFromMutator(string str, byte GroupNum, byte TeamNum)
{
	if(TeamNum == 1)
	{
		switch (GroupNum)
		{
		case 0:	BlueGroup0.Length = BlueGroup0.Length + 1; BlueGroup0[BlueGroup0.Length - 1] = str;
            break;
		case 1:	BlueGroup1.Length = BlueGroup1.Length + 1; BlueGroup1[BlueGroup1.Length - 1] = str;
            break;
		case 2:	BlueGroup2.Length = BlueGroup2.Length + 1; BlueGroup2[BlueGroup2.Length - 1] = str;
            break;
		case 3:	BlueGroup3.Length = BlueGroup3.Length + 1; BlueGroup3[BlueGroup3.Length - 1] = str;
            break;
		case 4:	BlueGroup4.Length = BlueGroup4.Length + 1; BlueGroup4[BlueGroup4.Length - 1] = str;
            break;
		}
	}
    else 
    {
        switch (GroupNum)
        {
        case 0:	RedGroup0.Length = RedGroup0.Length + 1; RedGroup0[RedGroup0.Length - 1] = str;
            break;
        case 1:	RedGroup1.Length = RedGroup1.Length + 1; RedGroup1[RedGroup1.Length - 1] = str;
            break;
        case 2:	RedGroup2.Length = RedGroup2.Length + 1; RedGroup2[RedGroup2.Length - 1] = str;
            break;
        case 3:	RedGroup3.Length = RedGroup3.Length + 1; RedGroup3[RedGroup3.Length - 1] = str;
            break;
        case 4:	RedGroup4.Length = RedGroup4.Length + 1; RedGroup4[RedGroup4.Length - 1] = str;
            break;
        }
    }
}

//Returns the weapon at the specific index.
simulated function string GetGroupItem(byte GroupNum, int ItemNum)
{
    return GetGroupItemForTeam(GroupNum, PC.GetTeamNum(), ItemNum);
}

//Returns the number of weapons in the group.
simulated function int GroupLengthForTeam(byte GroupNum, byte team)
{
	if (team == 1)
	{
		switch (GroupNum)
		{
			case 0: return BlueGroup0.length;
			case 1: return BlueGroup1.length;
			case 2: return BlueGroup2.length;
			case 3: return BlueGroup3.length;
			case 4: return BlueGroup4.length;
		}
	}
	switch (GroupNum)
	{
		case 0: return RedGroup0.length;
		case 1: return RedGroup1.length;
		case 2: return RedGroup2.length;
		case 3: return RedGroup3.length;
		case 4: return RedGroup4.length;
	}
	return -1;
}

//Returns the number of weapons in the group.
simulated function int GroupLength(byte GroupNum)
{
	return GroupLengthForTeam(PC.GetTeamNum());
}

function bool IsInList (out array<string> List, string Test, optional out int Index)
{
	for(Index=0;Index<List.length;Index++)
		if (List[Index] == Test)
			return true;
	return false;
}

function FillWeapons()
{
    local int team, group_index, wep_index;

    for (team = 0; team < 2; ++team)
    {
        for (group_index = 0; group_index < 5; ++group_index)
        {
            for (wep_index = 0; wep_index < Mut.GetGroup(group_index, team).Length; ++wep_index)
            {
                PushWeaponFromMutator(Mut.GetGroupItem(group_index, wep_index, team), group_index, team);
            }
        }
    }

    for (team = 0; team < 2; ++team)
    {
        for (group_index = 0; group_index < 5; ++group_index)
        {
            for (wep_index = 0; wep_index < GroupLengthForTeam(group_index, team); ++wep_index)
            {
               Log("Group "$group_index$", team "$team$", index "$wep_index$" is "$GetGroupItemForTeam(group_index, team, wep_index));
            }
        }
    }
}

//Goes through the available loadout weapons, adding them to the array and continuing if the loaded weapon is invalid.
//Boxes indicate which group the weapon is in.
//Uses bitwise operations on Boxes to handle weapons which exist in multiple groups at once.
function SendWeapons ()
{
	local int i, j;
	local array<string> Weaps;
	local array<byte>	RedBoxes, BlueBoxes;

	//Go through the available loadout weapons, adding them to the Weaps array. Continue if there is no weapon in the slot
	for (i=0;i<Mut.RedLoadoutGroup0.length;i++)
	{
		if (Mut.RedLoadoutGroup0[i] == "")
			continue;
		Weaps[Weaps.length] = Mut.RedLoadoutGroup0[i];
		Redboxes[Redboxes.length] = 1;
	}

	for (i=0;i<Mut.RedLoadoutGroup1.length;i++)
	{
		if (Mut.RedLoadoutGroup1[i] == "")
			continue;
		
		//If the current weapon is already in the weapon list, update its Redboxes entry to indicate it's in multiple slots
		if (IsInList(Weaps, Mut.RedLoadoutGroup1[i], j))
			Redboxes[j] += 2;
		else
		{
			//Insert weapon at end
			Weaps[Weaps.length] = Mut.RedLoadoutGroup1[i];
			//Insert slot info
			Redboxes[Redboxes.length] = 2;
		}
	}
	for (i=0;i<Mut.RedLoadoutGroup2.length;i++)
	{
		if (Mut.RedLoadoutGroup2[i] == "")
			continue;
		//Third bit
		if (IsInList(Weaps, Mut.RedLoadoutGroup2[i], j))
			Redboxes[j] += 4;
		else
		{
			Weaps[Weaps.length] = Mut.RedLoadoutGroup2[i];
			Redboxes[Redboxes.length] = 4;
		}
	}
	for (i=0;i<Mut.RedLoadoutGroup3.length;i++)
	{
		if (Mut.RedLoadoutGroup3[i] == "")
			continue;
		//Fourth bit
		if (IsInList(Weaps, Mut.RedLoadoutGroup3[i], j))
			Redboxes[j] += 8;
		else
		{
			Weaps[Weaps.length] = Mut.RedLoadoutGroup3[i];
			Redboxes[Redboxes.length] = 8;
		}
	}
	for (i=0;i<Mut.RedLoadoutGroup4.length;i++)
	{
		if (Mut.RedLoadoutGroup4[i] == "")
			continue;
		if (IsInList(Weaps, Mut.RedLoadoutGroup4[i], j))
			Redboxes[j] += 16;
		else
		{
			Weaps[Weaps.length] = Mut.RedLoadoutGroup4[i];
			Redboxes[Redboxes.length] = 16;
		}
	}
	
	//Now again for the Blue team...
	for (i=0;i<Mut.BlueLoadoutGroup0.length;i++)
	{
		if (Mut.BlueLoadoutGroup0[i] == "")
			continue;
		Weaps[Weaps.length] = Mut.BlueLoadoutGroup0[i];
		Blueboxes[Blueboxes.length] = 1;
	}

	for (i=0;i<Mut.BlueLoadoutGroup1.length;i++)
	{
		if (Mut.BlueLoadoutGroup1[i] == "")
			continue;
		
		//If the current weapon is already in the weapon list, update its Blueboxes entry to indicate it's in multiple slots
		if (IsInList(Weaps, Mut.BlueLoadoutGroup1[i], j))
			Blueboxes[j] += 2;
		else
		{
			//Insert weapon at end
			Weaps[Weaps.length] = Mut.BlueLoadoutGroup1[i];
			//Insert slot info
			Blueboxes[Blueboxes.length] = 2;
		}
	}
	for (i=0;i<Mut.BlueLoadoutGroup2.length;i++)
	{
		if (Mut.BlueLoadoutGroup2[i] == "")
			continue;
		//Third bit
		if (IsInList(Weaps, Mut.BlueLoadoutGroup2[i], j))
			Blueboxes[j] += 4;
		else
		{
			Weaps[Weaps.length] = Mut.BlueLoadoutGroup2[i];
			Blueboxes[Blueboxes.length] = 4;
		}
	}
	for (i=0;i<Mut.BlueLoadoutGroup3.length;i++)
	{
		if (Mut.BlueLoadoutGroup3[i] == "")
			continue;
		//Fourth bit
		if (IsInList(Weaps, Mut.BlueLoadoutGroup3[i], j))
			Blueboxes[j] += 8;
		else
		{
			Weaps[Weaps.length] = Mut.BlueLoadoutGroup3[i];
			Blueboxes[Blueboxes.length] = 8;
		}
	}
	for (i=0;i<Mut.BlueLoadoutGroup4.length;i++)
	{
		if (Mut.BlueLoadoutGroup4[i] == "")
			continue;
		if (IsInList(Weaps, Mut.BlueLoadoutGroup4[i], j))
			Blueboxes[j] += 16;
		else
		{
			Weaps[Weaps.length] = Mut.BlueLoadoutGroup4[i];
			Blueboxes[Blueboxes.length] = 16;
		}
	}
	
	for (i=0;i<Weaps.length-1;i++)
		ReceiveWeapon(Weaps[i], RedBoxes[i], BlueBoxes[i]);
	//Last weapon, terminate
	ReceiveWeapon(Weaps[Weaps.length-1], RedBoxes[Weaps.length-1], BlueBoxes[Weaps.length-1], True);
}

//Uses "Boxes" to determine which groups a weapon to be added to
//Flags are checked per weapon and if fifth flag is up, the weapons
//have all been sent
simulated function ReceiveWeapon (string WeaponName, byte RedBoxes, byte BlueBoxes, optional bool bTerminate)
{
	//Red.
	if ((RedBoxes & 1) > 0)
		RedGroup0[RedGroup0.length] = WeaponName;
	if ((RedBoxes & 2) > 0)
		RedGroup1[RedGroup1.length] = WeaponName;
	if ((RedBoxes & 4) > 0)
		RedGroup2[RedGroup2.length] = WeaponName;
	if ((RedBoxes & 8) > 0)
		RedGroup3[RedGroup3.length] = WeaponName;
	if ((RedBoxes & 16) > 0)
		RedGroup4[RedGroup4.length] = WeaponName;
		
	//Blue.
	if ((BlueBoxes & 1) > 0)
		BlueGroup0[BlueGroup0.length] = WeaponName;
	if ((BlueBoxes & 2) > 0)
		BlueGroup1[BlueGroup1.length] = WeaponName;
	if ((BlueBoxes & 4) > 0)
		BlueGroup2[BlueGroup2.length] = WeaponName;
	if ((BlueBoxes & 8) > 0)
		BlueGroup3[BlueGroup3.length] = WeaponName;
	if ((BlueBoxes & 16) > 0)
		BlueGroup4[BlueGroup4.length] = WeaponName;
	
	if (bTerminate)
    {
        SortLists();

		bWeaponsReady = true;
    }
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
function bool LoadWIFromCache(string ClassStr, out BC_WeaponInfoCache.WeaponInfo WepInfo)
{
	local int i;

	WepInfo = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(ClassStr, i);
	if (i==-1)
	{
		log("Error loading item for Conflict: "$ClassStr, 'Warning');
		return false;
	}
	return true;
}

simulated function SortLists()
{
    local int team, group_index;

    for (team = 0; team < 2; ++team)
    {
        for (group_index = 0; group_index < 5; ++group_index)
        {
            SortList(group_index, team);
        }
    }
}

// fuck me, sorting lists in unrealscript is HORRIBLE
simulated function SortList(byte group_index, byte team)
{
	local int i, j;
	local BC_WeaponInfoCache.WeaponInfo WI;
    local array<string> sorted;

	local array<BC_WeaponInfoCache.WeaponInfo> SortedWIs;
	local int wiGroup, existingGroup;

	for (i=0; i < GetGroupForTeam(group_index, team).Length; i++)
	{
        if (LoadWIFromCache(GetGroupItemForTeam(group_index, team, i), WI))
        {
            if (SortedWIs.Length == 0)
                SortedWIs[SortedWIs.Length] = WI;
            else 
            {	
                wiGroup = WI.InventoryGroup;
                
                if (wiGroup == 0)
                    wiGroup = 10;
                    
                for (j = 0; j < SortedWIs.Length; ++j)
                {
                    existingGroup = SortedWIs[j].InventoryGroup;
                    
                    if (existingGroup == 0)
                        existingGroup = 10;
                    
                    if (wiGroup < existingGroup)
                    {
                        SortedWIs.Insert(j, 1);
                        SortedWIs[j] = WI;
                        break;
                    }
                    
                    if (wiGroup == existingGroup)
                    {
                        if (StrCmp(WI.ItemName, SortedWIs[j].ItemName, 6, True) <= 0)
                        {	
                            SortedWIs.Insert(j, 1);
                            SortedWIs[j] = WI;
                            break;
                        }
                    }
                    
                    if (j == SortedWIs.Length - 1)
                    {
                        SortedWIs[SortedWIs.Length] = WI;
                        break;
                    }
                }
            }

		}

        else 
            Log("ClientTeamOutfittingInterface: Failed to load "$ GetGroupItemForTeam(group_index, team, i) $" from cache");
	}
	
	for (i = 0; i < SortedWIs.Length; ++i)
    {
		SetGroupItemForTeam(SortedWIs[i].ClassName, group_index, team, i);
    }
}

function Initialize(Mut_TeamOutfitting MO, PlayerController P)
{
	Mut = MO;
	PC = P;

	bWeaponsReady=true;

	if (level.NetMode != NM_StandAlone)
    {   
        if (Viewport(P.Player) == None)
		    SendWeapons();
    }

    else 
    {
        FillWeapons();
        SortLists();
    }

	ClientOpenLoadoutMenu();

	SetTimer(1.0,true);
}

simulated function ClientOpenLoadoutMenu()
{
	if (PC ==None || PC.Player == None)
		return;
	PC.ClientOpenMenu ("BallisticProV55.BallisticTeamOutfittingMenu");
	if (PC.Player.GUIController != None)
	{
		BallisticTeamOutfittingMenu(GUIController(PC.Player.GUIController).ActivePage).SetupCOI(self);
	}		
}

event Timer()
{
	if (PC == None)
		Destroy();
}

event Destroyed()
{
	local int i;

	for (i=0;i<Mut.COIPond.length;i++)
	{
		if (Mut.COIPond[i] == self)
		{
			Mut.COIPond.Remove(i, 1);
			break;
		}
	}

	super.Destroyed();
}

// Called from menu to inform us that the client's loadout has changed.
simulated function LoadoutChanged(string Stuff[5])
{
	ServerLoadoutChanged(
		Stuff[0], 
		Stuff[1], 
		Stuff[2], 
		Stuff[3], 
		Stuff[4]
	);
}

// Called from client when its loadout changes.
function ServerLoadoutChanged(string Stuff0, string Stuff1, string Stuff2, string Stuff3, string Stuff4)
{
	local int i;
	// FIXME: There's some hardcoded crap here for Invasion, CTF and Onslaught!
	if (PC.Pawn == None || PC.Pawn.Health < 1)
		return;
	
	if ( (Level.TimeSeconds - PC.Pawn.SpawnTime < DeathMatch(Level.Game).SpawnProtectionTime * 5) ||
		 (level.TimeSeconds - LastLoadoutTime > ChangeInterval) ||
		 (Invasion(level.Game)!=None && !Invasion(level.Game).bWaveInProgress) ||
		 (CTFGame(level.Game)!=None && PC.GetTeamNum()<2 && VSize(CTFTeamAI(CTFGame(level.Game).Teams[PC.GetTeamNum()].AI).FriendlyFlag.HomeBase.Location - PC.Pawn.Location) < 384) )
	{
		ServerSetLoadout(Stuff0, Stuff1, Stuff2, Stuff3, Stuff4);
		LastLoadoutTime = level.TimeSeconds;
	}

	else if ((ONSOnslaughtGame(level.Game)!=None))
		for(i=0;i<ONSOnslaughtGame(level.Game).PowerCores.length;i++)
			if ( (ONSOnslaughtGame(level.Game).PowerCores[i].bPoweredByRed && PC.GetTeamNum() == 0) || (ONSOnslaughtGame(level.Game).PowerCores[i].bPoweredByBlue && PC.GetTeamNum() == 1) )
				if (VSize(ONSOnslaughtGame(level.Game).PowerCores[i].Location - PC.Pawn.Location) < 384)
				{
					ServerSetLoadout(Stuff0, Stuff1, Stuff2, Stuff3, Stuff4);
					LastLoadoutTime = level.TimeSeconds;
					return;
				}
}

// Called from server. Tells client to send back loadout info.
// Called at respawn of player.
simulated function ClientStartLoadout()
{
	ServerSetLoadout(
	class'Mut_TeamOutfitting'.default.LoadOut[0],
	class'Mut_TeamOutfitting'.default.LoadOut[1],
	class'Mut_TeamOutfitting'.default.LoadOut[2],
	class'Mut_TeamOutfitting'.default.LoadOut[3],
	class'Mut_TeamOutfitting'.default.LoadOut[4]
	);
}

// Loadout info sent back from client after it was requested by server.
// Outfit the client with the standard weapons.
function ServerSetLoadout(string Stuff0, string Stuff1, string Stuff2, string Stuff3, string Stuff4)
{
	local string Stuff[5];
	
	Stuff[0] = Stuff0;
	Stuff[1] = Stuff1;
	Stuff[2] = Stuff2;
	Stuff[3] = Stuff3;
	Stuff[4] = Stuff4;

	if (PC.Pawn != None)
		Mut.OutfitPlayer(PC.Pawn, Stuff, LastLoadout);
		
	LastLoadout[0] = Stuff[0];
	LastLoadout[1] = Stuff[1];
	LastLoadout[2] = Stuff[2];
	LastLoadout[3] = Stuff[3];
	LastLoadout[4] = Stuff[4];
}

defaultproperties
{
     ChangeInterval=60.000000
     bHidden=True
     bOnlyRelevantToOwner=True
     bAlwaysRelevant=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
}
