class MX32Weapon extends BallisticWeapon;

var() name			RocketsLoadAnim;	//Anim for rocket reload

var() Sound			GrenOpenSound;		//Sounds for rocket reloading
var() Sound			GrenLoadSound;		//
var() Sound			GrenCloseSound;		//

var   bool			bLaserOn;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;
var   LaserActor_G5Painter	Laser;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
	unreliable if (ROLE == Role_Authority)
		ClientRocketsPickedUp; 
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != default.bLaserOn)
	{
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerWeaponSpecial(optional byte i)
{
	if (bServerReloading)
		return;
	ServerSwitchLaser(!bLaserOn);
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;

	if (ThirdPersonActor!=None)
		MX32Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
		
	MX32SecondaryFire(FireMode[1]).AdjustLaserParams(bLaserOn);

	if (bLaserOn)
	{
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=false;
		CurrentWeaponMode=1;
		ServerSwitchWeaponMode(1);
	}
	else
	{
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		CurrentWeaponMode=0;
		ServerSwitchWeaponMode(0);		
	}

    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (bLaserOn)
	{
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=false;
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
	}
	
	MX32SecondaryFire(FireMode[1]).AdjustLaserParams(bLaserOn);
	
	PlayIdle();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_G5Painter');
		
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
		
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if ( ThirdPersonActor != None )
		MX32Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'G5LaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			MX32Attachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	Super.Destroyed();
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || (!bLaserOn) || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = class'BUtil'.static.ConvertFOVs(Instigator.Location + Instigator.EyePosition(), Instigator.GetViewRotation(), End, Instigator.Controller.FovAngle, DisplayFOV, 400);

	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}

// Notifys for greande loading sounds
simulated function Notify_M50GrenadeSlideUp()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_M50GrenadeIn()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);		}
simulated function Notify_M50GrenadeSlideDown()	
{	
	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64);
	if (Ammo[1].AmmoAmount < MX32SecondaryFire(FireMode[1]).default.Rockets)
		MX32SecondaryFire(FireMode[1]).Rockets = Ammo[1].AmmoAmount;
	else
		MX32SecondaryFire(FireMode[1]).Rockets = MX32SecondaryFire(FireMode[1]).default.Rockets;
}

// Rockets have just been picked up. Loads one in if we're empty
function RocketsPickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadRockets();
		else
		{
			if (Ammo[1].AmmoAmount < MX32SecondaryFire(FireMode[1]).default.Rockets)
				MX32SecondaryFire(FireMode[1]).Rockets = Ammo[1].AmmoAmount;
			else
				MX32SecondaryFire(FireMode[1]).Rockets = MX32SecondaryFire(FireMode[1]).default.Rockets;
		}
	}
	if (!Instigator.IsLocallyControlled())
		ClientRocketsPickedUp();
}

simulated function ClientRocketsPickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadRockets();
		else
		{
			if (Ammo[1].AmmoAmount < MX32SecondaryFire(FireMode[1]).default.Rockets)
				MX32SecondaryFire(FireMode[1]).Rockets = Ammo[1].AmmoAmount;
			else
				MX32SecondaryFire(FireMode[1]).Rockets = MX32SecondaryFire(FireMode[1]).default.Rockets;
		}
	}
}
simulated function bool AreRocketsLoaded()
{
	if (MX32SecondaryFire(FireMode[1]).Rockets > 0)
		return true;
	else 
		return false;
}

function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_MX32Rockets(Ammo[1]) != None)
		Ammo_MX32Rockets(Ammo[1]).Gun = self;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == RocketsLoadAnim)
	{
		ReloadState = RS_None;
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
		
	Super.AnimEnd(Channel);
}
// Load in rockets
//if reserve ammo is above mag size, just need to check if the number of rockets is below the default
//if reserve ammo is less or equal to mag size, check if the number of rockets is below the reserve ammo

simulated function LoadRockets()
{
	if (Ammo[1].AmmoAmount > MX32SecondaryFire(FireMode[1]).default.Rockets && MX32SecondaryFire(FireMode[1]).Rockets >= MX32SecondaryFire(FireMode[1]).default.Rockets)
		return;
		
	if (Ammo[1].AmmoAmount <= MX32SecondaryFire(FireMode[1]).default.Rockets && MX32SecondaryFire(FireMode[1]).Rockets >= Ammo[1].AmmoAmount)
		return;
		
	if (ReloadState == RS_None)
	{
		ReloadState = RS_Cocking;
		PlayAnim(RocketsLoadAnim, 0.75, , 0);
	}		
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;

	GetAnimParams(channel, seq, frame, rate);
	
	if (seq == RocketsLoadAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingRockets())
		{
			LoadRockets();
			ClientStartReload(1);
		}
		return;
	}
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
		{
			if (AmmoAmount(1) > 0 && !IsReloadingRockets())
				LoadRockets();
		}
		else
			CommonStartReload(i);
	}
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return FireCount < 18;
	return super.CheckWeaponMode(Mode);
}

function bool BotShouldReloadRockets ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !AreRocketsLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadRockets() && !IsReloadingRockets())
		LoadRockets();
}

function vector GetRocketDir()
{	
	local vector Start, End, HitLocation, HitNormal, AimDir;
	local Actor Other;
	
	AimDir = BallisticFire(FireMode[0]).GetFireDir(Start);

	End = Start + Normal(AimDir)*10000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	HitLocation = End;
	
	return HitLocation;
}

