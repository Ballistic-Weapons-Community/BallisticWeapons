//=============================================================================
// Mut_Regeneration.
//
// Periodically restores health to players.
// Also adds a rules class that awards a health bonus for killing players.
//
// by Logan "Black Eagle" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_Regeneration extends Mutator
	config(BallisticProV55);

var globalconfig bool     	bUseRegen;
var globalconfig float		RegenRate;			// Amount of time between restoring 'RegenAmount' health to players.
var globalconfig int		RegenAmount;		// How much health to restore every 'RegenRate'.
var globalconfig float		RegenDelay;			// Amount of time between a player being damaged and the regeneration starting.
var globalconfig int		HealthCap;			// The maximum amount of health a player can regenerate.
var globalconfig int		HealthBonus;		// Amount of health awarded for killing players.
var globalconfig int		HealthBonusCap;		// The maximum amount of health a player can get through killing enemies.
var globalconfig bool		VehiclesRegen;		// Can vehicles regenerate health?.

event Timer()
{
	local int i;

	if (bUseRegen)
	{
		for (i=0;i<Level.GRI.PRIArray.Length;i++)
		{
			if(Level.GRI.PRIArray[i] != None && Controller(Level.GRI.PRIArray[i].Owner) != None && Controller(Level.GRI.PRIArray[i].Owner).Pawn != None)
			{
				if(Vehicle(Controller(Level.GRI.PRIArray[i].Owner).Pawn) != None && VehiclesRegen)
				{
					if(Controller(Level.GRI.PRIArray[i].Owner).Pawn.LastPainTime < (Level.TimeSeconds-(RegenDelay*1.5)) && Controller(Level.GRI.PRIArray[i].Owner).Pawn.Health > 0 && Controller(Level.GRI.PRIArray[i].Owner).Pawn.Health < Controller(Level.GRI.PRIArray[i].Owner).Pawn.HealthMax)
						Controller(Level.GRI.PRIArray[i].Owner).Pawn.Health = Clamp(Controller(Level.GRI.PRIArray[i].Owner).Pawn.Health+(RegenAmount*2),0,Controller(Level.GRI.PRIArray[i].Owner).Pawn.HealthMax);
				}
				else if(Vehicle(Controller(Level.GRI.PRIArray[i].Owner).Pawn) == None)
				{
					if(Controller(Level.GRI.PRIArray[i].Owner).Pawn.LastPainTime < (Level.TimeSeconds-RegenDelay) && Controller(Level.GRI.PRIArray[i].Owner).Pawn.Health > 0 && Controller(Level.GRI.PRIArray[i].Owner).Pawn.Health < HealthCap)
						Controller(Level.GRI.PRIArray[i].Owner).Pawn.Health = Clamp(Controller(Level.GRI.PRIArray[i].Owner).Pawn.Health+RegenAmount,0,HealthCap);
				}
			}
		}
	}
}

event PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (bUseRegen)
	{
		SetTimer(RegenRate, true);

		if(!bDeleteMe)
			Level.Game.AddGameModifier(Spawn(class'Rules_Regen'));
	}
}

defaultproperties
{
     bUseRegen=True
	 RegenRate=1.000000
     RegenAmount=3
     RegenDelay=6.000000
     HealthCap=100
     HealthBonus=25
     HealthBonusCap=150
     VehiclesRegen=True
     FriendlyName="BallisticPro: Regeneration"
     Description="Periodically restores health to injured players and vehicles, and awards bonus player health for kills...||http://www.runestorm.com"
}
