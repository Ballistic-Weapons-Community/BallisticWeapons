//=============================================================================
// CYLOUAW.
//
// CYLO Versitile Urban Assault Weapon.
//
// This nasty little gun has all sorts of tricks up its sleeve. Primary fire is
// a somewhat unreliable assault rifle with random fire rate and a chance to jam.
// Secondary fire is a semi-auto shotgun with its own magazine system. Special
// fire utilizes the bayonet in an attack by modifying properties of primary fire
// when activated.
//
// The gun is small enough to allow dual wielding, but because the left hand is
// occupied with the other gun, the shotgun can not be used, so that attack is
// swapped with a melee attack.
//
// by Casey 'Xavious' Johnson, Marc 'Sergeant Kelly' and Azarael
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// notes for spinny firerate changes are: weapon line 61, weapon line 282, secondary fire line 173
//=============================================================================
class ZX98AssaultRifle extends BallisticWeapon;

var   float DesiredSpeed, BarrelSpeed;
var   int	BarrelTurn;
var() Sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;

var float		RotationSpeeds[3];

var   sound		MeleeFireSound;

replication
{
	reliable if (Role < ROLE_Authority)
		SetServerTurnVelocity;
}

function SetServerTurnVelocity (int NewTVYaw, int NewTVPitch)
{
	ZX98PrimaryFire(FireMode[0]).TurnVelocity.Yaw = NewTVYaw;
	ZX98PrimaryFire(FireMode[0]).TurnVelocity.Pitch = NewTVPitch;
	
	ZX98SecondaryFire(FireMode[1]).TurnVelocity.Yaw = NewTVYaw;
	ZX98SecondaryFire(FireMode[1]).TurnVelocity.Pitch = NewTVPitch;
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	ZX98PrimaryFire(FireMode[0]).ZX98Weapon = self;
	ZX98SecondaryFire(FireMode[1]).ZX98Weapon = self;
}

simulated function float GetRampUpSpeed()
{
	local float mult;
	
	mult = 1 - (BarrelSpeed / RotationSpeeds[2]);
	
	return 0.075f + (0.07f * mult * mult);	//change 0.07f here to increase/decrease rotation acceleration. higher values = faster accel
}

simulated event WeaponTick (float DT)
{
	local rotator BT;

	BT.Roll = BarrelTurn;

	SetBoneRotation('RotatingBarrel', BT);

	DesiredSpeed = RotationSpeeds[CurrentWeaponMode];

	super.WeaponTick(DT);
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		Instigator.AmbientSound = None;
		BarrelSpeed = 0;
		return true;
	}
	return false;
}

simulated event Tick (float DT)
{
	local float OldBarrelTurn;

	super.Tick(DT);

	if ((FireMode[0].IsFiring() || (FireMode[1].IsFiring() && FireCount <= 0)) && !bServerReloading)
	{
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.35*DT, GetRampUpSpeed() *DT);
		BarrelTurn += BarrelSpeed * 655360 * DT;
	}
	else if (BarrelSpeed > 0)
	{
		BarrelSpeed = FMax(BarrelSpeed-0.5*DT, 0.01);
		OldBarrelTurn = BarrelTurn;
		BarrelTurn += BarrelSpeed * 655360 * DT;
		if (BarrelSpeed <= 0.025 && int(OldBarrelTurn/10922.66667) < int(BarrelTurn/10922.66667))
		{
			BarrelTurn = int(BarrelTurn/10922.66667) * 10922.66667;
			BarrelSpeed = 0;
			PlaySound(BarrelStopSound, SLOT_None, 0.5, , 32, 1.0, true);
			Instigator.AmbientSound = None;
		}
	}
	if (BarrelSpeed > 0)
	{
		Instigator.AmbientSound = BarrelSpinSound;
		Instigator.SoundPitch = 32 + 96 * BarrelSpeed;
	}

	if (ThirdPersonActor != None)
		ZX98Attachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;
}

/*simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode > 0 && FireCount >= 1)
		return false;
		
	return super.CheckWeaponMode(Mode);
}*/

function ServerSwitchWeaponMode (byte NewMode)
{
	if (NewMode == 255)
		NewMode = CurrentWeaponMode + 1;
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}
	if (!WeaponModes[NewMode].bUnavailable)
		CurrentWeaponMode = NewMode;
}

