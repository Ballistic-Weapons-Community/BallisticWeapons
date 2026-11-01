//============================================================================
// Freon version of the Dark Star, to maintain SoulPower between rounds.
//=============================================================================
class FreonRSDarkStar extends RSDarkStar
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
				
			if (mPRI.DarkSoulPower > SoulPower)
				SoulPower = mPRI.DarkSoulPower;
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
	SoulPower = FClamp(SoulPower+Amount, 0, MaxSoulPower + 0.2f);
	
	if(!bOnRampage && mPRI != None)
		mPRI.DarkSoulPower = SoulPower;
}

function ServerWeaponSpecial(optional byte i)
{
	if (SoulPower >= MaxSoulpower)
	{
		StartRampage();
		if (mPRI != None)
			mPRI.DarkSoulPower = 0;
		ClientWeaponSpecial(1);
	}
}

defaultproperties
{
     PickupClass=Class'3SPNv3141BW.FreonRSDarkPickup'
     bGameRelevant=True
}
