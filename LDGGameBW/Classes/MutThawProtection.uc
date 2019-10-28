class MutThawProtection extends xMutator;

var string							VersionString;

var globalconfig float	ThawProtectionTime;
var	globalconfig float	RecentlyThawnTime;
var globalconfig bool		ThawWhileProtected;
var globalconfig bool		RecentlyThawnOnlyInOT;

var localized string		GUIDisplayText[4]; // config property label names
var localized string		GUIDescText[4];    // config property long descriptions

/////////////////////
/// config page stuff
static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);
	PlayInfo.AddSetting("3SPN", "ThawProtectionTime", GetDisplayText("ThawProtectionTime"), 0, 0, "Text",,,,true);
	PlayInfo.AddSetting("3SPN", "RecentlyThawnTime", GetDisplayText("RecentlyThawnTime"), 0, 0, "Text",,,,true);
	PlayInfo.AddSetting("3SPN", "ThawWhileProtected", GetDisplayText("ThawWhileProtected"), 0, 0, "Check");
	PlayInfo.AddSetting("3SPN", "RecentlyThawnOnlyInOT", GetDisplayText("RecentlyThawnOnlyInOT"), 0, 0, "Check");
}

static event string GetDescriptionText(string PropName)
{
 	switch(PropName)
	{
	 	case "ThawProtectionTime": return default.GUIDescText[0];
 	 	case "ThawWhileProtected": return default.GUIDescText[1];
 	 	case "RecentlyThawnOnlyInOT": return default.GUIDescText[2];
 	 	case "RecentlyThawnTime": return default.GUIDescText[3];
	}

	return Super.GetDescriptionText(PropName);
}

static function string GetDisplayText(string PropName)
{
	switch(PropName)
	{
	 	case "ThawProtectionTime": return default.GUIDisplayText[0];
 	 	case "ThawWhileProtected": return default.GUIDisplayText[1];
 	 	case "RecentlyThawnOnlyInOT": return default.GUIDisplayText[2];
 	 	case "RecentlyThawnTime": return default.GUIDisplayText[3];
	}

	return "";
}

// end config page stuff
/////////////////////////////////

function GetServerDetails( out GameInfo.ServerResponseLine ServerState )
{
	local int i;
	
	Super.GetServerDetails(ServerState);
	
	i = ServerState.ServerInfo.Length;
	ServerState.ServerInfo.Length = i + 2;
	ServerState.ServerInfo[i].Key = "Thaw Protection Time";
	ServerState.ServerInfo[i].Value = ThawProtectionTime@"Seconds";
	ServerState.ServerInfo[i+1].Key = "Thaw While Protected";
	ServerState.ServerInfo[i+1].Value = string(ThawWhileProtected);
}

function bool IsFreon()
{
	return ClassIsChildOf(Level.Game.GameReplicationInfoClass, class'Freon_GRI');
}

event PreBeginPlay()
{
	if(!IsFreon())
 	{
	 	log("### MutFreonThawProtection - ALERT: THIS IS NOT A FREON GAME: DESTROYING MYSELF!");
		Destroy();
		return;
	}

	Super.PreBeginPlay();

	Log("### MutFreonThawProtection: PreBeginPlay() - Mutator: " $ FriendlyName);
	Log("### MutFreonThawProtection: PreBeginPlay() - ThawProtectionTime set to" @ ThawProtectionTime);
	Log("### MutFreonThawProtection: PreBeginPlay() - ThawWhileProtected set to" @ ThawWhileProtected);

	if(bDeleteMe)
		return;
}

function PostBeginPlay()
{
	local ThawRules Rules;

	Super.PostBeginPlay();

	Rules = Spawn(class'ThawRules');
	Rules.ThawProtectionTime = ThawProtectionTime;
	Rules.Mutator = self;

	if ( Level.Game.GameRulesModifiers == None ) 
		Level.Game.GameRulesModifiers = Rules;
	else
		Level.Game.GameRulesModifiers.AddGameRules(Rules);
}

