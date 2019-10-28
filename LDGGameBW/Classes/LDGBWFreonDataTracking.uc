class LDGBWFreonDataTracking extends Object
	config(LDGBWFreon);

struct LDGBWFreonDBEntry
{
	var string ID;
	var string EncPlayerName;
	var int AvailableEFR;
	var int TakenEFR;
	var bool Deranked;
	var bool HideSkill;
	var float Kills;
	var float Deaths;
	var int TotalKills;
	var int TotalDeaths;
	var float KillSpectrum[11];
	var float FirstPercentile;
	var float SecondPercentile;
	var float Inactivity;
	var float Penalty;
	var float ThawPoints;
	var float TotalThawPoints;
	var float Efficiency;
	var float Bayesian;
};

struct MergeData
{
	var string OldID;
	var string NewID;
};

enum EBayesianType
{
	BT_LINEAR,
	BT_QUADRATIC
};

var config EBayesianType BayesianType;

var config array<LDGBWFreonDBEntry> Database;
var config float AverageEfficiency;
var config int MaximumSamples;

var config int EfficiencySample;
var config int SmallEfficiencySample;
var config float ThawPointsKillConversion;
var config float ActivityRatio;
var config InterpCurve InactivityDecayCurve;
var config float InactivityMaximum;

var config int SpectrumSamples;
var config float FirstPercentile;
var config float SecondPercentile;

// hours:minutes
var config string LastMatchStart;
var config string RankExlucsionResetTime; 
var config string PeakHoursStart;
var config string PeakHoursEnd;

var array<MergeData> Merges;

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

static function GetTime(string time, out int hours, out int minutes)
{
	local array<string> parts;
	
	Split(time, ":", parts);
	
	if (parts.Length != 2)
	{
		hours = 0;
		minutes = 0;
	}
	else
	{
		hours = int(parts[0]);
		minutes = int(parts[1]);
	}
}

static function bool CompareTime(int ha, int ma, int hb, int mb)
{
	if (ha == hb)
		return ma > mb;
	
	return ha > hb;
}

static function AddMerge(string OldID, string NewID)
{
	local int i;
	
	i = default.Merges.Length;
	default.Merges.Length = default.Merges.Length + 1;
	default.Merges[i].OldID = OldID;
	default.Merges[i].NewID = NewID;
}

static function CarryOutMerges()
{
	local int i, NotFound;
	local int oldIndex, newIndex;
	
	for (i = 0; i < default.Merges.Length; i++)
	{
		oldIndex = BinarySearch(default.Merges[i].OldID, false, NotFound);
		if (NotFound == 1)
		{
			Log("MERGE: " $ default.Merges[i].OldID $ " -> " $ default.Merges[i].NewID $ " FAILED! OldID not found!");
			continue;
		}
		
		newIndex = BinarySearch(default.Merges[i].NewID, false, NotFound);
		if (NotFound == 1)
		{
			Log("MERGE: " $ default.Merges[i].OldID $ " -> " $ default.Merges[i].NewID $ " FAILED! OldID not found!");
			continue;
		}
		
		default.Database[newIndex].TakenEFR += default.Database[oldIndex].TakenEFR;
		default.Database[newIndex].Kills += default.Database[oldIndex].Kills;
		default.Database[newIndex].Deaths += default.Database[oldIndex].Deaths;
		default.Database[newIndex].TotalKills += default.Database[oldIndex].TotalKills;
		default.Database[newIndex].TotalDeaths += default.Database[oldIndex].TotalDeaths;
		default.Database[newIndex].Inactivity += default.Database[oldIndex].Inactivity;
		default.Database[newIndex].Penalty += default.Database[oldIndex].Penalty;
		default.Database[newIndex].ThawPoints += default.Database[oldIndex].ThawPoints;
		default.Database[newIndex].TotalThawPoints += default.Database[oldIndex].TotalThawPoints;
		default.Database.Remove(oldIndex, 1);
		Log("MERGE: " $ default.Merges[i].OldID $ " -> " $ default.Merges[i].NewID $ " SUCCESS!");
	}
	
	default.Merges.Remove(0, default.Merges.Length);
}

