//=============================================================================
// DTleMatrevolverHead.
//
// Damage type for the Wilson DB Revolver headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTleMatRevolverHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k unleashed %kh diamond back on %o's head."
     DeathStrings(1)="%o got %vh head blown off in a duel with %k."
     DeathStrings(2)="%k went leMat on %o's head.."
     DeathStrings(3)="%o got %vh head in a few too many duels with %k."
     DeathStrings(4)="%k's Diamond Back bit %o in the head."
     bHeaddie=True
     WeaponClass=Class'BallisticProV55.leMatRevolver'
     DeathString="%k went leMat on %o's head."
     FemaleSuicide="%o shot herself in the face."
     MaleSuicide="%o shot himself in the face."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
