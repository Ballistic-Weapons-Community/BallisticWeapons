//=============================================================================
// DT_HVCLightning.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_HVCLightning extends DT_BWMiscDamage;

static function bool OverrideCanSever(Pawn Pawn, name Bone, int Damage, vector HitLoc, vector HitRay, bool bDirectHit, out byte bCanSever)
{
	switch (Bone)
	{
		case 'pelvis'	: if (200 + Rand(150) < Damage * default.GibModifier) bCanSever=1; break;
		case 'spine'	: if (200 + Rand(150) < Damage * default.GibModifier) bCanSever=1; break;
		case 'head'		: if (50 + Rand(50) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lshoulder': if (60 + Rand(60) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rshoulder': if (60 + Rand(60) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lfarm'	: if (30 + Rand(30) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rfarm'	: if (30 + Rand(30) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lhand'	: if (20 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
		case 'righthand': if (20 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rhand'	: if (20 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lthigh'	: if (60 + Rand(60) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rthigh'	: if (60 + Rand(60) < Damage * default.GibModifier) bCanSever=1; break;
		case 'lfoot'	: if (20 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
		case 'rfoot'	: if (20 + Rand(20) < Damage * default.GibModifier) bCanSever=1; break;
	}
	return true;
}

defaultproperties
{
     DeathStrings(0)="%o was enlightened by %k."
     DeathStrings(1)="%o was struck down by %k's lightning."
     DeathStrings(2)="%k electrocuted %o with %kh lightning gun."
     DeathStrings(3)="%k seared %o into ash with %kh HVC."
     DeathStrings(4)="%o screamed and burned as %k poured lightning into %vm."
     DeathStrings(5)="%k tossed %o around with scorching lightning."
     DeathStrings(6)="%k exerted the wrath of God on %o."
     SimpleKillString="HVC-Mk9 Lightning Stream"
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     FlashThreshold=0
     FlashV=(X=800.000000,Y=800.000000,Z=2000.000000)
     FlashF=0.500000
     ShieldDamage=15
     bDetonatesBombs=False
     bIgniteFires=True
     InvasionDamageScaling=3.000000
     DamageIdent="Streak"
     DamageDescription=",Electro,"
     bMultiSever=True
     WeaponClass=Class'BallisticProV55.HVCMk9LightningGun'
     DeathString="%o was was enlightened by %k."
     FemaleSuicide="%o was struck down by the hand of God."
     MaleSuicide="%o was struck down by the hand of God."
     bInstantHit=True
     bCauseConvulsions=True
     GibModifier=5.000000
     DamageOverlayMaterial=Shader'BallisticEpicEffects.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     KDamageImpulse=20000.000000
}
