class UTComp_GameRules extends GameRules;

var MutUTComp UTCompMutator;

function int NetDamage( int OriginalDamage, int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	local byte HitSoundType;
	local UTComp_PRI uPRI;
	local controller C;
	
	if(Damage > 0 && InstigatedBy != None && Injured != None && InstigatedBy.Controller != None && UTComp_xPlayer(InstigatedBy.Controller) != None)
	{
		if(UTCompMutator.EnableHitSoundsMode > 0)
		{
			if(InstigatedBy == Injured)
				HitSoundType = 0;
			else if(InstigatedBy.GetTeamNum() == 255 || InstigatedBy.GetTeamNum() != Injured.GetTeamNum())
				HitSoundType = 1;
			else
				HitSoundType = 2;
				
			//using teams 3 and 4 for grouped hitsounds and doing the damage check here...
			if (DamageType == class'DamTypeFlakChunk' || ClassIsChildOf(DamageType, class'DamTypeFlakChunk'))
				HitSoundType += 2;
				
			UTComp_xPlayer(InstigatedBy.Controller).ReceiveHitSound(Damage, Injured, UTCompMutator.EnableHitSoundsMode, HitSoundType);

			uPRI = class'UTComp_Util'.static.GetUTCompPRIForPawn(InstigatedBy);
		
			if(uPRI != None)
				uPRI.DamG += Min(Damage, Injured.Health);

			for(C = Level.ControllerList; C!=None; C = C.NextController)
			{
				if(UTComp_xPlayer(C) != None && C.PlayerReplicationInfo != None && (C.PlayerReplicationInfo.bOnlySpectator || C.PlayerReplicationInfo.bOutOfLives) 
					&& PlayerController(C).ViewTarget == InstigatedBy)
					UTComp_xPlayer(C).ReceiveHitSound(Damage, Injured, UTCompMutator.EnableHitSoundsMode, HitSoundType);
			}
		}
	}

	if(Injured != None && Injured.Controller != None && UTComp_xPlayer(Injured.Controller) != None)
	{
		uPRI = class'UTComp_Util'.static.GetUTCompPRIForPawn(Injured);
		
		if(uPRI != None)
			uPRI.DamR += Min(Damage, Injured.Health);
	}
	
	if ( NextGameRules != None )
		return NextGameRules.NetDamage( OriginalDamage,Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
		
	return Damage;
}

function bool IsFarming(Controller C, optional bool bAllowSentinel)
{
	local UTComp_PRI uPRI;
	
	if (!UTCompMutator.bNoVehicleFarming)
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
	local UTComp_PRI uPRI;
	
	if (Killed != None && Killed.PlayerReplicationInfo != None)
	{
		//Suicide
		if (Killer == None || Killer == Killed || Killer.PlayerReplicationInfo == None)
		{
			uPRI = class'UTComp_Util'.static.GetUTCompPRIFor(Killed);
			if (uPRI != None)
				uPRI.RealDeaths++;
		}
		else
		{
			//Team game - check TK
			if (Level.Game.bTeamGame && Killer.PlayerReplicationInfo.Team != None && Killed.PlayerReplicationInfo.Team != None && Killer.PlayerReplicationInfo.Team == Killed.PlayerReplicationInfo.Team)
			{				
				// check vehicle
				if (!IsFarming(Killer, true) && !IsFarming(Killed, false))
				{	
					uPRI = class'UTComp_Util'.static.GetUTCompPRIFor(Killer);
					if (uPRI != None)
						uPRI.RealKills--;
				}
			}
			else
			{			
				//normal kill - check vehicle
				if (!IsFarming(Killer, true) && !IsFarming(Killed, false))
				{	
					uPRI = class'UTComp_Util'.static.GetUTCompPRIFor(Killer);
				
					if(uPRI != None)
						uPRI.RealKills++;
					
					uPRI = class'UTComp_Util'.static.GetUTCompPRIFor(Killed);
					
					if(uPRI != None)
						uPRI.RealDeaths++;
				}
			}
		}
	}
	
	if ( NextGameRules != None )
		NextGameRules.ScoreKill(Killer,Killed);
}

defaultproperties
{
}
