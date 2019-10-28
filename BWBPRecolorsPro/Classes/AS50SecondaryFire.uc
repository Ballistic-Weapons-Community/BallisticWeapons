//=============================================================================
// AS50PrimaryFire.
//
// Ignites struck targets.
//=============================================================================
class AS50SecondaryFire extends BallisticProInstantFire;

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	BW.TargetedHurtRadius(5, 96, DamageType, 1, HitLocation,Pawn(Other));
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
    local int i;
	local AS50ActorFire Burner;
	
	super.DoDamage (Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount);
	if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
	{
		for (i=0;i<Other.Attached.length;i++)
		{
			if (AS50ActorFire(Other.Attached[i])!=None)
			{
				AS50ActorFire(Other.Attached[i]).AddFuel(2);
				break;
			}
		}
		if (i>=Other.Attached.length)
		{
			Burner = Spawn(class'AS50ActorFire',Other,,Other.Location + vect(0,0,-30));
			Burner.Initialize(Other);
			if (Instigator!=None)
			{
				Burner.Instigator = Instigator;
				Burner.InstigatorController = Instigator.Controller;
			}
		}
	}
}

defaultproperties
{
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WaterRangeFactor=0.800000
     Damage=30.000000
     DamageHead=60.000000
     DamageLimb=30.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DT_AS50Torso'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_AS50Head'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_AS50Limb'
     KickForce=6000
     PDamageFactor=0.000000
     WallPDamageFactor=0.850000
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     BrassClass=Class'BWBPRecolorsPro.Brass_BMGInc'
     BrassBone="breach"
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     RecoilPerShot=512.000000
     VelocityRecoil=255.000000
     FireChaos=1.000000
     BallisticFireSound=(Sound=SoundGroup'PackageSounds4Pro.AS50.AS50-Fire',Volume=5.100000,Slot=SLOT_Interact,bNoOverride=False)
     FireAnim="CFire"
     FireEndAnim=
     FireRate=0.280000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_50Inc'
     ShakeRotMag=(X=450.000000,Y=64.000000)
     ShakeRotRate=(X=12400.000000,Y=12400.000000,Z=12400.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-5.500000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.250000
     BotRefireRate=0.300000
     WarnTargetPct=0.050000
     aimerror=950.000000
}
