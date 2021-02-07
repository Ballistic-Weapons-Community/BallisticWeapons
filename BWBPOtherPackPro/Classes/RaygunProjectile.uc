class RaygunProjectile extends BallisticProjectile;

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
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 1, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 1, Instigator);
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

function DoDamage (Actor Other, vector HitLocation)
{
	local RaygunPlagueEffect RPE;
	
	super.DoDamage (Other, HitLocation);
	if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
	{
		foreach Other.BasedActors(class'RaygunPlagueEffect', RPE)
		{
			RPE.ExtendDuration(0.5);
			break;
		}
	}
}

defaultproperties
{
     ImpactManager=Class'BWBPOtherPackPro.IM_Raygun'
     AccelSpeed=80000.000000
     TrailClass=Class'BWBPOtherPackPro.RaygunShotTrail'
     MyRadiusDamageType=Class'BWBPOtherPackPro.DTRaygun'
     bUsePositionalDamage=True
     
     MaxDamageGainFactor=0.5
     DamageGainStartTime=0.05
     DamageGainEndTime=0.2
     
     DamageTypeHead=Class'BWBPOtherPackPro.DTRaygun'
     Speed=4500.000000
     MaxSpeed=10000.000000
     Damage=38.000000
     MomentumTransfer=4500.000000
     MyDamageType=Class'BWBPOtherPackPro.DTRaygun'
     ExploWallOut=12.000000
     LightType=LT_Steady
     LightHue=30
     LightSaturation=24
     LightBrightness=64.000000
     LightRadius=24.000000
     bDynamicLight=True
     LifeSpan=1.000000
     Skins(0)=FinalBlend'BW_Core_WeaponTex.GunFire.A73ProjFinal'
     Skins(1)=FinalBlend'BW_Core_WeaponTex.GunFire.A73Proj2Final'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=128.000000
}
