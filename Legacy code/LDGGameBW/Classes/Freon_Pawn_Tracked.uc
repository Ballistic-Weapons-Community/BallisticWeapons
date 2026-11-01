class Freon_Pawn_Tracked extends Freon_Pawn_Normal;

var MutUTCompBW_LDG_FR UTCompMutator;

function bool GiveAttributedHealth(int HealAmount, int HealMax, pawn Healer, optional bool bOverheal)
{
	local UTComp_PRI_BW_FR_LDG uPRI;
	local bool bAwardThawPoints;
	
	if (Health >= HealMax && !bOverheal)
		return false;
		
	if (bFrozen)
	{
		if (Health > 95 || Freon(Level.Game).bRoundOT)
			return false;
		else
			HealAmount = 1;
	}

	HealAmount = Freon(Level.Game).ReduceHealing(HealAmount, self, Healer);
	
	if (HealAmount > 0)
	{
		if (bFrozen && Healer != None && Healer.PlayerReplicationInfo != None && PlayerReplicationInfo != None)
		{
			uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(PlayerReplicationInfo));
			if (uPRI != None)
				bAwardThawPoints = !uPRI.bExcludedFromRanking;
			
			if (bAwardThawPoints && UTCompMutator != None && (!UTCompMutator.bNoBotFarming || (!Healer.PlayerReplicationInfo.bBot && !PlayerReplicationInfo.bBot)))
			{
				uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(Healer.PlayerReplicationInfo));
				if (uPRI != None)
					uPRI.ThawPoints += float(HealAmount) / 5.0;
			}
		}
		
		super(BallisticPawn).GiveAttributedHealth(HealAmount, HealMax, Healer, bOverheal);
	}
	
	return true;
}

defaultproperties
{
}
