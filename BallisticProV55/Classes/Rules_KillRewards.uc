//=============================================================================
// Rules_KillRewards.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class Rules_KillRewards extends GameRules;

function ScoreKill(Controller Killer, Controller Killed)
{
    local int RewardHealthMax, RewardShieldMax, armorStrength;
	local xPawn KillerPawn;

    super.ScoreKill(Killer, Killed);

    if (Killed == None || Killer == None)
		return;

	if (Vehicle(Killer.Pawn) != None)
		KillerPawn = xPawn(Vehicle(Killer.Pawn).Driver);
	else 
		KillerPawn = xPawn(Killer.Pawn);

	if (KillerPawn == None || KillerPawn.Health <= 0)
		return;

	RewardHealthMax = class'BallisticReplicationInfo'.default.KillRewardHealthMax;

	if (RewardHealthMax == 0)
		RewardHealthMax = KillerPawn.SuperHealthMax;

	RewardShieldMax = class'BallisticReplicationInfo'.default.KillRewardShieldMax;

	if (RewardShieldMax == 0)
		RewardShieldMax = KillerPawn.ShieldStrengthMax;
    
	if(KillerPawn.Health < RewardHealthMax)
	{
		KillerPawn.Health = Clamp(KillerPawn.Health + class'BallisticReplicationInfo'.default.HealthKillReward, 0, RewardHealthMax);
	}

	if(KillerPawn.ShieldStrength < RewardShieldMax)
	{
		ArmorStrength = Min(class'BallisticReplicationInfo'.default.ShieldKillReward, RewardShieldMax - KillerPawn.ShieldStrength);

		if (ArmorStrength > 0)
			xPawn(Killer.Pawn).AddShieldStrength(ArmorStrength);
	}
}

defaultproperties
{
}
