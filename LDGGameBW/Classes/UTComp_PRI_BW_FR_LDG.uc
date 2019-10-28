class UTComp_PRI_BW_FR_LDG extends UTComp_PRI_BW_LDG;

var float ThawPoints;
var float Skill;
var bool bExcludedFromRanking, bAdminExcludedFromRanking, bHideSkill, bDeranked;
var int AvailableExclusionsFromRanking;

var String MatchStart;

var float NewSkill;
var int   KillPoints, DeathPoints, NewThawPoints;
var bool NewSkillReceiver;

var int KillSpectrumIndex;
var array<float> KillSpectrum;

var byte KSThresh[2];
var InterpCurve KS1Curve, KS2Curve;

replication
{
	reliable if(ROLE == ROLE_Authority)
		Skill, ThawPoints, bHideSkill, bDeranked;
		
	reliable if  (Role == ROLE_Authority && bNetOwner)
		KSThresh;
		
	reliable if(ROLE == ROLE_Authority && NewSkillReceiver && bNetOwner)
		NewSkillReceiver, KillPoints, NewThawPoints, DeathPoints, NewSkill;
}


function AddKill(float VictimSkill)
{
	if (KillSpectrumIndex >= KillSpectrum.Length)
		KillSpectrum.Length = KillSpectrum.Length + 100;
	
	KillSpectrum[KillSpectrumIndex] = VictimSkill;
	KillSpectrumIndex++;
}

function ResetProps()
{
	Super.ResetProps();
	
	ThawPoints = 0;
	KillSpectrum.Length = 0;
	KillSpectrumIndex = 0;
}

function SetStreakThresholds()
{
	KSThresh[0] = InterpCurveEval(KS1Curve, Skill);
	KSThresh[1] = InterpCurveEval(KS2Curve, Skill);
}

defaultproperties
{
     KS1Curve=(Points=((OutVal=2.000000),(InVal=2.000000,OutVal=2.000000),(InVal=4.000000,OutVal=3.000000),(InVal=6.500000,OutVal=4.000000),(InVal=10.000000,OutVal=4.000000)))
     KS2Curve=(Points=((OutVal=4.000000),(InVal=2.000000,OutVal=4.000000),(InVal=3.500000,OutVal=4.000000),(InVal=5.000000,OutVal=6.000000),(InVal=6.500000,OutVal=7.000000),(InVal=7.500000,OutVal=9.000000),(InVal=10.000000,OutVal=9.000000)))
}
