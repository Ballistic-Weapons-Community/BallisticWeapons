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

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	if (Other == Instigator && (!bCanHitOwner))
		return;
	
	if (Other == HitActor)
		return;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );
				
	if (Role == ROLE_Authority)		// Do damage for direct hits, but only once to the same actor
		DoDamage(Other, HitLocation);
	HitActor = Other;
	Explode(HitLocation, Normal(HitLocation-Other.Location));
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

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, DmgRadiusScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	
	if (Pawn(Victim) == None)
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
			{
				if (!bCoverPenetrator)
					continue;
				else DmgRadiusScale = (DamageRadius - GetCoverReductionFor(Victims.Location)) / DamageRadius;
				
				if (DamageRadius * DmgRadiusScale < 16)
					continue;
			}
			else DmgRadiusScale = 1;
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			if (bCoverPenetrator && DmgRadiusScale < 1 && VSize(dir) > DamageRadius * DmgRadiusScale)
				continue;
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/ (DamageRadius * DmgRadiusScale));
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
     bCoverPenetrator=True
     Speed=7000.000000
     MaxSpeed=7000.000000
     Damage=140.000000
	 DamageRadius=512.000000
     MomentumTransfer=30000.000000
     MyDamageType=Class'BWBPRecolorsPro.DTBulldogFRAG'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.Bulldog.Frag12Proj'
     bDynamicLight=True
     AmbientSound=Sound'BallisticSounds2.G5.G5-RocketFly'
     DrawScale=2.500000
     SoundVolume=192
     SoundRadius=128.000000
     bBounce=True
     bFixedRotationDir=True
     bIgnoreTerminalVelocity=True
     RotationRate=(Roll=32768)
}
