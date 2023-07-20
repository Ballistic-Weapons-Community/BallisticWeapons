//=============================================================================
// DTXK2SMGHead.
//
// Damage type for the XK2 SMG headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXK2SMGHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was stung in the head by %k's XK2."
     DeathStrings(1)="%k ruined %o's head with %kh XK2."
     EffectChance=0.500000
     bHeaddie=True
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     WeaponClass=Class'BallisticProV55.XK2SubMachinegun'
     DeathString="%o was stung in the head by %k's XK2."
     FemaleSuicide="%o silenced herself."
     MaleSuicide="%o silenced himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     VehicleDamageScaling=0.000000
}
