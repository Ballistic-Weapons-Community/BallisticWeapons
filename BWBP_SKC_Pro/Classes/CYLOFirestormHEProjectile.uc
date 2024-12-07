//=============================================================================
// SK410HEProjectile.
//
// An explosive slug
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOFirestormHEProjectile extends BallisticGrenade;

function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	
	if (Victim == None)
	{
		DamageAmount *= 0.5;
		DamageRadius *= 0.75;
	}
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			if (!FastTrace(Victims.Location, Location))
				continue;
					
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/ DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * 0.6 * dir),
				DamageType
			);
		 }
	}
	bHurtEntry = false;
}

defaultproperties
{
	PawnDampAdjust=0.01
    WeaponClass=Class'BWBP_SKC_Pro.CYLOUAW'
	ArmedDetonateOn=DT_Impact
	bNoInitialSpin=True
	bAlignToVelocity=True
	DetonateDelay=0.150000
	ImpactDamage=80
	ImpactDamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormHESlug'
	ImpactManager=Class'BWBP_SKC_Pro.IM_SlugHE'
	AccelSpeed=3000.000000
	TrailClass=Class'BWBP_SKC_Pro.SK410FireTrail'
	TrailOffset=(X=-8.000000)
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormHESlug'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=512.000000
	MotionBlurRadius=128.000000
	Speed=8000.000000
	MaxSpeed=15000.000000
	Damage=50.000000
	DamageRadius=192.000000
	MomentumTransfer=50000.000000
	MyDamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormHESlug'
	LightHue=180
	LightSaturation=100
	LightBrightness=160.000000
	LightRadius=8.000000
	StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj'
	LifeSpan=16.000000
	DrawScale=2.000000
	ModeIndex=1
}
