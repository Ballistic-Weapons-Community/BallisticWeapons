class R9A1RangerRifle extends BallisticWeapon;

#exec OBJ LOAD File=BWBP_OP_Tex.utx

var float LastModeChangeTime;

var rotator ScopeSightPivot;
var vector ScopeSightOffset;

var rotator IronSightPivot;
var vector IronSightOffset;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (CurrentWeaponMode == 2)
	{
		SetBoneScale(0, 1, 'LaserMag');
		SetBoneScale(1, 0, 'BulletMag');
	}
	else
	{
		SetBoneScale(0, 0, 'LaserMag');
		SetBoneScale(1, 1, 'BulletMag');
	}
}

//===========================================================================
// Roll switch
//===========================================================================

function ServerSwitchWeaponMode (byte NewMode)
{
	local int m;
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (NewMode == 255)
		NewMode = CurrentWeaponMode + 1;
	if (NewMode == CurrentWeaponMode)
		return;
	
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}

	if (!WeaponModes[NewMode].bUnavailable)
	{
		CommonSwitchWeaponMode(NewMode);
		ClientSwitchWeaponMode(CurrentWeaponMode);
		NetUpdateTime = Level.TimeSeconds - 1;
	}
	
	R9A1Attachment(ThirdPersonActor).CurrentTracerMode = CurrentWeaponMode;
		
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;

	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');

	CommonStartReload(0);	//Server animation
	ClientStartReload(0);	//Client animation
}

exec simulated function SwitchWeaponMode (optional byte ModeNum)	
{
	if (ClientState == WS_PutDown || ClientState == WS_Hidden || ReloadState != RS_None)
		return;
	bRedirectSwitchToFiremode=True;
	PendingMode = CurrentWeaponMode;
}

exec simulated function WeaponModeRelease()
{
	bRedirectSwitchToFiremode=False;
	ServerSwitchWeaponMode(PendingMode);
	CurrentWeaponMode = PendingMode;
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (bRedirectSwitchToFiremode)
	{
		PendingMode--;
		if (PendingMode >= WeaponModes.Length)
			PendingMode = WeaponModes.Length-1;
		return None;
	}

	return Super.PrevWeapon(CurrentChoice, CurrentWeapon);
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (bRedirectSwitchToFiremode)
	{
		PendingMode++;
		if (PendingMode >= WeaponModes.Length)
			PendingMode = 0;
		return None;
	}

	return Super.NextWeapon(CurrentChoice, CurrentWeapon);
}