function Actor MyReplaceWith(actor Other, string aClassName)
{
	local Actor A;
	local class<Actor> aClass;

	if ( aClassName == "" )
		return none;

	aClass = class<Actor>(DynamicLoadObject(aClassName, class'Class'));
	if ( aClass != None )
		A = Spawn(aClass,Other.Owner,Other.tag,Other.Location, Other.Rotation);
	if ( Other.IsA('Pickup') )
	{
		if ( Pickup(Other).MyMarker != None )
		{
			Pickup(Other).MyMarker.markedItem = Pickup(A);
			if ( Pickup(A) != None )
			{
				Pickup(A).MyMarker = Pickup(Other).MyMarker;
				A.SetLocation(A.Location
					+ (A.CollisionHeight - Other.CollisionHeight) * vect(0,0,1));
			}
			Pickup(Other).MyMarker = None;
		}
		else if ( A.IsA('Pickup') )
			Pickup(A).Respawntime = 0.0;
	}
	if ( A != None )
	{
		A.event = Other.event;
		A.tag = Other.tag;
		return A;
	}
	return none;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{	
	local Freon_Pawn FP;
	local Freon_Trigger FT;
	
	if (PlayerReplicationInfo(Other) != None)
	{
		AddThawInfo(PlayerReplicationInfo(Other));
		return true;
	}

	//if no thawing while proteced, we replace Freon's trigger class with ours
	if(!ThawWhileProtected && Freon_Trigger(Other) != none && ThawProtectionTrigger(Other) == none)
	{
		FP = Freon_Pawn(Other.Owner);
		FT = Freon_Trigger(MyReplaceWith(Other, string(class'ThawProtectionTrigger')));
		
		if (FP != None && FT != None)
			FP.MyTrigger = FT;
		
		return false;
	}

	return true;
}

function Mutate(string MutateString, PlayerController Sender)
{
 	if(MutateString == "thawcheckstate") 
 	{
 		if(Level.NetMode == NM_DedicatedServer) 
 		{
 	 		if(Sender.PlayerReplicationInfo.bAdmin)
 	 		{
				if(ServerDebugCheckState())
					  Sender.ClientMessage("FAILURE! Errors In Game State Detected! Check Server Logs for Details!");
				else
					  Sender.ClientMessage("SUCCESS! Game State OK!");
			}
		}
 	}

	Super.Mutate(MutateString, Sender);
}

simulated function bool ServerDebugCheckState() 
{
	local int PlayerCount;
	local int ItemCount;
 	local Controller c;
 	local ThawInfo ti;
	local ThawProtectionEmitterRed e;
	local ThawRules tr;
	local bool bFail;

	//ensure no more than playercount types of each special class exist

  PlayerCount = 0;
  bFail = false;

  c = Level.ControllerList;

  while( c != none ) 
  {
  	PlayerCount++;
   	c = c.nextController;
  }

	ItemCount = 0;
  foreach AllObjects(class'ThawInfo', ti) 
		ItemCount++;

	if(ItemCount > PlayerCount) 
	{
		bFail = true;
	 	log("### MutThawProtection - ALERT: More ThawInfo Classes Exist than PLAYERS!");
	}

	ItemCount = 0;
  foreach AllObjects(class'ThawProtectionEmitterRed', e) 
		ItemCount++;
	
	if(ItemCount > PlayerCount) 
	{
		bFail = true;
	 	log("### MutThawProtection - ALERT: More BaseThawProtectionEmitter Classes Exist than PLAYERS!");
	}

 	ItemCount = 0;
  foreach AllObjects(class'ThawRules', tr) 
		ItemCount++;
	
	
	if(ItemCount > 1) 
	{
		bFail = true;
	 	log("### MutThawProtection - ALERT: MULTIPLE ThawRules Classes Exist!");
	}

	return bFail;
}

//config tab stuff
simulated function ThawInfo GetThawInfo(Controller C)
{
 	local LinkedReplicationInfo lPRI;
 	
	lPRI = C.PlayerReplicationInfo.CustomReplicationInfo;

	while (lPRI != None)
  {
		if (lPRI.IsA('ThawInfo'))
			return ThawInfo(lPRI);
			
		lPRI = lPRI.NextReplicationInfo;
  }

	return None;
}

function ThawInfo AddThawInfo(PlayerReplicationInfo PRI) 
{
	local ThawInfo TI;
	local LinkedReplicationInfo lPRI;

	TI = Spawn(class'ThawInfo', PRI.Owner);
	TI.ThawProtectionTime = ThawProtectionTime;
	TI.RecentlyThawnTime = RecentlyThawnTime;
	TI.bRecentlyThawnOnlyInOT = RecentlyThawnOnlyInOT;
	TI.bThawWhileProtected = ThawWhileProtected;
	TI.ParentPRI = PRI;

	if(PRI.CustomReplicationInfo != None)
	{
		lPRI = PRI.CustomReplicationInfo;
		PRI.CustomReplicationInfo = TI;
		TI.NextReplicationInfo = lPRI;
	}
	else
		PRI.CustomReplicationInfo = TI;
	
	return TI;
}

function ModifyPlayer( Pawn Other )
{
	local ThawInfo TI;

	Super.ModifyPlayer(Other);

	TI = GetThawInfo(Other.Controller);
	TI.Respawned(xPawn(Other));
}

function NotifyLogout( Controller Exiting )
{
	local ThawInfo TI;

	TI = GetThawInfo(Exiting);
	
	if(TI != none && !TI.bDeleteMe)
		TI.Destroy();

	Super.NotifyLogout(Exiting);
}

simulated function ClientSideInitialization(PlayerController PC)
{
	local ThawInfoHUDOverlay TIHUD;
	local LinkedReplicationInfo lPRI;
	
	TIHUD = ThawInfoHUDOverlay(AddAHudOverlay(PC, string(class'ThawInfoHUDOverlay'), true));
	
	if (TIHUD != None)
	{
		lPRI = PC.PlayerReplicationInfo.CustomReplicationInfo;
		while (lPRI != None)
		{
			if (ThawInfo(lPRI) != None)
			{
				TIHUD.ThawInfo = ThawInfo(lPRI);
				break;
			}
			
			lPRI = lPRI.NextReplicationInfo;
		}
	}
}

defaultproperties
{
     VersionString="1.02 BW"
     ThawProtectionTime=5.000000
     GUIDisplayText(0)="Thaw Protection Time"
     GUIDisplayText(1)="Allow Thawing While Protected"
     GUIDisplayText(2)="Thaw Ability Regen. Delay Only In OT"
     GUIDisplayText(3)="Thaw Ability Regen. Delay Time"
     GUIDescText(0)="Sets the length of time a thawed player is protected"
     GUIDescText(1)="Should a protected player be allowed to thaw teammates?"
     GUIDescText(2)="Should a recently thawn have to wait for thawing teammates only in OT?"
     GUIDescText(3)="Sets the length of time a thawed player is considered recently thawn player"
     bAddToServerPackages=True
     GroupName="ThawProtection"
     FriendlyName="Freon Thaw Protection for Ballistic Weapons"
     Description="Thaw protection for 3SPN Freon v3141 gametype for Ballistic Weapons"
}
