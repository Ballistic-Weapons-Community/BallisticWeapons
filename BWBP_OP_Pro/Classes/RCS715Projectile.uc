//=============================================================================
// SK410HEProjectile.
//
// An explosive slug
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RCS715Projectile extends BallisticGrenade;

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

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local RCS715FireControl F;
	local Teleporter TB;

	if ( Role == ROLE_Authority )
	{
		//No teleporter camping, die die die
		foreach RadiusActors(class'Teleporter', TB, 256)
		{
			if (Instigator != None)
				Level.Game.Broadcast(self, "RCS Grenade thrown by"@Instigator.PlayerReplicationInfo.PlayerName@"too close to a teleporter!");
			return;
		}
		F = Spawn(class'RCS715FireControl',self,,HitLocation-HitNormal*2, rot(0,0,0));
		if (F!=None)
		{
			F.Instigator = Instigator;
			F.Initialize();
		}
	}
	Destroy();
}

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.RCS715Shotgun'
	ModeIndex=1
	ArmedDetonateOn=DT_Impact
	bNoInitialSpin=True
	bAlignToVelocity=True
	DetonateDelay=0.150000
	ImpactDamage=15.000000
	ImpactDamageType=Class'BWBP_OP_Pro.DT_RCS715Grenade'
	ImpactManager=Class'BallisticProV55.IM_Grenade'
	AccelSpeed=3000.000000
	TrailClass=Class'BWBP_OP_Pro.RCS715FireTrail'
	TrailOffset=(X=-8.000000)
	MyRadiusDamageType=Class'BWBP_OP_Pro.DT_RCS715Burned'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=512.000000
	MotionBlurRadius=128.000000
	Speed=4000.000000
	MaxSpeed=15000.000000
	Damage=50.000000
	DamageRadius=128.000000
	MomentumTransfer=0.000000
	MyDamageType=Class'BWBP_OP_Pro.DT_RCS715Grenade'
	LightHue=180
	LightSaturation=100
	LightBrightness=160.000000
	LightRadius=8.000000
	StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj'
	LifeSpan=16.000000
	DrawScale=2.000000
}
