//=============================================================================
// LS440Instagib.
//
// A gatling laser with a high rof primary and instakill secondary
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
// Modified by Marc 'Sergeant Kelly' Moylan
//=============================================================================
class LS440Instagib extends BallisticWeapon
	transient
	HideDropDown
	CacheExempt;

var	bool		bBarrelsOnline;		//Used for alternating laser effect in attachment class.
var	bool		bOverloaded;	//You exploded it.
var float		lastModeChangeTime;

var Actor	Glow;				// Blue charge effect

var actor HeatSteam;
var actor BarrelFlare;
var actor BarrelFlareSmall;
var actor VentCore;
var actor VentBarrel;
var actor CoverGlow;

var   float ChargeRate;
var()     float Heat, CoolRate;
var   bool			bIsCharging;

var() name		RocketPackBone;			// Bone to use for hiding rabid packs of rockets
var() name		MiscBone1;
var() name		MiscBone2;
var() name		MiscBone3;
var() name		MiscBone4;

// Barrel rotation
var   float DesiredSpeed, BarrelSpeed;
var   int	BarrelTurn;
var() Sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;

replication
{
	reliable if (Role == ROLE_Authority)
		ChargeRate;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	SetBoneScale (0, 0.0, RocketPackBone);
	SetBoneScale (1, 0.0, MiscBone1);
	SetBoneScale (2, 0.0, MiscBone2);
	SetBoneScale (3, 0.0, MiscBone3);
	SetBoneScale (4, 0.0, MiscBone4);


//	Core Glow Effect
	if (CoverGlow != None)
		CoverGlow.Destroy();

    	if (Instigator.IsLocallyControlled() && level.DetailMode >= DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    	{
    	CoverGlow = None;
	class'BUtil'.static.InitMuzzleFlash (CoverGlow, class'LS440GlowFX', DrawScale, self, 'BarrelGlow');
	}
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (BarrelFlare != None)	BarrelFlare.Destroy();
		if (BarrelFlareSmall != None)	BarrelFlareSmall.Destroy();
	}
	bOverloaded=false;
	return false;
}
simulated function Destroyed()
{
	if (BarrelFlare != None)	BarrelFlare.Destroy();
	if (BarrelFlareSmall != None)	BarrelFlareSmall.Destroy();
	if (CoverGlow != None)
		CoverGlow.Destroy();
	super.Destroyed();
}

simulated function Notify_BrassOut()
{
//	BFireMode[0].EjectBrass();
}

