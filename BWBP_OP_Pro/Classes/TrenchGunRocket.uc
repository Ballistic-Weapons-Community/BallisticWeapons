//=============================================================================
// TrenchGunRocket.
//
// FRAG-12 explosive charge
//
// by Sergeant Kelly and edited by Azarael
//=============================================================================
class TrenchGunRocket extends BallisticGrenade;

var float                   ArmingDelay;

var sound 					ImpactSounds[6];
var int						ImpactKickForce;
var vector					StartLoc;

replication
{
	reliable if (Role == ROLE_Authority)
		StartLoc;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Role == ROLE_Authority)
		StartLoc = Location;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if (VSize(StartLoc - Location) < (default.Speed * 0.10))
		SetTimer(0.10 - (VSize(StartLoc-Location) / default.Speed), False);
	else bBounce = False;
}

simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	DetonateOn = DT_Impact;
	SetPhysics(PHYS_Falling);
}

simulated function Landed (vector HitNormal)
{
	Explode(Location, HitNormal);
}	

simulated function HitWall( vector HitNormal, Actor Wall )
{
    local Vector VNorm;

	if (DetonateOn == DT_Impact)
	{
		Explode(Location, HitNormal);
		return;
	}
    
    bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

    Speed = VSize(Velocity/2);

	RandSpin(100000);

	if (Speed < 20)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc, 1.5);
		if (ImpactManager != None)
			ImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Owner);
    }
}

defaultproperties
{
	 DampenFactor=0.15000
     DampenFactorParallel=0.300000
     ArmingDelay=0.10
     DetonateOn=DT_None
	 PlayerImpactType=PIT_Detonate
     ImpactSounds(0)=Sound'XEffects.Impact4Snd'
     ImpactSounds(1)=Sound'XEffects.Impact6Snd'
     ImpactSounds(2)=Sound'XEffects.Impact7Snd'
     ImpactSounds(3)=Sound'XEffects.Impact3'
     ImpactSounds(4)=Sound'XEffects.Impact1'
     ImpactSounds(5)=Sound'XEffects.Impact2'

     ImpactDamage=125
     ImpactDamageType=Class'BWBP_SKC_Pro.DT_BulldogImpact'
     ImpactManager=Class'BWBP_SKC_Pro.IM_BulldogFRAG'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BallisticProV55.HAMRShellTrail'


     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=7000.000000
     MaxSpeed=7000.000000
     Damage=110.000000
	 DamageRadius=180.000000
     WallPenetrationForce=192
     MomentumTransfer=60000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DTBulldogFRAG'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTBulldogFRAGRadius'

     StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj'

     AmbientSound=Sound'BW_Core_WeaponSound.G5.G5-RocketFly'
     SoundVolume=192
     SoundRadius=128.000000

     DrawScale=0.300000

     bIgnoreTerminalVelocity=True

}
