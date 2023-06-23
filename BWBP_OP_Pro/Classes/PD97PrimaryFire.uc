class PD97PrimaryFire extends BallisticProShotgunFire;

var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

simulated function PlayFiring()
{
	if (PD97Bloodhound(BW).bNeedRotate)
		PD97Bloodhound(BW).CycleDrum();
	
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'OpenIdle';
		BW.ReloadAnim = 'OpenReload';
		AimedFireAnim = 'OpenSightFire';
		FireAnim = 'OpenFire';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	
	Super.PlayFiring();
	
	PD97Bloodhound(BW).ShellFired();
}

simulated state Projectile
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
	// Override for even wierder situations
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
	// Azarael edit: Wall code
	function DoFireEffect()
	{
		local Vector Start, X, Y, Z, End, HitLocation, HitNormal, StartTrace;
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
		
		//wall check
		End = Start + (Vector(Aim) * SpawnOffset.X);
		Other = Weapon.Trace(HitLocation, HitNormal, End, Start, false);
		if (Other != None)
			StartTrace = HitLocation;
		//end wall check

		End = Start + (Vector(Aim)*MaxRange());
		Other = Trace (HitLocation, HitNormal, End, Start, true);

		if (Other != None)
			Aim = Rotator(HitLocation-StartTrace);
		SpawnProjectile(StartTrace, Aim);

		SendFireEffect(none, vect(0,0,0), StartTrace, 0);
		Super(BallisticFire).DoFireEffect();
	}
		
	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		Proj = Spawn (ProjectileClass,,, Start, Dir);
		if (Proj != None)
		{
			Proj.Instigator = Instigator;
			if (ProjectileClass == Class'BWBP_OP_Pro.PD97Dart')
				PD97Dart(Proj).Master = PD97Bloodhound(BW);
			if (ProjectileClass == Class'BWBP_OP_Pro.PD97Rocket')
			{
				PD97Rocket(Proj).Master = PD97Bloodhound(BW);
				PD97Rocket(Proj).LastLoc = PD97Bloodhound(BW).GetRocketTarget();
			}
		}
	}
}

defaultproperties
{
	//shot
	TraceCount=9
	TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
	ImpactManager=Class'BallisticProV55.IM_Shell'
	TraceRange=(Min=5000.000000,Max=5000.000000)
	Damage=4.000000
	 
	//proj
	SpawnOffset=(X=15.000000,Y=15.000000,Z=-20.000000)
	ProjectileClass=Class'BWBP_OP_Pro.PD97Dart'
	
	AimedFireAnim="SightFire"
	FireRecoil=256.000000
	FireChaos=0.150000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Radius=128,Volume=0.5)
	PreFireAnim=
	FireAnimRate=1.100000
	FireForce="AssaultRifleAltFire"
	FireRate=0.400000
	AmmoClass=Class'BWBP_OP_Pro.Ammo_BloodhoundDarts'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-70.000000)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.700000
	WarnTargetPct=0.300000
}
