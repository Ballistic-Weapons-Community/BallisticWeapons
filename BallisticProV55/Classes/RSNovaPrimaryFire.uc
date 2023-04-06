//=============================================================================
// RSNovaPrimaryFire.
//
// Multi mode novastaff fire.
// Big projectiles		:
// Small projectiles	:
// Lightning			:
// Big One shot zap		:
// Chain Lightning		:
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaPrimaryFire extends BallisticProProjectileFire;

#exec OBJ LOAD FILE=BW_Core_WeaponSound.uax

var   Actor					MuzzleFlashFast;
var   Actor					MuzzleFlashSlow;
var   Actor					LightMuzzleFlash;

var() sound					ChnLtngSoundLoop;
var() sound					FireSoundLoop;
var() sound					FireSound2;
var   bool					bIsZapping;
var() int					Damage;

var 	float				ModePowerDrain;

var   bool					bPendingOwnerZap;
var   float					PendingZapDamage;

var   RSNovaStaff			NovaStaff;

var   bool					bChainZapping;

struct ChainVic
{
	var float	ZapTime;
	var actor	ZapVic;
};
var   array<ChainVic>	ChainVics;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	NovaStaff = RSNovaStaff(Weapon);
}

//hacky fix for nova's multi firemodes that utilise damage in main weapon
simulated function ApplyFireEffectParams(FireEffectParams params)
{
	local ProjectileEffectParams effect_params;

    super.ApplyFireEffectParams(params);

	effect_params = ProjectileEffectParams(params);

	Damage = effect_params.Damage;
	default.Damage = effect_params.Damage;
}

simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	if (BW.bScopeView || BW.CurrentWeaponMode != 4)
		return super.GetFireSpread();
	else
	{
		fX = frand();
		R.Yaw =  1024 * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
		R.Pitch = 1024 * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
		return Vector(R);
	}
}

// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire())
        return;
    if (bIsJammed)
    {
    	if (BW.FireCount == 0)
    	{
    		bIsJammed=false;
			if (bJamWastesAmmo && Weapon.Role == ROLE_Authority)
			{
				ConsumedLoad += Load;
				Timer();
			}
	   		if (UnjamMethod == UJM_FireNextRound)
	   		{
		        NextFireTime += FireRate;
   			    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
				BW.FireCount++;
    			return;
    		}
    		if (!AllowFire())
    			return;
    	}
    	else
    	{
	        NextFireTime += FireRate;
   		    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		return;
   		}
    }

	if (BW != None)
	{
		BW.bPreventReload=true;
		BW.FireCount++;

		if (BW.ReloadState != RS_None)
		{
			if (weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}

    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

	ConsumedLoad += Load;
	SetTimer(FMin(0.1, FireRate/2), false);
    // server
    if (Weapon.Role == ROLE_Authority)
    {
//		Weapon.ConsumeAmmo(ThisModeNum, Load);
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
//        Instigator.SpawnTime = -100000;
        Instigator.DeactivateSpawnProtection();
    if(InStr(Level.Game.GameName, "Freon") != -1 && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
		class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
    }
		
	if (!BW.bScopeView)
		BW.AddFireChaos(FireChaos);
    	
	BW.LastFireTime = Level.TimeSeconds;


    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
    {
        ServerPlayFiring();
    }

    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease)
    {
        if (bIsFiring)
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
    }
    else if (bBurstMode)
    {
    	if (BurstCount > MaxBurst)
    	{
    		NextFireTime += FireRate * 1.7;
    		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		Weapon.StopFire(ThisModeNum);
    		BurstCount = 0;
    	}
    	else
    	{
    		NextFireTime += FireRate * 0.8;
  			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
  		}
    }
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	if (BW != None)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
		if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
			BW.bNeedCock=true;
	}
}


function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if (MuzzleFlashFast == None || MuzzleFlashFast.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashFast, class'RSNovaFastMuzzleFlash', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if (MuzzleFlashSlow == None || MuzzleFlashSlow.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashSlow, class'RSNovaSlowMuzzleFlash', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	MuzzleFlash = MuzzleFlashSlow;
}

// Remove effects
simulated function DestroyEffects()
{
	Super(WeaponFire).DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlashFast);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashSlow);
	class'BUtil'.static.KillEmitterEffect (LightMuzzleFlash);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	RSNovaAttachment(Weapon.ThirdPersonActor).NovaUpdateHit(BW.CurrentWeaponMode);
}

