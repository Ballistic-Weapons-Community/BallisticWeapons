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
        
    if(Other.Class == class'BallisticProV55.RSDarkStar')
    {
        SpawnWeapon(class'FreonRSDarkStar', Other.Instigator);
        
	   	if (Other != None)
    		Other.Destroy();
    	return false;
    }
    
    if(Other.Class == class'BallisticProV55.RSNovaStaff')
    {
      	SpawnWeapon(class'FreonRSNovaStaff', Other.Instigator);
      	
    	if (Other != None)
    		Other.Destroy();
        return false;
    }
	
	if(Other.Class == class'XOXOStaff')
    {
      	SpawnWeapon(class'FreonXOXOStaff', Other.Instigator);
      	
    	if (Other != None)
    		Other.Destroy();
        return false;
    } 
	
    return true;
}

function SpawnWeapon(class<Weapon> newClass, Pawn P)
{
	local Weapon newWeapon;

    if( newClass!=None && P != None && (P.FindInventoryType(newClass)==None))
    {
    	newWeapon = P.Spawn(newClass,,,P.Location);
        
        if( newWeapon != None )
            newWeapon.GiveTo(P);        
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
