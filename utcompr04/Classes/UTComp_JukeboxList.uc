class UTComp_JukeboxList extends Object
	config(UTCompJukeBox)
	perobjectconfig;
	
struct JukeBoxEntry
{
	var string Level;
	var string Song;
};

var config array<JukeBoxEntry> JukeBoxList;

function NewEntry(string level, string song)
{
	local int i;
	
	i = InStr(level, "[");
	if (i > 5)
		level = Left(level, i);
		
	for (i = 0; i < JukeBoxList.Length; i++)
	{
		if (JukeBoxList[i].Level ~= level)
		{
			if (JukeBoxList[i].Song != song)
			{
				JukeBoxList[i].Song = song;
				SaveConfig();
			}
			
			return;
		}
	}
	
	i = JukeBoxList.Length;
	JukeBoxList.Length = JukeBoxList.Length + 1;
	
	JukeBoxList[i].Level = level;
	JukeBoxList[i].Song = song;
	SaveConfig();
}

function RemoveEntry(string level)
{
	local int i;
	
	i = InStr(level, "[");
	if (i > 5)
		level = Left(level, i);
		
	for (i = 0; i < JukeBoxList.Length; i++)
	{
		if (JukeBoxList[i].Level ~= level)
		{
			JukeBoxList.Remove(i, 1);
			SaveConfig();
			return;
		}
	}
}

function string GetEntry(string level)
{
	local int i;
	
	i = InStr(level, "[");
	if (i > 5)
		level = Left(level, i);
		
	for (i = 0; i < JukeBoxList.Length; i++)
	{
		if (JukeBoxList[i].Level ~= level)
			return JukeBoxList[i].Song;
	}
	
	return "";
}

defaultproperties
{
     JukeBoxList(0)=(Level="####",Song="####")
}
