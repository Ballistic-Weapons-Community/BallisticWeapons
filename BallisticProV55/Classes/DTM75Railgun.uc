//=============================================================================
// DTM75Railgun.
//
// Damage type for the M75 Railgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM75Railgun extends DT_BWBullet;

// Railgun sever effect can spread a little if damage is high enough
static function ModifyHit (Pawn Victim, out float Damage, vector Momentum, out vector HitLocation, out vector HitRay, out name HitBone)
{
	if (Damage > 100 + Rand(50))
	{
		if (HitBone == 'lshoulder' || HitBone == 'rshoulder')
			HitBone = 'spine';
		else if (HitBone == 'lthigh' || HitBone == 'rthigh')
			HitBone = 'pelvis';
		else if (HitBone == 'lfoot')
			HitBone = 'lthigh';
		else if (HitBone == 'rfoot')
			HitBone = 'rthigh';
		else if (HitBone == 'lfarm')
			HitBone = 'lshoulder';
		else if (HitBone == 'rfarm')
			HitBone = 'rshoulder';
	}
}

defaultproperties
{
     DeathStrings(0)="%o was railed by %k."
     DeathStrings(1)="%k's rail slug put a corkscrew through %o."
     DeathStrings(2)="%k derailed %o's skin."
     DeathStrings(3)="%o got %vs nebulised by %k's railgun."
     DeathStrings(4)="%o saw the light at the end of %k's M75 muzzle."
     AimedString="Scoped"
     BloodManagerName="BallisticProV55.BloodMan_Railgun"
     FlashThreshold=0
     FlashV=(Z=250.000000)
     FlashF=0.250000
     bSnipingDamage=True
     InvasionDamageScaling=1.500000
     DamageIdent="Sniper"
     bDisplaceAim=True
     AimDisplacementDamageThreshold=110
     AimDisplacementDuration=0.450000
     DamageDescription=",Bullet,Electro,"
     bOnlySeverLimbs=False
     WeaponClass=Class'BallisticProV55.M75Railgun'
     DeathString="%o was railed by %k."
     FemaleSuicide="%o derailed herself."
     MaleSuicide="%o derailed himself."
     bExtraMomentumZ=True
     VehicleDamageScaling=1.000000
}