simulated function SwitchWeaponMode (byte NewMode)
{
	Super.SwitchWeaponMode(NewMode);
	
	switch(NewMode)
	{
		case 0:
			MuzzleFlash = MuzzleFlashSlow;
			ModePowerDrain=0;
			break;
		case 1:
			MuzzleFlash = MuzzleFlashFast;
			ModePowerDrain=0;
			break;
		case 2:
			MuzzleFlash = LightMuzzleFlash;
			ModePowerDrain=0.04;
			break;
		case 3:
			MuzzleFlash = MuzzleFlashSlow;
			ModePowerDrain=0.5;
			break;
		case 4:
			MuzzleFlash = LightMuzzleFlash;
			ModePowerDrain=0.1;
			break;
	}
	
	if (RSNovaStaff(BW).bOnRampage)
		ModePowerDrain *= 0.4;
}

event Timer()
{
	super.Timer();
	if (bIsZapping && (!IsFiring() || Weapon.GetFireMode(1).IsFiring() || !IsInState('NovaLightning')))
		StopLightning();
	if (bChainZapping && (!IsFiring() || Weapon.GetFireMode(1).IsFiring() || !IsInState('ChainLightning')))
		StopChainLightning();
}

function StopLightning()
{
	NovaStaff.KillZap();
	bIsZapping=false;
	if (LightMuzzleFlash != None)
	{	Emitter(LightMuzzleFlash).Kill();	LightMuzzleFlash = None;	}
	Instigator.AmbientSound = BW.UsedAmbientSound;
	Instigator.SoundVolume = Weapon.default.SoundVolume;
}

function StopChainLightning()
{
	NovaStaff.KillChainZaps();
	bChainZapping=false;

	ChainVics.length = 0;
	if (LightMuzzleFlash != None)
	{	Emitter(LightMuzzleFlash).Kill();	LightMuzzleFlash = None;	}
	Instigator.AmbientSound = BW.UsedAmbientSound;
	Instigator.SoundVolume = Weapon.default.SoundVolume;
}