simulated function float ChargeBar()
{
     return BarrelSpeed / DesiredSpeed;
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
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

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticProInstantFire(BFireMode[0]).DecayRange.Min, BallisticProInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     BarrelSpinSound=Sound'IndoorAmbience.Machinery14'
     BarrelStopSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStop'
     BarrelStartSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStart'
	 TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_CC_Tex.AR.ARBigIcon'
     BigIconCoords=(X1=16,Y1=30)
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Automatic fire. Moderate power, fire rate and recoil."
     ManualLines(1)="Automatic Gauss fire. High Power, Slower fire rate and Lower recoil."
     ManualLines(2)="Effective at medium range."
     SpecialInfo(0)=(Info="240.0;25.0;0.9;85.0;0.1;0.9;0.4")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
     CockAnimPostReload="Cock"
     CockAnimRate=1.400000
     CockSound=(Sound=Sound'BWBP_CC_Sounds.ZX98.ZX98-Cock')
     ClipHitSound=(Sound=Sound'BWBP_CC_Sounds.ZX98.ZX98-ClipHit')
     ClipOutSound=(Sound=Sound'BWBP_CC_Sounds.ZX98.ZX98-ClipOut')
     ClipInSound=(Sound=Sound'BWBP_CC_Sounds.ZX98.ZX98-ClipIn')
     ClipInFrame=0.700000
     bAltTriggerReload=True
	 bShowChargingBar=True
	 
	 WeaponModes(0)=(ModeName="600 RPM",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="1200 RPM",ModeID="WM_FullAuto",bUnavailable=True)
     WeaponModes(2)=(ModeName="1800 RPM",ModeID="WM_FullAuto",bUnavailable=True)
	 
	 // originally XMV is 1200 RPM on its base firemode, so its rotation speed is 0.33. (3600 RPM = 1.00 rot speed)
	 // so divide desired RPM by 3600 to get rot speed
	 RotationSpeeds(0)=0.17 // 612 RPM
	 RotationSpeeds(1)=0.34 // 1224 RPM
	 RotationSpeeds(2)=0.51 // 1836 RPM
	 NDCrosshairCfg=(Pic1=TexRotator'BW_Core_WeaponTex.NovaStaff.NovaOutA-Rot',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.R78InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=200,R=0,A=255),Color2=(B=48,G=46,R=42,A=130),StartSize1=61,StartSize2=120)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	 CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightPivot=(Pitch=64)
     SightOffset=(X=-10.000000,Y=-0.500000,Z=12.500000)
     GunLength=16.000000
	 SightFXClass=Class'BWBP_APC_Pro.ZX98SightLEDs'
	 ScopeViewTex=Texture'BWBP_CC_Tex.AR.M30A1-Scope'
     FireModeClass(0)=Class'BWBP_APC_Pro.ZX98PrimaryFire'
     FireModeClass(1)=Class'BWBP_APC_Pro.ZX98SecondaryFire'
     SelectAnimRate=1.000000
     PutDownAnimRate=1.600000
     PutDownTime=0.330000
     BringUpTime=0.450000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
     Description="In the field of gauss weaponry, things are rapidly evolving to deal with growing threats like Cryons and heavily armored Skrith. Though precision weapons do help, in the frontlines, there hasn't been anything to deal with close range enemies until now.  The ZX-98 Combat Gauss Rifle is a new development, firing 7.62 rounds continuously through a gauss battery which has been made to stand up to full auto fire without overheating. Nicknamed the 'Reaper' for it's demonic appearance and it's prowess to take the lives of those who stand on the wrong end, this gauss combat rifle is ready to defend from any threat."
     DisplayFOV=55.000000
     Priority=41
     HudColor=(B=25,G=150,R=50)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     GroupOffset=10
     PickupClass=Class'BWBP_APC_Pro.ZX98Pickup'
     PlayerViewOffset=(X=7.000000,Y=5.000000,Z=-10.500000)
     BobDamping=2.250000
     AttachmentClass=Class'BWBP_APC_Pro.ZX98Attachment'
     IconMaterial=Texture'BWBP_CC_Tex.AR.ARSmallIcon'
     IconCoords=(X2=127,Y2=31)
     ItemName="ZX-98 Reaper Gauss Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClasses(0)=Class'ZX98WeaponParamsArena'
	 ParamsClasses(1)=Class'ZX98WeaponParamsClassic'
	 ParamsClasses(2)=Class'ZX98WeaponParamsRealistic'
     Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_ZX98'
     DrawScale=0.200000
}
