class LDGMut_Outfitting extends Mut_Outfitting
	HideDropDown
	CacheExempt;

function SpawnStreakGR()
{
	local LDGBallisticOutfittingKillstreakRules G;
	
	if (bAllowKillstreaks)
	{
		G = spawn(class'LDGBallisticOutfittingKillstreakRules');
		if ( Level.Game.GameRulesModifiers == None )
			Level.Game.GameRulesModifiers = G;
		else    
			Level.Game.GameRulesModifiers.AddGameRules(G);
		G.Mut = self;
	}
}

// Use the console command "Mutate Loadout" to open the loadout menu
function Mutate(string MutateString, PlayerController Sender)
{
	local int i;
	local BallisticPlayerReplicationInfo BPRI;

	if (MutateString ~= "Loadout" && Sender != None)
	{
		for (i=0;i<COIPond.length;i++)
		{
			if (COIPond[i].PC == Sender)
			{
				COIPond[i].ClientOpenLoadoutMenu();
				return;
			}
		}
		COIPond[i] = Spawn(class'LDGClientOutfittinginterface',Sender);
		COIPond[i].Initialize(self, Sender);
	}
	
	else if (MutateString ~= "Killstreak" && Sender != None)
	{
		if (!bAllowKillstreaks)
			Sender.ClientMessage("Killstreaks are currently disabled.");
		else
		{
			for (i=0;i<COIPond.length;i++)
			{
				if (COIPond[i].PC == Sender && xPawn(Sender.Pawn) != None)
				{
					BPRI = class'Mut_Ballistic'.static.GetBPRI(Sender.PlayerReplicationInfo);
					if (BPRI != None && BPRI.RewardLevel > 0)
						GrantKillstreakReward(COIPond[i], Sender.Pawn, BPRI);
					break;
				}
			}
		}
	}
	
	super(Mut_Ballistic).Mutate(MutateString, Sender);
}

// Give the players their weapons
function ModifyPlayer(Pawn Other)
{
	local int i;
	local class<weapon> W;
	local string Stuff[5];

	Super(Mut_Ballistic).ModifyPlayer(Other);
	
	if (Other.LastStartTime > Level.TimeSeconds + 2)
		return;

	//Bots get their weapons here.
	if (Other.Controller != None && Bot(Other.Controller) != None)
	{
		for (i=0;i<5;i++)
			Stuff[i] = GetGroup(i)[Rand(GetGroup(i).length)];
		ChangeLoadout(Other, Stuff);		
		for (i=2;i<5;i+=0)
		{
			if (Stuff[i] == "")		
			{
				if (i == 0)
					i = 4;
				else if (i == 3)
					break;
				else
					i--;
				continue;
			}
			if (Right(Stuff[i], 5) ~= "Dummy")
				Stuff[i] = GetGroup(i)[0];
			W = class<weapon>(DynamicLoadObject(Stuff[i],class'Class'));
			if (W == None)
			{
				if (i == 0)
					i = 4;
				else if (i == 3)
					break;
				else
					i--;
				continue;
			}
			SpawnWeapon(W, Other);
			if (i == 0)
				i = 4;
			else if (i == 3)
				break;
			else
				i--;
		}
	}
	
	else if (Other.Controller != None && PlayerController(Other.Controller) != None)
	{
		for (i=0;i<COIPond.length;i++)
			if (COIPond[i].PC == Other.Controller)
			{	
				if (Team_GameBase(Level.Game).LockTime == 0 && COIPond[i].LastLoadout[0] != "")
					OutfitPlayer(Other, COIPond[i].LastLoadout);
				else COIPond[i].ClientStartLoadout();
				return;	
			}
	}
}

