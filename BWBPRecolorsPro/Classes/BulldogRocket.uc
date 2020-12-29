//=============================================================================
// BulldogRocket.
//
// FRAG-12 explosive charge
//
// by Sergeant Kelly and edited by Azarael
//=============================================================================
class BulldogRocket extends BallisticProjectile;

var sound 					ImpactSounds[6];
var int 					ImpactDamage;
var int						ImpactKickForce;
var class<DamageType> 		ImpactDamageType;
var class<BCImpactManager>	ReflectImpactManager;
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
	
	if (VSize(StartLoc - Location) < (default.Speed * 0.15))
		SetTimer(0.15 - (VSize(StartLoc-Location) / default.Speed), False);
	else bBounce = False;
}

simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	bBounce=False;
}

simulated function Landed (vector HitNormal)
{
	Explode(Location, HitNormal);
}	

simulated function HitWall( vector HitNormal, actor Wall )
{
    if ( !Wall.bStatic && !Wall.bWorldGeometry 
		&& ((Mover(Wall) == None) || Mover(Wall).bDamageTriggered) )
    {
        if ( Level.NetMode != NM_Client )
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
            Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
		}
        Destroy();
        return;
    }

	if(bBounce)
	{	
		if ( !Level.bDropDetail )
			PlaySound(ImpactSounds[Rand(6)]);
		bBounce=False;
		Velocity = 0.75 * (Velocity - 2.0*HitNormal*(Velocity dot HitNormal));
		return;
   	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc, 1.5);
		if (ReflectImpactManager != None)
		{
			if (Instigator == None)
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Instigator);			
		}
    }
   	
   	Explode(Location, HitNormal);
}

defaultproperties
{
     ImpactSounds(0)=Sound'XEffects.Impact4Snd'
     ImpactSounds(1)=Sound'XEffects.Impact6Snd'
     ImpactSounds(2)=Sound'XEffects.Impact7Snd'
     ImpactSounds(3)=Sound'XEffects.Impact3'
     ImpactSounds(4)=Sound'XEffects.Impact1'
     ImpactSounds(5)=Sound'XEffects.Impact2'
     ImpactDamage=80
     ImpactDamageType=Class'BWBPRecolorsPro.DT_BulldogImpact'
     ImpactManager=Class'BWBPRecolorsPro.IM_BulldogFRAG'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BallisticProV55.MRLTrailEmitter'
     TrailOffset=(X=-14.000000)
     MyRadiusDamageType=Class'BWBPRecolorsPro.DTBulldogFRAGRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=7000.000000
     MaxSpeed=7000.000000
     Damage=140.000000
	 DamageRadius=512.000000
     WallPenetrationForce=192
     MomentumTransfer=30000.000000
     MyDamageType=Class'BWBPRecolorsPro.DTBulldogFRAG'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     Physics=PHYS_Falling
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj'
     bDynamicLight=True
     AmbientSound=Sound'BW_Core_WeaponSound.G5.G5-RocketFly'
     DrawScale=2.500000
     SoundVolume=192
     SoundRadius=128.000000
     bBounce=True
     bFixedRotationDir=True
     bIgnoreTerminalVelocity=True
     RotationRate=(Roll=32768)
}
