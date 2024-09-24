class A800MinigunPrimaryFire extends BallisticProProjectileFire;

var rotator OldLookDir, TurnVelocity;
var float	LastFireTime, MuzzleBTime, MuzzleCTime, OldFireRate;
var A800SkrithMinigun Minigun;

var float	LagTime;

var	int		ProjectileCount;

var bool	bStarted;

var float	NextTVUpdateTime;

//Do the spread on the client side
function PlayFiring()
{
	super.PlayFiring();

	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlaySound(Minigun.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}
}

function ServerPlayFiring()
{
	super.ServerPlayFiring();
	
	if (!bStarted)
	{
		bStarted = true;
		BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		BW.PlayOwnedSound(Minigun.BarrelStartSound, SLOT_None, 0.5, , 32, 1.0, true);
	}
}

function StopFiring()
{
	super.StopFiring();
	bStarted = false;
}

simulated event PostBeginPlay()
{
	OldLookDir = BW.GetPlayerAim();

	super.PostBeginPlay();
}

event ModeTick(float DT)
{
	local float DesiredFireRate;

	OldFireRate = FireRate;

	if (Minigun.BarrelSpeed <= 0)
		FireRate = 1.0;
	else
	{
		DesiredFireRate = (FMin(1.0 / (60 * (1 + 0.25*int(BW.bBerserk)) * Minigun.BarrelSpeed), 1));
		FireRate = DesiredFireRate;
	}
	NextFireTime += FireRate - OldFireRate;

	super.ModeTick(DT);
}

defaultproperties
{
     SpawnOffset=(X=1.000000,Y=5.000000,Z=-5.000000)
     MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
     FlashScaleFactor=0.100000
     FireRecoil=120.000000
     FirePushBackForce=15.000000
     XInaccuracy=16.000000
     YInaccuracy=16.000000
	 FireChaos=0.100000
	 FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Fire',Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     TweenTime=0.000000
     FireRate=0.175000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBP_SWC_Pro.A73NewProjectile'
     WarnTargetPct=0.200000
	 AimedFireAnim="SightFire"
	 FireLoopAnim="FireLoop"
	 FireEndAnim="FireEnd"
}
