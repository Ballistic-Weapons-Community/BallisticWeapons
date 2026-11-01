class UTComp_PRI_BW extends UTComp_PRI;

var string OverlayInfoWeapons[16];
var byte bHasDD_BW[16];
var TeamOverlayInfo OverlayInfo_BW[16];

replication
{
	unreliable if(Role==ROLE_Authority && bNetOwner)
		OverlayInfo_BW, bHasDD_BW, OverlayInfoWeapons;
}

defaultproperties
{
}
