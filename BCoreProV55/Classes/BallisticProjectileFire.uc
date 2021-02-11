//=============================================================================
// BallisticProjectileFire.
//
// Fire class for projectiles.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticProjectileFire extends BallisticFire;

var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

// Mode info - Azarael
// Added here to simplify the process a bit as well as for BWStats support
struct ProjFireModeInfo
{
	var class<Projectile> mProjClass;
	var float mFireRate;
	var float mFireChaos;
	var Sound mFireSound;
	var Name mFireAnim;
	var bool bLoopedAnim; // If true, ModeFireAnim is set to FireLoopAnim and FireAnim is cleared.
	var Name mFireEndAnim;
	var float mRecoil;
	var int mAmmoPerFire;
	var Name TargetState; // Name of the state to switch to.
	//AI info
	var bool bModeLead;
	var bool bModeInstantHit;
	Var bool bModeSplash;
	var bool bModeRecommendSplash;
	var float mBotRefireRate;
	var float mWarnTargetPct;
};

//FireModes(0)=(mProjClass=,mFireRate=,mFireChaos=,mFireSound=,mFireAnim=,bLoopedAnim=False,mFireEndAnim=,mRecoil=,mAmmoPerFire=,TargetState='',bModeLead=,bModeInstantHit=,bModeSplash=,bModeRecommendSplash=)

var array<ProjFireModeInfo> FireModes;

simulated function InitializeFromParams(FireParams params)
{
    local ProjectileEffectParams effect_params;

    super.InitializeFromParams(params);

    effect_params = ProjectileEffectParams(params.FireEffectParams[0]);

    ProjectileClass =  effect_params.ProjectileClass;
    SpawnOffset = effect_params.SpawnOffset;
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
	Super.DoFireEffect();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (Proj != None)
		Proj.Instigator = Instigator;
}

function StartBerserk()
{
	if (FireModes.Length == 0 || BW.CurrentWeaponMode == 0)
	{
		FireRate = default.FireRate * 0.75;
		FireAnimRate = default.FireAnimRate/0.75;
		FireRecoil = default.FireRecoil * 0.75;
		FireChaos = default.FireChaos * 0.75;
	}
	else
	{
		FireRate = FireModes[BW.CurrentWeaponMode-1].mFireRate * 0.75;
		FireAnimRate = default.FireAnimRate/0.75;
		FireRecoil = FireModes[BW.CurrentWeaponMode-1].mRecoil * 0.75;
		FireChaos = FireModes[BW.CurrentWeaponMode-1].mFireChaos * 0.75;
	}
}

function StopBerserk()
{
	if (FireModes.Length == 0 || BW.CurrentWeaponMode == 0)
	{
		FireRate = default.FireRate;
		FireAnimRate = default.FireAnimRate;
		FireRecoil = default.FireRecoil;
		FireChaos = default.FireChaos;
	}
	else
	{
		FireRate = FireModes[BW.CurrentWeaponMode-1].mFireRate;
		FireAnimRate = default.FireAnimRate;
		FireRecoil = FireModes[BW.CurrentWeaponMode-1].mRecoil;
		FireChaos = FireModes[BW.CurrentWeaponMode-1].mFireChaos;
	}
}

// Set firemode-specific props on mode switch if requested
simulated function SwitchWeaponMode (byte NewMode)
{
	if (FireModes.Length > 0)
	{
		if (NewMode == 0)
		{
			ProjectileClass = 					default.ProjectileClass;
			FireRate 		= 					default.FireRate;
			FireChaos 		=					default.FireChaos;
			BallisticFireSound.Sound = 	default.BallisticFireSound.Sound;
			FireLoopAnim 	= 					default.FireLoopAnim;
			FireAnim 		= 					default.FireAnim;
			FireEndAnim = 					default.FireEndAnim;
			FireRecoil = 					default.FireRecoil;
			AmmoPerFire = 					default.AmmoPerFire;
			GoToState('');
			
			//AI info
			bLeadTarget = 					default.bLeadTarget;
			bInstantHit = 						default.bInstantHit;
			bSplashDamage = 				default.bSplashDamage;
			bRecommendSplashDamage = default.bRecommendSplashDamage;
		}
		
		else
		{
			NewMode--;
			
			ProjectileClass = FireModes[NewMode].mProjClass;
			FireRate = FireModes[NewMode].mFireRate;
			FireChaos = FireModes[NewMode].mFireChaos;
			BallisticFireSound.Sound = FireModes[NewMode].mFireSound;
			if (FireModes[NewMode].bLoopedAnim)
			{
				FireLoopAnim = FireModes[NewMode].mFireAnim;
				FireAnim = '';
			}
			else
			{
				FireLoopAnim = '';
				FireAnim = FireModes[NewMode].mFireAnim;
			}

			FireEndAnim = FireModes[NewMode].mFireEndAnim;
			FireRecoil = FireModes[NewMode].mRecoil;
			AmmoPerFire = FireModes[NewMode].mAmmoPerFire;
			if (FireModes[NewMode].TargetState == '')
				GoToState('');
			else GoToState(FireModes[NewMode].TargetState);
			
			//AI info
			bLeadTarget = FireModes[NewMode].bModeLead;
			bInstantHit = FireModes[NewMode].bModeInstantHit;
			bSplashDamage = FireModes[NewMode].bModeSplash;
			bRecommendSplashDamage = FireModes[NewMode].bModeRecommendSplash;
			
			NewMode++;
		}
		
		if (Weapon.bBerserk)
		{
			FireRate *= 0.75;
			FireRecoil *= 0.75;
			FireChaos *= 0.75;
		}
		
		if ( Level.GRI.WeaponBerserk > 1.0 )
			FireRate /= Level.GRI.WeaponBerserk;

		Load=AmmoPerFire;
	}
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;

    local class<BallisticProjectile> BProjClass;

    BProjClass = class<BallisticProjectile>(default.ProjectileClass);

	FS.DamageInt = BProjClass.default.Damage;
	FS.Damage = String(FS.DamageInt);

    if (BProjClass.default.DamageGainEndTime > 0)
        FS.Damage @= "-" @ String(Int(FS.DamageInt * (1f + BProjClass.default.MaxDamageGainFactor)));

    FS.HeadMult = class<BallisticProjectile>(default.ProjectileClass).default.HeadMult;
    FS.LimbMult = class<BallisticProjectile>(default.ProjectileClass).default.LimbMult;

	FS.DPS = default.ProjectileClass.default.Damage / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/default.ProjectileClass.default.Damage) - 1);
	if (default.FireRate < 0.5)
		FS.RPM = String(int((1 / default.FireRate) * 60))@default.ShotTypeString$"/min";
	else FS.RPM = 1/default.FireRate@"times/second";
	FS.RPShot = default.FireRecoil;
	FS.RPS = default.FireRecoil / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	FS.RangeOpt = "Maximum:"@(10000 / 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
    ShotTypeString="shots"
    bLeadTarget=True
    bInstantHit=False
    WarnTargetPct=0.500000
}
