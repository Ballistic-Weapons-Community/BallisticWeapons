//=============================================================================
// NukeRocket.
//
// Massively powerful nuclear rocket. Will destroy anything in its path.
// Goes through walls and irradiates people in a HUGE radius.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class NukeRocketONS extends G5Rocket;
var int		explosions;
var int		RadiationRadius;

delegate OnDie(Actor Cam);

simulated function Explode(vector HitLocation, vector HitNormal)
{
	OnDie(self);

	Infect(HitLocation, HitNormal);
	Super.Explode(HitLocation, HitNormal);
	GotoState('Dying');
}

// Infect the crap out of players
function Infect(vector HitLocation, vector HitNormal)
{

}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	local Actor A;

	if (Role < ROLE_Authority)
		return;

	if (DamageRadius > 0)
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);

	foreach RadiusActors( class 'Actor', A, RadiationRadius, Location )
	{

		if (A.bCanBeDamaged)
		{
			class'BallisticDamageType'.static.Hurt(A, (1.0-(VSize(A.Location - Location)/RadiationRadius))*150.0, Instigator, A.Location, Normal(A.Location - Location)*500, class'DT_NukePiercingRadius');
		}
	}

	MakeNoise(1.0);
}


state Dying
{

    function BeginState()
    {
		bHidden = true;
		SetPhysics(PHYS_None);
		SetCollision(false,false,false);
		Spawn(class'IonCore',,, Location, Rotation);
    }

   
Begin:
    PlaySound(sound'WeaponSounds.redeemer_explosionsound');
    HurtRadius(Damage, DamageRadius*0.125, MyDamageType, MomentumTransfer, Location);
    Sleep(0.5);
    HurtRadius(Damage, DamageRadius*0.300, MyRadiusDamageType, 10000, Location);
    Sleep(0.2);
    HurtRadius(Damage, DamageRadius*0.475, MyRadiusDamageType, 10000, Location);
    Sleep(0.2);
    HurtRadius(Damage, DamageRadius*0.650, MyRadiusDamageType, 10000, Location);
    Sleep(1.2);
    HurtRadius(Damage, DamageRadius*0.825, MyRadiusDamageType, 10000, Location);
    Sleep(1.2);
    HurtRadius(Damage, DamageRadius*1.000, MyRadiusDamageType, 10000, Location);
    Sleep(1.5);
    HurtRadius(50, DamageRadius*0.475, MyDamageType, 400, Location);
    Sleep(2.5);
    HurtRadius(50, DamageRadius*0.475, MyDamageType, 400, Location);
    Sleep(2.5);
    HurtRadius(50, DamageRadius*0.475, MyDamageType, 400, Location);
    Sleep(2.5);
    HurtRadius(50, DamageRadius*0.475, MyDamageType, 400, Location);
    Sleep(2.5);
    HurtRadius(50, DamageRadius*0.475, MyDamageType, 400, Location);
    Sleep(3.5);
    HurtRadius(50, DamageRadius*0.475, MyDamageType, 400, Location);
    Sleep(3.5);
    HurtRadius(50, DamageRadius*0.475, MyDamageType, 400, Location);
    Sleep(3.5);

    Destroy();
}


defaultproperties
{
     ImpactManager=Class'BWBP_KFC_DE.IM_NUKE'
     AccelSpeed=50.000000
     MyRadiusDamageType=Class'BWBP_KFC_DE.DT_NukeRadius'
     MotionBlurRadius=15500.000000
     ShakeRadius=20000.000000
     MotionBlurFactor=6.000000
     MotionBlurTime=2.000000
     ShakeRotMag=(X=576.000000,Y=450.000000,Z=400.000000)
     ShakeRotRate=(X=7000.000000,Y=7000.000000,Z=5500.000000)
     ShakeRotTime=8.000000
     ShakeOffsetMag=(X=40.000000,Y=40.000000,Z=40.000000)
     ShakeOffsetRate=(X=650.000000,Y=650.000000,Z=650.000000)
     ShakeOffsetTime=10.000000
     LifeSpan=40.000000
     Speed=1800.000000
     MaxSpeed=4000.000000
     Damage=1500.000000
     DamageRadius=15500.000000
     RadiationRadius=20000.000000
     MomentumTransfer=400000.000000
     MyDamageType=Class'BWBP_KFC_DE.DT_Nuke'
}
