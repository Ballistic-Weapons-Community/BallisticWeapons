//=============================================================================
// CX61 'Spectre' Assault Rifle
//
// Flamethrower / G28 gas sprayer.
//
// by Azarael
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//=============================================================================
class CX61AssaultRifle extends BallisticWeapon;

var   RX22ASpray		Flame;
var   CX61GasSpray 	GasSpray;
var 	float				StoredGas;

//can't seem to declare color literals
var array<Object.Color> ModeColors[2];

replication
{
	reliable if (Role == ROLE_Authority)
		StoredGas;
}

exec simulated function SwitchWeaponMode (optional byte NewMode)
{
	if (FireMode[1].bIsFiring || Flame != None || GasSpray != None)
		return;
	ServerSwitchWeaponMode(255);	
}

function ServerSwitchWeaponMode(byte NewMode)
{
    if (Firemode[1].bIsFiring || Flame != None || GasSpray != None)
        return;
	super.ServerSwitchWeaponMode(NewMode);
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

simulated event RenderOverlays(Canvas C)
{
	super.RenderOverlays(C);
	if (Flame != None)
	{
		Flame.SetLocation(ConvertFOVs(GetBoneCoords('tip2').Origin, DisplayFOV, Instigator.Controller.FovAngle, 32));
		Flame.SetRotation(rotator(Vector(GetAimPivot() + GetRecoilPivot()) >> GetPlayerAim()));
		C.DrawActor(Flame, false, false, Instigator.Controller.FovAngle);
	}
	
	else if (GasSpray != None)
	{
		GasSpray.SetLocation(ConvertFOVs(GetBoneCoords('tip2').Origin, DisplayFOV, Instigator.Controller.FovAngle, 32));
		GasSpray.SetRotation(rotator(Vector(GetAimPivot() + GetRecoilPivot()) >> GetPlayerAim()));
		C.DrawActor(GasSpray, false, false, Instigator.Controller.FovAngle);
	}
}

simulated function WeaponTick (float DT)
{
	super.WeaponTick(DT);

	if (ThirdPersonActor != None && !Instigator.IsFirstPerson() && AIController(Instigator.Controller) == None)
	{
		if (Flame != None)
		{
			Flame.SetLocation(CX61Attachment(ThirdPersonActor).GetAltTipLocation());
			Flame.SetRotation(rotator(Vector(GetAimPivot() + GetRecoilPivot()) >> GetPlayerAim()));
		}
		if (GasSpray != None)
		{
			GasSpray.SetLocation(CX61Attachment(ThirdPersonActor).GetAltTipLocation());
			GasSpray.SetRotation(rotator(Vector(GetAimPivot() + GetRecoilPivot()) >> GetPlayerAim()));
		}
	}
}

//Draw special weapon info on the hud
simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;

	Super(Weapon).NewDrawWeaponInfo (C, YPos);
	
	DrawCrosshairs(C);
	
	if (bSkipDrawWeaponInfo)
		return;

	ScaleFactor = C.ClipX / 1600;
	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		Temp = GetHUDAmmoText(1);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.DrawColor = ModeColors[CurrentWeaponMode];
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 130 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
		C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}

	// This is pretty damn disgusting, but the weapon seems to be the only way we can draw extra info on the HUD
	// Would be nice if someone could have a HUD function called along the inventory chain
	if (SprintControl != None && SprintControl.Stamina < SprintControl.MaxStamina)
	{
		SprintFactor = SprintControl.Stamina / SprintControl.MaxStamina;
		C.CurX = C.OrgX  + 5    * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 330  * ScaleFactor * class'HUD'.default.HudScale;
		if (SprintFactor < 0.2)
			C.SetDrawColor(255, 0, 0);
		else if (SprintFactor < 0.5)
			C.SetDrawColor(64, 128, 255);
		else
			C.SetDrawColor(0, 0, 255);
		C.DrawTile(Texture'Engine.MenuWhite', 200 * ScaleFactor * class'HUD'.default.HudScale * SprintFactor, 30 * ScaleFactor * class'HUD'.default.HudScale, 0, 0, 1, 1);
	}
}

