class MutUTCompBW_LDG extends MutUTCompBW
	CacheExempt;

function ShowDamagePopup(vector ShowLocation, int PopupDamage, optional color PopupColor)
{
	local Controller C;
	
	for (C = Level.ControllerList; C != None; C = C.NextController)
	{
		if (UTComp_xPlayer(C) != None && UTComp_PRI_BW_LDG(UTComp_xPlayer(C).UTCompPRI) != None)
			UTComp_PRI_BW_LDG(UTComp_xPlayer(C).UTCompPRI).ShowDamagePopup(ShowLocation, PopupDamage, PopupColor);
	}
}

defaultproperties
{
     MyVersionSuffix="LDG BW"
     PRIType=Class'LDGGameBW.UTComp_PRI_BW_LDG'
     GameRulesType=Class'LDGGameBW.UTComp_GameRules_BW_LDG'
     HUDType(0)=(NewClass=Class'LDGGameBW.UTComp_HUD_DM_REV')
     HUDType(1)=(NewClass=Class'LDGGameBW.UTComp_HUD_TDM_REV')
     HUDType(3)=(NewClass=Class'LDGGameBW.UTComp_HUD_CTF_REV')
     HUDType(5)=(OldClass=Class'UT2k4Assault.HUD_Assault',NewClass=Class'LDGGameBW.UTComp_HUD_Assault')
     HUDType(6)=(OldClass=Class'Onslaught.ONSHUDOnslaught',NewClass=Class'LDGGameBW.UTComp_HUD_Onslaught')
     HUDType(7)=(OldClass=Class'Jailbreak.JBInterfaceHud',NewClass=Class'LDGGameBW.UTComp_JBInterfaceHud')
     ScoreBoardType(2)=(OldClass=Class'UT2k4Assault.ScoreBoard_Assault',NewClass=Class'LDGGameBW.UTComp_ScoreBoard_AS',NewClassEnh=Class'LDGGameBW.UTComp_ScoreBoard_NEW_AS')
     FriendlyName="UTComp Version R03 for BW on LDG"
     Description="A mutator for warmup, brightskins, hitsounds, and various other features - with enhancements for LDG Ballistic Weapons."
}
