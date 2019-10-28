//============================================================================
// Freon version of the Nova Staff, to maintain SoulPower between rounds.
//=============================================================================
class FreonRSNovaStaff extends RSNovaStaff
	HideDropDown
	CacheExempt;

var Misc_PRI mPRI;

simulated function PostNetBeginPlay()
{
	local RSDarkNovaControl DNC;

	super(BallisticWeapon).PostNetBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		if (Instigator != None && Misc_PRI(Instigator.PlayerReplicationInfo) != None)
		{
				mPRI = Misc_PRI(Instigator.PlayerReplicationInfo);
				
				if (mPRI.NovaSoulPower > SoulPower)
					SoulPower = mPRI.NovaSoulPower;
		}
		
		if (DNControl == None)
		{
			foreach DynamicActors (class'RSDarkNovaControl', DNC)
			{
				DNControl = DNC;
				return;
			}
			DNControl = Spawn(class'RSDarkNovaControl', None);
		}
	}
}

function AddSoul(float Amount)
{
	SoulPower = FClamp(SoulPower+Amount	, 0, 5);
	
	if(!bOnRampage && mPRI != None)
		mPRI.NovaSoulPower = SoulPower;
}

function ServerWeaponSpecial(optional byte i)
{
	if (SoulPower >= 5)
	{
		StartRampage();
		if (mPRI != None)
			mPRI.NovaSoulPower = 0;
		ClientWeaponSpecial(1);
	}
}

defaultproperties
{
     PickupClass=Class'3SPNv3141BW.FreonRSNovaPickup'
     bGameRelevant=True
}
