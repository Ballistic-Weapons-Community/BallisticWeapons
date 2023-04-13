//=============================================================================
// SARPrimaryFire.
//
// Average power, 600RpM, rifle range, low accuracy assault rifle fire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class SARPrimaryFire extends BallisticProInstantFire;

function PlayFiring()
{
	if (SARAssaultRifle(Weapon).bStockExtended && !SARAssaultRifle(Weapon).bStockBoneOpen)
		SARAssaultRifle(Weapon).SetStockRotation();

	PlayFireAnimations();

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

//Spawn shell casing for first person
function EjectBrass()
{
	local vector Start, X, Y, Z;
	local Coords C;
	local actor BrassActor;

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
	BrassActor = Spawn(BrassClass, weapon,, Start, Rotator(C.XAxis));
	if (BrassActor != None)
	{
		BrassActor.bHidden=true;
		SARAssaultRifle(Weapon).UziBrassList.length = SARAssaultRifle(Weapon).UziBrassList.length + 1;
		SARAssaultRifle(Weapon).UziBrassList[SARAssaultRifle(Weapon).UziBrassList.length-1].Actor = BrassActor;
		SARAssaultRifle(Weapon).UziBrassList[SARAssaultRifle(Weapon).UziBrassList.length-1].KillTime = level.TimeSeconds + 0.2;
	}
}

defaultproperties
{
     TraceRange=(Min=9000.000000,Max=9000.000000)
     DamageType=Class'BallisticProV55.DTSARRifle'
     DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
     DamageTypeArm=Class'BallisticProV55.DTSARRifle'
     PenetrateForce=150
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=24.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'FlashEmitter_AR'
     FlashScaleFactor=0.900000
     BrassClass=Class'BallisticProV55.Brass_SAR'
     BrassBone="tip"
     BrassOffset=(X=-105.000000,Y=-10.000000,Z=-1.000000)
     AimedFireAnim="AimedFire"
     FireRecoil=180.000000
     FireChaos=0.022000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     bModeExclusive=False
     FireEndAnim=
     FireRate=0.09
     AmmoClass=Class'BallisticProV55.Ammo_556mm'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}
