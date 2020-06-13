class ProtonGameRules extends GameRules;

var array<ProtonStreamer> Cannons;

function AddStreamer(ProtonStreamer P)
{
	Cannons[Cannons.Length] = P;
}

function RemoveStreamer(ProtonStreamer P)
{
	local int i;
	
	for (i=0; i < Cannons.Length; ++i)
	{
		if (Cannons[i] == P)
			Cannons.Remove(i, 1);
	}
}

function int NetDamage( int OriginalDamage, int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	local int i;
	
	if (Cannons.Length > 0)
	{
		for (i=0;i<Cannons.Length;i++)
		{
			if (Cannons[i].DrainTarget == instigatedBy)
			{
				Damage *= 0.25;
				goto LoopLeave;
			}
			if (Cannons[i].BoostTarget == instigatedBy)
			{
				Damage *= 1.5;
				goto LoopLeave;
			}
		}
	}

	//Loop Bugs Yo
	LoopLeave:
	
	if ( NextGameRules != None )
		return NextGameRules.NetDamage( OriginalDamage,Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
	return Damage;
}

defaultproperties
{
}
