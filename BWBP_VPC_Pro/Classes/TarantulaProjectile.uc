//-----------------------------------------------------------
//Rocket projectile for Tarantula Pack
//-----------------------------------------------------------
class TarantulaProjectile extends Projectile;

#exec OBJ LOAD FILE=..\Sounds\VMVehicleSounds-S.uax

var Emitter SmokeTrailEffect;
var Effects Corona;

simulated function Destroyed()
{
	if ( SmokeTrailEffect != None )
		SmokeTrailEffect.Kill();
	if ( Corona != None )
		Corona.Destroy();
	Super.Destroyed();
}

simulated function PostBeginPlay()
{
	if (Level.NetMode != NM_DedicatedServer)
	{
		SmokeTrailEffect = Spawn(class'TarantulaRocketTrail',self);
		Corona = Spawn(class'RocketCorona',self);
		Corona.SetDrawScale(4.5 * Corona.default.DrawScale);
	}

	Velocity = vector(Rotation) * Speed;

	if (PhysicsVolume.bWaterVolume)
		Velocity = 0.6 * Velocity;

	Super.PostBeginPlay();
}

simulated function Landed( vector HitNormal )
{
	Explode(Location,HitNormal);
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
	if ( (Other != instigator) && (!Other.IsA('Projectile') || Other.bProjTarget) )
	{
		Explode(HitLocation, vect(0,0,1));
	}
}

function BlowUp(vector HitLocation)
{
	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local PlayerController PC;

	PlaySound(SoundGroup'BW_Core_WeaponSound.Explosions.Explode-Small',,1.5);

    if ( EffectIsRelevant(Location,false) )
    {
    	Spawn(class'IE_NRP57Explosion',,,HitLocation + HitNormal*20,rotator(HitNormal));
//    	Spawn(class'NewExplosionA',,,HitLocation + HitNormal*20,rotator(HitNormal));
    	PC = Level.GetLocalPlayerController();
		if ( (PC.ViewTarget != None) && VSize(PC.ViewTarget.Location - Location) < 5000 )
	        Spawn(class'ExplosionCrap',,, HitLocation + HitNormal*20, rotator(HitNormal));
    }

	BlowUp(HitLocation);
	Destroy();
}

defaultproperties
{
     Speed=2500.000000
     MaxSpeed=2500.000000
     Damage=120.000000
     DamageRadius=250.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'XWeapons.DamTypeRocket'
     ExplosionDecal=Class'Onslaught.ONSRocketScorch'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.RocketProj'
     AmbientSound=Sound'VMVehicleSounds-S.HoverTank.IncomingShell'
     LifeSpan=8.000000
     DrawScale3D=(Y=0.400000,Z=0.400000)
     AmbientGlow=32
     FluidSurfaceShootStrengthMod=10.000000
     SoundVolume=255
     bFixedRotationDir=True
     RotationRate=(Roll=50000)
     DesiredRotation=(Roll=900000)
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
