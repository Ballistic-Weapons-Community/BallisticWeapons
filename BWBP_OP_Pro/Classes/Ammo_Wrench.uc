class Ammo_Wrench extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=100
     InitialAmount=50
     ItemName="Wrench Energy"

	Begin Object Class=AmmoParams Name=ArenaParams
		KillInitialAmmoMult=0.0f
		bResuppliesFromPack=False
	End Object

	Begin Object Class=AmmoParams Name=ClassicParams
		KillInitialAmmoMult=0.0f
		bResuppliesFromPack=False
	End Object

	Begin Object Class=AmmoParams Name=RealismParams
		KillInitialAmmoMult=0.0f
		bResuppliesFromPack=False
	End Object

	Begin Object Class=AmmoParams Name=TacticalParams
		KillInitialAmmoMult=0.0f
		bResuppliesFromPack=False
	End Object

	Params[0]=ArenaParams
	Params[1]=ClassicParams
	Params[2]=RealismParams
	Params[3]=TacticalParams
}
