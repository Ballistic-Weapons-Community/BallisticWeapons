//=============================================================================
// ICISSecondaryFire.
//
// Preps and stabs the needle into enemies.
//
// by Marc Sergeant Kelly Moylan
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ICISSecondaryFire extends BallisticMeleeFire;

var byte        AmmoCost;

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	local BallisticPawn BPawn;
	local ICISPoisoner IP;
    local float Pwr;

    Pwr = FMin(1f, BW.AmmoAmount(0) / float(AmmoCost));

	BPawn = BallisticPawn(Target);	

    super.ApplyDamage(Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);

    IP = Spawn(class'ICISPoisoner', Instigator.Controller);
    IP.Instigator = Instigator;
    IP.Pwr = Pwr;

    if(Instigator.Role == ROLE_Authority && Instigator.Controller != None)
        IP.InstigatorController = Instigator.Controller;

    IP.Initialize(BPawn);
    ICISStimPack(BW).ConsumeAmmo(1, AmmoCost, True);
    ICISStimPack(BW).PlaySound(ICISStimPack(BW).HealSound, SLOT_Misc, 1.5, ,64);
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing

	return Weapon.AmmoAmount(ThisModeNum) > 0;
}

defaultproperties
{
     SwipePoints(0)=(offset=(Pitch=4000,Yaw=2000))
     SwipePoints(1)=(offset=(Pitch=2000,Yaw=1000))
     SwipePoints(3)=(offset=(Pitch=-2000,Yaw=-1000))
     SwipePoints(4)=(offset=(Pitch=-4000,Yaw=-2000))
     SwipePoints(5)=(Weight=-1)
     SwipePoints(6)=(Weight=-1)
     TraceRange=(Min=96.000000,Max=96.000000)
     AmmoCost=50     
     DamageType=Class'BWBP_SKC_Pro.DT_ICIS'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_ICIS'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_ICIS'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.X4.X4_Melee',Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepFriendlyShank"
     FireAnim="FriendlyShank"
     FireRate=0.600000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_ICISStim'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
