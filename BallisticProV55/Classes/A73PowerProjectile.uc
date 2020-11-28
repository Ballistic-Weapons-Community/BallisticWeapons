//=============================================================================
// A73ProjectileBal.
//
// Bigger, slower projectile for da A73.
//
// Kaboodles
//=============================================================================
class A73PowerProjectile extends A73Projectile;

var() float FallSpeed;

simulated function Tick(float DT)
{
	local vector DS;

    if (bScaleDone)
        return;

	DS.X = (default.LifeSpan - LifeSpan) / 0.40;
    DS.Y = 0.20 + DS.X;
	DS.Z = DS.Y;
	if (DS.X >= 0.8)
	{
		DS.X = 0.8;
		bScaleDone=true;
		InitEffects();
	}
	SetDrawScale3D(DS);
}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;
	if (DamageRadius > 0)
		TargetedHurtRadius(Damage * (1 + 0.5 * FMin(default.LifeSpan - LifeSpan, 1)), DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	MakeNoise(1.0);
}

simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	Super(BallisticProjectile).GetDamageVictim(Other, HitLocation, Dir, Dmg, DT);
	
	Dmg *= 1 + 1.25 * FMin(default.LifeSpan - LifeSpan, 0.7) / 0.7;
	
	return Other;
}

simulated function InitProjectile ()
{
	InitEffects();
}
// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	
	DamageRadius = 100 + 75 * FMin((default.LifeSpan - LifeSpan)/3, 1);
	
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = FMax(1 - Sqrt(FMax(0,dist - Victims.CollisionRadius)/DamageRadius),0);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	bHurtEntry = false;
}

defaultproperties
{
     FallSpeed=300.000000
     ImpactManager=Class'BallisticProV55.IM_A73Lob'
     bPenetrate=False
     AccelSpeed=8000.000000
     TrailClass=Class'BallisticProV55.A73PowerTrailEmitter'
     MyRadiusDamageType=Class'BallisticProV55.DTA73SkrithPowerRadius'
     bUsePositionalDamage=False
     ShakeRadius=300.000000
     MotionBlurRadius=250.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=2.000000
     Speed=3000.000000
     MaxSpeed=7000.000000
     Damage=60.000000
     DamageRadius=100.000000
     MomentumTransfer=50000.000000
     MyDamageType=Class'BallisticProV55.DTA73SkrithPower'
     LightSaturation=128
     LightBrightness=225.000000
     LightRadius=18.000000
     StaticMesh=StaticMesh'BallisticHardware2.A42.A42Projectile'
     LifeSpan=9.000000
     Skins(0)=FinalBlend'BallisticEffects.GunFire.A73ProjFinal'
     Skins(1)=FinalBlend'BallisticEffects.GunFire.A73Proj2Final'
     SoundRadius=128.000000
     bFixedRotationDir=False
     bOrientToVelocity=True
}
