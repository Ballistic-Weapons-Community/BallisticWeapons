class MX32Rocket extends BallisticProjectile;

var float           FlightSpeed;
var float           ArmingDelay;
var bool            bArmed;

var Sound           IgniteSound;

simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
    Acceleration = vect(0,0,0);
	
	SetTimer(ArmingDelay, false);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if ( Level.bDropDetail || Level.DetailMode == DM_Low )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else
	{
		PC = Level.GetLocalPlayerController();
		if ( (PC == None) || (Instigator == None) || (PC != Instigator.Controller) )
		{
			bDynamicLight = false;
			LightType = LT_None;
		}
	}

    if (Emitter(Trail) != None)
        class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale * 0.35);
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	if (Level.NetMode != NM_DedicatedServer)
	{
		if (TrailClass != None && Trail == None)
		{
			GetAxes(Rotation,X,Y,Z);
			Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
			if (Emitter(Trail) != None)
            {
                if (bArmed)
				    class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
                else 
                    class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale * 0.35);

            }
			if (Trail != None)
				Trail.SetBase (self);
		}
	}
}

simulated function Timer()
{
	SetCollision(true,true);

	InitProjectile();

    PlaySound(IgniteSound, SLOT_Misc, 255, true, 512);
	
	Velocity = vector(Rotation) * FlightSpeed;
    Acceleration = Normal(Velocity) * AccelSpeed;
    SoundVolume = 128;

    bArmed = true;

    if (Emitter(Trail) != None)
        class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
}

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.MX32Weapon'
    ModeIndex=1
    IgniteSound=sound'CicadaSnds.MissileIgnite'
    ArmingDelay=0.2
    ImpactManager=Class'BallisticProV55.IM_MRLRocket'
    bRandomStartRotation=False
    TrailClass=Class'BallisticProV55.MRLTrailEmitter'
    TrailOffset=(X=-4.000000)
    MyRadiusDamageType=Class'BWBP_OP_Pro.DT_MX32RocketRadius'
    SplashManager=Class'BallisticProV55.IM_ProjWater'
    Speed=500.000000
    AccelSpeed=10000.000000
    FlightSpeed=20000.000000
    MaxSpeed=30000.000000
    Damage=32.000000
    DamageRadius=150.000000
    MyDamageType=Class'BWBP_OP_Pro.DT_MX32Rocket'
    StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
    AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
    SoundVolume=32
    bCollideActors=True
    bFixedRotationDir=True
    RotationRate=(Roll=32768)
}
