//-----------------------------------------------------------
//Bomb projectile for Albatross
//-----------------------------------------------------------
class AlbatrossBomb extends Projectile;

simulated function PostBeginPlay()
{
//	Velocity = vector(Rotation) * Speed;

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

simulated Event Tick(float DT)
{
	local rotator R;
	local vector V;

	V = Vector (rotation);

	if (v.z == -1)
		return;

	v.z = fMax(-1, v.z - DT);

	R = rotator (V);
	R.Roll = rotation.roll;
	setrotation(R);
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
     MaxSpeed=2500.000000
     Damage=180.000000
     DamageRadius=400.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'XWeapons.DamTypeRocket'
     ExplosionDecal=Class'Onslaught.ONSRocketScorch'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5Rocket'
     Physics=PHYS_Falling
     LifeSpan=20.000000
     DrawScale=2.000000
     AmbientGlow=32
     FluidSurfaceShootStrengthMod=10.000000
     SoundVolume=255
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
     DesiredRotation=(Roll=900000)
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
