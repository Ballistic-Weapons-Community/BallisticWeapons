//=============================================================================
// DT_RSNovaLightning.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTProtonStreamer extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o underwent a total protonic reversal from %k's E90-N."
     DeathStrings(1)="%k busted %o with a proton stream."
     DeathStrings(2)="%k made a ghost out of %o."
     DeathStrings(3)="%k neutronized %o with %kh particle accelerator."
     DeathStrings(4)="%k ain't 'fraid of &o's ghost."
     DeathStrings(5)="%k crossed %o's stream."
     DeathStrings(6)="%k made every molecule in %o's body explode at the speed of light."
     DeathStrings(7)="%k reduced %o to a focused, non-terminal, repeating phantasm."
     SimpleKillString="E90-N Proton Stream"
     BloodManagerName="BallisticProV55.BloodMan_NovaLightning"
     FlashThreshold=0
     FlashV=(Z=350.000000)
     FlashF=0.700000
     ShieldDamage=15
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Electro,"
     WeaponClass=Class'BWBPOtherPackPro.ProtonStreamer'
     DeathString="%k busted %o with a proton stream."
     FemaleSuicide="Its true, %o has no dick."
     MaleSuicide="Its true, %o has no dick."
     bInstantHit=True
     bLocationalHit=False
     bCauseConvulsions=True
     bNeverSevers=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     KDamageImpulse=20000.000000
}
