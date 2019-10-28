//=============================================================================
// MGLauncher.
//
// Multiple Grenade LauncherLauncher!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MGLauncher extends BallisticWeapon;

var() Material	MatDef;
var() Material	MatArmed;
var() Rotator	DrumRot;

var bool bRemoteGrenadeOut;

replication
{
	unreliable if (Role == ROLE_Authority)
		ClientUpdateGrenadeStatus;
}

function ServerSwitchWeaponMode (byte NewMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	super.ServerSwitchWeaponMode (NewMode);
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim))
	{
		bPreventReload=false;
		DrumRot.Roll -= 65535 / 6 ;
		SetBoneRotation('drum',DrumRot);	
	}
	
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
		DrumRot.Roll -= 65535 / 6 ;
		SetBoneRotation('drum',DrumRot);	
	}

	// Modified stuff from Engine.Weapon
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if (MeleeState < MS_Held)
			bPreventReload=false;
		if (Channel == 0)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn)
	{
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1 )
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			ReAim(0.05);
		}
		return;
	}
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		ReAim(0.05);
	}
	
	if (ReloadState == RS_GearSwitch)
		ReloadState = RS_None;
}

function UpdateGrenadeStatus(bool bDetonatable)
{
	bRemoteGrenadeOut = bDetonatable;
	
	if (bDetonatable)
		Skins[2]=MatArmed;
	else
		Skins[2]=MatDef;
		
	if (Role == ROLE_Authority && !Instigator.IsLocallyControlled())
		ClientUpdateGrenadeStatus(bDetonatable);
}

simulated function ClientUpdateGrenadeStatus(bool bDet)
{
	bRemoteGrenadeOut = bDet;
	if (bDet)
		Skins[2]=MatArmed;
	else
		Skins[2]=MatDef;
}

simulated function bool HasAmmo()
{
	if (bRemoteGrenadeOut)
		return true;
	return Super.HasAmmo();
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount <=0 && MagAmmo <= 0)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	// Enemy too far away
	if (Dist > 1000)
		Result -= (Dist-1000) / 2000;
	// If the enemy has a knife too, a gun looks better
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.1 * B.Skill;
	// Sniper bad, very bad
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.3;
	Result += 1 - Dist / 1000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/4000));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

simulated function Notify_BrassOut()
{
//	BFireMode[0].EjectBrass();
}

defaultproperties
{
     MatDef=Texture'BallisticRecolors4TexPro.MGL.MGL-ScreenBase'
     MatArmed=Texture'BallisticRecolors4TexPro.MGL.MGL-Screen'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     TeamSkins(1)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticRecolors4TexPro.MGL.BigIcon_MGL'
     IdleTweenTime=0.000000
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     bWT_Super=True
     ManualLines(0)="Launches a grenade. Fire rate, damage and explosive radius are good. These grenades have an arming delay and if striking a surface when unarmed will ricochet. Direct impacts will always result in explosion."
     ManualLines(1)="Employs a manually controlled grenade. Pressing altfire again detonates the grenade."
     ManualLines(2)="Effective with height advantage and at medium range."
     SpecialInfo(0)=(Info="300.0;30.0;0.5;60.0;0.0;1.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway')
     MagAmmo=6
     CockSound=(Sound=Sound'PackageSounds4Pro.M781.M781-Pump',Volume=2.300000,Radius=32.000000)
     ClipOutSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOff',Volume=1.700000,Radius=32.000000)
     ClipInSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOn',Volume=1.700000,Radius=32.000000)
     ClipInFrame=0.325000
     StartShovelAnim="ReloadStart"
     EndShovelAnim="ReloadEnd"
     WeaponModes(0)=(ModeName="Timed",bUnavailable=True,ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Impact",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="4-Round Burst",bUnavailable=True)
     CurrentWeaponMode=1
     bNoCrosshairInScope=True
     SightPivot=(Pitch=512)
     SightOffset=(X=-30.000000,Y=12.450000,Z=14.850000)
     GunLength=48.000000
     SprintOffSet=(Pitch=-3000,Yaw=-4096)
     AimSpread=192
     ChaosDeclineTime=1.000000
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
     RecoilYCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYawFactor=0.000000
     RecoilXFactor=0.400000
     RecoilYFactor=0.400000
     RecoilMax=6144.000000
     RecoilDeclineDelay=0.500000
     FireModeClass(0)=Class'BWBPRecolorsPro.MGLPrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.MGLSecondaryFire'
     SelectAnimRate=1.500000
     PutDownAnimRate=2.000000
     PutDownTime=0.660000
     BringUpTime=0.660000
     AIRating=0.600000
     CurrentRating=0.600000
     Description="The big, bad Conqueror” is an alias to the VDML-6 Multiple Grenade Launcher, designed as a heavier, tactical version of the old world M32, and a more direct way of punting grenades down range, unlike the PUMA’s Airburst grenades or the Longhorn’s smart cluster. Black and Wood designed this weapon to bring down explosives over the Skrith’s plasma barriers with haste, the user can fire timed grenades to flush out any hiders, or impact to wreck enemies without bouncing off of them (note, when fired at a short range, the impact fuse will not engage). But when tactics are needed, the “Conqueror” can also fire remote detonated grenades for traps. So far, the Conqueror has already conquered 2 services and will be seeing more as they come."
     Priority=245
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBPRecolorsPro.MGLPickup'
     PlayerViewOffset=(X=5.000000,Y=-1.000000,Z=-7.000000)
     AttachmentClass=Class'BWBPRecolorsPro.MGLAttachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.MGL.SmallIcon_MGL'
     IconCoords=(X2=127,Y2=35)
     ItemName="Conqueror MGL"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.Conqueror_FP'
     DrawScale=0.130000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolors4TexPro.MGL.MGL-Main'
     Skins(2)=Texture'BallisticRecolors4TexPro.MGL.MGL-ScreenBase'
     Skins(3)=Shader'BallisticRecolors4TexPro.MGL.MGL-HolosightGlow'
}
