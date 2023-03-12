//=============================================================================
// Hyper plasma ball.
//
// EXTREMELY PAINFUL
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AY90BoltProjectileSuper extends BallisticProjectile;

var() float ZapDamage;
var() float ZapRadius; //Radius to do damaging zaps
var() float ZapInterval; //time between zaps
var bool bPrimed;

struct ZappedTarget
{
	var() Pawn	Vic;
	var() float	Zaps;
};
var array<ZappedTarget> OldTargets;

simulated function PreBeginPlay()
{
    local BallisticWeapon BW;
    Super(Projectile).PreBeginPlay();

    if (Instigator == None)
        return;

    BW = BallisticWeapon(Instigator.Weapon);

    if (BW == None)
        return;

    BW.default.ParamsClasses[BW.GameStyleIndex].static.OverrideProjectileParams(self, 2);
}


simulated function PostBeginPlay()
{
	SetTimer(0.10, false);
	super.PostBeginPlay();
}

/*
// Make the thing look like its pointing in the direction its going
simulated event Tick( float DT )
{

	local Actor Target;

	foreach VisibleCollidingActors( class 'Actor', Target, ZapRadius-70, Location )
	{

		if (Target.bCanBeDamaged && Target != self)
		{
			class'BallisticDamageType'.static.GenericHurt (Target, ZapDamage, Instigator, Target.Location, vect(0,0,0), class'DT_BFGExplode');
		}

	}

} */


simulated event Timer()
{
	local Actor Target;

	if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		SetPhysics(default.Physics);
		SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
		InitProjectile();
//		return;
	}
	
		foreach VisibleCollidingActors( class 'Actor', Target, ZapRadius-70, Location )
	{

		if (Target.bCanBeDamaged && Target != Instigator)
		{
			class'BallisticDamageType'.static.GenericHurt (Target, ZapDamage, Instigator, Target.Location, vect(0,0,0), class'DT_BFGExplode');
		}

	}
			SetTimer(ZapInterval, false);


/*
	local actor Victims, T;
	local vector Dir, ForceDir, HitLoc, HitNorm, AimDir, Start;
	local Rotator Aim;
	local array<actor>	Targets;
	local float Dist, AmmoFactor, TotalWallZaps, Dmg, TotalPlayerZaps, ZapFactor;
	local class<DamageType> DT;
	local int i;
	local array<int> Lures;
	local array<int> TargIndexes;
	local array<vector> Vecs;

	if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		SetPhysics(default.Physics);
		SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
		InitProjectile();
		SetTimer(0.10, false);
		return;
	}

		// Find all possible victims
		foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, ZapRadius, Location )
		{
			if ( Victims != Instigator && Victims.Role == ROLE_Authority && !Victims.IsA('FluidSurfaceInfo') && !Victims.bWorldGeometry && Victims.bProjTarget && !Victims.bStatic && Projectile(Victims)==None && /*Victims.bCanBeDamaged &&*/
				(!Victims.PhysicsVolume.bWaterVolume || (Pawn(Victims)!=None && !Pawn(Victims).HeadVolume.bWaterVolume)) )
			{
				Dir = Normal(Victims.Location - Location);
				if (Dir Dot AimDir > 0.75)
				{
					Targets[Targets.length] = Victims;
					if (Pawn(Victims) != None)
					{
						for (i=0;i<OldTargets.length;i++)
						{
							if (OldTargets[i].Vic == Victims)
							{
								Dist = VSize(Victims.Location - Location);

								TargIndexes[TargIndexes.length] = i;
								break;
							}
						}
						if (i>=OldTargets.length)
						{
							OldTargets.length = OldTargets.length + 1;
							OldTargets[OldTargets.length-1].Vic = Pawn(Victims);
							TargIndexes[TargIndexes.length] = OldTargets.length-1;
						}
					}
					else
					{
						TargIndexes[TargIndexes.length] = -1;
					}
				}
			}
		}

	// Zap up our victims
	for (i=0;i<Targets.length;i++)
	{
		Dmg = ZapDamage;
		if (TargIndexes[i] > -1)
		{
			Dist = VSize(Targets[i].Location - Location);
			Dmg *= 1/Targets.length;
		}

		Dir = Normal(Targets[i].Location - Location);
		if (Dir Dot AimDir > 0.75)
		{
			ForceDir = (Location + AimDir * (650+Rand(100))) - Targets[i].Location;

			DT = class'DT_BFGCharge';

			if (Instigator.Physics == PHYS_Falling)
				Instigator.Velocity -= Normal(Targets[i].Location - Instigator.Location) * 20 + VRand() * 15;
			else
				Instigator.Velocity -= Normal(Targets[i].Location - Instigator.Location) * 80 + VRand() * 60;

			class'BallisticDamageType'.static.GenericHurt (Targets[i], Dmg, Instigator, Targets[i].Location + Dir*-24, 40000 * FMax(0.1, 1-(VSize(ForceDir)/2000)) * Normal(ForceDir), DT);

			if (Targets[i].RemoteRole == ROLE_None)
			{
				Targets.Remove(i,1);
				TargIndexes.Remove(i,1);
				i--;
			}
		}
	}
			SetTimer(ZapInterval, false);

*/
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
     ImpactManager=Class'BWBP_SKCExp_Pro.IM_SkrithBFGProjectile'
     AccelSpeed=100.000000
	 MyDamageType=Class'BWBP_SKCExp_Pro.DTAY90Skrith'
	 DamageTypeHead=Class'BWBP_SKCExp_Pro.DTAY90SkrithHead'
     MyRadiusDamageType=Class'BWBP_SKCExp_Pro.DTAY90SkrithRadius'
     MotionBlurRadius=1024.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=8500.000000
     MaxSpeed=1000000.000000
     bSwitchToZeroCollision=True
     Damage=500.000000
     DamageRadius=832.000000
     ZapDamage=10.000000
     ZapInterval=0.1
     ZapRadius=512.000000
     MomentumTransfer=280000.000000
     LightHue=150
     LightSaturation=0
     LightBrightness=192.000000
     LightRadius=12.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig'
     AmbientSound=Sound'IndoorAmbience.electricity1'
     LifeSpan=16.000000
     Skins(1)=FinalBlend'BWBP_SKC_Tex.SkrithBow.AY90Projectile1-Final'
     Skins(0)=FinalBlend'BWBP_SKC_Tex.A73b.AY90ProjectileBig2-Final'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bProjTarget=True
	 Drawscale=10.000000
}