// ========================================================================
// Lightning State
// ========================================================================
state NovaLightning
{
	function EndState()
	{
		if (bIsZapping)
			StopLightning();
	}

	function float MaxRange()
	{
		return 1000;
	}


	// ModeDoFire from WeaponFire.uc, but with a few changes
	simulated event ModeDoFire()
	{
	if (!AllowFire())
	        return;

		BW.FireCount++;

	    // server
    	if (Weapon.Role == ROLE_Authority)
	    {
			ConsumedLoad += Load;
			SetTimer(FMin(0.1, FireRate/2), false);
	        DoFireEffect();
    	    if ( (Instigator == None) || (Instigator.Controller == None) )
				return;
	        if ( AIController(Instigator.Controller) != None )
    	        AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        	Instigator.DeactivateSpawnProtection();
	    }

	    // client
    	if (Instigator.IsLocallyControlled())
	    {
    	    ShakeView();
        	PlayFiring();
	        FlashMuzzleFlash();
    	    StartMuzzleSmoke();
	    }
    	else // server
        	ServerPlayFiring();

		NextFireTime += FireRate;
		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

	    Load = AmmoPerFire;
    	HoldTime = 0;

	    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    	{
        	bIsFiring = false;
	        Weapon.PutDown();
    	}
	}

	function DoFireEffect()
	{
		local Actor Target, Victims;
		local float TargetAngle, DR, BHD;
		local vector ForceDir;

		local DestroyableObjective HealObjective;
		local Vehicle HealVehicle;
		local int AdjustedDamage;
		local bool bWasAlive;
		local RSBlackHole BH;

		bIsZapping=true;

		if (!bAISilent)
			Instigator.MakeNoise(1.0);
		ApplyRecoil();

		TargetAngle = 0.92;
		foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, 700, Instigator.Location )
		{
			if ( Victims != None && Victims != Instigator && Victims.Role == ROLE_Authority && !Victims.IsA('FluidSurfaceInfo') &&
				!Victims.bWorldGeometry && (Victims.bCanBeDamaged||RSDarkFlameProjectile(Victims)!=None) &&
				(!Victims.PhysicsVolume.bWaterVolume || (Pawn(Victims)!=None && !Pawn(Victims).HeadVolume.bWaterVolume)) )
			{
				DR = Normal(Victims.Location - Instigator.Location) Dot vector(Instigator.GetViewRotation());
				if (RSDarkProjectile(Victims)!=None || RSDarkFastProjectile(Victims)!=None)
				{
					if (DR > 0.9)
						Victims.TakeDamage(10, Instigator, Victims.Location, normal(Instigator.Location - Victims.Location)*1000, class'DT_RSNovaLightning');
				}
				else if (RSDarkFlameProjectile(Victims)!=None)
				{
					if (DR > 0.91)
					{
						BH = NovaStaff.DNControl.GetNearestBlackHole(Victims.Location, BHD);
						if (BHD <= 384 || BHD <= BH.CollisionRadius)
							BH.AddCharge(0.5);
						else
						{
							BH = spawn(class'RSBlackHole',,, Victims.Location);
							NovaStaff.DNControl.AddBlackHole(BH);
						}
						Victims.Destroy();
					}
				}
				else if (RSBlackHole(Victims)!=None)
				{
					RSBlackHole(Victims).AddCharge(0.2);
//					TargetAngle=1.0;
//					Target = None;
				}
				else if (DR > TargetAngle)
				{
					Target = Victims;
					TargetAngle = DR;
				}
			}
		}
		if (Target == None)
			NovaStaff.SetFreeZap();
		else
		{
			HealObjective = DestroyableObjective(Target);
			if ( HealObjective == None )
				HealObjective = DestroyableObjective(Target.Owner);
			if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
			{
				AdjustedDamage = Damage * Instigator.DamageScaling * 15;
				if (Instigator.HasUDamage())
					AdjustedDamage *= 2;
				HealObjective.HealDamage(AdjustedDamage, Instigator.Controller, class'DT_RSNovaLightning');
				NovaStaff.SetTargetZap(Target, true);
				return;
			}

			HealVehicle = Vehicle(Target);
			if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
			{
				AdjustedDamage = Damage * Instigator.DamageScaling * 15;
				if (Instigator.HasUDamage())
					AdjustedDamage *= 2;
				HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, class'DT_RSNovaLightning');
				NovaStaff.SetTargetZap(Target, true);
				return;
			}

			if (Pawn(Target) != None && Pawn(Target).bProjTarget && Instigator.Controller.SameTeamAs(Pawn(Target).Controller))
			{
				AdjustedDamage = Damage * Instigator.DamageScaling;
				if (Instigator.HasUDamage())
					AdjustedDamage *= 2;
				if (BallisticPawn(Target) != None)
					BallisticPawn(Target).GiveAttributedShield(2, Instigator);
				else Pawn(Target).AddShieldStrength(2);
				NovaStaff.SetTargetZap(Target, true);
				return;
			}

			if (xPawn(Target) != None && Pawn(Target).Health > 0)
			{
				if (Monster(Target) == None || Pawn(Target).default.Health > 275)
					bWasAlive = true;
			}
			else if (Vehicle(Target) != None && Vehicle(Target).Driver!=None && Vehicle(Target).Driver.Health > 0)
				bWasAlive = true;
			ForceDir = (Instigator.Location + vector(Instigator.GetViewRotation()) * 700) - Target.Location;
			class'BallisticDamageType'.static.GenericHurt (Target, Damage, Instigator, Target.Location + (Normal(Target.Location - Instigator.Location))*-24, 40000 * FMax(0.1, 1-(VSize(ForceDir)/2000)) * Normal(ForceDir), class'DT_RSNovaLightning');

			if (bWasAlive && Pawn(Target).Health <= 0)
				class'RSNovaSoul'.static.SpawnSoul(Target.Location, Instigator, Pawn(Target), Weapon);

			NovaStaff.SetTargetZap(Target, false);
			
			//Consumes soulpower or HP
			if (RSNovaStaff(Weapon).SoulPower >= ModePowerDrain)
				RSNovaStaff(Weapon).AddSoul(-ModePowerDrain);
			else
			{
				Instigator.PlaySound(Sound'BW_Core_WeaponSound.Dark-ImmolateIgnite',,3.7,,32);
				RSNovaStaff(Weapon).AddSoul(-5);
				class'BallisticDamageType'.static.GenericHurt (Instigator, 100 * (ModePowerDrain - RSNovaStaff(Weapon).SoulPower), Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 3000 + vect(0,0,1000), class'DT_RSNovaBacklash');
			}
		}
	}

	simulated function bool AllowFire()
	{
		if (!super.AllowFire() || Instigator.PhysicsVolume.bWaterVolume)
		{
			if (bIsZapping)
			{
				PlayFireEnd();
			}
			return false;
		}
		return true;
	}

	function ServerPlayFiring()
	{
		if (BW.FireCount < 2)
	    {
			if (BallisticFireSound.Sound != None)
				Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	    }
		if (FireSoundLoop != None)
		{
			Instigator.AmbientSound = FireSoundLoop;
			Instigator.SoundVolume = 255;
		}
	}

	function PlayFiring()
	{
		if (Instigator.PhysicsVolume.bWaterVolume)
		{
			StopLightning();
			super.PlayFireEnd();
	        if (Weapon.HasAnim(FireLoopAnim))
    	        BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
			NextFireTime+=2.0;
			return;
		}
	    if (FireCount < 1)
    	{
        	if (Weapon.HasAnim(FireLoopAnim))
            	BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
			if (BallisticFireSound.Sound != None)
				Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	    }
    	else if (FireCount == Max(1, level.TimeDilation * 5.0))
			Weapon.PlayOwnedSound(FireSound2,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	    ClientPlayForceFeedback(FireForce);  // jdf
    	FireCount++;

		if (level.NetMode == NM_Client)
		{
			bIsZapping=true;
		}

		if (LightMuzzleFlash == None || LightMuzzleFlash.bDeleteMe)
			class'BUtil'.static.InitMuzzleFlash (LightMuzzleFlash, class'RSNovaLightMuzzleFlash', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);

		if (FireSoundLoop != None)
		{
			Instigator.AmbientSound = FireSoundLoop;
			Instigator.SoundVolume = 255;
		}
	}

	function PlayFireEnd()
	{
		if (bIsZapping)
			super.PlayFireEnd();
		StopLightning();
	}

	function StopFiring()
	{
		super.StopFiring();
		StopLightning();
	}

	function FlashMuzzleFlash();
}

