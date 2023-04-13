//=============================================================================
// CYLOFirestormSecondaryShotgunFire.
//
// Incendiary shotgun fire. 
// Can light targets but is weaker than other shotgun and incendiary shells
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOFirestormSecondaryShotgunFire extends BallisticShotgunFire;

function CYLOFirestormFireControl GetFireControl()
{
	return CYLOFirestormAssaultWeapon(Weapon).GetFireControl();
}

function DoFireEffect()
{
    local Vector Start, Dir, End, HitLocation, HitNormal;
    local Rotator R, Aim;
	local actor Other;
	local float Dist, NodeDist, DR;
	local int i;

    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();
	Aim = GetFireAim(Start);

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

	for (i=0;i<TraceCount;i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(Start, R);
		
		if (Other != None && (Other.bWorldGeometry || Mover(Other) != none))
			GetFireControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, Other);
		else
			GetFireControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, None);
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
			GetFireControl().GasNodes[i].TakeDamage(5, Instigator, GetFireControl().GasNodes[i].Location, vect(0,0,0), class'DT_CYLOFirestormShotgun');
	}


	SendFireEffect(none, Vector(Aim)*TraceRange.Max, Start, 0);

	Super(BallisticFire).DoFireEffect();
}

simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (CYLOFirestormAssaultWeapon(Weapon).SGShells < 1)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			CYLOFirestormAssaultWeapon(BW).bAltNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);
		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (CYLOFirestormAssaultWeapon(BW).bAltNeedCock)
		return false;
    return true;
}
simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	Super.ModeDoFire();
    CYLOFirestormAssaultWeapon(Weapon).SGShells--;
	if (Weapon.Role == ROLE_Authority && CYLOFirestormAssaultWeapon(Weapon).SGShells == 0)
		CYLOFirestormAssaultWeapon(BW).bAltNeedCock = true;
}

defaultproperties
{
     TraceCount=4
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlameLight'
     ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
     TraceRange=(Min=1500.000000,Max=1500.000000)
     DamageType=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgun'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgunHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgun'
     KickForce=5000
     PenetrateForce=0
	 bPenetrate=False
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashBone="Muzzle2"
     BrassClass=Class'BallisticProV55.Brass_Shotgun' //Make these orange
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     FireChaos=0.650000
     XInaccuracy=1250.000000
     YInaccuracy=1250.000000
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000)
     bWaitForRelease=True
     bModeExclusive=False
     FireAnim="FireSG"
     FireAnimRate=1.000000
     FireRate=0.350000
	 AmmoPerFire=0
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_CYLOSG' //Make dragon
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.7
     WarnTargetPct=0.5
}
