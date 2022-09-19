//===========================================================================
// ThawProtectionTrigger
//
// Also handles auto-thaw adjustment
//===========================================================================
class ThawProtectionTrigger extends Freon_Trigger;

var MutUTCompBW_LDG_FR 	UTCompMutator;
var float							SkillThawAdjustment;

function int DisallowInteraction(Pawn Other) 
{
 	local ThawInfo ti;

	ti = GetThawInfo(Other.Controller);
	if(ti != none)
	{
		if(ti.bIsProtected)
			return 0;
		else if (ti.bRecentlyThawn)
			return 1;
	}

	return -1;
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

function SendThawedMessage(Controller C)
{	
	if(PlayerController(PawnOwner.Controller) != None && DisallowInteraction(PawnOwner) == -1)
    PlayerController(PawnOwner.Controller).ReceiveLocalizedMessage(class'Freon_ThawMessage', 1, C.PlayerReplicationInfo);
}

function Timer()
{
  local int i;
  local int MostHealth;

  if(bTeamHeal && Toucher.Length > 0 && Level.TimeSeconds - PawnOwner.LastDamagedTime > TeamHealPostHitDelay)
  {
    for(i = 0; i < Toucher.Length; i++)
    {
    	if(DisallowInteraction(Toucher[i]) != -1)
    		continue;
    		
      if(Toucher[i].Health > MostHealth)
      	MostHealth = Toucher[i].Health;
    }

    if(Toucher.Length > 0 && PawnOwner.Health < MostHealth)      	
      PawnOwner.GiveHealth(MostHealth / (ThawSpeed * 2.5), MostHealth);
  }        
}

function OwnerFroze()
{ 
    FrozeTime = Level.TimeSeconds;
	if (LDGBallisticFRTracked(Level.Game) != None && PawnOwner.Controller != None)
		SkillThawAdjustment = LDGBallisticFRTracked(Level.Game).GetAutoThawRate(PawnOwner.Controller);
	else log("Skill thaw adjustment failed!",'Freon');
    GotoState('PawnFrozen');
}

state PawnFrozen 
{
    function Timer()
    {
        local int i, s;
        local int invalidTouchers;

        local int MostHealth;
        local float HealthGain;

        local float Touchers;

        local float AverageDistance, Distance, ThawScore;
        local UTComp_PRI_BW_FR_LDG uPRI, myuPRI;
        local bool bAwardThawPoints;

        if(PawnOwner == None)
        {
            Destroy();
            return;
        }
	    invalidTouchers = 0;
	    for(i = 0; i < Toucher.Length; i++)
	    {
		    s = DisallowInteraction(Toucher[i]);
	  	
            if(s != -1)
            {
                invalidTouchers++;
                if(PlayerController(Toucher[i].Controller) != None)
                PlayerController(Toucher[i].Controller).ReceiveLocalizedMessage(class'ThawWhileProtectedMessage', s);
            }
        }

        // touch thaw adjustment
        if((PawnOwner.Health > 12 || Freon(Level.Game).bRoundOT) && Toucher.Length - invalidTouchers > 0)
        {
            if(PlayerController(PawnOwner.Controller) != None)
            {
                for(i = 0; i < Toucher.Length; i++)
                {
                    if(DisallowInteraction(Toucher[i]) != -1)
                        continue;
                    
                    if (Toucher[i].PlayerReplicationInfo != None)
                    {
                        PlayerController(PawnOwner.Controller).ReceiveLocalizedMessage(class'Freon_ThawMessage', 2, Toucher[i].PlayerReplicationInfo);
                        break;
                    }
                }
            
                if (i == Toucher.Length)
                    PlayerController(PawnOwner.Controller).ReceiveLocalizedMessage(class'Freon_ThawMessage', 2);
            }

            for(i = 0; i < Toucher.Length; i++)
            {
                if(DisallowInteraction(Toucher[i]) != -1)
                    continue;
                    
                if (Freon_PRI(Toucher[i].PlayerReplicationInfo) != None)
                Freon_PRI(Toucher[i].PlayerReplicationInfo).LastThawTime = Level.TimeSeconds;
                    
                if(Toucher[i].Health > MostHealth)
                    MostHealth = Toucher[i].Health;

                if(Toucher[i].bThawFast)
                {
                    Touchers += FastThawModifier;
                    ThawScore = FastThawModifier;
                }
                else
                {
                    Touchers += 1.0;
                    ThawScore = 1.0;
                }

                Distance = VSize(PawnOwner.Location - Toucher[i].Location);
                
                myuPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(PawnOwner.PlayerReplicationInfo));

                if (myuPRI != None && !myuPRI.bExcludedFromRanking)
                    bAwardThawPoints = true;
                
                if (bAwardThawPoints && Toucher[i].PlayerReplicationInfo != None)
                {			
                    if (UTCompMutator != None && (!UTCompMutator.bNoBotFarming || (!PawnOwner.PlayerReplicationInfo.bBot && !Toucher[i].PlayerReplicationInfo.bBot)))
                    {
                        uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(Toucher[i].PlayerReplicationInfo));
                        
                        if (uPRI != None)
                        {
                            if(Freon(Level.Game).bRoundOT)
                            ThawScore *= 0.4;
                        
                            if (Distance > 100.0)
                                ThawScore *= 0.5;
                        
                            uPRI.ThawPoints += ThawScore;
                        }
                    }
                }
                            
                AverageDistance += Distance;
            }

            AverageDistance /= i;

            if(AverageDistance <= 100.0)
                HealthGain += (100.0 / ThawSpeed) * 0.5 * Touchers;
            else
                HealthGain += (100.0 / ThawSpeed) * 0.25 * Touchers;
                
            if(Freon(Level.Game).bRoundOT)
                HealthGain *= 0.4;
        }

        // auto thaw adjustment
        else if(AutoThawTime > 0.0)
        {
            if(!Freon(Level.Game).bRoundOT)
            HealthGain += (100.0 / AutoThawTime) * 0.5 * SkillThawAdjustment;
        }

        PawnOwner.DecimalHealth += HealthGain;
        if(PawnOwner.DecimalHealth >= 1.0)
        {
            HealthGain = int(PawnOwner.DecimalHealth);
            PawnOwner.DecimalHealth -= HealthGain;
            PawnOwner.GiveHealth(HealthGain, 100);
        }

        // thaw if needed
        if(PawnOwner.Health >= 100)
        {
            PawnOwner.DecimalHealth = 0.0;
            
            PawnOwner.Health = 100;

            if (PlayerController(PawnOwner.Controller) != None)
                PlayerController(PawnOwner.Controller).ClientPlaySound(ThawSound);
            PawnOwner.PlaySound(ThawSound, SLOT_Interact, PawnOwner.TransientSoundVolume * 1.5,, PawnOwner.TransientSoundRadius * 1.5);

            if (AIController(PawnOwner.Controller) != None)
            {			
                if (Toucher.Length - invalidTouchers > 0)
                    PawnOwner.ThawByTouch(Toucher, true, MostHealth);
                else
                    PawnOwner.Thaw();

                if (PawnOwner == None)
                    Destroy();
            }
            
            else
            {
                if (Toucher.Length - invalidTouchers > 0)
                    PawnOwner.ThawByTouch(Toucher, false, MostHealth);
                else
                {
                    PlayerController(PawnOwner.Controller).ServerViewSelf();
                    PlayerController(PawnOwner.Controller).ReceiveLocalizedMessage(class'Freon_ThawMessage', 0);
                }
                
                Destroy();
            }
        }
    }
}


/*
		old thaw
    // thaw if needed
    if(PawnOwner.Health >= 100)
    {
      PawnOwner.DecimalHealth = 0.0;

      if(PlayerController(PawnOwner.Controller) != None)
      	PlayerController(PawnOwner.Controller).ClientPlaySound(ThawSound);
      PawnOwner.PlaySound(ThawSound, SLOT_Interact, PawnOwner.TransientSoundVolume * 1.5,, PawnOwner.TransientSoundRadius * 1.5);

      if(Toucher.Length - invalidTouchers > 0)
          PawnOwner.ThawByTouch(Toucher, MostHealth);
      else
          PawnOwner.Thaw();

      if(PawnOwner == None)
      	Destroy();
    }
	*/

defaultproperties
{
     SkillThawAdjustment=1.000000
}
