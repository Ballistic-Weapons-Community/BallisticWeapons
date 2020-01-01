//=============================================================================
// LS-14 Laser Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
// Modified by Marc 'Sergeant Kelly' Moylan
// Scope code by Kaboodles
// Reloading code and handling change by Azarael, yaaaay!
//=============================================================================
class XM20AutoLas extends BallisticWeapon;

function int ManageHeatInteraction(Pawn P, int HeatPerShot)
{
	local XM20HeatManager HM;
	local int HeatBonus;
	
	foreach P.BasedActors(class'XM20HeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'XM20HeatManager',P,,P.Location + vect(0,0,-30));
		HM.SetBase(P);
	}
	
	if (HM != None)
	{
		HeatBonus = HM.Heat;
		if (Vehicle(P) != None)
			HM.AddHeat(HeatPerShot/4);
		else HM.AddHeat(HeatPerShot);
	}
	
	return heatBonus;
}

// AI Interface =====
simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1)
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}
	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

defaultproperties
{
     ManualLines(0)="Hts heat up the target, causing subsequent shots to inflict greater damage. This effect on the target decays with time."
     ManualLines(1)="Unfortunately, it's not the Wrenchgun."
     ManualLines(2)="Effective at modeerate range and against enemies using healing weapons and items."
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticRecolors3TexPro.LS14.BigIcon_LS14'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Energy=True
	 bWT_Machinegun=True
	 bNoCrosshairInScope=True
     SpecialInfo(0)=(Info="240.0;15.0;1.1;90.0;1.0;0.0;0.3")
     BringUpSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Select')
     PutDownSound=(Sound=Sound'PackageSounds4Pro.LS14.Gauss-Deselect')
     MagAmmo=30
     CockSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Cock')
     ReloadAnimRate=1.150000
     ClipHitSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds3.USSR.USSR-ClipIn')
     ClipInFrame=0.650000 
     CurrentWeaponMode=2
     SightOffset=(X=20.000000,Y=16.8500000,Z=29.000000)
	 SightDisplayFOV=30
     GunLength=80.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     JumpOffSet=(Pitch=-6000,Yaw=2000)
     AimSpread=128
     ChaosDeclineTime=0.800000
     ChaosSpeedThreshold=2500.000000
     RecoilXCurve=(Points=(,(InVal=0.150000),(InVal=0.250000,OutVal=-0.080000),(InVal=0.400000,OutVal=0.080000),(InVal=0.600000,OutVal=-0.120000),(InVal=0.800000,OutVal=0.100000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.400000,OutVal=0.450000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.400000
     RecoilYFactor=0.400000
     RecoilDeclineTime=1.000000
     FireModeClass(0)=Class'BWBPSomeOtherPack.XM20PrimaryFire'
     FireModeClass(1)=Class'BWBPSomeOtherPack.XM20SecondaryFire'
     SelectAnimRate=1.500000
     PutDownAnimRate=2.000000
     PutDownTime=0.500000
     BringUpTime=0.400000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     Description="XM-20 Auto Las||Manufacturer: Wrenchgun Industries|Primary: High Intensity Laser Beam|Secondary: Diffused High Intesity Beams"
     Priority=194
     HudColor=(B=255,G=150,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=4
     PickupClass=Class'BWBPSomeOtherPack.XM20Pickup'
     PlayerViewOffset=(X=-12.000000,Y=0.000000,Z=-22.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBPSomeOtherPack.XM20Attachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.LS14.SmallIcon_LS14'
     IconCoords=(X2=127,Y2=31)
     ItemName="XM-20 Auto Las"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.XM20_FP'
     DrawScale=0.500000
}
