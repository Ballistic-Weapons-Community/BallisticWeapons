//=============================================================================
// DT_DTSHead.
//
// Damagetype for nanosword decapitations.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FlameSwordHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k's psionically imbued sword burned through %o's screaming face."
     DeathStrings(1)="%k directed %kh fire sword through %o's scrawny neck."
     DeathStrings(2)="%o was the victim of %k's pyrokinetic decapitation."
     DeathStrings(3)="%o's neck was left a smoldering stump from %k's PSI-56 Fire Sword."
     bHeaddie=True
     DamageIdent="Melee"
     WeaponClass=Class'BWBPOtherPackPro.FlameSword'
     DeathString="%k's psionically imbued sword burned through %o's screaming face"
     FemaleSuicide="%o swung her fire sword like a fool."
     MaleSuicide="%o swung his fire sword like a fool."
     bAlwaysSevers=True
     bSpecial=True
	 BlockFatiguePenalty=0.2
	 BlockPenetration=0.2
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     KDamageImpulse=1000.000000
}
