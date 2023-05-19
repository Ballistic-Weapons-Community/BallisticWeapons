//=============================================================================
// VSKTranqRifle.
//
// Special operations gas rifle. Fires anesthetic darts for maximum fun.
// Scope changes rate of fire and sound and stuff.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class VSKTranqRifle extends BallisticWeapon;

var float		lastModeChangeTime;

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	//if (class'BallisticReplicationInfo'.static.IsArena())
	//{
	//	VSKPrimaryFire(FireMode[0]).bDOT = true;
	//}
	VSKPrimaryFire(FireMode[0]).SwitchScopedMode(CurrentWeaponMode);
}
/*replication
{
	reliable if (Role == ROLE_Authority)
		ClientSwitchWeaponMode;
}*/



function ServerSwitchWeaponMode (byte newMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		VSKPrimaryFire(FireMode[0]).SwitchScopedMode(CurrentWeaponMode);
	ClientSwitchWeaponMode (CurrentWeaponMode);
}

simulated function ClientSwitchWeaponMode (byte newMode)
{
	VSKPrimaryFire(FireMode[0]).SwitchScopedMode(newMode);
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);
		if (CurrentWeaponMode == 0)
		{
			FireMode[0].FireRate 	= 0.4;
		}
		else if (CurrentWeaponMode == 1)
		{
			FireMode[0].FireRate 	= 0.15;
		}
		else
		{
			FireMode[0].FireRate 	= BFireMode[0].default.FireRate;
		}
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}


// AI Interface =====
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 1000)
		Result += (Dist/1000) - 1;
	else
		Result += 1-(Abs(Dist-5000)/5000);

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_SKC_Tex.VSKS.BigIcon_VSK'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;2.0;0.1;0.1")
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.VSK.VSK-Draw')
     PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.VSK.VSK-Holster')
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'BWBP_SKC_Sounds.VSK.VSK-Cock',Volume=1.000000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.VSK.VSK-ClipOut',Volume=1.500000)
     ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.VSK.VSK-ClipIn',Volume=1.500000)
	 ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.RS04-SlideLock',Volume=1.500000)
     ClipInFrame=0.650000
     bNeedCock=False
	 WeaponModes(0)=(ModeName="High Powered",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Low Powered",ModeID="WM_FullAuto")
	 WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=1
     ScopeViewTex=Texture'BWBP_SKC_Tex.VSK.VSKScopeView'
     ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	 ZoomType=ZT_Fixed
	 FullZoomFOV=50
     bNoCrosshairInScope=True

	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Cross4',pic2=Texture'BW_Core_WeaponTex.Crosshairs.A73OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=25,G=122,R=11,A=255),Color2=(B=255,G=255,R=255,A=255),StartSize1=22,StartSize2=59)     
     FireModeClass(0)=Class'BWBP_SKC_Pro.VSKPrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="VSK42 'Vampir' Tranqulizer Rifle||Manufacturer: Zavod Tochnogo Voorujeniya (ZTV Export)|Primary: Tranqulizer Dart Fire|Secondary: Zooming Scope||Vintovka Snayperskaya Kisel'eva - Paraliticheskaya. Named the Vampire due to the fact that it literally sucks the life force out of its enemies with its highly potent tranqulizer rounds. Perfect for stealthy take downs, the tactical VSP-42 and non-lethal VSK-42 are high class weapons produced in the post-war Russian Federation. The unique cased subsonic rounds of the VSK are packed with an extremely potent immobilising drug capable of dropping a juggernaut in a single shot. (Usage of more than one shot is not recommended as doses of more than 1 ml carry a 95% casualty rate in humans.) Dart velocity can be adjusted when using gas-assisted firemodes to increase range and hypodermic penetration."
     Priority=65
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     PickupClass=Class'BWBP_SKC_Pro.VSKPickup'
	 
     PlayerViewOffset=(X=0.000000,Y=10.000000,Z=-11.000000)
	 SightOffset=(X=30.000000,Y=0.5,Z=-1.250000)

     BobDamping=2.000000
     AttachmentClass=Class'BWBP_SKC_Pro.VSKAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.VSKS.SmallIcon_VSK'
     IconCoords=(X2=127,Y2=31)
     ItemName="VSK-42 Tranquilizer Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClasses(0)=Class'VSKWeaponParamsArena'
	 ParamsClasses(1)=Class'VSKWeaponParamsClassic'
	 ParamsClasses(2)=Class'VSKWeaponParamsRealistic'
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_VSKS'
     DrawScale=0.700000
}