// Makes sure client loadout is allowed, then cleans stuff out the inventory and adds the new weapons
function OutfitPlayer(Pawn Other, string Stuff[5], optional string OldStuff[5])
{
	local byte i, j, k, m, DummyFlags;
	local bool bMatch;
	local class<weapon> W;
	local BallisticWeapon BW;
	local Freon_Player.AmmoTrack TrackInfo;
	
	if (Vehicle(Other) != None && Vehicle(Other).Driver != None)
		Other = Vehicle(Other).Driver;

	// Make sure everything is legit
	for (i=0;i<5;i++)
	{
		// Random weapon handling
		// Tries ten times to pick a weapon which isn't a dummy
		// (i.e. itself) and doesn't match any previous weapon
		// if it fails to do so, returns the first weapon in the group
		if (GetItemName(Stuff[i]) ~= "RandomWeaponDummy")
		{
			for(j=0; j < 10; j++)
			{
				k = Rand(GetGroup(i).length - DummyGroups[i].Positions.length);
				
				for (m = 0; m < DummyGroups[i].Positions.Length; m++)
					if (k == DummyGroups[i].Positions[m])
						k++;
			
				Stuff[i] = GetGroup(i)[k];
					
				bMatch = False;
					
				for (m=0; m<i; m++)
				{
					if (Stuff[i] ~= Stuff[m])
					{
						bMatch = True;
						break;
					}
				}

				if (!bMatch)
					break;

				else if (j == 9)
					Stuff[i] = GetGroup(i)[0];
			}
		}
		
		else if (Right(GetItemName(Stuff[i]), 5) == "Dummy")
			DummyFlags = DummyFlags | (1 << i);
		
		for (j=0;j<GetGroup(i).length;j++)
			if (GetGroup(i)[j] ~= Stuff[i])
				break;
		if (j >= GetGroup(i).length)
			Stuff[i] = GetGroup(i)[Rand(GetGroup(i).length)];
	}
	// Clean out other weapons...
	ChangeLoadout(Other, Stuff, OldStuff);
	// Now spawn it all
	if (xPawn(Other) != None)
	{
		xPawn(Other).RequiredEquipment[0] = Stuff[1];
		xPawn(Other).RequiredEquipment[1] = Stuff[0];
	}
	
	for (i=2;i<5;i+=0)
	{
		if (!bool(DummyFlags & (1 << i)))
		{
			if (Stuff[i] != "")
			{
				//log("Incoming gun:"@Stuff[i]);
				W = class<weapon>(DynamicLoadObject(Stuff[i],class'Class'));
				if (W == None)
					log("Could not load outfitted weapon "$Stuff[i]);
				else
				{
					if (class<BallisticWeapon>(W) != None)
						TrackInfo = Freon_Player(Other.Controller).GetAmmoTrackFor(W);
					if (TrackInfo.GunClass == None || (TrackInfo.GunClass != W && !ClassIsChildOf(TrackInfo.GunClass, W)))
						SpawnWeapon(W, Other);
					else /*if (TrackInfo.Ammo1 != 0 || TrackInfo.Ammo2 != 0)*/
					{
						BW = BallisticWeapon(SpawnWeapon(W, Other));
						BW.SetAmmoTo(TrackInfo.Ammo1, 0);
						if (BW.GetAmmoClass(0) != BW.GetAmmoClass(1) && BW.GetAmmoClass(1) != None)
							BW.SetAmmoTo(TrackInfo.Ammo2, 1);
					}
					//else log("Empty weapon");
				}
					
			}
		}
		if (i == 0)
			i = 4;
		else if (i == 3)
			break;
		else
			i--;
	}
	
	if (DummyFlags != 0)
	{
		j = 0;
		for (i=1; i < 32; i = i << 1)
		{
			if (bool(DummyFlags & i))
			{
				W = class<Weapon>(DynamicLoadObject(Stuff[j], class'Class'));
				if (class<DummyWeapon>(W) != None)
					class<DummyWeapon>(W).static.ApplyEffect(Other, 0, true);
			}
			j++;
		}
	}
}

simulated event Timer()
{
	super(Mut_Ballistic).Timer();
	if (PCPendingCOI == None)
		return;
	COIPond[COIPond.length] = Spawn(class'LDGClientOutfittinginterface',PCPendingCOI);
	COIPond[COIPond.length-1].Initialize(self, PCPendingCOI);
	PCPendingCOI = None;
}

defaultproperties
{
}