// ========================================================================
// Big Zap State
// ========================================================================
state Zap
{
	function OnTraceHit(Actor Other, vector HitLocation, vector Dir)
{
		local bool bWasAlive;

		if (xPawn(Other) != None && Pawn(Other).Health > 0)
		{
			if (Monster(xPawn(Other)) == None || Pawn(Other).default.Health > 275)
				bWasAlive = true;
		}
		else if (Vehicle(Other) != None && Vehicle(Other).Driver!=None && Vehicle(Other).Driver.Health > 0)
			bWasAlive = true;

		class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, HitLocation, 50000 * Dir, class'DT_RSNovaOneShotZap');

		if (bWasAlive && Pawn(Other).Health <= 0)
			class'RSNovaSoul'.static.SpawnSoul(Other.Location, Instigator, Pawn(Other), Weapon);
	}

	function DoFireEffect()
	{
    	local Vector StartTrace;
	    local Rotator Aim;

		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);

        if (Level.NetMode == NM_DedicatedServer)
            BW.RewindCollisions();

		DoTrace(StartTrace, Aim);

        if (Level.NetMode == NM_DedicatedServer)
            BW.RestoreCollisions();

		ApplyRecoil();
		
		//Consumes soulpower or HP
		if (RSNovaStaff(Weapon).SoulPower >= ModePowerDrain)
			RSNovaStaff(Weapon).AddSoul(-ModePowerDrain);
		else
		{
			Instigator.PlaySound(Sound'BW_Core_WeaponSound.Dark-ImmolateIgnite',,3.7,,32);
			RSNovaStaff(Weapon).AddSoul(-5);
			class'BallisticDamageType'.static.GenericHurt (Instigator, 100 * (ModePowerDrain - RSNovaStaff(Weapon).SoulPower), Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 3000 + vect(0,0,1000), class'DT_RSNovaBacklash');
		}
	}
	function float MaxRange()
	{
		return 7500;
	}
	function DoTrace (Vector InitialStart, Rotator Dir)
	{
		local Vector					End, X, HitLocation, HitNormal, Start, LastHitLoc;
		local Material					HitMaterial;
		local float						Dist;
		local Actor						Other, LastOther;
		local bool						bHitWall;

		// Work out the range
		Dist = MaxRange();

		Start = InitialStart;
		X = Normal(Vector(Dir));
		End = Start + X * Dist;
		LastHitLoc = End;
		Weapon.bTraceWater=true;

		while (Dist > 0)		// Loop traces in case we need to go through stuff
		{
			// Do the trace
			Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
			Weapon.bTraceWater=false;
			Dist -= VSize(HitLocation - Start);
			if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
				break;
			if (Other != None)
			{
				// Water
				if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
				{
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
					break;
				}
				LastHitLoc = HitLocation;
				// Got something interesting
				if (!Other.bWorldGeometry && Other != LastOther)
				{
					OnTraceHit(Other, HitLocation, X);
//					class'BallisticDamageType'.static.GenericHurt (Other, 100, Instigator, HitLocation, 50000 * X, class'DT_RSNovaOneShotZap');
//					LastOther = Other;

					if (Vehicle(Other) != None)
						bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
					else if (Mover(Other) == None)
					{
						bHitWall = true;
						SendFireEffect(Other, HitLocation, HitNormal, HitMaterial.SurfaceType);
						break;
					}
				}
				// Do impact effect
				if (Other.bWorldGeometry || Mover(Other) != None)
				{
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
					break;
				}
/*				// Still in the same guy
				if (Other == Instigator || Other == LastOther)
				{
					Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
					End = Start + X * Dist;
					Weapon.bTraceWater=true;
					continue;
				}
*/				break;
			}
			else
			{
				LastHitLoc = End;
				break;
			}
		}
		// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
		if (!bHitWall)
			NoHitEffect(X, InitialStart, LastHitLoc);
	}

	// Tells the attachment to play fire anims and so on, but without impact effects
	function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
	{
		if (Weapon != None && level.NetMode != NM_Client)
		{
			if (HitLocation != vect(0,0,0) && HitLocation != WaterHitLoc)
				SendFireEffect(none, HitLocation, vect(0,0,0), 0, WaterHitLoc);
			else
				SendFireEffect(none, Start + Dir * MaxRange(), vect(0,0,0), 0, WaterHitLoc);
		}
	}

	// Does something to make the effects appear
	simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
	{
		local int Surf;

		if (!Other.bWorldGeometry && Mover(Other) == None && Vehicle(Other) == None || level.NetMode == NM_Client)
			return false;

		if (Vehicle(Other) != None)
			Surf = 3;
		else if (HitMat == None)
			Surf = int(Other.SurfaceType);
		else
			Surf = int(HitMat.SurfaceType);

		// Tell the attachment to spawn effects and so on
		SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
		if (!bAISilent)
			Instigator.MakeNoise(1.0);
		return true;
	}
	simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
	{
		RSNovaAttachment(Weapon.ThirdPersonActor).BigZapUpdateHit(Other, HitLocation, HitNormal, Surf);
	}
}