//Show little tiny rockets
simulated function DrawWeaponInfo(Canvas C)
{
	NewDrawWeaponInfo(C, 0.705*C.ClipY);
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float ScaleFactor2;

	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;

	Super.NewDrawWeaponInfo (C, YPos);
	
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
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		Temp = GetHUDAmmoText(1);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 130 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
		C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
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

	ScaleFactor2 = 85 * C.ClipX/3200;
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;


	Count = Min(18,MX32SecondaryFire(FireMode[1]).Rockets);

    for( i=0; i<Count; i++ )
    {
		C.SetPos(C.ClipX - (0.22*i+1) * ScaleFactor2, C.ClipY - 100 * ScaleFactor * class'HUD'.default.HudScale);
		C.DrawTile(Texture'BWBP_SKC_Tex.LS14.LS14-RocketIcon', ScaleFactor2, ScaleFactor2, 0, 0, 128, 128);
	}
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
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || !AreRocketsLoaded())
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for Rockets
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	// Too close for Rockets
	if (Dist < 500 &&  VDot > 0.3)
		result -= (500-Dist) / 1000;
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
	// Improve Rockets acording to height, but temper using horizontal distance (bots really like Rockets when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

simulated function bool IsReloadingRockets()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == RocketsLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!AreRocketsLoaded())
	{
		if (IsReloadingRockets())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadRockets())
		{
			LoadRockets();
			return false;
		}
	}
	return super.CanAttack(Other);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.75, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.0;	}

// End AI Stuff =====

defaultproperties
{
	 LaserOnSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
     LaserOffSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	 RocketsLoadAnim="RocketReload"
	 GrenOpenSound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOff'
     GrenLoadSound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn'
     GrenCloseSound=Sound'BW_Core_WeaponSound.A73.A73-PipeIn'
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_OP_Tex.MX32.BigIcon_MX32'
     BigIconCoords=(Y1=40,Y2=235)
     
     bWT_Bullet=True
     bWT_Splash=True
     bWT_Machinegun=True
     bWT_Projectile=True
     ManualLines(0)="Automatic 5.56 bullet fire. Low damage per shot with medium range, low penetration and medium recoil."
     ManualLines(1)="Fires a gas-powered rocket barrage, with heavy inaccuracy and recoil with repeated shots."
     ManualLines(2)="Activates a guiding laser, which stabilises secondary fire and directs rockets. Suitable for further distances."
     SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;2.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'BWBP_OP_Sounds.MX32.MX32-Cock',Volume=1.350000)
	 ClipHitSound=(Sound=Sound'BWBP_OP_Sounds.MX32.MX32-MagHit',Volume=1.350000)
	 ClipOutSound=(Sound=Sound'BWBP_OP_Sounds.MX32.MX32-MagOut',Volume=1.350000)
	 ClipInSound=(Sound=Sound'BWBP_OP_Sounds.MX32.MX32-MagIn',Volume=1.350000)
     ClipInFrame=0.650000
     bNoCrosshairInScope=True
     SightOffset=(X=0,Y=0,Z=1.72)
	 SightBobScale=0.3
     FireModeClass(0)=Class'BWBP_OP_Pro.MX32PrimaryFire'
     FireModeClass(1)=Class'BWBP_OP_Pro.MX32SecondaryFire'
	 WeaponModes(0)=(ModeName="Auto Rockets",ModeID="WM_FullAuto")
	 WeaponModes(1)=(ModeName="Guided Rockets",ModeID="WM_FullAuto",bUnavailable=true)
	 WeaponModes(2)=(bUnavailable=true)
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.G5OutA',pic2=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',USize1=256,VSize1=256,USize2=128,VSize2=128,Color1=(B=255,G=255,R=255,A=255),Color2=(B=0,G=0,R=255,A=255),StartSize1=110,StartSize2=30)
	 CurrentWeaponMode=0
	 ParamsClasses(0)=Class'MX32WeaponParamsComp'
	 ParamsClasses(1)=Class'MX32WeaponParamsClassic'
	 ParamsClasses(2)=Class'MX32WeaponParamsRealistic'
     ParamsClasses(3)=Class'MX32WeaponParamsTactical'
	 MagAmmo=50
     PutDownAnimRate=1.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="In the ongoing efforts of the Anti-Krao Buster Movement, several weapons have entered the foray but nothing quite like the MX32 Rocket Machinegun.  Originally designed for geneboosted soldiers and light mech units, the MX32 is a behemoth of a weapon, able to decimate hordes of Krao with it’s signature rocket barrage especially when paired with its guiding laser. Due to weight issues and lack of options when in close quarters, newer models have lighter materials and the ability to shoot low caliber bullets when things are danger close."
	 Priority=41
     HudColor=(B=170,G=170,R=210)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     GroupOffset=7
     PickupClass=Class'BWBP_OP_Pro.MX32Pickup'
     PlayerViewOffset=(X=10.00,Y=4.50,Z=-3.50)
     AttachmentClass=Class'BWBP_OP_Pro.MX32Attachment'
     IconMaterial=Texture'BWBP_OP_Tex.MX32.SmallIcon_MX32'
     IconCoords=(X2=127,Y2=28)
     ItemName="MX-32 Rocket Machine Gun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_MX32'
     DrawScale=0.300000
	 SightAnimScale=0.5
}
