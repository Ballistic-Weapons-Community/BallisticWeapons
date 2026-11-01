//---------------------------------------	--------------------
//
//-----------------------------------------------------------
class ThawRules extends GameRules;

var float ThawProtectionTime;
var MutThawProtection	mutator;


//we use this in case another Mutator Author has messed up and not called the super
//method in ModifyPlayer(), or has deliberately caused ModifyPlayer to not be called
//for other mutators on each player. We have to shutdown and alert to the log that
//something happened, and hopefully clue the server owner in on what is going down.
function emergencyCleanup() {
	local GameRules current;
	local GameRules previous;

    if(mutator != none)
    {
		mutator.Destroy();
		mutator = none;
	}

 	current = Level.Game.GameRulesModifiers;

 	while(current != none) {

      	if(current == self) {

      		//unlink ourselves from the game rules list
			if(previous == none)
			    Level.Game.GameRulesModifiers = NextGameRules;
			else
				previous.NextGameRules = NextGameRules;

			//destroy ourselves
			Destroy();
      	 	return;
      	}

		previous = current;
		current = current.NextGameRules;
 	}

 	log("### MutFreonThawProtection: Freon Thaw Mutator Destroyed");
}

function int NetDamage( int OriginalDamage, int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	local ThawInfo ti;
	local float M;

	if(!injured.IsPlayerPawn())
		return super.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

	ti = GetThawInfo(injured.Controller);

	if(ti == none)
	{
		//return what normally would have happened
		Damage = super.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

    	//Some other Mutator author screwed up the call to ModifyPlayer and didn't call the super class.
		//Let's log this and remove ourselves from the mutator chain.
		Log("### MutThawProtection - ALERT! Could not find ThawInfo for player:" @  injured);
		Log("### MutThawProtection - ALERT! ThawRules::NetDamage() - ModifyPlayer() on the Mutator HAS NOT BEEN CALLED! Check other running mutators to ensure they either call super.ModifyPlayer(), or call NextMutator.ModifyPlayer(Other) if the override this method!");
    	emergencyCleanup();
		return Super.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
	}

	if(ti.bIsProtected)
	{
		//remove momentum so you cant push protected players off cliffs
		if (class<BallisticDamageType>(DamageType) == None || class<BallisticDamageType>(DamageType).default.HipString  != "Deployed")
		{
			Momentum.X *= 0.5;
			Momentum.Y *= 0.5;
			Momentum.Z *= 0.5;
			
			M = VSize(Momentum);
			if (M > 2000)
				Momentum *= 2000 / M;
		}
		return 0;
	}

	return Super.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
}

function ThawInfo GetThawInfo(Controller c)
{
	local PlayerController pc;
 	local LinkedReplicationInfo LRI;

 	//is c none?

	LRI = c.PlayerReplicationInfo.CustomReplicationInfo;
	pc = PlayerController(c);

	while ( LRI != none )
    {
        if ( LRI.IsA( 'ThawInfo' ) )
			return ThawInfo(LRI);
        LRI = LRI.NextReplicationInfo;
    }

	return none;
}

defaultproperties
{
}
