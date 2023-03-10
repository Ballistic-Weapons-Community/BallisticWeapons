//=============================================================================
// Slow moving energy projectile
//
// To do: Slow vehicles.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_EMPTorpedo extends BallisticProjectile;

delegate OnDie(Actor Cam);

simulated function Explode(vector HitLocation, vector HitNormal)
{
	OnDie(self);
	Super.Explode(HitLocation, HitNormal);
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
    WeaponClass=Class'BWBP_SKC_Pro.Supercharger_AssaultWeapon'
     ImpactManager=Class'BWBP_SKC_Pro.IM_EMPRocketLarge'
     AccelSpeed=1200.000000
     TrailClass=Class'Onslaught.ONSBluePlasmaFireEffect'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_BFGCharge'
     bTearOnExplode=False
     MotionBlurRadius=300.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=3600.000000
     MaxSpeed=1000000.000000
     bSwitchToZeroCollision=True
     Damage=70.000000
     DamageRadius=240.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_BFGCharge'
     LightHue=180
     LightSaturation=100
     LightBrightness=160.000000
     LightRadius=8.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig'
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
