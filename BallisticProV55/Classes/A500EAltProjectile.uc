//=============================================================================
// A500AltProjectile.
//
// Blob fired by A500.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500EAltProjectile extends BallisticGrenade;

var int BaseImpactDamage, BonusImpactDamage;
var float AcidLoad;

simulated function ApplyImpactEffect( actor Other, vector HitLocation )
{
	local int DirectDamage;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	DirectDamage = BaseImpactDamage + (BonusImpactDamage * AcidLoad);

	class'BallisticDamageType'.static.GenericHurt (Other, DirectDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
	ReduceHP(Other);
}

function ReduceHP (Actor Other)
{
	local A500HPReducer hpReducer;
	
	if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
	{
		hpReducer= A500HPReducer(Pawn(Other).FindInventoryType(class'A500HPReducer'));
	
		if (hpReducer == None)
		{
			Pawn(Other).CreateInventory("BallisticProV55.A500HPReducer");
			hpReducer = A500HPReducer(Pawn(Other).FindInventoryType(class'A500HPReducer'));
		}
	
		hpReducer.AddStack(12 * AcidLoad);
	}
}
simulated function BlowUp(vector HitLocation)
{
	local vector Start;

	Start = Location/* + 10 * HitNormal*/;
	TargetedHurtRadius(Damage, DamageRadius * AcidLoad, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local A500AcidControl F;
	local Teleporter TB;

	Super.Explode(HitLocation,HitNormal);

	if(Role == ROLE_Authority)
	{
		//No teleporter camping, die die die
		foreach RadiusActors(class'Teleporter', TB, 256)
		{
			if (Instigator != None)
				Level.Game.Broadcast(self, "A500 Acid Bomb fired by"@Instigator.PlayerReplicationInfo.PlayerName@"too close to a teleporter!");
			return;
		}
		F = Spawn(class'A500AcidControl',self,,HitLocation+HitNormal*4, rot(0,0,0));
		if (F!=None)
		{
			F.Instigator = Instigator;
			F.Initialize(HitNormal, AcidLoad);
		}
	}

	Destroy();
}

function AdjustSpeed()
{
	Velocity = Vector(Rotation) * ((default.Speed * 0.25) + (default.Speed * 0.75 * AcidLoad));
}

defaultproperties
{
    ArmedDetonateOn=DT_Impact
    ArmedPlayerImpactType=PIT_Detonate
    bNoInitialSpin=True
    bAlignToVelocity=True
    DetonateDelay=1.000000
    BaseImpactDamage=50
    BonusImpactDamage=100
    ImpactDamageType=Class'BallisticProV55.DTA500Impact'
    ImpactManager=Class'BallisticProV55.IM_A500EAcidExplode'
    TrailClass=Class'BallisticProV55.A500EProjectileTrail'
    TrailOffset=(X=-8.000000)
    MyRadiusDamageType=Class'BallisticProV55.DTA500Splash'
    SplashManager=Class'BallisticProV55.IM_ProjWater'
    ShakeRadius=0.000000
    MotionBlurRadius=384.000000
    MotionBlurFactor=3.000000
    MotionBlurTime=4.000000
    MyDamageType=Class'BallisticProV55.DTA500Splash'
    LightType=LT_Steady
    LightEffect=LE_QuadraticNonIncidence
    LightHue=54
    LightSaturation=100
    LightBrightness=150.000000
    LightRadius=8.000000
    bDynamicLight=True
    DrawScale=1.000000
	ModeIndex=1
}
