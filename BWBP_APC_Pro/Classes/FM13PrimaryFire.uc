//=============================================================================
// M763PrimaryFire.
//
// Powerful, ranged shotgun blast.
// Now automatic, due to inability to balance it any other way.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FM13PrimaryFire extends BallisticProShotgunFire;

// ==================================================================================
//FireFromFireControl - Shotgun uses a firecontrol with incendiary projectiles, these projectiles ignite gas clouds and cause ground fires, ignition depends on # pellets hit
// ==================================================================================
simulated state FireFromFireControl
{

	function FM13FireControl GetFireControl()
	{
		return FM13Shotgun(Weapon).GetFireControl();
	}

	//======================================================================
	// ShotgunIncendiary-DoFireEffect
	//
	// Spawn fire bits
	//======================================================================
	function DoFireEffect()
	{
		local Vector Start, Dir, End, HitLocation, HitNormal;
		local Rotator R, Aim;
		local actor Other;
		local float Dist, NodeDist, DR;
		local int i;

		//============================= Instant Hit Bits ====================
		Aim = GetFireAim(Start);
		
		if (Level.NetMode == NM_DedicatedServer)
			BW.RewindCollisions();
		
		//Spawn the damage tracers first
		for (i=0;i<TraceCount;i++)
		{
			R = Rotator(GetFireSpread() >> Aim);
			DoTrace(Start, R);
		}
		
		if (Level.NetMode == NM_DedicatedServer)
			BW.RestoreCollisions();
		
		ApplyHits();
		
		//============================= Flamey Bits ==========================
		Start = Instigator.Location + Instigator.EyePosition();
		Aim = GetFireAim(Start);
		Aim = Rotator(GetFireSpread() >> Aim);

		Dir = Vector(Aim);
		End = Start + (Dir*MaxRange());
		Weapon.bTraceWater=true;
		for (i=0;i<20;i++)
		{
			Other = Trace(HitLocation, HitNormal, End, Start, true);
			if (Other == None || Other.bWorldGeometry || Mover(Other) != none || Vehicle(Other)!=None || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
				break;
			Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
		}
		Weapon.bTraceWater=false;

		if (Other == None)
			HitLocation = End;
		if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			Other = None;
		
		//Spawn the tracers but also spawn a bunch of fire projectiles
		for (i=0;i<TraceCount;i++)
		{
			R = Rotator(GetFireSpread() >> Aim);
			
			if (Other != None && (Other.bWorldGeometry || Mover(Other) != none))
				GetFireControl().FireShotRotated(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, Other, R);
			else
				GetFireControl().FireShotRotated(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, None, R);
		}

		Dist = VSize(HitLocation-Start);
		for (i=0;i<GetFireControl().GasNodes.Length;i++)
		{
			if (GetFireControl().GasNodes[i] == None || (RX22AGasCloud(GetFireControl().GasNodes[i]) == None && RX22AGasPatch(GetFireControl().GasNodes[i]) == None && RX22AGasSoak(GetFireControl().GasNodes[i]) == None))
				continue;
			NodeDist = VSize(GetFireControl().GasNodes[i].Location-Start);
			if (NodeDist > Dist)
				continue;
			DR = Dir Dot Normal(GetFireControl().GasNodes[i].Location-Start);
			if (DR < 0.75)
				continue;
			NodeDist = VSize(GetFireControl().GasNodes[i].Location - (Start + Dir * (DR * NodeDist)));
			if (NodeDist < 128)
				GetFireControl().GasNodes[i].TakeDamage(5, Instigator, GetFireControl().GasNodes[i].Location, vect(0,0,0), class'DTRX22ABurned');
		}

		// Tell the attachment the aim. It will calculate the rest for the clients
		SendFireEffect(none, Vector(Aim)*TraceRange.Max, Start, 0);
	
		Super(BallisticFire).DoFireEffect();
	}

}

// ==================================================================================
//FireFromImpact - Shotgun has radius damage and ignites any targets hit
// ==================================================================================
simulated state FireFromImpact
{

	simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
	{
		BW.TargetedHurtRadius(5, 96, DamageType, 1, HitLocation,Pawn(Other));
		return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
	}

	function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
	{
		local int i;
		local FM13ActorFire Burner;
		
		super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
		
		if (Pawn(Target) != None && Pawn(Target).Health > 0 && Vehicle(Target) == None)
		{
			for (i=0;i<Target.Attached.length;i++)
			{
				if (FM13ActorFire(Target.Attached[i])!=None)
				{
					FM13ActorFire(Target.Attached[i]).AddFuel(2);
					break;
				}
			}
			if (i>=Target.Attached.length)
			{
				Burner = Spawn(class'FM13ActorFire',Target,,Target.Location + vect(0,0,-30));
				Burner.Initialize(Target);
				if (Instigator!=None)
				{
					Burner.Instigator = Instigator;
					Burner.InstigatorController = Instigator.Controller;
				}
			}
		}
	}

}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	
	if (BW.MagAmmo < AmmoPerFire)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			BW.bNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (BW.bNeedReload)
		return false;
	else if (BW.bNeedCock || FM13Shotgun(BW).bAltLoaded)
		return false;		// Alt's loaded or needs cocking
    return true;
}
// ==================================================================================
//Regular Shotgun Stuff ==================================================================================
// ==================================================================================
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'SightfireNoCock';
		FireAnim = 'FireNoCock';
	}
	else
	{
		AimedFireAnim='Sightfire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}

function ServerPlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		AimedFireAnim = 'SightfireNoCock';
		FireAnim = 'FireNoCock';
	}
	else
	{
		AimedFireAnim='Sightfire';
		FireAnim = 'Fire';
	}
	super.ServerPlayFiring();
}

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     HipSpreadFactor=3.000000
	 DecayRange=(Min=512,Max=1562)
     TraceCount=10
     TracerClass=Class'BWBP_APC_Pro.TraceEmitter_ShotgunFlame'
     ImpactManager=Class'BWBP_APC_Pro.IM_FireShot'
     TraceRange=(Min=3072.000000,Max=3072.000000)
     Damage=10.000000

     RangeAtten=0.15000
     DamageType=Class'BWBP_APC_Pro.DTFM13Shotgun'
     DamageTypeHead=Class'BWBP_APC_Pro.DTFM13ShotgunHead'
     DamageTypeArm=Class'BWBP_APC_Pro.DTFM13Shotgun'
     KickForce=5000
     PenetrateForce=0
	 bPenetrate=False
	 WallPenetrationForce=0
     MuzzleFlashClass=Class'BWBP_APC_Pro.FM13FlashEmitter'
     FlashScaleFactor=1.000000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="FireCombinedSight"
     FireRecoil=768.000000
     FireChaos=0.30000
     XInaccuracy=150.000000
     YInaccuracy=150.000000
     BallisticFireSound=(Sound=Sound'BWBP_CC_Sounds.FM13.FM13-Fire',Volume=1.300000)
     FireAnim="FireCombined"
     FireEndAnim=
     FireAnimRate=0.9
     FireRate=0.85
     AmmoClass=Class'BWBP_APC_Pro.Ammo_FM13IncendiaryGauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 ClipFinishSound=(Sound=Sound'BWBP_CC_Sounds.FM13.FM13-Roar',Volume=1.900000,Radius=1024.000000,Pitch=0.500000,bNoOverride=True)
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.7
     WarnTargetPct=0.5
}
