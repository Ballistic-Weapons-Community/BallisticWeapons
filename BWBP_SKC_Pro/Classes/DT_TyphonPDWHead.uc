//=============================================================================
// DT_TyphonPDWHead.
//
// Damage type for the Typhon headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_TyphonPDWHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's mind and brains were blown by %k's Typhon."
     DeathStrings(1)="%k made room in %o's skull for some Typhon bullets."
	 DeathStrings(2)="%o couldn’t take the mind altering weapon that %k had."
	 DeathStrings(3)="%k gave %o lethal laser eye surgery with a Typhon headshot."
	 DeathStrings(4)="%o's gray matter was forever scrambled by %k's Typhon."
	 DeathStrings(5)="%k showed %o who had the superior mind melter."
     bHeaddie=True
     WeaponClass=Class'BWBP_SKC_Pro.TyphonPDW'
     DeathString="%o was decapitated by %k with the Typhon."
     FemaleSuicide="%o peered down the barrel of her Typhon."
     MaleSuicide="%o peered down the barrel of his Typhon."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
