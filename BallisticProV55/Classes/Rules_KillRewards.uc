//=============================================================================
// Rules_KillRewards.
//
// by Paul "Grum" Haack.
// Copyright(c) 2012 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class Rules_KillRewards extends GameRules;

function ScoreKill(Controller Killer, Controller Killed)
{
    local int healthCap, shieldCap, armorStrength;
    super.ScoreKill(Killer,Killed);

    if(Killed != None && Killer != None && Killer.Pawn != None)
    {
        if(Killer.Pawn.Health > 0 && Killer.Pawn.Health < class'BallisticReplicationInfo'.default.killRewardHealthcap || class'BallisticReplicationInfo'.default.killRewardHealthcap == 0)
        {
            healthCap = class'BallisticReplicationInfo'.default.killRewardHealthcap;
            if(Vehicle(Killer.Pawn) == None)
            {
                if(healthCap == 0)
                    healthCap = Killer.Pawn.SuperHealthMax;
                Killer.Pawn.Health = Clamp(Killer.Pawn.Health+class'BallisticReplicationInfo'.default.killRewardHealthpoints,0,healthCap);
            }else
            {
                if(healthCap == 0)
                    healthCap = Vehicle(Killer.Pawn).Driver.SuperHealthMax;
                Vehicle(Killer.Pawn).Driver.Health = Clamp(Vehicle(Killer.Pawn).Driver.Health+class'BallisticReplicationInfo'.default.killRewardHealthpoints,0,healthCap);
            }
        }

        if(Killer.Pawn.Health > 0 && Killer.Pawn.ShieldStrength < class'BallisticReplicationInfo'.default.killrewardArmorCap || class'BallisticReplicationInfo'.default.killrewardArmorCap == 0)
        {
            shieldCap = class'BallisticReplicationInfo'.default.killrewardArmorCap;
            if(Vehicle(Killer.Pawn) == None && xPawn(Killer.Pawn) != none)
            {
                if(shieldCap == 0)
                    shieldCap = xPawn(Killer.Pawn).ShieldStrengthMax;
                armorStrength = Clamp(class'BallisticReplicationInfo'.default.killrewardArmor,0,shieldCap);

                xPawn(Killer.Pawn).AddShieldStrength(armorStrength);
            }else if(xPawn(Vehicle(Killer.Pawn).Driver) != none)
            {
                if(shieldCap == 0)
                    shieldCap = xPawn(Vehicle(Killer.Pawn).Driver).ShieldStrengthMax;

                armorStrength = Clamp(class'BallisticReplicationInfo'.default.killrewardArmor,0,shieldCap);
                xPawn(Vehicle(Killer.Pawn).Driver).AddShieldStrength(armorStrength);
            }
        }
    }
}

defaultproperties
{
}
