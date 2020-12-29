//=============================================================================
// Hyper plasma ball.
//
// EXTREMELY PAINFUL
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk66Projectile extends BallisticProjectile;

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
     ImpactManager=Class'BWBPRecolorsPro.IM_HVPCMk66Projectile'
     TrailClass=Class'BWBPRecolorsPro.HVPCMk66BFGTrail'
     MyRadiusDamageType=Class'BWBPRecolorsPro.DT_BFGCharge'
     MotionBlurRadius=512.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=3000.000000
     MaxSpeed=3000.000000
     bSwitchToZeroCollision=True
     Damage=500.000000
     DamageRadius=1280.000000
     MomentumTransfer=100000.000000
     MyDamageType=Class'BWBPRecolorsPro.DT_BFGCharge'
     LightHue=110
     LightSaturation=20
     LightBrightness=160.000000
     LightRadius=12.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig'
     AmbientSound=Sound'IndoorAmbience.electricity1'
     LifeSpan=16.000000
     Skins(0)=FinalBlend'BWBP_SKC_Tex.BFG.BFGProj2FB'
     Skins(1)=FinalBlend'BWBP_SKC_Tex.BFG.BFGProjFB'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bProjTarget=True
     RotationRate=(Roll=1638)
}
