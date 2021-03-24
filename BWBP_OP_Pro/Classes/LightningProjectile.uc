//=============================================================================
// Slow moving energy projectile
//
// To do: Slow vehicles.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LightningProjectile extends BallisticProjectile;

var Pawn ComboTarget;       // for AI use

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
     local LightningConductor LConductor;

	if (class<DT_LightningRifle>(DamageType) == None)
		return;

     //Initiates Lightning Conduction actor
	LConductor = Spawn(class'LightningConductor',Instigator,,Location);

	if (LConductor != None)
	{
		LConductor.Instigator = Instigator;
		LConductor.Damage = 120;
		LConductor.ChargePower = 2;
        LConductor.bIsCombo = true;

		LConductor.Initialize(self);
	}

     Damage = 1;

	Explode(Location, Normal(Velocity));
}

function Monitor(Pawn P)
{
    ComboTarget = P;

    if ( ComboTarget != None )
        GotoState('WaitForCombo');
}

State WaitForCombo
{
    function Tick(float DeltaTime)
    {
        if ( (ComboTarget == None) || ComboTarget.bDeleteMe
            || (Instigator == None) || (ShockRifle(Instigator.Weapon) == None) )
        {
            GotoState('');
            return;
        }

        if ( (VSize(ComboTarget.Location - Location) <= 0.5 * 768 + ComboTarget.CollisionRadius)
            || ((Velocity Dot (ComboTarget.Location - Location)) <= 0) )
        {
            LightningRifle(Instigator.Weapon).DoCombo();
            GotoState('');
            return;
        }
    }
}

defaultproperties
{
     ModeIndex=1
     ImpactManager=Class'BWBP_OP_Pro.IM_LightningArcProj'
     AccelSpeed=-100.000000
     MyRadiusDamageType=Class'BWBP_OP_Pro.DT_LightningProjectile'
     bTearOnExplode=True
     MotionBlurRadius=300.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=750.000000
     MaxSpeed=1500.000000
     bSwitchToZeroCollision=True
     Damage=20.000000
     DamageRadius=1.000000
     MyDamageType=Class'BWBP_OP_Pro.DT_LightningProjectile'
     bDynamicLight=True
     LightType=LT_Steady
     LightHue=150
     LightSaturation=0
     LightBrightness=225.000000
     LightRadius=12.000000
     StaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleSphere3'
     Skins(0)=FinalBlend'PickupSkins.Shaders.FinalHealthCore'
     DrawScale=0.300000
     bNetTemporary=False
     AmbientSound=Sound'WeaponSounds.ShockRifleProjectile'
     LifeSpan=7.500000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bCollideActors=True
     bCollideWorld=True
     bProjTarget=True
}