simulated function bool PutDown()
{
	if (Instigator.IsLocallyControlled())
	{
		bRedirectSwitchToFiremode = False;
		PendingMode = CurrentWeaponMode;
	}
	
	return Super.PutDown();
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;
	local int i;
	local byte StartMode;

	Super(Weapon).NewDrawWeaponInfo (C, YPos);
	
	DrawCrosshairs(C);
	
	if (bSkipDrawWeaponInfo)
		return;

	ScaleFactor = C.ClipX / 1600;  // C.ClipY / 900 is correct...
	
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	Temp = string(Ammo[0].AmmoAmount);

	C.TextSize(Temp, XL, YL);

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		if (!bRedirectSwitchToFiremode)
		{
			// Draw the spare ammo amount
			if (Temp == "0")
				C.DrawColor = class'hud'.default.RedColor;
			C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
			C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
			C.DrawText(Temp, false);
			C.DrawColor = class'hud'.default.WhiteColor;
	
			C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
			C.TextSize(WeaponModes[CurrentWeaponMode].ModeName , XL, YL2);
			C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
			C.CurY = C.ClipY - (130 * ScaleFactor * class'HUD'.default.HudScale) - YL2 - YL;
			C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
		}
		
		else
		{
			StartMode = PendingMode - 2;
			if (StartMode >= WeaponModes.Length)
				StartMode = (WeaponModes.Length-1) - (255 - StartMode);
				
				//case -2: desire 3
				//case -1: desire 2
				//case 0: desire 1
				//case 1: desire 0
				//case 2: desire -1
				
				
			for (i=-2; i<3; i++)
			{
				if (i != 0)
					C.SetDrawColor(255,128,128,255 - (75 * Abs(i)));
				else C.SetDrawColor(255,255,255,255);
				C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
				C.TextSize(WeaponModes[StartMode].ModeName, XL, YL2);
				C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
				C.CurY = C.ClipY - (130 * ScaleFactor * class'HUD'.default.HudScale) - (YL2 * (-i +1)) - YL;
				C.DrawText(WeaponModes[StartMode].ModeName, false);
				
				StartMode++;
				if (StartMode >= WeaponModes.Length)
					StartMode = 0;
			}
		}
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
//===========================================================================
// Dual scoping
//===========================================================================
exec simulated function ScopeView()
{
	if (ZoomType == ZT_Fixed && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		if (ZoomType == ZT_Fixed)
		{
			SightPivot = IronSightPivot;
			SightOffset = IronSightOffset;
			ZoomType = ZT_Irons;
			ScopeViewTex = None;
			SightingTime = default.SightingTime;
		}
	}
	
	Super.ScopeView();
}

exec simulated function ScopeViewRelease()
{
	if (ZoomType != ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

simulated function ScopeViewTwo()
{
	if (ZoomType == ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		switch(CurrentWeaponMode)
		{
			case 1: ScopeViewTex = FinalBlend'BWBP_OP_Tex.R9A1.R9_scope_UI_FB1'; break;
			case 2: ScopeViewTex = FinalBlend'BWBP_OP_Tex.R9A1.R9_scope_UI_FB2'; break;
			default: ScopeViewTex = Texture'BWBP_OP_Tex.R9A1.R9_scope_UI_DO1';
		}
		
		if (ZoomType == ZT_Irons)
		{
			SightPivot = ScopeSightPivot;
			SightOffset = ScopeSightOffset;
			ZoomType = ZT_Fixed;
			MaxZoom = 4;
			SightingTime = 0.4;
		}
	}
	
	Super.ScopeView();
}

simulated function ScopeViewTwoRelease()
{
	if (ZoomType == ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

// Swap sighted offset and pivot for left handers
simulated function SetHand(float InHand)
{
	IronSightPivot = default.SightPivot;
	IronSightOffset = default.SightOffset;

	super.SetHand(InHand);
	if (Hand < 0)
	{
		if (ZoomType != ZT_Irons)
		{
			ScopeSightOffset.Y = ScopeSightOffset.Y * -1;
			ScopeSightPivot.Roll = ScopeSightPivot.Roll * -1;
			ScopeSightPivot.Yaw = ScopeSightPivot.Yaw * -1;
		}
		else
		{
			IronSightOffset.Y = IronSightOffset.Y * -1;
			IronSightPivot.Roll = IronSightPivot.Roll * -1;
			IronSightPivot.Yaw = IronSightPivot.Yaw * -1;
		}
	}
}
//===========================================================================
// Mode Switch
//===========================================================================
simulated function Notify_MagDown()
{
	if (CurrentWeaponMode == 2)
	{
		SetBoneScale(0, 1, 'LaserMag');
		SetBoneScale(1, 0, 'BulletMag');
	}
	else
	{
		SetBoneScale(0, 0, 'LaserMag');
		SetBoneScale(1, 1, 'BulletMag');
	}
}

// See if firing modes will let us fire another round or not
simulated function bool CheckWeaponMode (int Mode)
{
	if (WeaponModes[CurrentWeaponMode].ModeID ~= "WM_FullAuto" || WeaponModes[CurrentWeaponMode].ModeID ~= "WM_None")
		return true;
	if ((Mode == 0 && FireCount >= WeaponModes[CurrentWeaponMode].Value) || (Mode == 1 && FireCount >= 2))
		return false;
	return true;
}

//===========================================================================
// ManageHeatInteraction
//
// Called from primary fire when hitting a target. Objects don't like having iterators used within them
// and may crash servers otherwise.
//===========================================================================
function int ManageHeatInteraction(Pawn P, int HeatPerShot)
{
	local R9A1HeatManager HM;
	local int HeatBonus;
	
	foreach P.BasedActors(class'R9A1HeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'R9A1HeatManager',P,,P.Location + vect(0,0,-30));
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
function byte BestMode()
{
	local Bot B;
	local R9HeatManager HM;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return 0;
		
	if (level.TimeSeconds - LastModeChangeTime < 1.4 - B.Skill*0.1)
		return 0;
		
		
	Dist = VSize(Instigator.Location - B.Enemy.Location);
	
	foreach B.Enemy.BasedActors(class'R9HeatManager', HM)
		break;
		
	if (HM != None || B.Enemy.Health + B.Enemy.ShieldStrength > 200)
	{
		if (CurrentWeaponMode != 2)
		{
			CurrentWeaponMode = 2;
			R9PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}
	
	else if (CurrentWeaponMode != 0)
	{
		CurrentWeaponMode = 0;
		R9PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
	}
	
	LastModeChangeTime = level.TimeSeconds;

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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 2048, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.7;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.7;	}
// End AI Stuff =====

defaultproperties
{
	SightPivot=(Roll=11800)
	SightOffset=(X=0.000000,Y=0.60000,Z=7.92)

	ScopeSightPivot=(Pitch=50)
	ScopeSightOffset=(X=4,Z=9.5)

	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_OP_Tex.R9A1.BigIcon_R9A1'
	
	bWT_Bullet=True
	ManualLines(0)="Semi-automatic, long-range, moderate recoil rifle fire with three choices of ammunition, switched between using the fire mode function.||Standard rounds inflict good damage with high penetration.||Freeze rounds inflict lower damage, but progressively slow struck targets.||Heat Ray shots inflict low initial damage, but heat up the target, causing subsequent shots to inflict more damage. This effect wears off over time."
	ManualLines(1)="Raises the scope."
	ManualLines(2)="The R9A1 has both a scope (secondary fire) and iron sights (normal key).||Modes are switched by holding the Fire Mode key and then scrolling the mouse.||Effective at long range and against enemies making use of healing items and weapons."
	SpecialInfo(0)=(Info="240.0;25.0;0.5;50.0;1.0;0.2;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Cock')
	ReloadAnimRate=1.250000
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Regular")
	WeaponModes(1)=(ModeName="Freeze",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(2)=(ModeName="Heat Ray",ModeID="WM_SemiAuto",Value=1.000000)
	CurrentWeaponMode=0
	FullZoomFOV=25.000000
	bNoCrosshairInScope=True
	GunLength=80.000000
	ParamsClasses(0)=Class'R9A1WeaponParamsComp'
	ParamsClasses(1)=Class'R9A1WeaponParamsClassic'
	ParamsClasses(2)=Class'R9A1WeaponParamsRealistic'
    ParamsClasses(3)=Class'R9A1WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_OP_Pro.R9A1PrimaryFire'
	FireModeClass(1)=Class'BWBP_OP_Pro.R9A1ScopeFire'
	SightingTime=0.4
	SightBobScale=0.2
	SelectAnimRate=1.100000
	BringUpTime=0.400000
	SelectForce="SwitchToAssaultRifle"
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc6',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.R78InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=206,G=0,R=0,A=152),Color2=(B=0,G=0,R=0,A=194),StartSize1=132,StartSize2=115)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	AIRating=0.800000
	CurrentRating=0.800000
	Description="Outstanding reliability and durability in the field are what characterise one of Black & Wood's legendary rifles. Though not widely used by most military forces, the R9 is renowned for its near indestructable design, and superb reliability. Those who use the weapon, mostly snipers, hunters, and specialised squads, swear by it's accuracy and dependability. Often used without fancy features or burdening devices such as optical scopes and similar attachements, the R9 is a true legend with it's users."
	Priority=33
	HudColor=(G=175)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	GroupOffset=3
	PickupClass=Class'BWBP_OP_Pro.R9A1Pickup'
	PlayerViewOffset=(X=12,Y=9.00000,Z=-12.000000)
	AttachmentClass=Class'BWBP_OP_Pro.R9A1Attachment'
	IconMaterial=Texture'BWBP_OP_Tex.R9A1.SmallIcon_R9A1'
	IconCoords=(X2=127,Y2=31)
	ItemName="R9A1 Ranger Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_R9A1'
	DrawScale=0.500000
	SightAnimScale=0.25
}