simulated event Tick (float DT)
{
	super.Tick(DT);
	if (StoredGas < default.StoredGas && ( FireMode[1]==None || !FireMode[1].IsFiring() ))
		StoredGas = FMin(default.StoredGas, StoredGas + (DT / 20));
}

simulated event Destroyed()
{
	if (Flame != None)
		Flame.bHidden=false;
	if (GasSpray != None)
		GasSpray.bHidden=false;
	super.Destroyed();
}

simulated function float ChargeBar()
{
	return StoredGas;
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_CX61Mag';
}

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	super.PlayReload();
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
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

	Result = Super.GetAIRating();
	if (Dist > 700)
		Result += 0.3;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.05 * B.Skill;
	if (Dist > 2000)
		Result -= (Dist-2000) / 4000;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     StoredGas=1.000000
     ModeColors(0)=(B=210,G=210,R=75,A=255)
     ModeColors(1)=(G=100,R=255,A=255)
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBPOtherPackTex.CX61.BigIcon_CX61'
     BigIconCoords=(Y1=12,Y2=230)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     bWT_Heal=True
     ManualLines(0)="Automatic fire. Lowest per-shot damage of all weapons in its class, but solid fire rate and sustained damage output. Recoil is similarly low. Hip effective."
     ManualLines(1)="Flamethrower mode launches a stream of fire, dealing minor damage to enemies and causing disorientation.|Healing Gas mode sprays G28 gas, granting health to allies."
     ManualLines(2)="It is recommended to check which mode of the CX is active before engaging the altfire. Burning allies or healing enemies is not conducive to survival.||The CX61 is effective at close to medium range."
     SpecialInfo(0)=(Info="240.0;25.0;0.8;90.0;0.0;1.0;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
     MagAmmo=40
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'BallisticSounds3.SAR.SAR-Cock')
     ReloadAnimRate=1.100000
     ClipOutSound=(Sound=Sound'BallisticSounds3.SAR.SAR-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds3.SAR.SAR-ClipIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Healing Gas",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Flamethrower",ModeID="WM_FullAuto")
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bNotifyModeSwitch=True
     bNoCrosshairInScope=True
     SightPivot=(Pitch=600)
     SightOffset=(X=6.000000,Y=-0.350000,Z=22.799999)
     SightDisplayFOV=25.000000
     GunLength=16.000000
     SightAimFactor=0.200000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
     AimAdjustTime=0.400000
     AimSpread=16
     ChaosDeclineTime=1.250000
     ChaosSpeedThreshold=15000.000000
     ChaosAimSpread=3072
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.060000),(InVal=0.400000,OutVal=0.110000),(InVal=0.500000,OutVal=-0.120000),(InVal=0.600000,OutVal=0.130000),(InVal=0.800000,OutVal=0.160000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.190000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.135000
     FireModeClass(0)=Class'BWBPOtherPackPro.CX61PrimaryFire'
     FireModeClass(1)=Class'BWBPOtherPackPro.CX61SecondaryFire'
     SelectAnimRate=1.400000
     PutDownAnimRate=1.500000
     PutDownTime=0.400000
     BringUpTime=0.400000
     SelectForce="SwitchToAssaultRifle"
     bShowChargingBar=True
     Description="Cimerion Labs' CX61 Tactical Rifle was engineered as a reliable primary weapon for use by medical personnel. Incorporating a nano-forge capable of producing G28 aerosol for projection by the weapon, it is able to choose between projecting healing spray or igniting the G28 gas in order to emit a blast of flame to disorient foes."
     DisplayFOV=55.000000
     Priority=32
     HudColor=(B=168,G=111,R=83)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     GroupOffset=9
     PickupClass=Class'BWBPOtherPackPro.CX61Pickup'
     PlayerViewOffset=(X=-3.000000,Y=7.000000,Z=-13.500000)
     AttachmentClass=Class'BWBPOtherPackPro.CX61Attachment'
     IconMaterial=Texture'BWBPOtherPackTex.CX61.Icon_CX61'
     IconCoords=(X2=127,Y2=31)
     ItemName="CX61 Tactical Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=130.000000
     LightRadius=3.000000
     Mesh=SkeletalMesh'BWBPOtherPackAnim.CX61_FP'
     DrawScale=0.300000
}
