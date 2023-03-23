//=============================================================================
// HVCMk9PrimaryFire.
//
// Will eventually bounce to hit multiple targets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9PrimaryFire extends BallisticProInstantFire;

var()	bool		bDoOverCharge;
var		Sound		FireSoundLoop;
var		bool		bPendingOwnerZap;
var		bool		bZapping, bSoundActive;
var		float		NextMessageTime;

var int 			SuccessiveHits;

//[2.5] default vars
var() sound			FireSound2;
var   bool			bIsZapping;
var   float			PendingZapDamage;

struct ZappedTarget
{
	var() Pawn	Vic;
	var() float	Zaps;
};
var array<ZappedTarget> OldTargets;

struct ZapLure
{
	var() vector Loc;
	var() float Zaps;
};
var array<ZapLure> OldLures;

// ====================================================== Pro Direct Fire Lightning ================================================
simulated state DirectFire
{
	simulated function bool AllowFire()
	{
		if (HVCMk9LightningGun(Weapon).HeatLevel >= 10 || HVCMk9LightningGun(Weapon).bIsVenting || !super.AllowFire())
		{
			if (Instigator.Role == ROLE_Authority && HvCMk9Attachment(Weapon.ThirdPersonActor).bStreamOn)
				HvCMk9Attachment(Weapon.ThirdPersonActor).EndStream();
			return false;
		}
		
		return true;
	}

	/*
	simulated function bool StreamAllowFire()
	{
		if (!CheckReloading())
			return false;		// Is weapon busy reloading

		if (BW.MagAmmo < AmmoPerFire)
		{
			BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

			BW.EmptyFire(ThisModeNum);
			return false;		// Is there ammo in weapon's mag
		}
		else if (BW.bNeedReload)
			return false;
		return true;
	}
	*/

	//===========================================================================
	// ApplyDamage
	//
	// Damage of stream ramps with successive hits
	//===========================================================================
	function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
	{
		class'BallisticDamageType'.static.GenericHurt (Victim, Min(Damage + SuccessiveHits * 5, 30), Instigator, HitLocation, MomentumDir, DamageType);
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
		
		if (HvCMk9Attachment(Weapon.ThirdPersonActor).StreamEffect == None)
			HvCMk9Attachment(Weapon.ThirdPersonActor).StartStream();

		ApplyRecoil();
	}

	//manages self damage
	event Timer()
	{	
		Super.Timer();
		if (bPendingOwnerZap)
		{
			bPendingOwnerZap=false;
			class'BallisticDamageType'.static.GenericHurt (Instigator, 50, Instigator, Instigator.Location + vector(Instigator.GetViewRotation()) * Instigator.CollisionRadius, KickForce * vector(Instigator.GetViewRotation()), class'DT_HVCOverheat');
		}
	}

	//if we aren't overheated, go to old trace - else blow shit up
	function DoTrace (Vector Start, Rotator Dir)
	{
		local actor Victims;
		local vector X;
		local float f;

		if (!bDoOverCharge)
		{
			OldDoTrace(Start, Dir);
			return;
		}
		
		X = vector(Dir);
		SendFireEffect(level, Start+X*64, -X, 0);
		
		foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, 192, Start + X * 64 )
			if(!Victims.IsA('FluidSurfaceInfo') && !Victims.bWorldGeometry && Victims.bCanBeDamaged)
			{
				if (Victims == Instigator)
				{
					bPendingOwnerZap = true;
					SetTimer(0.15, false);
				}
				else
					class'BallisticDamageType'.static.GenericHurt (Victims, 50, Instigator, Victims.Location - X * Victims.CollisionRadius, f * KickForce * X, class'DT_HVCOverheat');
			}
	}

	function OldDoTrace(Vector InitialStart, Rotator Dir)
	{
		local Vector					End, X, HitLocation, Start, HitNormal, LastHitLoc;
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
					SuccessiveHits = 0;
					break;
				}
				LastHitLoc = HitLocation;
				// Got something interesting
				if (!Other.bWorldGeometry && Other != LastOther)
				{
					OnTraceHit(Other, HitLocation, InitialStart, X, 0, 0, 0);
					
					SuccessiveHits++;

					if (Vehicle(Other) != None)
						bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
					else if (Mover(Other) == None)
					{
						bHitWall = true;
						if (HitMaterial != None)
							SendFireEffect(Other, HitLocation, HitNormal, HitMaterial.SurfaceType);
						else SendFireEffect(Other, HitLocation, HitNormal, 0);
						break;
					}
				}
				// Do impact effect
				if (Other.bWorldGeometry || Mover(Other) != None)
				{
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
					SuccessiveHits = 0;
					break;
				}
				
				SuccessiveHits = 0;
				break;
			}
			else
			{
				LastHitLoc = End;
				SuccessiveHits = 0;
				break;
			}
		}
		// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
		if (!bHitWall)
			NoHitEffect(X, InitialStart, LastHitLoc);
	}

	function PlayFiring()
	{
			if (!bSoundActive)
			{
				if (FireSoundLoop != None)
				Instigator.AmbientSound = FireSoundLoop;
				Instigator.SoundRadius=512;
				Instigator.SoundVolume = 255;
				bSoundActive = True;
			}
			
			if (Weapon.HasAnim(FireLoopAnim))
				BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
			ClientPlayForceFeedback(FireForce);  // jdf
			FireCount++;
			
			if(Level.NetMode == NM_Client)
			HvCMk9LightningGun(BW).AddHeat(0.3);
			
			if (Level.NetMode != NM_Client && !bDoOverCharge && HVCMk9LightningGun(Weapon).HeatLevel > 10)
			{
				bDoOverCharge = true;
				Weapon.PlaySound(HVCMk9LightningGun(Weapon).OverHeatSound,Slot_None,0.7,,64,1.0,true);
				HVCMk9LightningGun(Weapon).ClientOverCharge();
				Weapon.ServerStopFire(ThisModeNum);
			}

			CheckClipFinished();
	}

	function ServerPlayFiring()
	{
			if (!bSoundActive)
			{
				if (FireSoundLoop != None)
				Instigator.AmbientSound = FireSoundLoop;
				Instigator.SoundRadius=512;
				Instigator.SoundVolume = 255;
				bSoundActive = True;
			}
			
			if (Weapon.Role == Role_Authority && !bDoOverCharge && HVCMk9LightningGun(Weapon).HeatLevel > 10)
			{
				bDoOverCharge = true;
				Weapon.PlaySound(HVCMk9LightningGun(Weapon).OverHeatSound,Slot_None,0.7,,64,1.0,true);
				HVCMk9LightningGun(Weapon).ClientOverCharge();
				Weapon.ServerStopFire(ThisModeNum);
			}
			
			if (Weapon.HasAnim(FireLoopAnim))
				BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
			ClientPlayForceFeedback(FireForce);  // jdf
			FireCount++;

			CheckClipFinished();
	}

	function StopFiring()
	{
			Super.StopFiring();
			
			if (Instigator.Role == ROLE_Authority)
				HvCMk9Attachment(Weapon.ThirdPersonActor).EndStream();
			
			if (bDoOverCharge)
			{
				NextFireTime += 2.0;
				bDoOverCharge = false;
			}
			bZapping=False;
			bSoundActive = False;
			Instigator.AmbientSound = None;
			Instigator.SoundVolume = Weapon.default.SoundVolume;
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
			DoFireEffect();
			HVCMk9LightningGun(Weapon).AddHeat(0.15);
			if ( (Instigator == None) || (Instigator.Controller == None) )
				return;
			if ( AIController(Instigator.Controller) != None )
				AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
			Instigator.DeactivateSpawnProtection();
			if(BallisticTurret(Weapon.Owner) == None  && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
				class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, 1);
		}
		else if (!BW.bScopeView)
		{
			ApplyRecoil();
		}
		
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

	//    Weapon.IncrementFlashCount(ThisModeNum);

		// set the next firing time. must be careful here so client and server do not get out of sync
		if (bFireOnRelease)
		{
			if (bIsFiring)
				NextFireTime += MaxHoldTime + FireRate;
			else
				NextFireTime = Level.TimeSeconds + FireRate;
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
}

