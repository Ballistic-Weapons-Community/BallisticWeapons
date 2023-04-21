class CX85PrimaryFire extends BallisticProInstantFire;

var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

simulated state SeekerFlechette
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
		CX85Flechette(Proj).Master = CX85AssaultWeapon(BW);
	}
}

defaultproperties
{
	ProjectileClass="BWBP_OP_Pro.CX85Flechette"
	SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
	TraceRange=(Min=30000.000000,Max=30000.000000)
	DamageType=Class'BWBP_OP_Pro.DTCX85Bullet'
	DamageTypeHead=Class'BWBP_OP_Pro.DTCX85BulletHead'
	DamageTypeArm=Class'BWBP_OP_Pro.DTCX85Bullet'
	PenetrateForce=150
	bPenetrate=True
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
	bCockAfterEmpty=True
	MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
	FlashScaleFactor=0.800000
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	BrassBone="tip"
	BrassOffset=(X=-80.000000,Y=1.000000)
	FireRecoil=120.000000
	FireChaos=0.080000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,Pitch=1.500000,bNoOverride=False)
	bPawnRapidFireAnim=True
	FireEndAnim=
	FireRate=0.090000
	AmmoClass=Class'BWBP_OP_Pro.Ammo_CX61Rounds'

	ShakeRotMag=(X=64.000000)
	ShakeRotRate=(X=960.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-7.00)
	ShakeOffsetRate=(X=-100.000000)
	ShakeOffsetTime=2.000000

	WarnTargetPct=0.200000
	aimerror=900.000000
}
