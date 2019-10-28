class LDGFlags extends Object
	config(LDGFlags);
	
var private array<string> AllowedFlags;
var private config array<string> List; //List is: GUID;Name;Flag1;Flag2 etc.

static function string AddFlag(string ID, string flag)
{
	local int i, pos;
	local array<string> Chunks;
	local string Builder;
	local bool bValid;
	
	ID = Caps(ID);
	flag = Caps(flag);
	
	bValid = false;
	
	if (ID ~= "" || flag ~= "")
		return "";
	
	//check flag
	for (i = 0; i < default.AllowedFlags.Length; i++)
	{
		if (default.AllowedFlags[i] == flag)
		{
			bValid = true;
			break;
		}
	}
	
	if (!bValid)
		return "BAD_FLAG";
	
	pos = -1;
		
	//check id
	for (i = 0; i < default.List.Length; i++)
	{
		if (InStr(Caps(default.List[i]), ID) == 0)
		{
			pos = i;
			break;
		}
	}
	
	if (pos == -1)
		return "BAD_ID";
	
	Split(Caps(default.List[pos]), ";", Chunks);
	
	for (i = 2; i < Chunks.Length; i++)
	{
		if (Chunks[i] == flag)
			return "FLAG_ALREADY_THERE";
	}
	
	Chunks[Chunks.Length] = flag;
	
	Builder = Chunks[0];
	
	for (i = 1; i < Chunks.Length; i++)	
		Builder = Builder $ ";" $ Chunks[i];
		
	default.List[pos] = Builder;
	if (!class'LDGFlagsType'.default.bSlave)
		StaticSaveConfig();
	return "";
}

static function string RemoveFlag(string ID, string flag)
{
	local int i, pos;
	local array<string> Chunks;
	local string Builder;
	local bool bValid;
	
	ID = Caps(ID);
	flag = Caps(flag);
	
	bValid = false;
	
	//check flag
	for (i = 0; i < default.AllowedFlags.Length; i++)
	{
		if (default.AllowedFlags[i] == flag)
		{
			bValid = true;
			break;
		}
	}
	
	if (!bValid)
		return "BAD_FLAG";
	
	pos = -1;
		
	//check id
	for (i = 0; i < default.List.Length; i++)
	{
		if (InStr(Caps(default.List[i]), ID) == 0)
		{
			pos = i;
			break;
		}
	}
	
	if (pos == -1)
		return "BAD_ID";
	
	Split(Caps(default.List[pos]), ";", Chunks);
	
	for (i = 2; i < Chunks.Length; i++)
	{
		if (Chunks[i] == flag)
		{
			Chunks.Remove(i, 1);
			Builder = Chunks[0];
	
			for (i = 1; i < Chunks.Length; i++)	
				Builder = Builder $ ";" $ Chunks[i];
				
			default.List[pos] = Builder;
			if (!class'LDGFlagsType'.default.bSlave)
				StaticSaveConfig();
			return "";
		}
	}
	
	return "FLAG_NOT_THERE";
}  

static function string AddID(string ID, string plrName)
{
	local int i;

	ID = Caps(ID);
	plrName = repl(Caps(plrName), ";", "_");

	if (ID ~= "" || plrName ~= "")
		return "";

	for (i = 0; i < default.List.Length; i++)
	{
		if (InStr(Caps(default.List[i]), ID) == 0)
			return "ID_ALREADY_THERE";
	}

	default.List[default.List.Length] = ID $ ";" $ plrName;
	if (!class'LDGFlagsType'.default.bSlave)
		StaticSaveConfig();
	return "";
}

static function string RemoveID(string ID)
{
	local int i;

	ID = Caps(ID);

	for (i = 0; i < default.List.Length; i++)
	{
		if (InStr(Caps(default.List[i]), ID) == 0)
		{
			default.List.Remove(i, 1);
			if (!class'LDGFlagsType'.default.bSlave)
				StaticSaveConfig();
			return "";
		}
	}

	return "ID_NOT_THERE";
}

static function AllowFlag(string flag)
{
	local int i;
	local bool bNew;
	
	flag = Caps(flag);

	if (flag ~= "")
		return;
	
	bNew = true;
	
	//check flag
	for (i = 0; i < default.AllowedFlags.Length; i++)
	{
		if (default.AllowedFlags[i] == flag)
		{
			bNew = false;
			break;
		}
	}
	
	if (bNew)
		default.AllowedFlags[default.AllowedFlags.Length] = flag;
}

static function DisallowFlag(string flag)
{
	local int i, pos;
	
	flag = Caps(flag);
	
	pos = -1;
	
	//check flag
	for (i = 0; i < default.AllowedFlags.Length; i++)
	{
		if (default.AllowedFlags[i] == flag)
		{
			pos = i;
			break;
		}
	}
	
	if (pos != -1)
		default.AllowedFlags.Remove(pos, 1);
}

static function bool CheckFlag(string ID, string flag)
{
	local int i, pos;
	local array<string> Chunks;
	
	pos = -1;
	
	ID = Caps(ID);
	flag = Caps(flag);
		
	//check id
	for (i = 0; i < default.List.Length; i++)
	{
		if (InStr(Caps(default.List[i]), ID) == 0)
		{
			pos = i;
			break;
		}
	}
	
	if (pos == -1)
		return false;
	
	Split(Caps(default.List[pos]), ";", Chunks);
		
	for (i = 2; i < Chunks.Length; i++)
	{
		if (Chunks[i] == flag)
			return true;
	}
	
	return false;
}

static function GetFlagsForID(string ID, out array<string> flags)
{
	local int pos, i;
	
	pos = -1;
	
	ID = Caps(ID);
	
	//check id
	for (i = 0; i < default.List.Length; i++)
	{
		if (InStr(Caps(default.List[i]), ID) == 0)
		{
			pos = i;
			break;
		}
	}
	
	Split(Caps(default.List[pos]), ";", flags);
	
	//remove first two
	flags.Remove(0,2);
}

static function GetIDsForFlag(string flag, out array<string> IDs)
{
	local string ID;
	local int i;
	
	flag = ";" $ flag;
	
	ID = Caps(ID);
	
	//check id
	for (i = 0; i < default.List.Length; i++)
	{
		if (InStr(Caps(default.List[i]), flag) != -1)
			IDs[IDs.Length] = Left(Caps(default.List[i]), 32);
	}
}

static function PrintList(PlayerController Sender)
{
	local int i;
	
	Sender.ClientMessage("LDG Flags List:");
	for (i = 0; i < default.List.Length; i++)
		Sender.ClientMessage(string(i + 1)$")" @ Repl(default.List[i], ";", "; "));
}

defaultproperties
{
}