simulated event RenderOverlays (Canvas Canvas)
{
	local float	ScaleFactor;

	if (!bScopeView)
	{
		Super(Weapon).RenderOverlays(Canvas);
		if (SightFX != None)
			RenderSightFX(Canvas);
		return;
	}
	else
	{
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}
	ScaleFactor = Canvas.ClipX / 1600;

    if (ScopeViewTex != None) //Now resets gun variables
    {
		if (CurrentWeaponMode == 1)
		{
	        Canvas.SetDrawColor(255,255,255,255);

        	Canvas.SetPos(Canvas.OrgX, Canvas.OrgY);
    		Canvas.DrawTile(Texture'BWBP_SKC_Tex.LS14.LS14ScopeDbl', (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1);

        	Canvas.SetPos((Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(Texture'BWBP_SKC_Tex.LS14.LS14ScopeDbl', Canvas.SizeY, Canvas.SizeY, 0, 0, 1024, 1024);

        	Canvas.SetPos(Canvas.SizeX - (Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(Texture'BWBP_SKC_Tex.LS14.LS14ScopeDbl', (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1);
		}
		else
		{
	        Canvas.SetDrawColor(255,255,255,255);
		//Left Border
        	Canvas.SetPos(Canvas.OrgX, Canvas.OrgY);
    		Canvas.DrawTile(ScopeViewTex, (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1024);
		//Scope
        	Canvas.SetPos((Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(ScopeViewTex, Canvas.SizeY, Canvas.SizeY, 0, 0, 1024, 1024);
		//Right Border
        	Canvas.SetPos(Canvas.SizeX - (Canvas.SizeX - Canvas.SizeY)/2, Canvas.OrgY);
        	Canvas.DrawTile(ScopeViewTex, (Canvas.SizeX - Canvas.SizeY)/2, Canvas.SizeY, 0, 0, 1, 1024);
		}

		Canvas.Font = GetFontSizeIndex(Canvas, -2 + int(2 * class'HUD'.default.HudScale));

		if ((Canvas.ClipX/Canvas.ClipY) > 1.4)
		{
			Canvas.SetPos(Canvas.SizeX*0.549,Canvas.SizeY*0.689);
			Canvas.DrawText("X", false);
		}
		else
		{
			Canvas.SetPos(Canvas.SizeX*0.56, Canvas.SizeY*0.7);
			Canvas.DrawText("X", false);
		}


	}
}

// Heat Junk
simulated event Tick (float DT)
{
	local float OldBarrelTurn;

	if (FireMode[1].IsFiring())
	{
		BarrelSpeed = BarrelSpeed + FClamp(0.2 - BarrelSpeed, -0.2*DT, 0.4*DT);
		BarrelTurn += BarrelSpeed * 655360 * DT;
		CoolRate = 0;
		bIsCharging = true;
	}
	else if (BarrelSpeed > 0)
	{
		BarrelSpeed = FMax(BarrelSpeed-0.1*DT, 0.01);
		OldBarrelTurn = BarrelTurn;
		BarrelTurn += BarrelSpeed * 655360 * DT;
		if (BarrelSpeed <= 0.025 && int(OldBarrelTurn/10922.66667) < int(BarrelTurn/10922.66667))
		{
			BarrelTurn = int(BarrelTurn/10922.66667) * 10922.66667;
			BarrelSpeed = 0;
			PlaySound(BarrelStopSound, SLOT_None, 0.5, , 32, 1.0, true);
			AmbientSound = None;
		}
		CoolRate = default.CoolRate;
		bIsCharging = false;
	}
	else
	{
		CoolRate = default.CoolRate;
		bIsCharging = false;
	}
	if (BarrelSpeed > 0)
	{
		AmbientSound = BarrelSpinSound;
		SoundPitch = 32 + 96 * BarrelSpeed;
	}

	//if (ThirdPersonActor != None)
	//	XMV850MinigunAttachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;

    Heat = FMax(0, Heat - CoolRate*DT);
	
	super.Tick(DT);
}

simulated event WeaponTick (float DT)
{
	local rotator BT;

	BT.Roll = BarrelTurn;
	SetBoneRotation('BarrelArray', BT);

	super.WeaponTick(DT);
}

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

// Targeted hurt radius moved here to avoid crashing

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, optional Pawn ExcludedPawn )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry ) //not handled well...
		return;

	bHurtEntry = true;
	
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo') && (ExcludedPawn == None || Victims != ExcludedPawn))
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	bHurtEntry = false;
}


// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	B = Bot(Instigator.Controller);
	if (B != None)
	{
		if (CurrentWeaponMode != 2 && VSize(B.Enemy.Location - Instigator.Location) > 500)
			return 0;
		else if (CurrentWeaponMode != 3 && VSize(B.Enemy.Location - Instigator.Location) < 500)
			return 1;
	}

	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	if (Result < 0.34)
	{
		if (CurrentWeaponMode != 2)
		{
			CurrentWeaponMode = 2;
		}
	}

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

simulated function float ChargeBar()
{
    return FMin(LS440PrimaryFire(FireMode[1]).LaserCharge, LS440PrimaryFire(FireMode[1]).MaxCharge);
}

defaultproperties
{
     BarrelSpinSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelSpinLoop'
     BarrelStopSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStop'
     BarrelStartSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStart'
	 ChargeRate=2.400000
	 CoolRate=1.0
     bShowChargingBar=True
     PlayerSpeedFactor=1.000000
     PlayerJumpFactor=1.100000
     PutDownAnimRate=1.500000
     PutDownTime=1.000000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
     BigIconMaterial=Texture'BWBP_SKC_Tex.LS440M.BigIcon_LS440'
     //BallisticInventoryGroup=7
     bWT_Bullet=True
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     bWT_Energy=True
     bNoCrosshairInScope=true;
     RocketPackBone="RLPack"
     MiscBone1="RLFlap"
     MiscBone2="RocketOne"
     MiscBone3="RocketTwo"
     MiscBone4="RocketThree"
     SpecialInfo(0)=(Info="900.0;60.0;1.0;90.0;2.0;1.0;1.5")
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Select')
     PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Deselect')
     MagAmmo=100
     CockSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Cock')
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipIn')
     ClipInFrame=0.650000
     bNeedCock=True
     WeaponModes(0)=(ModeName="Semi-Auto")
     WeaponModes(1)=(ModeName="Burst",Value=3.000000)
     WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
     CurrentWeaponMode=2
     ScopeViewTex=Texture'BWBP_SKC_Tex.LS440M.LS440Scope'
     ZoomInSound=(Sound=ProceduralSound'WeaponSounds.PZoomIn1.P1ZoomIn1',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=ProceduralSound'WeaponSounds.PZoomOut1.P1ZoomOut1',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=5.000000
	 ZoomType=ZT_Logarithmic
     //bNoMeshInScope=True
     //SightPivot=(Pitch=600,Roll=-1024)
     SightOffset=(X=0.000000,Y=2.900000,Z=16.000000)
     //CrosshairCfg=(Pic1=Texture'BallisticUI2.Crosshairs.A73InA',pic2=Texture'BallisticUI2.Crosshairs.Misc5',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=255,R=255,A=192),Color2=(B=0,G=0,R=133,A=124),StartSize1=50,StartSize2=47)     GunLength=80.000000
     //CrouchAimFactor=0.600000
     //SprintOffSet=(Pitch=-1000,Yaw=-2048)
     //SprintChaos=1.000000
     //AimSpread=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000))
     //ViewAimFactor=0.250000
     //ViewRecoilFactor=0.550000
     //ChaosDeclineTime=1.500000
     //ChaosAimSpread=(X=(Min=-1250.000000,Max=1400.000000),Y=(Min=-1250.000000,Max=1400.000000))
     //RecoilYawFactor=0.100000
     //RecoilXFactor=0.700000
     //RecoilYFactor=0.700000
     //RecoilDeclineTime=1.000000
     ParamsClasses(0)=Class'LS440WeaponParamsClassic'
     ParamsClasses(1)=Class'LS440WeaponParamsClassic'
     FireModeClass(0)=Class'BWBP_SKC_Pro.LS440SecondaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.LS440PrimaryFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bSniping=True
     bNoMag=True
     Description="LS-440M Overcharged Laser Rifle||Manufacturer: UTC Defense Tech|Primary: Charged Photon Beam|Secondary: Rapid Photon Beam||The LS-440M is a specialized LS440 that has been upgraded by Nexron Defense to pierce Skrith energy armor through brute force, and as such has massively boosted energy levels. Power is provided by a heavy duty E-115 backpack, the same used on high output E-V and H-V plasma cannons. While the backpack hampers mobility, it gauarantees that users will not run out of power in a firefight. Caution: Due to the rifle's extreme power outputs, all LS-440Ms have safety systems on override. Full protective gear must be worn at all times, as the unshielded core vents can emit in excess of 3,000 rads."
     Priority=34
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     PickupClass=Class'BWBP_SKC_Pro.LS440Pickup'
     PlayerViewOffset=(X=5.000000,Y=10.000000,Z=-12.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBP_SKC_Pro.LS440Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.LS440M.SmallIcon_LS440'
     IconCoords=(X2=127,Y2=31)
     ItemName="[B] LS-440M Instagib Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_LS440'
     DrawScale=0.300000
     UsedAmbientSound=Sound'BW_Core_WeaponSound.M75.M75Hum'
     bFullVolume=True
     SoundVolume=255
     SoundRadius=256.000000
     //Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     //Skins(1)=Shader'BWBP_SKC_Tex.LS440M.LS440_SD'
     //Skins(2)=Combiner'BWBP_SKC_Tex.M30A2.M30A2-GunScope'
}
