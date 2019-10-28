class RaygunProjectile extends BallisticProjectile;

simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	Super.GetDamageVictim(Other, HitLocation, Dir, Dmg, DT);
	
	Dmg *= 1 + 0.4 * FMin(default.LifeSpan - LifeSpan, 1);
	
	return Other;
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	if (bExploded)
		return;
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 2, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 2, Instigator);
	}
	BlowUp(HitLocation);
	bExploded=true;

	if (!bNetTemporary && bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
	{
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GoToState('NetTrapped');
	}
	
	else 
		Destroy();

}

defaultproperties
{
     ImpactManager=Class'BWBPOtherPackPro.IM_Raygun'
     AccelSpeed=35000.000000
     TrailClass=Class'BWBPOtherPackPro.RaygunShotTrail'
     MyRadiusDamageType=Class'BWBPOtherPackPro.DTRaygun'
     bUsePositionalDamage=True
     DamageHead=82.000000
     DamageLimb=41.000000
     DamageTypeHead=Class'BWBPOtherPackPro.DTRaygun'
     Speed=5000.000000
     MaxSpeed=8500.000000
     Damage=41.000000
     MomentumTransfer=4500.000000
     MyDamageType=Class'BWBPOtherPackPro.DTRaygun'
     ExploWallOut=12.000000
     LightType=LT_Steady
     LightHue=30
     LightSaturation=24
     LightBrightness=64.000000
     LightRadius=24.000000
     bDynamicLight=True
     LifeSpan=9.000000
     Skins(0)=FinalBlend'BallisticEffects.GunFire.A73ProjFinal'
     Skins(1)=FinalBlend'BallisticEffects.GunFire.A73Proj2Final'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=128.000000
}
