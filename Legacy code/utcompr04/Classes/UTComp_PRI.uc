class UTComp_PRI extends LinkedReplicationInfo;

struct TeamOverlayInfo
{
	var byte Armor;
	var byte Weapon;
	var int Health;
	var PlayerReplicationInfo PRI;
};

var string ColoredName;
var int BalancerSwitches;
var int RealKills;
var int RealDeaths;
var int DamR;
var int DamG;

var bool InAVehicle;
var bool bShowSelf;
var byte bHasDD[16];
var TeamOverlayInfo OverlayInfo[16];
var float VehicleExitTime;

replication
{
	unreliable if(ROLE == Role_Authority)
		DamR, DamG, ColoredName, RealKills, RealDeaths, InAVehicle;

	unreliable if(ROLE == Role_Authority && bNetOwner)
		bHasDD, OverlayInfo;
		
	reliable if(ROLE < ROLE_Authority)
		SetColoredName, SetShowSelf;
}

function SetColoredName(string S)
{
	ColoredName = S;
}

function SetShowSelf(bool B)
{
	bShowSelf = B;
}

function ResetProps()
{
	RealKills = 0;
	RealDeaths = 0;
	DamG = 0;
	DamR = 0;
}

function Reset()
{	
	InAVehicle = false;
	VehicleExitTime = 0.0;
	
	Super.Reset();
}

defaultproperties
{
     bShowSelf=True
}