static function Recalc(string MatchStart)
{
	local bool bResetEFR;
	local int MSH, MSM, LMSH, LMSM, RSTH, RSTM;
	
	GetTime(MatchStart, MSH, MSM);
	GetTime(default.LastMatchStart, LMSH, LMSM);
	GetTime(default.RankExlucsionResetTime, RSTH, RSTM);
	
	if (CompareTime(LMSH, LMSM, MSH, MSM))
		bResetEFR = !CompareTime(LMSH, LMSM, RSTH + 24, RSTM) && CompareTime(MSH, MSM, RSTH, RSTM);
	else
		bResetEFR = !CompareTime(LMSH, LMSM, RSTH, RSTM) && CompareTime(MSH, MSM, RSTH, RSTM);
	
	default.LastMatchStart = MatchStart;
	CarryOutMerges();
	DecayData();
	ComputeEfficiency();
	ComputeBayesian(bResetEFR);
	StaticSaveConfig();
}

static function AwardInactivity(float MatchTime)
{
	local int i;

	for (i = 0; i < default.Database.Length; i++)
		default.Database[i].Inactivity = FMin(default.Database[i].Inactivity + MatchTime, default.InactivityMaximum);
}

static function DecayData()
{
	local int i, j;
	local float w;

	for (i = 0; i < default.Database.Length; i++)
	{
		if (default.ThawPointsKillConversion > 0)
			w = default.Database[i].Kills + default.Database[i].Deaths + default.Database[i].Penalty + (default.Database[i].ThawPoints / default.ThawPointsKillConversion);
		else
			w = default.Database[i].Kills + default.Database[i].Deaths + default.Database[i].Penalty;
		
		if (w > default.MaximumSamples)
		{
			w = default.MaximumSamples / w;
			default.Database[i].Kills *= w;
			default.Database[i].Deaths *= w;
			default.Database[i].Penalty *= w;
			default.Database[i].ThawPoints *= w;
		}
		
		w = 0;
		
		for (j = 0; j < 11; j++)
			w += default.Database[i].KillSpectrum[j];
		
		if (w > default.SpectrumSamples)
		{
			w = default.SpectrumSamples / w;
			for (j = 0; j < 11; j++)
				default.Database[i].KillSpectrum[j] *= w;
		}
	}
}

static function ComputeEfficiency()
{
	local float avg;
	local int i, c;
	
	c = 0;
	avg = 0;

	if (default.ThawPointsKillConversion > 0)
	{
		for (i = 0; i < default.Database.Length; i++)
		{
			if ((default.Database[i].Kills + (default.Database[i].Deaths + default.Database[i].Penalty) + (default.Database[i].ThawPoints / default.ThawPointsKillConversion)) > 0)
				default.Database[i].Efficiency = (default.Database[i].Kills + (default.Database[i].ThawPoints / default.ThawPointsKillConversion)) / (default.Database[i].Kills + (default.Database[i].Deaths + default.Database[i].Penalty) + (default.Database[i].ThawPoints / default.ThawPointsKillConversion));
			else
				default.Database[i].Efficiency = 0;
				
			if ((default.Database[i].Kills + (default.Database[i].Deaths + default.Database[i].Penalty) + (default.Database[i].ThawPoints / default.ThawPointsKillConversion)) >= default.SmallEfficiencySample)
			{
				avg += default.Database[i].Efficiency;
				c++;
			}
		}
	}
	else
	{
		for (i = 0; i < default.Database.Length; i++)
		{
			if ((default.Database[i].Kills + (default.Database[i].Deaths + default.Database[i].Penalty)) > 0)
				default.Database[i].Efficiency = (default.Database[i].Kills) / (default.Database[i].Kills + (default.Database[i].Deaths + default.Database[i].Penalty));
			else
				default.Database[i].Efficiency = 0;
				
			if ((default.Database[i].Kills + (default.Database[i].Deaths + default.Database[i].Penalty)) >= default.SmallEfficiencySample)
			{
				avg += default.Database[i].Efficiency;
				c++;
			}
		}
	}
	
	if (c > 0)
		default.AverageEfficiency = avg / c;
	else
		default.AverageEfficiency = 0;
		
}

