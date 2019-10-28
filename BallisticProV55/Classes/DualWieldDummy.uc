//===================================================================
// DualWieldDummy
//
// Doubles up on the player's sidearm and maxes out the ammo.
//===================================================================
class DualWieldDummy extends DummyWeapon
	abstract
	HideDropDown;
	
static function bool ApplyEffect(Pawn Other, byte Level, optional bool bInitial)
{
	local BallisticHandgun HG;
	
	HG = BallisticHandgun(Other.FindInventoryType(class'BallisticHandgun'));
	
	if (HG == None)
	{
		PlayerController(Other.Controller).ClientMessage("You can only use this killstreak with compatible sidearms.");
		return false;
	}
	
	else
	{
		class'Mut_Outfitting'.static.SpawnWeapon(HG.Class, Other);
		if (HG != None)
			HG.MaxOutAmmo();
		
		if (BallisticPawn(Other) != None)
			BallisticPawn(Other).bActiveKillstreak = True;
			
		return true;
	}
}

defaultproperties
{
     BigIconMaterial=Texture'BallisticProTextures.Icons.DualWield'
     ItemName="Dual Wield"
}
