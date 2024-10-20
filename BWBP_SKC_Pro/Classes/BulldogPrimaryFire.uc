//  =============================================================================
//	Bulldog primary fire.
//
//  Powerful ranged attack which deals radius damage.
//  Originally written by Sergeant_Kelly based on code by DarkCarnivour.
//  Modified by Azarael.
//  =============================================================================
class BulldogPrimaryFire extends BallisticProInstantFire;

var() class<actor>			AltBrassClass1;			//Alternate Fire's brass
var() class<actor>			AltBrassClass2;			//Alternate Fire's brass (whole FRAG-12)
var bool 	bSmallRadiusDamage; //We're in classic, do radius damage
var bool 	bLargeRadiusDamage; //We're in realistic, blow them up

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
	else if (BW.bNeedCock || !BulldogAssaultCannon(BW).bAltNeedCock)
		return false;		// Alt's loaded or needs cocking
    return true;
}


//Spawn shell casing for first person
function EjectFRAGBrass()
{
	local vector Start, X, Y, Z;
	local Coords C;

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	if (BrassClass == None)
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
	if (AIController(Instigator.Controller) != None)
		return;
	C = Weapon.GetBoneCoords(BrassBone);
//	Start = C.Origin + C.XAxis * BrassOffset.X + C.YAxis * BrassOffset.Y + C.ZAxis * BrassOffset.Z;
    Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * BrassOffset.X + Y * BrassOffset.Y + Z * BrassOffset.Z;
	Spawn(AltBrassClass2, weapon,, Start, Rotator(C.XAxis));
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim != None && Victim.bProjTarget)
	{
		if (BallisticShield(Victim) != None)
			BW.TargetedHurtRadius(Damage, 48, class'DTBulldog', 500, HitLocation, Pawn(Victim));
		else
			BW.TargetedHurtRadius(Damage, 96, class'DTBulldog', 500, HitLocation, Pawn(Victim));
	}
}

// Does something to make the effects appear
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if (!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None || level.NetMode == NM_Client)
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);
		
	if (bSmallRadiusDamage && (Other == None || Other.bWorldGeometry))
		BW.TargetedHurtRadius(30, 96, class'DTBulldog', 500, HitLocation);
		
	if (bLargeRadiusDamage && (Other == None || Other.bWorldGeometry))
		BW.TargetedHurtRadius(35, 160, class'DTBulldog', 500, HitLocation);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
		
	return true;
}

defaultproperties
{
     AltBrassClass1=Class'BWBP_SKC_Pro.Brass_FRAGSpent'
     AltBrassClass2=Class'BWBP_SKC_Pro.Brass_FRAG'
     TraceRange=(Min=30000.000000,Max=30000.000000)
     DamageType=Class'BWBP_SKC_Pro.DTBulldog'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTBulldogHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTBulldog'
     KickForce=1000
     PenetrateForce=250
     bPenetrate=True
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     FlashScaleFactor=1.100000
     BrassClass=Class'BWBP_SKC_Pro.Brass_BOLT'
     BrassOffset=(X=-30.000000,Y=1.000000)
     FireRecoil=1280.000000
     FirePushbackForce=3000.000000
     FireChaos=1.000000
	 BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Bulldog.Bulldog-Fire',Volume=7.500000)
	 AimedFireAnim="SightFire"
     FireEndAnim=
     FireAnimRate=2.000000
     FireRate=0.85
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_75BOLT'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-25.00)
	ShakeOffsetRate=(X=-500.000000)
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
