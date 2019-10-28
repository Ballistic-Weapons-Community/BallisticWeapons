//============================================================================
// Freon version of the XOXO Staff, to maintain Lewdness between rounds.
//=============================================================================
class FreonXOXOStaff extends XOXOStaff
	HideDropDown
	CacheExempt;

var Misc_PRI mPRI;

simulated function PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		if (Instigator != None && Misc_PRI(Instigator.PlayerReplicationInfo) != None)
		{
				mPRI = Misc_PRI(Instigator.PlayerReplicationInfo);
				
				if (mPRI.XOXOLewdness > Lewdness)
					Lewdness = mPRI.XOXOLewdness;
		}
	}
}

function AddLewd(float Amount)
{
	Lewdness = FClamp(Lewdness+Amount, 0, 5);
	
	if(!bLoveMode && mPRI != None)
		mPRI.XOXOLewdness = Lewdness;
}

function ServerWeaponSpecial(optional byte i)
{
	if (Lewdness >= 5)
	{
		LoveMode();
		if (mPRI != None)
			mPRI.XOXOLewdness = 0;
		ClientWeaponSpecial(1);
	}
}

defaultproperties
{
     PickupClass=Class'3SPNv3141BW.FreonXOXOPickup'
     bGameRelevant=True
}
