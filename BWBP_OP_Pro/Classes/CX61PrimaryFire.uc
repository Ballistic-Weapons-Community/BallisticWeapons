//=============================================================================
// CX61 primary fire. Automatic.
//=============================================================================
class CX61PrimaryFire extends BallisticProInstantFire;


var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

simulated state Flechette
{
	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ProjectileEffectParams effect_params;

		super(BallisticFire).ApplyFireEffectParams(params);

		effect_params = ProjectileEffectParams(params);

		ProjectileClass =  effect_params.ProjectileClass;
		SpawnOffset = effect_params.SpawnOffset;    
		default.ProjectileClass =  effect_params.ProjectileClass;
		default.SpawnOffset = effect_params.SpawnOffset;
	}

	// Became complicated when acceleration came into the picture
	// Override for even weirder situations
	function float MaxRange()
	{
		if (ProjectileClass.default.MaxSpeed > ProjectileClass.default.Speed)
		{
			// We know BW projectiles have AccelSpeed
			if (class<BallisticProjectile>(ProjectileClass) != None && class<BallisticProjectile>(ProjectileClass).default.AccelSpeed > 0)
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * 2) * 2);
				else
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * ProjectileClass.default.LifeSpan) * ProjectileClass.default.LifeSpan);
			}
			// For the rest, just use the max speed
			else
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return ProjectileClass.default.MaxSpeed * 2;
				else
					return ProjectileClass.default.MaxSpeed * ProjectileClass.default.LifeSpan*0.75;
			}
		}
		else // Hopefully this proj doesn't change speed.
		{
			if (ProjectileClass.default.LifeSpan <= 0)
				return ProjectileClass.default.Speed * 2;
			else
				return ProjectileClass.default.Speed * ProjectileClass.default.LifeSpan;
		}
	}

	// Get aim then spawn projectile
	function DoFireEffect()
	{
		local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
		local Rotator Aim;
		local actor Other;

	    Weapon.GetViewAxes(X,Y,Z);
    	// the to-hit trace always starts right in front of the eye
	    Start = Instigator.Location + Instigator.EyePosition();

	    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    	if ( !Weapon.WeaponCentered() )
		    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);

		End = Start + (Vector(Aim)*MaxRange());
		Other = Trace (HitLocation, HitNormal, End, Start, true);

		if (Other != None)
			Aim = Rotator(HitLocation-StartTrace);
	    SpawnProjectile(StartTrace, Aim);

		SendFireEffect(none, vect(0,0,0), StartTrace, 0);
		// Skip the instant fire version which would cause instant trace damage.
		Super(BallisticFire).DoFireEffect();
	}

	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		Proj = Spawn (ProjectileClass,,, Start, Dir);
		Proj.Instigator = Instigator;
	}
}

defaultproperties
{
	 ProjectileClass="BWBP_OP_Pro.CX61Flechette"
     SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
     TraceRange=(Min=9000.000000,Max=9000.000000)
     DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
     DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
     DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
     PenetrateForce=180
     bPenetrate=True
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashScaleFactor=0.700000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassBone="tip"
     BrassOffset=(X=-80.000000,Y=1.000000)
     AimedFireAnim="SightFire"
     FireRecoil=128.000000
     FireChaos=0.030000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-Fire',Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireAnim="SightFire"
     FireEndAnim=
     FireAnimRate=1.200000
     FireRate=0.115000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_CX61Rounds'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
