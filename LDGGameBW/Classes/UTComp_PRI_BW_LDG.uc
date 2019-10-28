class UTComp_PRI_BW_LDG extends UTComp_PRI_BW;

replication
{
	//let's keep it reliable
	reliable if(Role==ROLE_Authority)
		ShowDamagePopup;
}

simulated function ShowDamagePopup(vector ShowLocation, int PopupDamage, optional color PopupColor)
{
	local LDGDamagePopup Popup;
	
	if (Level.NetMode != NM_DedicatedServer && class'LDGDamagePopup'.default.bShowDamagePopup)
	{
		if (PopupDamage < 0) 
			return;
						
		if(PopupColor.A == 0 )
		{
			PopupColor.R=255;
			PopupColor.G=255;
			PopupColor.B=255;
			PopupColor.A=255;
		}
		
		Popup = Spawn(class'LDGDamagePopup',,,ShowLocation,rot(16384,0,0));
	
		Popup.Damage=PopupDamage;
	 	Popup.FontColor=PopupColor;
	 	Popup.Initialize();
	}
}

defaultproperties
{
}
