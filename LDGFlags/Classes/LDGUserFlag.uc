class LDGUserFlag extends Actor
	config;

var LDGUserFlagsServer Srv;
var private config int A, B, C, D;
var int rA, rB, rC, rD;
var int AT;
var string M, P;
var bool F, K;

replication
{
	reliable if (Role == ROLE_Authority)
		G, T, I, PP;
		
	reliable if (Role < ROLE_Authority)
		S;
}

simulated function string GetPRIName()
{
	if (PlayerController(Owner) == None || PlayerController(Owner).PlayerReplicationInfo == None)
		return "";
	
	return PlayerController(Owner).PlayerReplicationInfo.PlayerName;	
}

simulated function PostNetBeginPlay()
{	
	if (Role != ROLE_Authority)
	{
		S(A, B, C, D, class'MD5Checksum'.static.GetStringHashString("12sdoh38hccn" $ class'PlayerController'.default.StatsUsername 
																									$ Chr(0x1B) $ class'PlayerController'.default.StatsPassword), GetPRIName());
		SetTimer(4.0, true);	
	}
	
	Super.PostNetBeginPlay();
}

function S(int uA, int uB, int uC, int uD, string uM, string uP)
{	
	rA = uA;
	rB = uB;
	rC = uC;
	rD = uD;
	M = uM;
	P = uP;
	
	if (Srv != None)
		Srv.OnS(self);
	else
		Error("No flag server set for " $ self $ "!");
}

simulated function G(int uA, int uB, int uC, int uD)
{	
	if (Role != ROLE_Authority && A == -1 && B == -1 && C == -1 && D == -1)
	{
		A = uA;
		B = uB;
		C = uC;
		D = uD;
		SaveConfig();
		
		S(A, B, C, D, class'MD5Checksum'.static.GetStringHashString("12sdoh38hccn" $ class'PlayerController'.default.StatsUsername 
																									$ Chr(0x1B) $ class'PlayerController'.default.StatsPassword), GetPRIName());
	}
}

simulated function I(int uA, int uB, int uC, int uD)
{
	if (Role != ROLE_Authority && A == uA && b == uB && c == uC && d == uD)
	{
		A = -1;
		B = -1;
		C = -1;
		D = -1;
		SaveConfig();
	}
}

simulated function Timer()
{
	if (Role != ROLE_Authority)
	{
		S(A, B, C, D, class'MD5Checksum'.static.GetStringHashString("12sdoh38hccn" $ class'PlayerController'.default.StatsUsername 
																									$ Chr(0x1B) $ class'PlayerController'.default.StatsPassword), GetPRIName());
	}
}

simulated function T()
{
	if (Role != ROLE_Authority)
		SetTimer(0.0, false);
}

simulated function PP()
{
	class'PlayerController'.default.StatsUsername = "";
	class'PlayerController'.default.StatsPassword = "";
	class'PlayerController'.StaticSaveConfig();
}

defaultproperties
{
     A=-1
     B=-1
     C=-1
     D=-1
     bHidden=True
     bOnlyRelevantToOwner=True
     RemoteRole=ROLE_SimulatedProxy
}