// ========================================================================
// Chain Lightning State
// ========================================================================
state ChainLightning
{
	function float MaxRange()
	{
		return 1200;
	}

	simulated event ModeDoFire()
	{
		if (!AllowFire())
	        return;

		BW.FireCount++;

	    // server
    	if (Weapon.Role == ROLE_Authority)
	    {
			ConsumedLoad += Load;
			SetTimer(FMin(0.1, FireRate/2), false);
	        DoFireEffect();
    	    if ( (Instigator == None) || (Instigator.Controller == None) )
				return;
	        if ( AIController(Instigator.Controller) != None )
    	        AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        	Instigator.DeactivateSpawnProtection();
	    }

	    // client
    	if (Instigator.IsLocallyControlled())
	    {
    	    ShakeView();
        	PlayFiring();
	        FlashMuzzleFlash();
    	    StartMuzzleSmoke();
	    }
    	else // server
        	ServerPlayFiring();

		NextFireTime += FireRate;
		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);

	    Load = AmmoPerFire;
    	HoldTime = 0;

	    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    	{
        	bIsFiring = false;
	        Weapon.PutDown();
    	}
	}

	function DoFireEffect()
	{
		local Actor Target, Victims;
		local float TargetWeight, Weight;
		local vector ForceDir;

		local bool bWasAlive;

		local int i, j;
		local vector PrevLoc;

		bChainZapping=true;

		Instigator.MakeNoise(1.0);

		ApplyRecoil();

		PrevLoc = Instigator.Location;
		for (i=0;i<ChainVics.length;i++)
		{
			if (ChainVics[i].ZapVic == None || !Weapon.FastTrace(ChainVics[i].ZapVic.Location, PrevLoc))
			{
				ChainVics.Remove(i,1);
				i--;
				continue;
			}
			PrevLoc = ChainVics[i].ZapVic.Location;
			ChainVics[i].ZapTime += 0.1;
		}
		if (ChainVics.length > 0)
		{
			i = ChainVics.length - 1;
			if (ChainVics[i].ZapTime >= 0.5)
			{
				TargetWeight = 10000;
				foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, 1600, ChainVics[i].ZapVic.Location )
				{
					if ( Victims != None && Victims != Instigator && Victims.Role == ROLE_Authority && !Victims.IsA('FluidSurfaceInfo') &&
						!Victims.bWorldGeometry && Victims.bProjTarget && !Victims.bStatic && Projectile(Victims)==None &&
						(!Victims.PhysicsVolume.bWaterVolume || (Pawn(Victims)!=None && !Pawn(Victims).HeadVolume.bWaterVolume)) )
					{
						for (j=0;j<ChainVics.length;j++)
							if (ChainVics[j].ZapVic == Victims)
								break;
						if (j >= ChainVics.length)
						{
							Weight = VSize(Victims.Location - ChainVics[i].ZapVic.Location);
							if (Weight < TargetWeight)
							{
								Target = Victims;
								TargetWeight = Weight;
							}
						}
					}
				}
				if (Target != None)
				{
					ChainVics.Length = i+2;
					i++;
					ChainVics[i].ZapVic = Target;
					ChainVics[i].ZapTime = 0;
				}
			}
		}
		else
		{
			TargetWeight = 0.85;
			foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, 1000, Instigator.Location )
			{
				if ( Victims != None && Victims != Instigator && Victims.Role == ROLE_Authority && !Victims.IsA('FluidSurfaceInfo') &&
					!Victims.bWorldGeometry && Victims.bProjTarget && !Victims.bStatic && Projectile(Victims)==None &&
					(!Victims.PhysicsVolume.bWaterVolume || (Pawn(Victims)!=None && !Pawn(Victims).HeadVolume.bWaterVolume)) )
				{
					Weight = Normal(Victims.Location - Instigator.Location) Dot vector(Instigator.GetViewRotation());
					if (Weight > TargetWeight)
					{
						Target = Victims;
						TargetWeight = Weight;
					}
				}
			}
			if (Target != None)
			{
				ChainVics.Length = 1;
				ChainVics[0].ZapVic = Target;
				ChainVics[0].ZapTime = 0;
			}
		}

		if (ChainVics.length < 1)
			NovaStaff.SetFreeChainZap();
		else
		{
			for (i=0;i<ChainVics.length;i++)
			{
				if (ChainVics[i].ZapVic == None)
					continue;

				if (xPawn(ChainVics[i].ZapVic) != None && Pawn(ChainVics[i].ZapVic).Health > 0)
					bWasAlive = true;
				else if (Vehicle(ChainVics[i].ZapVic) != None && Vehicle(ChainVics[i].ZapVic).Driver!=None && Vehicle(ChainVics[i].ZapVic).Driver.Health > 0)
					bWasAlive = true;
				else
					bWasAlive = false;

				ForceDir = (Instigator.Location + vector(Instigator.GetViewRotation()) * 700) - ChainVics[i].ZapVic.Location;
				class'BallisticDamageType'.static.GenericHurt (ChainVics[i].ZapVic, Damage*2, Instigator, ChainVics[i].ZapVic.Location + (Normal(ChainVics[i].ZapVic.Location - Instigator.Location))*-24, 40000 * FMax(0.1, 1-(VSize(ForceDir)/2000)) * Normal(ForceDir), class'DT_RSNovaChainLightning');

				if (bWasAlive && Pawn(ChainVics[i].ZapVic).Health <= 0)
					class'RSNovaSoul'.static.SpawnSoul(ChainVics[i].ZapVic.Location, Instigator, Pawn(ChainVics[i].ZapVic), Weapon);
			}
			NovaStaff.SetChainZap();
			
			//Consumes soulpower or HP
			if (RSNovaStaff(Weapon).SoulPower >= ModePowerDrain)
				RSNovaStaff(Weapon).AddSoul(-ModePowerDrain);
			else
			{
				Instigator.PlaySound(Sound'BW_Core_WeaponSound.Dark-ImmolateIgnite',,3.7,,32);
				RSNovaStaff(Weapon).AddSoul(-5);
				class'BallisticDamageType'.static.GenericHurt (Instigator, 100 * (ModePowerDrain - RSNovaStaff(Weapon).SoulPower), Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 3000 + vect(0,0,1000), class'DT_RSNovaBacklash');
			}
		}
	}

	simulated function bool AllowFire()
	{
		if (!super.AllowFire() || Instigator.PhysicsVolume.bWaterVolume)
		{
			if (bChainZapping)
				PlayFireEnd();
			return false;
		}
		return true;
	}

	function ServerPlayFiring()
	{
		if (BW.FireCount < 2)
	    {
			if (BallisticFireSound.Sound != None)
				Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	    }
		if (ChnLtngSoundLoop != None)
		{
			Instigator.AmbientSound = ChnLtngSoundLoop;
			Instigator.SoundVolume = 255;
		}
	}

	function PlayFiring()
	{
		if (Instigator.PhysicsVolume.bWaterVolume)
		{
			StopChainLightning();
			super.PlayFireEnd();
	        if (Weapon.HasAnim(FireLoopAnim))
    	        BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
			NextFireTime+=2.0;
			return;
		}
	    if (FireCount < 1)
    	{
        	if (Weapon.HasAnim(FireLoopAnim))
            	BW.SafeLoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
			if (BallisticFireSound.Sound != None)
				Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	    }
    	else if (FireCount == Max(1, level.TimeDilation * 5.0))
			Weapon.PlayOwnedSound(FireSound2,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	    ClientPlayForceFeedback(FireForce);  // jdf
    	FireCount++;

		if (level.NetMode == NM_Client)
			bChainZapping=true;

		if (LightMuzzleFlash == None || LightMuzzleFlash.bDeleteMe)
			class'BUtil'.static.InitMuzzleFlash (LightMuzzleFlash, class'RSNovaLightMuzzleFlash', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);

		if (ChnLtngSoundLoop != None)
		{
			Instigator.AmbientSound = ChnLtngSoundLoop;
			Instigator.SoundVolume = 255;
		}
	}

	function PlayFireEnd()
	{
		if (bChainZapping)
			super.PlayFireEnd();
		StopChainLightning();
	}

	function StopFiring()
	{
		super.StopFiring();
		StopChainLightning();
	}

	function FlashMuzzleFlash();
}

defaultproperties
{
     ChnLtngSoundLoop=Sound'BW_Core_WeaponSound.NovaStaff.Nova-ChainLightning'
     FireSoundLoop=Sound'BW_Core_WeaponSound.NovaStaff.Nova-AltFireLoop'
     Damage=2
     SpawnOffset=(X=12.000000,Y=8.000000,Z=-9.000000)
	 MuzzleFlashClass=Class'BallisticProV55.RSNovaSlowMuzzleFlash'
     FireRecoil=1024.000000
     FireChaos=0.250000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=1.350000
     AmmoClass=Class'BallisticProV55.Ammo_NovaCrystal'
     AmmoPerFire=3
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.RSNovaProjectile'
     WarnTargetPct=0.200000
}
