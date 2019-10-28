class LDGBWWeaponDataTracking extends Object
	dependson(BallisticPlayerReplicationInfo)
	config(LDGBWWeapon);
	
struct LDGBWWeaponDBEntry
{
	var string ID;
	var string EncPlayerName;
	var int MeleeDamage;
	var array<BallisticPlayerReplicationInfo.HitStat> HitStats[10];
};

var config array<LDGBWWeaponDBEntry> Database;

static function int BinarySearch(string SearchString, bool bReturnClosest, out int bNotFound)
{
  local int Middle;
  local int Low;
  local int High;

	Low = 0;
  High = default.Database.Length - 1;
  SearchString = Caps(SearchString);
  bNotFound = 0;
  
  while ( Low <= High )
  {
    Middle = (Low + High) / 2;
    
    if ( default.Database[Middle].ID ~= SearchString )
      return Middle;

    if ( Caps(default.Database[Middle].ID) > SearchString )
      High = Middle - 1;
    else if ( Caps(default.Database[Middle].ID) < SearchString )
      Low = Middle + 1;
  }
  
  bNotFound = 1;
  
  if ( bReturnClosest )
  {
    if ( (default.Database.Length > 0) && (Low < default.Database.Length) && (Caps(default.Database[Low].ID) < SearchString) )
      ++Low;
      
    return Low;
  }
  
  return -1;
}

static function string EncodeColoredName(string s)
{
	local string build;
	local int l, i, c, hi, lo;
	
	l = len(s);
	build = "";
	
	for (i = 0; i < l; i++)
	{
		c = Asc(s);
		
		hi = c / 16;		
		lo = c - (hi * 16);
		
		if (hi < 10)
			build = build $ Chr(0x30 + hi);
		else
			build = build $ Chr(0x41 + hi - 10);
			
		if (lo < 10)
			build = build $ Chr(0x30 + lo);
		else
			build = build $ Chr(0x41 + lo - 10);
		
		s = Mid(s, 1);
	}
	
	return build;
}

static function string DecodeColoredName(string s)
{
	local string build;
	local int l, i, c, hi, lo;
	
	l = len(s) / 2;
	build = "";
	
	for (i = 0; i < l; i++)
	{
		hi = Asc(s);
		s = Mid(s, 1);
		
		lo = Asc(s);
		s = Mid(s, 1);
		
		if (hi >= 0x41)
			hi -= 0x41 - 10;
		else
			hi -= 0x30;
			
		if (lo >= 0x41)
			lo -= 0x41 - 10;
		else
			lo -= 0x30;
		
		c = hi * 16 + lo;
		build = build $ Chr(c);
	}
	
	return build;
}

static function Store()
{
	StaticSaveConfig();
}

defaultproperties
{
}
