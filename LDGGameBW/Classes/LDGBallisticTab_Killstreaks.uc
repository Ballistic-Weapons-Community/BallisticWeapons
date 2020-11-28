class LDGBallisticTab_Killstreaks extends BallisticTab_Killstreaks;

// very lazy, but it's more work to do it properly
function ShowPanel(bool bShow)
{
	local UTComp_PRI_BW_FR_LDG uPRI;
	
	Super.ShowPanel(bShow);

	uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(PlayerOwner().PlayerReplicationInfo));
	
	if (uPRI != None)
	{
		Item_Streak1.Caption = uPRI.KS1Threshold@"Kills";
		Item_Streak2.Caption = uPRI.KS2Threshold@"Kills";
	}
	
    else
	{
		Item_Streak1.Caption = "Unknown Threshold";
		Item_Streak2.Caption = "Unknown Threshold";
	}
}

defaultproperties
{
}
