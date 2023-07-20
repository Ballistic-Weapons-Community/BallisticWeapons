class AkeronRocketHE extends BallisticProjectile;

var sound ImpactSounds[6];

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
		if ( !Level.bDropDetail && (FRand() < 0.4) )
		Playsound(ImpactSounds[Rand(6)]);
		bBounce=False;
		Velocity = 0.75 * (Velocity - 1.25*HitNormal*(Velocity dot HitNormal));
		return;
   	}
   	
   	Explode(Location, -vector(Rotation));
}

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.AkeronLauncher'
	ImpactSounds(0)=Sound'XEffects.Impact4Snd'
	ImpactSounds(1)=Sound'XEffects.Impact6Snd'
	ImpactSounds(2)=Sound'XEffects.Impact7Snd'
	ImpactSounds(3)=Sound'XEffects.Impact3'
	ImpactSounds(4)=Sound'XEffects.Impact1'
	ImpactSounds(5)=Sound'XEffects.Impact2'
	ImpactManager=Class'BWBP_OP_Pro.IM_AkeronHE'
	bRandomStartRotation=False
	AccelSpeed=100000.000000
	TrailClass=Class'BWBP_OP_Pro.AkeronRocketTrail'
	TrailOffset=(X=-4.000000)
	MyRadiusDamageType=Class'BWBP_OP_Pro.DTAkeron'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	Speed=4000.000000
	MaxSpeed=35000.000000
	Damage=90.000000
	DamageRadius=300.000000
	MomentumTransfer=70000.000000
	MyDamageType=Class'BWBP_OP_Pro.DTAkeron'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_Grenade'
	AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
	DrawScale=0.750000
	SoundVolume=64
	bBounce=False
	bFixedRotationDir=True
	RotationRate=(Roll=32768)
}