static function ComputeBayesian(bool bResetEFR)
{
	local bool pt1done, pt2done;
	local int i, j;
	local float WeightMultiplication, WeightDecay, SpectrumWeightMultiplication, ThawPoints, w, count, rat, pt1, pt2;
	
	switch (default.BayesianType)
	{
		case BT_LINEAR:
			WeightMultiplication = 1.0 / LinearWeighting(1.0, default.MaximumSamples, 0.0, default.EfficiencySample, 1.0);
			SpectrumWeightMultiplication = 1.0 / LinearWeighting(1.0, default.SpectrumSamples, 0.0, default.SpectrumSamples / 3.0 , 1.0);
			
			for (i = 0; i < default.Database.Length; i++)
			{
				// Get the inactivity decay
				WeightDecay = InterpCurveEval(default.InactivityDecayCurve, default.Database[i].Inactivity);
				
				// Thaw points
				if (default.ThawPointsKillConversion > 0)
					ThawPoints = default.Database[i].ThawPoints / default.ThawPointsKillConversion;
				else
					ThawPoints = 0;
					
				// Spectrum Percentile
				default.Database[i].FirstPercentile = 0.0;
				default.Database[i].SecondPercentile = 0.0;
				
				w = 0;
				
				for (j = 0; j < 11; j++)
					w += default.Database[i].KillSpectrum[j];
				
				if (w > 0)
				{
					pt1 = w * FClamp(default.FirstPercentile, 0.0, 1.0);
					pt2 = w * FClamp(default.SecondPercentile, 0.0, 1.0);
					pt1done = false;
					pt2done = false;
					count = default.Database[i].KillSpectrum[0];
					for (j = 1; j < 11; j++)
					{
						if ((!pt1done) && (count < pt1) && ((count + default.Database[i].KillSpectrum[j]) >= pt1))
						{
							rat = pt1 - count;
							default.Database[i].FirstPercentile = (float(j - 1) + (rat / default.Database[i].KillSpectrum[j])) / 10.0; // default.Database[i].KillSpectrum[j] is always nonzero
							pt1done = true;
						}
						
						if ((!pt2done) && (count < pt2) && ((count + default.Database[i].KillSpectrum[j]) >= pt2))
						{
							rat = pt2 - count;
							default.Database[i].SecondPercentile = (float(j - 1) + (rat / default.Database[i].KillSpectrum[j])) / 10.0; // default.Database[i].KillSpectrum[j] is always nonzero
							pt2done = true;
						}
						
						if (pt1done && pt2done)
							break;
						
						count += default.Database[i].KillSpectrum[j];
					}
				}

				default.Database[i].FirstPercentile = LinearWeighting(default.Database[i].FirstPercentile, w, default.AverageEfficiency, default.SpectrumSamples / 3.0, SpectrumWeightMultiplication);
				default.Database[i].SecondPercentile = LinearWeighting(default.Database[i].SecondPercentile, w, default.AverageEfficiency, default.SpectrumSamples / 3.0, SpectrumWeightMultiplication);

				// Calculate bayesian
				default.Database[i].Bayesian = LinearWeighting(default.Database[i].Efficiency, default.Database[i].Kills + ThawPoints + (default.Database[i].Deaths + default.Database[i].Penalty), default.AverageEfficiency, default.EfficiencySample, WeightMultiplication * WeightDecay);
				if (bResetEFR)
				{
					if (default.Database[i].Bayesian >= 0.6)
						default.Database[i].AvailableEFR = 2;
					else if (default.Database[i].Bayesian >= 0.5)
						default.Database[i].AvailableEFR = 1;
					else
						default.Database[i].AvailableEFR = 0;
				}
			}
			break;
			
		case BT_QUADRATIC:
			WeightMultiplication = 1.0 / QuadraticWeighting(1.0, default.MaximumSamples, 0.0, default.EfficiencySample, 1.0);
			SpectrumWeightMultiplication = 1.0 / QuadraticWeighting(1.0, default.SpectrumSamples, 0.0, default.SpectrumSamples / 3.0 , 1.0);
			
			for (i = 0; i < default.Database.Length; i++)
			{
				// Get the inactivity decay
				WeightDecay = InterpCurveEval(default.InactivityDecayCurve, default.Database[i].Inactivity);
				
				// Thaw points
				if (default.ThawPointsKillConversion > 0)
					ThawPoints = default.Database[i].ThawPoints / default.ThawPointsKillConversion;
				else
					ThawPoints = 0;
				
				// Spectrum Percentile
				default.Database[i].FirstPercentile = 0.0;
				default.Database[i].SecondPercentile = 0.0;
				
				w = 0;
				
				for (j = 0; j < 11; j++)
					w += default.Database[i].KillSpectrum[j];
				
				if (w > 0)
				{
					pt1 = w * FClamp(default.FirstPercentile, 0.0, 1.0);
					pt2 = w * FClamp(default.SecondPercentile, 0.0, 1.0);
					pt1done = false;
					pt2done = false;
					count = default.Database[i].KillSpectrum[0];
					for (j = 1; j < 11; j++)
					{
						if ((!pt1done) && (count < pt1) && ((count + default.Database[i].KillSpectrum[j]) >= pt1))
						{
							rat = pt1 - count;
							default.Database[i].FirstPercentile = (float(j - 1) + (rat / default.Database[i].KillSpectrum[j])) / 10.0; // default.Database[i].KillSpectrum[j] is always nonzero
							pt1done = true;
						}
						
						if ((!pt2done) && (count < pt2) && ((count + default.Database[i].KillSpectrum[j]) >= pt2))
						{
							rat = pt2 - count;
							default.Database[i].SecondPercentile = (float(j - 1) + (rat / default.Database[i].KillSpectrum[j])) / 10.0; // default.Database[i].KillSpectrum[j] is always nonzero
							pt2done = true;
						}
						
						if (pt1done && pt2done)
							break;
						
						count += default.Database[i].KillSpectrum[j];
					}
				}
				
				default.Database[i].FirstPercentile = QuadraticWeighting(default.Database[i].FirstPercentile, w, default.AverageEfficiency, default.SpectrumSamples / 3.0, SpectrumWeightMultiplication);
				default.Database[i].SecondPercentile = QuadraticWeighting(default.Database[i].SecondPercentile, w, default.AverageEfficiency, default.SpectrumSamples / 3.0, SpectrumWeightMultiplication);
				
				// Calculate bayesian
				default.Database[i].Bayesian = QuadraticWeighting(default.Database[i].Efficiency, default.Database[i].Kills + (default.Database[i].Deaths + default.Database[i].Penalty) + ThawPoints, default.AverageEfficiency, default.EfficiencySample, WeightMultiplication * WeightDecay);
				if (bResetEFR)
				{
					if (default.Database[i].Bayesian >= 0.6)
						default.Database[i].AvailableEFR = 2;
					else if (default.Database[i].Bayesian >= 0.5)
						default.Database[i].AvailableEFR = 1;
					else
						default.Database[i].AvailableEFR = 0;
				}
			}
			break;
	}
}

