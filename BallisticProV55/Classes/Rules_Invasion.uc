class Rules_Invasion extends Rules_Ballistic;

function int NetDamage( int OriginalDamage, int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	if ( (Monster(injured) != None || class<MonsterController>(injured.ControllerClass) != None) && class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).default.InvasionDamageScaling != 1)
		Damage *= class<BallisticDamageType>(DamageType).default.InvasionDamageScaling;
		
	return Super.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);
}

defaultproperties
{
}
