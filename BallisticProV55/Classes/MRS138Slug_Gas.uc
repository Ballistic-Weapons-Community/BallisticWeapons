//=============================================================================
// MRS138Slug_Gas.
//
// 10 gauge frag round
//
// by Sarge, based on code by RS
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138Slug_Gas extends BallisticGrenade;

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local MRS138CloudControl C;
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if ( Role == ROLE_Authority )
	{
		C = Spawn(class'MRS138CloudControl',self,,HitLocation-HitNormal*2);
		if (C!=None)
		{
			C.Instigator = Instigator;
		}
	}
	Destroy();
}


defaultproperties
{
	bAlignToVelocity=true
	bNoInitialSpin=true
	DampenFactor=1
	DampenFactorParallel=1
	bBounce=false
	
	ArmingDelay=0.03
	UnarmedDetonateOn=DT_Disarm
	UnarmedPlayerImpactType=PIT_Bounce
	ArmedDetonateOn=DT_Impact
	ArmedPlayerImpactType=PIT_Detonate

	ImpactDamage=50
	
	WeaponClass=class'BallisticProV55.MRS138Shotgun'
	ImpactManager=Class'BallisticProV55.IM_TearGasProj'
	ReflectImpactManager=Class'BallisticProV55.IM_BigBullet'
	AccelSpeed=50000.000000
	TrailClass=Class'BallisticProV55.TraceEmitter_M763Gas'
	ImpactDamageType=Class'BallisticProV55.DTMRS138GasImpact'
	MyRadiusDamageType=Class'BallisticProV55.DTMRS138ShotgunFragRadius'
	MotionBlurRadius=130.000000
	Speed=6000.000000
	MaxSpeed=8000.000000
	Damage=50.000000
	DamageRadius=180.000000
	MomentumTransfer=30000.000000
	MyDamageType=Class'BallisticProV55.DTMRS138ShotgunFrag'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
	DrawScale=1.000000
}