static function float LinearWeighting(float val, float valweight, float avg, float avgweight, float weightmult)
{
	local float weight;

	weight = FClamp((valweight) / (valweight + avgweight) * weightmult, 0.0, 1.0);
	return (val * weight) + (avg * (1.0 - weight));
}

static function float QuadraticWeighting(float val, float valweight, float avg, float avgweight, float weightmult)
{
	local float weight;
	
	weight = FClamp((valweight * valweight) / (valweight * valweight + avgweight * avgweight) * weightmult, 0.0, 1.0);
	return (val * weight) + (avg * (1.0 - weight));
}

static function string StripColor(string s)
{
	local string EscapeCode;
	local int p;

  EscapeCode = Chr(0x1B);
  p = InStr(s, EscapeCode);
  
	while (p >= 0)
	{
		s = left(s, p) $ mid(s, p + 4);
		p = InStr(s, EscapeCode);
	}

	return s;
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

defaultproperties
{
     MaximumSamples=3000
     EfficiencySample=500
     SmallEfficiencySample=100
     ActivityRatio=48.000000
     InactivityDecayCurve=(Points=((OutVal=1.000000),(InVal=336.000000,OutVal=1.000000),(InVal=672.000000),(InVal=999999.000000)))
     InactivityMaximum=672.000000
     SpectrumSamples=1500
     FirstPercentile=0.500000
     SecondPercentile=0.750000
     PeakHoursStart="19:00"
     PeakHoursEnd="23:59"
}