// ====================================================== V2.5 Branching Autoseeking Arcs ================================================
simulated state BranchingFire
{

	function float MaxRange()
	{
		return 1200;
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
	//		Weapon.ConsumeAmmo(ThisModeNum, Load);
			DoFireEffect();
			if ( (Instigator == None) || (Instigator.Controller == None) )
				return;
			if ( AIController(Instigator.Controller) != None )
				AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
	//        Instigator.SpawnTime = -100000;
			Instigator.DeactivateSpawnProtection();
		}
		//else
			//FireRecoil(); //Todo: find replacement function

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

	event Timer()
	{
		super.Timer();
		if (bIsZapping && !IsFiring())
			StopLightning();
		if (bPendingOwnerZap)
		{
			bPendingOwnerZap=false;
			class'BallisticDamageType'.static.GenericHurt (Instigator, PendingZapDamage, Instigator, Instigator.Location, vect(0,0,5000), class'DT_HVCFisher');
		}
	}

	simulated function vector GetFireSpread()
	{
		local float fX;
		local Rotator R;

		fX = frand();
		R.Yaw =   XInaccuracy * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
		R.Pitch = YInaccuracy * sin ((frand()*1.5-0.5) * 1.5707963267948966) * cos(fX*1.5707963267948966);

		return Vector(R);
	}

	function DoFireEffect()
	{
		local actor Victims, T;
		local vector Dir, ForceDir, HitLoc, HitNorm, AimDir, Start;
		local Rotator Aim;
		local array<actor>	Targets;
		local float Dist, AmmoFactor, TotalWallZaps, Dmg, TotalPlayerZaps, ZapFactor;
		local class<DamageType> DT;
		local int i;
		local array<int> Lures;
		local array<int> TargIndexes;
		local array<vector> Vecs;

		if (Instigator.PhysicsVolume.bWaterVolume)
		{
			NextFireTime+=2.0;
			AmmoFactor = FMin(1, float(Weapon.AmmoAmount(0))/100.0);
			HVCMk9LightningGun(Weapon).AddHeat(2.0);
			if (Weapon.AmmoAmount(0) > 5)
				HVCMk9Attachment(Weapon.ThirdPersonActor).DoWaterDischarge();
			ConsumedLoad = 100;
			ForEach Instigator.PhysicsVolume.TouchingActors(class'Actor', Victims)
			{
				if ( Victims.bCanBeDamaged && !Victims.bStatic )
				{
					Dir = Victims.location - Instigator.location;
					Dist = VSize(Dir);
					Dir = Normal(Dir);
					if (Dist <= 2000)
					{
						if (Victims == Instigator)
						{
							PendingZapDamage = AmmoFactor*250;
							bPendingOwnerZap = true;
							SetTimer(0.2, false);
						}
						else
							class'BallisticDamageType'.static.GenericHurt (Victims, AmmoFactor*250*FMax(0.04, 1-Dist/2000), Instigator, Victims.Location + Dir*-24, Dir * 20000, class'DT_HVCFisher');
					}
				}
			}
			if (!bPendingOwnerZap)
			{
				PendingZapDamage = AmmoFactor*250;
				bPendingOwnerZap = true;
				SetTimer(0.2, false);
			}
			return;
		}

		HVCMk9LightningGun(Weapon).AddHeat(0.15);
		bIsZapping=true;

		if (Instigator == None || Weapon == None || Instigator.Health < 1)
			return;

		// The idea is that lightning should lock onto stuff it hits more and ignore other stuff
		// Will not try attacking walls if its already got locked players
		// If it gets a wall lock, it begins to unlock players
		// If no player locks, fire traces to find walls
		// If we have 3 wall locks, don't even try getting new players
		// If we have any wall locks, decrease lock on players
		// Each time a wall is zapped, it becomes even more attractive
		// Red zap will place a reasonable lock on a player or wall

		// Search for valid wall locks
		// Search for valid player locks
		// If ok, search for more players

		// Damage dealt to players must be multiplied by (lock on player divided by amount of lock we have on the walls)
		// Actually zap any players we found
		// Add to zap count of wall hits
		// Add zap count on players. Scaled down by (lock on player divided by amount of lock we have on the walls))

		Start = Instigator.Location + Instigator.EyePosition();
		Aim = GetFireAim(Start);
		AimDir = Vector(Aim);

		// Find old wall hits
		for (i=0;i<OldLures.length;i++)
		{
			if (Weapon.FastTrace(OldLures[i].Loc, Instigator.Location) &&
				Normal(OldLures[i].Loc-Instigator.Location) Dot AimDir > 0.75)
			{
				Dist = VSize(OldLures[i].Loc - Instigator.Location);
				if (Dist < 900)
				{
	//				Lure += OldLures[i].Zaps * (VSize(OldLures[i].Loc - Instigator.Location) / 900);
					Lures[Lures.length] = i;
					TotalWallZaps += OldLures[i].Zaps * 2 * (1-Dist/900);
				}
			}
		}
		// Too many wall hits to try getting new targets. Just work on the old ones.
		if (Lures.length > 1)
		{
			for (i=0;i<OldTargets.length;i++)
			{
				if (OldTargets[i].Vic != None && OldTargets[i].Zaps > TotalWallZaps / 4 &&
					!OldTargets[i].Vic.HeadVolume.bWaterVolume &&
					Normal(OldTargets[i].Vic.Location - Instigator.Location) Dot AimDir > 0.75)
				{
					Dist = VSize(OldTargets[i].Vic.Location - Instigator.Location);
					if (Dist > 950)
						continue;
					Targets[Targets.length] = OldTargets[i].Vic;
					TargIndexes[TargIndexes.length] = i;

					TotalPlayerZaps += OldTargets[i].Zaps + OldTargets[i].Zaps * (1-Dist/950);
				}
			}
		}
		else
		{
			// Find all possible victims
			foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, 950, Instigator.Location )
			{
				if ( Victims != Instigator && Victims.Role == ROLE_Authority && !Victims.IsA('FluidSurfaceInfo') && !Victims.bWorldGeometry && Victims.bProjTarget && !Victims.bStatic && Projectile(Victims)==None && /*Victims.bCanBeDamaged &&*/
					(!Victims.PhysicsVolume.bWaterVolume || (Pawn(Victims)!=None && !Pawn(Victims).HeadVolume.bWaterVolume)) )
				{
					Dir = Normal(Victims.Location - Instigator.Location);
					if (Dir Dot AimDir > 0.75)
					{
						Targets[Targets.length] = Victims;
						if (Pawn(Victims) != None)
						{
							for (i=0;i<OldTargets.length;i++)
							{
								if (OldTargets[i].Vic == Victims)
								{
									Dist = VSize(Victims.Location - Instigator.Location);
									TotalPlayerZaps += OldTargets[i].Zaps + OldTargets[i].Zaps * (1-Dist/950);

									TargIndexes[TargIndexes.length] = i;
									break;
								}
							}
							if (i>=OldTargets.length)
							{
								OldTargets.length = OldTargets.length + 1;
								OldTargets[OldTargets.length-1].Vic = Pawn(Victims);
								TargIndexes[TargIndexes.length] = OldTargets.length-1;
							}
						}
						else
						{
							TotalPlayerZaps += 0.8;
							TargIndexes[TargIndexes.length] = -1;
						}
					}
				}
			}
		}
		// No victims, try attacking more walls
		if (/*Targets.length < 1*/ TotalPlayerZaps < 5.0 && Lures.length < 3 && FRand() > 0.65)
		{
			T = Trace(HitLoc, HitNorm, Instigator.Location + (GetFireSpread() >> Aim) * 800, Instigator.Location, true);
			if (T != None && T.bWorldGeometry)
			{
				OldLures.length = OldLures.length + 1;
				OldLures[OldLures.length-1].Loc  = HitLoc;
				OldLures[OldLures.length-1].Zaps = 1.0;
				Lures[Lures.length] = OldLures.length-1;
			}
		}

		TotalWallZaps = 0;
		// zap the walls
		for (i=0;i<Lures.length;i++)
		{
			OldLures[Lures[i]].Zaps += 0.3;
			Vecs[Vecs.length] = OldLures[Lures[i]].Loc;
			TotalWallZaps += OldLures[Lures[i]].Zaps;
		}

		// Zap up our victims
		for (i=0;i<Targets.length;i++)
		{
			Dmg = Damage+Rand(4);
			if (TargIndexes[i] > -1)
			{
				Dist = VSize(Targets[i].Location - Instigator.Location);
				if (TotalWallZaps > 0)
					ZapFactor = FMin(1.0, (OldTargets[TargIndexes[i]].Zaps + OldTargets[TargIndexes[i]].Zaps * (1-Dist/900)) / TotalWallZaps);
				else
					ZapFactor = 1;

				if (Lures.length < 3)
					OldTargets[TargIndexes[i]].Zaps += 0.5 * ZapFactor;
				Dmg *= ZapFactor;
			}

			Dir = Normal(Targets[i].Location - Instigator.Location);
			if (Dir Dot AimDir > 0.75)
			{
				ForceDir = (Instigator.Location + AimDir * (650+Rand(100))) - Targets[i].Location;

				if (TargIndexes[i] > -1 && OldTargets[TargIndexes[i]].Zaps >= 25)
					DT = class'DT_HVCBurstLightning';
				else
					DT = class'DT_HVCLightning';

				if (Instigator.Physics == PHYS_Falling)
					Instigator.Velocity -= Normal(Targets[i].Location - Instigator.Location) * 20 + VRand() * 15;
				else
					Instigator.Velocity -= Normal(Targets[i].Location - Instigator.Location) * 80 + VRand() * 60;

				class'BallisticDamageType'.static.GenericHurt (Targets[i], Dmg, Instigator, Targets[i].Location + Dir*-24, 40000 * FMax(0.1, 1-(VSize(ForceDir)/2000)) * Normal(ForceDir), DT);

				if (Targets[i].RemoteRole == ROLE_None)
				{
					Targets.Remove(i,1);
					TargIndexes.Remove(i,1);
					i--;
				}
			}
		}

		// Send lists to LG for effects
		if (Targets.length > 0 || Lures.length > 0)
			HVCMk9LightningGun(Weapon).SetTargetZap(Targets, Vecs);
		else
			HVCMk9LightningGun(Weapon).SetFreeZap();

	}

	simulated function bool AllowFire()
	{
		if (HVCMk9LightningGun(Weapon).HeatLevel >= 10 || HVCMk9LightningGun(Weapon).bIsVenting || !super.AllowFire())
		{
			if (bIsZapping)
			{
				Weapon.PlayOwnedSound(HVCMk9LightningGun(Weapon).OverHeatSound,Slot_None,0.7,,64,1.0,true);
				PlayFireEnd();
			}
			return false;
		}
		return true;
	}
	function ServerPlayFiring()
	{
		if (!IsFiring())
			return;
		if (BW.FireCount < 2)
		{
			if (BallisticFireSound.Sound != None)
				Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		}
		else if (BW.FireCount == Max(2, level.TimeDilation * 5.0))
			Weapon.PlayOwnedSound(FireSound2,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		if (FireSoundLoop != None)
		{
			Instigator.AmbientSound = FireSoundLoop;
			Instigator.SoundVolume = 255;
		}
	}

	function PlayFiring()
	{
		if (!IsFiring())
			return;
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
			if (level.DetailMode > DM_Low)
				HVCMk9LightningGun(Weapon).InitArcs();
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
			HVCMk9LightningGun(Weapon).AddHeat(0.15);
		}

		if (/*Instigator.IsFirstPerson() && */(MuzzleFlash == None || MuzzleFlash.bDeleteMe))
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, class'HVCMk9MuzzleFlash', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);

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

	function StopLightning()
	{
		HVCMk9LightningGun(Weapon).KillZap();
		bIsZapping=false;
		if (MuzzleFlash != None)
		{	Emitter(MuzzleFlash).Kill();	MuzzleFlash = None;	}
		Instigator.AmbientSound = BW.UsedAmbientSound;
		Instigator.SoundVolume = Weapon.default.SoundVolume;
	}

	function FlashMuzzleFlash();

}

defaultproperties
{
     FireSoundLoop=Sound'BW_Core_WeaponSound.LightningGun.LG-FireLoop'
     Damage=10.000000
     HeadMult=1f
     LimbMult=1f
     
     DamageType=Class'BallisticProV55.DT_HVCLightning'
     DamageTypeHead=Class'BallisticProV55.DT_HVCLightning'
     DamageTypeArm=Class'BallisticProV55.DT_HVCLightning'
     KickForce=2000
	 MaxWaterTraceRange=9000
     bNoPositionalDamage=True
     FireChaos=0.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-FireStart')
     bPawnRapidFireAnim=True
     FireRate=0.070000
     AmmoClass=Class'BallisticProV55.Ammo_HVCCells'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=50.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=1.000000,Y=1.000000,Z=1.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
     WarnTargetPct=0.3
}
