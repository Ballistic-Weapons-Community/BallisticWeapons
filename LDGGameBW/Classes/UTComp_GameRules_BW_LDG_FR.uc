class UTComp_GameRules_BW_LDG_FR extends GameRules;

var MutUTCompBW_LDG_FR MyMutator;
var Pawn LastDamagedPawn;
var vector DamageLocation;
var int LastDamage;

function int NetDamage( int OriginalDamage, int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{	
	Damage = Super.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
	
	//only show popup if sbdy hit me
	if (instigatedBy != None)
	{
		if (LastDamagedPawn != None)
		{
			if (LastDamagedPawn != injured)
			{
				if (LastDamage > 0)
					MyMutator.ShowDamagePopup(DamageLocation, LastDamage);
				
				LastDamagedPawn = injured;
				LastDamage = Damage;
				DamageLocation = injured.Location;
			}
			else
				LastDamage += Damage;
		}
		else
		{
			LastDamagedPawn = injured;
			LastDamage = Damage;
			DamageLocation = injured.Location;
		}
		
		SetTimer(0.05,false);
	}
	
	return Damage;
}

function bool IsFarming(Controller C, optional bool bAllowSentinel)
{
	local UTComp_PRI uPRI;
	
	if ( (MyMutator.bNoBotFarming) && (Level.Game.IsA('LDGBallisticFRTracked') || Level.Game.IsA('LDGBallisticFR_CTFMapsTracked')) && (Bot(C) != None))
		return true;
	
	if (!MyMutator.bNoVehicleFarming)
		return false;

	if (ASVehicle_Sentinel(C.Pawn) != None && UnrealPlayer(C) == None && Bot(C) == None)
		return !bAllowSentinel;

	uPRI = class'UTComp_Util'.static.GetUTCompPRIFor(C);
	
	if (uPRI != None)
		return uPRI.InAVehicle || (Level.TimeSeconds - uPRI.VehicleExitTime < 0.5);
		
	return true;
}

function ScoreKill(Controller Killer, Controller Killed)
{
	local UTComp_PRI_BW_FR_LDG uPRIk, uPRIv;
	local ThawInfo ti;
	local bool bIncDeaths, bKillerUnranked, bVictimUnranked;
	
	// Check if we are end of round or with locked weapons, in such cases, don't do anythihg
	if (Team_GameBase(Level.Game) != None && (Team_GameBase(Level.Game).bEndOfRound || Team_GameBase(Level.Game).bWeaponsLocked || Team_GameBase(Level.Game).IsPracticeRound()))
		goto ScoreKillEnd;
	
	if (Killed != None && Killed.PlayerReplicationInfo != None)
	{
		//Suicide
		if (Killer == None || Killer == Killed || Killer.PlayerReplicationInfo == None)
		{
			uPRIv = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(Killed.PlayerReplicationInfo));
			if (uPRIv != None)
				uPRIv.RealDeaths++;
		}
		else
		{
			uPRIk = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(Killer.PlayerReplicationInfo));
			uPRIv = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(Killed.PlayerReplicationInfo));
			
			bKillerUnranked = uPRIk == None || uPRIk.bExcludedFromRanking;
			bVictimUnranked = uPRIv == None || uPRIv.bExcludedFromRanking;
			
			//Team game - check TK
			if (Level.Game.bTeamGame && Killer.PlayerReplicationInfo.Team != None && Killed.PlayerReplicationInfo.Team != None && Killer.PlayerReplicationInfo.Team == Killed.PlayerReplicationInfo.Team)
			{
				// check vehicle
				if (!IsFarming(Killer, true) && !IsFarming(Killed, false))
				{	
					// decrement kills unless killer is ranked and victim is unranked
					if (uPRIk != None && (!bKillerUnranked || bVictimUnranked))
						uPRIk.RealKills--;
				}
			}
			else
			{
				//normal kill - check vehicle
				if (!IsFarming(Killer, true) && !IsFarming(Killed, false))
				{		
					// increment kills unless killer is ranked and victim is unranked, and add kill to killer's spectrum
					if(uPRIk != None && (bKillerUnranked || !bVictimUnranked))
					{
						uPRIk.RealKills++;
						uPRIk.AddKill(uPRIv.Skill);
					}
					
					if(uPRIv != None)
					{
						// increment deaths unless killer is unranked and victim is ranked
						bIncDeaths = !bKillerUnranked || bVictimUnranked;
						
						if (bIncDeaths)
						{
							//make an extra check - if the player was thawn recently, do not increment deaths
							ti = GetThawInfo(Killed);
							if(ti != none)
							{
								if (ti.LastThawnTime != 0 && Level.TimeSeconds - ti.LastThawnTime < 10)
									bIncDeaths = false; 
							}
							
							if (bIncDeaths)
								uPRIv.RealDeaths++;
						}
					}
				}
			}
		}
	}

ScoreKillEnd:
	if ( NextGameRules != None )
		NextGameRules.ScoreKill(Killer,Killed);
}

event Timer()
{
	if (LastDamage > 0)
		MyMutator.ShowDamagePopup(DamageLocation, LastDamage);
		
	LastDamagedPawn = None;
	LastDamage = 0;
	DamageLocation = vect(0,0,0);
}

function ThawInfo GetThawInfo(Controller C)
{
	local LinkedReplicationInfo LRI;

	LRI = C.PlayerReplicationInfo.CustomReplicationInfo;

	while (LRI != none)
  {
		if (LRI.IsA('ThawInfo'))
			return ThawInfo(LRI);
			
		LRI = LRI.NextReplicationInfo;
  }

	return none;
}

defaultproperties
{
}
