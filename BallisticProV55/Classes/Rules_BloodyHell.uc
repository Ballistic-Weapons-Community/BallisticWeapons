//=============================================================================
// Rules_BloodyHell.
//
// Sends damage and death info to Blood controls.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Rules_BloodyHell extends GameRules;

var class<DamageType>			LastDamageType;
var class<BallisticDamageType>	ExplodedDamage;
var() string					ExplodedDamageName;

event PreBeginPlay()
{
	super.PreBeginPlay();
	ExplodedDamage = class<BallisticDamageType>(DynamicLoadObject(ExplodedDamageName, class'class'));
}

function bool PreventDeath(Pawn Killed, Controller Killer, class<DamageType> DT, vector HitLocation)
{
	LastDamageType = DT;
	if (super.PreventDeath(Killed,Killer, DT, HitLocation))
		return true;
	if (ExplodedDamage == None || UnrealPawn(Killed) == None || BallisticPawn(Killed) != None)
		return false;
	// This causes non ballistic weapons and damagetypes to make blood explode effects
	if (!ClassIsChildOf(DT, class'BallisticDamageType') && DT.default.bCausesBlood && (
		DT.default.bAlwaysGibs ||
		ClassIsChildOf(DT, class'Gibbed') ||
		ClassIsChildOf(DT, class'DamTypeRocket') ||
		ClassIsChildOf(DT, class'DamTypeFlakShell') ||
		ClassIsChildOf(DT, class'DamTypeSuperShockBeam') ||
		ClassIsChildOf(DT, class'DamTypeRedeemer') ||
		ClassIsChildOf(DT, class'DamTypeTankShell') ||
		ClassIsChildOf(DT, class'DamTypeAttackCraftMissle') ||
		ClassIsChildOf(DT, class'DamTypeShockCombo') ||
		ClassIsChildOf(DT, class'DamTypeMASCannon') ||
		ClassIsChildOf(DT, class'DamTypeTeleFrag') ||
		ClassIsChildOf(DT, class'DamTypeIonBlast') ||
		ClassIsChildOf(DT, class'DamTypeTeleFragged') ||
		ClassIsChildOf(DT, class'DamTypeIonCannonBlast') ))
		ExplodedDamage.static.DoBloodEffects(HitLocation, 100, Killed.Location - HitLocation * 10000, Killed, (Level.bDropDetail || Level.DetailMode == DM_Low));
	return false;

}
function ScoreKill(Controller Killer, Controller Killed)
{
	local BWBloodControl BC;

	super.ScoreKill(Killer,Killed);

	if (Killed.Pawn != None && BallisticPawn(Killed.Pawn) == None)
	{
		BC = Spawn(class'BWBloodControl', Killed.Pawn);
		BC.Initialize(LastDamageType);
		DoDamageDeathBlood();
	}
}

simulated function DoDamageDeathBlood()
{
}

defaultproperties
{
     ExplodedDamageName="BallisticProV55.DT_BWExplode"
}
