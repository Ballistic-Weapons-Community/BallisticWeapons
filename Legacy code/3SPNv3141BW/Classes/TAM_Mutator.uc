class TAM_Mutator extends DMMutator
    HideDropDown
    CacheExempt;
    
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{	
    bSuperRelevant = 0;

    if(Other.IsA('Pickup') && !Other.IsA('Misc_PickupHealth') && !Other.IsA('Misc_PickupShield') && !(Other.IsA('Misc_PickupAdren')))
        return false;
        
    if(Other.IsA('xPickupBase') && !Other.IsA('Misc_PickupBase'))
        Other.bHidden = true;
		
	if (Other.IsA('DECO_ExplodingBarrel'))
	{
		Other.Destroy();
		return false; // I fucking hate this shit - Azarael
	}
	
	// slow players when spawning during lock
	if (Other.IsA('BCSprintControl') && Team_GameBase(Level.Game).bLockMovement && Team_GameBase(Level.Game).LockTime > 0)
	{
		BCSprintControl(Other).AddSlow(0.01, Team_GameBase(Level.Game).LockTime);
		Log("Adding " $ Team_GameBase(Level.Game).LockTime $ " second initial slow");
	}
	
    return true;
}

function SpawnWeapon(class<BallisticWeapon> newClass, BallisticWeapon original, Pawn P)
{
	local BallisticWeapon newWeapon;

    if( newClass!=None && P != None && (P.FindInventoryType(newClass)==None))
    {
    	newWeapon = P.Spawn(newClass,,,P.Location);
        
        if( newWeapon != None )
        {
            newWeapon.NetInventoryGroup = original.NetInventoryGroup;
            newWeapon.bServerDeferInitialSwitch = original.bServerDeferInitialSwitch;
            newWeapon.GiveTo(P);     
        }   
    }

}

function ServerTraveling(string URL, bool bItems)
{
	if(Team_GameBase(Level.Game) != None)
        Team_GameBase(Level.Game).ResetDefaults();
    else if(ArenaMaster(Level.Game) != None)
        ArenaMaster(Level.Game).ResetDefaults();

    Super.ServerTraveling(URL, bItems);
}

defaultproperties
{
}
