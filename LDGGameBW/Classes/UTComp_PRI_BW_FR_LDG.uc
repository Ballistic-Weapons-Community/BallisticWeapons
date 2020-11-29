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
var byte KS1Threshold, KS2Threshold;
var InterpCurve KS1Curve, KS2Curve;

replication
{
	reliable if(ROLE == ROLE_Authority)
		Skill, ThawPoints, bHideSkill, bDeranked;
		
	reliable if  (Role == ROLE_Authority && bNetOwner)
		KS1Threshold, KS2Threshold;
		
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

    KS1Threshold = KSThresh[0];
    KS2Threshold = KSThresh[1];
}

defaultproperties
{
     KS1Curve=(Points=((InVal=1.000000,OutVal=1.000000),(InVal=2.000000,OutVal=2.000000),(InVal=4.000000,OutVal=3.000000),(InVal=5.000000,OutVal=4.000000),(InVal=6.000000,OutVal=5.000000),(InVal=7.500000,OutVal=6.000000),(InVal=8.000000,OutVal=7.000000),(InVal=10.000000,OutVal=7.000000)))
     KS2Curve=(Points=((InVal=1.000000,OutVal=2.000000),(InVal=2.000000,OutVal=4.000000),(InVal=4.000000,OutVal=6.000000),(InVal=5.000000,OutVal=9.000000),(InVal=6.000000,OutVal=10.000000),(InVal=7.500000,OutVal=12.000000),(InVal=8.000000,OutVal=14.000000),(InVal=10.000000,OutVal=14.000000)))
}
