//=============================================================================
// Slow moving energy projectile
//
// To do: Slow vehicles.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_ProtonTorpedo extends G5Rocket;

var() Sound ComboSound;
var() float ComboDamage;
var() float ComboRadius;
var() float ComboMomentumTransfer;
var ShockBall ShockBallEffect;
var() int ComboAmmoCost;
var class<DamageType> ComboDamageType;
var class<DamageType> ComboDamageType2;

delegate OnDie(Actor Cam);

simulated function Explode(vector HitLocation, vector HitNormal)
{
	OnDie(self);
	Super.Explode(HitLocation, HitNormal);
}


event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    if (DamageType == ComboDamageType || DamageType == ComboDamageType2)
    {
        Instigator = EventInstigator;
        SuperExplosion();
        if( EventInstigator.Weapon != None )
        {
			EventInstigator.Weapon.ConsumeAmmo(0, ComboAmmoCost, true);
            Instigator = EventInstigator;
        }
    }
}

function SuperExplosion()
{
	local vector HitLocation, HitNormal;

	HurtRadius(ComboDamage, ComboRadius, class'DamTypeShockCombo', ComboMomentumTransfer, Location );

	Spawn(class'ShockCombo');
	if ( (Level.NetMode != NM_DedicatedServer) && EffectIsRelevant(Location,false) )
	{
		HitActor = Trace(HitLocation, HitNormal,Location - Vect(0,0,120), Location,false);
		if ( HitActor != None )
			Spawn(class'ComboDecal',self,,HitLocation, rotator(vect(0,0,-1)));
	}
	PlaySound(ComboSound, SLOT_None,1.0,,800);
    Destroy();
}



simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight;
	if (level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
		if (Trail != None)
			Trail.SetBase (self);
	}
}

defaultproperties
{
     ComboSound=Sound'WeaponSounds.ShockRifle.ShockComboFire'
     ComboDamage=200.000000
     ComboRadius=275.000000
     ComboMomentumTransfer=150000.000000
     ComboAmmoCost=10
     ComboDamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
     ComboDamageType2=Class'BallisticProV55.DTRX22ABurned'
     ImpactManager=Class'BWBP_SKC_Pro.IM_EMPRocket'
     AccelSpeed=600.000000
     TrailClass=Class'BWBP_SKC_Pro.Supercharger_PhotonTrail'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_BFGCharge'
     bTearOnExplode=False
     bCanHitOwner=False
     MotionBlurRadius=100.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=600.000000
     MaxSpeed=700.000000
     bSwitchToZeroCollision=True
     Damage=50.000000
     DamageRadius=400.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_BFGCharge'
     LightHue=180
     LightSaturation=100
     LightBrightness=160.000000
     LightRadius=8.000000
     StaticMesh=StaticMesh'BWBP4-Hardware.DarkStar.DarkProjBig'
     bNetTemporary=False
     bSkipActorPropertyReplication=True
     bOnlyDirtyReplication=True
     AmbientSound=Sound'WeaponSounds.ShockRifleProjectile'
     LifeSpan=16.000000
     Skins(0)=FinalBlend'BWBP_SKC_Tex.LS14.EMPProjFB'
     Skins(1)=FinalBlend'BWBP_SKC_Tex.LS14.EMPProjFB'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bProjTarget=True
     RotationRate=(Roll=1638)
}
