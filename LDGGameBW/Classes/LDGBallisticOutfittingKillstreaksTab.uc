class LDGBallisticOutfittingKillstreaksTab extends BallisticOutfittingKillstreaksTab;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	Super(UT2K4TabPanel).InitComponent(MyController, MyOwner);
	
	if(BallisticOutfittingMenu(Controller.ActivePage) != None)
	p_Anchor = BallisticOutfittingMenu(Controller.ActivePage);
}

function ShowPanel(bool bShow)
{
	local UTComp_PRI_BW_FR_LDG uPRI;
	
	Super(UT2K4TabPanel).ShowPanel(bShow);

	uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(PlayerOwner().PlayerReplicationInfo));
	
	if (uPRI != None)
	{
		Item_Streak1.Caption = uPRI.KSThresh[0]@"Kills";
		Item_Streak2.Caption = uPRI.KSThresh[1]@"Kills";
	}

	if(!bWeaponsLoaded)
	{
		if (COI == None || !COI.bWeaponsReady)
		{
			if (PlayerOwner().level.NetMode == NM_Client)
			{
				l_Receiving.Caption = ReceivingText[0];
				SetTimer(0.5, true);
			}
			else
			{
				l_Receiving.Caption = ReceivingText[1];
				SetTimer(0.1, true);
			}
		}
		else
		{
			LoadWeapons();
			bWeaponsLoaded=True;
		}

		cb_Streak1.List.bSorted=true;
		cb_Streak1.List.Sort();
		cb_Streak2.List.bSorted=true;
		cb_Streak2.List.Sort();
	}
}

defaultproperties
{
}
