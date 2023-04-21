//=============================================================================
// D49PrimaryFire.
//
// BANG! You're dead!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class D49PrimaryFire extends BallisticProInstantFire;

var   bool			bSecondary;

simulated function FlashMuzzleFlash()
{
	if (bSecondary)
		D49SecondaryFire(Weapon.GetFireMode(1)).FlashSingleMuzzleFlash();
	else
		super.FlashMuzzleFlash();
}
simulated function PlayFiring()
{
//	D49Revolver(Weapon).RevolverFired(ThisModeNum);
	super.PlayFiring();
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	switch(D49Revolver(Weapon).GetBarrelMode())
	{
		case BM_Neither:
			D49Revolver(Weapon).RevolverFired(BM_Neither);
			BW.FireCount++;
	        NextFireTime += FireRate*0.5;
    	    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
			return;
		case BM_Primary:
			break;
		case BM_Secondary:
			bSecondary = true;
			break;
		default:
			break;
	}
	super.ModeDoFire();
	if (bSecondary)
		D49Revolver(Weapon).RevolverFired(BM_Secondary);
	else
		D49Revolver(Weapon).RevolverFired(BM_Primary);
	bSecondary = false;
}

defaultproperties
{        
    FlashBone="tip2"
    AmmoClass=Class'BallisticProV55.Ammo_44Magnum'

	ShakeRotMag=(X=72.000000)
	ShakeRotRate=(X=1080.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-10.00)
	ShakeOffsetRate=(X=-200.00)
	ShakeOffsetTime=2.000000
    
    // AI
    bInstantHit=True
    bLeadTarget=False
    bTossed=False
    bSplashDamage=False
    bRecommendSplashDamage=False
    BotRefireRate=0.7
}
