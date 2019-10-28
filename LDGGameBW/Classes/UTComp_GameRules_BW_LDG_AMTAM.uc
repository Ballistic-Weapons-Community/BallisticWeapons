class UTComp_GameRules_BW_LDG_AMTAM extends GameRules;

var MutUTCompBW_LDG_AMTAM MyMutator;
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

event Timer()
{
	if (LastDamage > 0)
		MyMutator.ShowDamagePopup(DamageLocation, LastDamage);
		
	LastDamagedPawn = None;
	LastDamage = 0;
	DamageLocation = vect(0,0,0);
}

defaultproperties
{
}
