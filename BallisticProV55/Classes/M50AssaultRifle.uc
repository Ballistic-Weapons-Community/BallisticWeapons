//=============================================================================
// M50AssaultRifle.
//
// M50 Assault Rifle, aka the Reaper. High fire rate, good damage, good accuracy, good range, FullAuto, Burst, Semi-Auto
// Has grenade launcher secondary.
// Weapon special deploys a camera on the wall, then press to switch between play and cam view. Get camera back by
// moving near it, and pressing Use.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50AssaultRifle extends BallisticWeapon;

var() name		GrenadeLoadAnim;	//Anim for grenade reload
var   M50Camera	Camera;				//The camera on the wall
var() ScriptedTexture CamTex;		//ScriptedTex to put on gun and generated from cam view
var() Sound		CamGrabSound;		//
var() Material	LCDCamOnTex;		//
var() BUtil.FullSound CamInSound;
var() BUtil.FullSound CamOutSound;
var() name		CamUpAnim;			//Anim when going to cam view
var() name		CamDownAnim;		//Anim when leaving cam view
var() float		CamUpdateRate;		//Time interval between scripted tex screen updates

var() Sound		GrenOpenSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//

var   actor GLIndicator;

replication
{
	unreliable if (Role == Role_Authority)
		ClientGrenadePickedUp;
	reliable if (Role == Role_Authority)
		ClientCamStart;
	reliable if (bNetDirty && Role == Role_Authority)
		Camera;
}

simulated function UpdateGLIndicator()
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (M50SecondaryFire(FireMode[1]).bLoaded)
	{
		if (GLIndicator == None)
			class'BUtil'.static.InitMuzzleFlash(GLIndicator, class'M50GLIndicator', DrawScale, self, 'tip');
	}
	else if (GLIndicator != None)
	{
		GLIndicator.Destroy();
		GLIndicator = None;
	}
}

// Notifys for greande loading sounds
simulated function Notify_M50GrenadeSlideUp()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_M50GrenadeIn()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);		}
simulated function Notify_M50GrenadeSlideDown()	{	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64); M50SecondaryFire(FireMode[1]).bLoaded = true; FireMode[1].PreFireTime = FireMode[1].default.PreFireTime; UpdateGLIndicator();	}

// A grenade has just been picked up. Loads one in if we're empty
function GrenadePickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadGrenade();
		else
			M50SecondaryFire(FireMode[1]).bLoaded=true;
	}
	if (!Instigator.IsLocallyControlled())
		ClientGrenadePickedUp();
}

simulated function ClientGrenadePickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadGrenade();
		else
			M50SecondaryFire(FireMode[1]).bLoaded=true;
	}
}
simulated function bool IsGrenadeLoaded()
{
	return M50SecondaryFire(FireMode[1]).bLoaded;
}

function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_M900Grenades(Ammo[1]) != None)
		Ammo_M900Grenades(Ammo[1]).DaM50 = self;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == GrenadeLoadAnim)
	{
		ReloadState = RS_None;
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
		
	if (Anim == CamUpAnim && Camera != None)
		CameraView();
	//if (Anim == FireMode[1].FireAnim && !M50SecondaryFire(FireMode[1]).bLoaded)
	//	LoadGrenade();
	else
		Super.AnimEnd(Channel);
}
// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || M50SecondaryFire(FireMode[1]).bLoaded)
		return;
	if (ReloadState == RS_None)
	{
		ReloadState = RS_Cocking;
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
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
	
	if (seq == GrenadeLoadAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
		{
			LoadGrenade();
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
			if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
				LoadGrenade();
		}
		else
			CommonStartReload(i);
	}
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return FireCount < 1;
	return super.CheckWeaponMode(Mode);
}

// Camera System ==============================================
// First, check if we are viewing from cam. If so, then switch view, otherwise it's over to the server
//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (Camera != None && PlayerController(Instigator.Controller).ViewTarget == Camera)
		SwitchView();
	else
		ServerWeaponSpecial(i);
}
// Weapon special is pressed. Try grabbing the camera, viewing from it or placing a new one...
function ServerWeaponSpecial(optional byte i)
{
	if (Camera != None)
	{
//		if (!GrabCamera())
			ClientWeaponSpecial(i);
	}
	else
		PlaceCamera();

}
// Server has decided that the play must view form the camera...
simulated function ClientWeaponSpecial(optional byte i)	{	SwitchView();	}

// Grab camera if we are near enough and looking right at it
function bool GrabCamera()
{
	if ( VSize(Camera.Location - Instigator.Location) < 120 && (Vector(Instigator.GetViewRotation()) dot Normal(Camera.Location - Instigator.Location) > 0.7) )
	{
		PlaySound(CamGrabSound, SLOT_Misc, 0.5,,32);
		Camera.Destroy();
		return true;
	}
	return false;
}

function TryUse(Pawn User)
{
	if (Camera != None && User.Controller == Instigator.Controller)
	{
		PlaySound(CamGrabSound, SLOT_Misc, 0.5,,32);
		Camera.Destroy();
	}
}

// Place a camera on the wall if there is one in range
function PlaceCamera()
{
	local actor T;
	local Vector HitLocation, HitNormal, Start, End;

	Start = Instigator.Location + Instigator.EyePosition();
	End = Start + vector(Instigator.GetViewRotation()) * 120;
	T = Trace(HitLocation, HitNormal, End, Start, true);
	if (T == None || (Pawn(T) != None && Vehicle(T) == None))
		return;
//	Camera = Spawn(class'M50Camera', self,, HitLocation + HitNormal * 7, Rotator(HitNormal));
	Camera = Spawn(class'M50Camera',,, HitLocation + HitNormal * 7, Rotator(HitNormal));
	Camera.Weapon = self;
	Camera.InstigatorController = Instigator.Controller;
	CamStart(Camera);
	if (Camera == None)
		return;
	Camera.CamBase = Spawn(class'M50CameraBase', self,, HitLocation, Rotator(HitNormal));
	if (!T.bWorldGeometry)
	{
		if (Camera.CamBase != None)
			Camera.CamBase.SetBase(T);
		Camera.SetBase(T);
	}
}

simulated event Timer()
{
	if (ClientState == WS_BringUp && CamUpdateRate > 0.0)
		SetTimer(CamUpdateRate, true);
	if (ClientState != WS_ReadyToFire)
	{
		super.Timer();
		return;
	}

	Level.TimeSeconds < FMin(LastRenderTime + CamUpdateRate, 0.05);
	if (Instigator.IsLocallyControlled() && Camera != None && CamUpdateRate > 0.0 && !Camera.bBusted && PlayerController(Instigator.Controller).ViewTarget == Instigator)
	{
		CamTex.Client = self;
		if (Camera != None)
			CamTex.Revision++;
	}
}

simulated function ClientCamStart(M50Camera Cam)
{
	CamStart(Cam);
}
// Called on clients from camera when it gets to postnetbegin
simulated function CamStart(M50Camera Cam)
{
	if (Instigator.IsLocallyControlled())
		CamTex.Client = self;
	Camera = Cam;
	Camera.OnCameraDie = CamDie;
	if (Role == ROLE_Authority)
	{
		if (Camera.MyUseTrigger == None)
			Camera.MyUseTrigger = Spawn(class'M50CamTrigger',self ,, Camera.Location);
		else
			Camera.MyUseTrigger.SetOwner(self);
	}
	if (!Camera.bBusted)
	{
		Skins[3] = LCDCamOnTex;
		if (Instigator.IsLocallyControlled())
			CamTex.Revision++;
		if (CamUpdateRate > 0.0 && ClientState == WS_ReadyToFire)
			SetTimer(CamUpdateRate, true);
	}
}

// Cam has been destroyed or damaged. Show noise on the little screen...
simulated function CamDie()
{
	Skins[3] = default.Skins[3];
}

// Switch between cam and player views
simulated function SwitchView()
{
	if (PlayerController(Instigator.Controller).ViewTarget == Camera)
		PlayerView();
	else if (ReloadState == RS_None)
	{
		if (bScopeView)
			CameraView();
		else
			PlayAnim(CamUpAnim, 1.0, 0.1);
	}
}
// Back to player
simulated function PlayerView()
{
	PlayerController(Instigator.Controller).SetViewTarget( Instigator );
	CamTex.Client = self;
	CamTex.Revision++;
	Camera.bOwnerNoSee=false;
	Camera.LastFOV = PlayerController(Instigator.Controller).DesiredFOV ;
	PlayerController(Instigator.Controller).DesiredFOV = PlayerController(Instigator.Controller).DefaultFOV;
	if (ReloadState == RS_None && !bScopeView)
		PlayAnim(CamDownAnim, 1.0, , 0);
}
// View from camera
simulated function CameraView()
{
	Camera.OldRotation = Camera.Rotation;
	Camera.SwitchViewRot = PlayerController(Instigator.Controller).Rotation;
	PlayerController(Instigator.Controller).SetViewTarget(Camera);
	PlayerController(Instigator.Controller).DesiredFOV = Camera.LastFOV;
	Camera.bOwnerNoSee=true;
}
// Draw cam view stuff if in cam view...
simulated event RenderOverlays( Canvas Canvas )
{
	local Rotator R, VR, OR;

	// Do stuff for camera view
	if ( Camera != None && PlayerController(Instigator.Controller).ViewTarget == Camera )
    {
		// Aim camera
		OR=Camera.Rotation;
		VR = Normalize((Camera.OldRotation - Camera.StartRotation) + PlayerController(Instigator.Controller).Rotation - Camera.SwitchViewRot);
		VR.Yaw = Clamp(VR.Yaw, -12288, 12288);
		VR.Pitch = Clamp(VR.Pitch, -12288, 12288);
		R = Camera.StartRotation + VR;
		Camera.SetRotation(R);
		if (Camera.Rotation != OR)
			Camera.PlayTracking();

		// Noise
		Canvas.SetDrawColor(255,255,255,255);
		Canvas.Style = ERenderStyle.STY_Alpha;
		Canvas.SetPos(0,0);
		if (Camera.bBusted)
			Canvas.DrawTile( Material'BallisticUI2.M50.NoiseComb', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 256, 256 ); // !! hardcoded size
		else
		{
			Canvas.DrawColor.A = 48;
			Canvas.DrawTile( Material'BallisticUI2.M50.Noise1', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 256, 256 ); // !! hardcoded size
		}
		// Tunnel vision
		Canvas.DrawColor.A = 255;
		Canvas.SetPos(0,0);
		Canvas.DrawTile( Material'BallisticUI2.M50.M50CamView', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 1024, 1024 ); // !! hardcoded size
	}
    else
        Super.RenderOverlays(Canvas);
}

simulated event RenderTexture(ScriptedTexture Tex)
{
	if(Camera != None)
	{
		Camera.bOwnerNoSee=true;
		Tex.DrawPortal(0, 0, Tex.USize, Tex.VSize, Camera, Camera.Location, Camera.Rotation, Camera.LastFOV);
		Camera.bOwnerNoSee=false;
	}
}
// Tell the texture who is da boss and update it if there is a cam up
simulated function BringUp(optional Weapon PrevWeapon)
{
	local M50Camera C;

	Super.BringUp(PrevWeapon);

	switch (class'Mut_Ballistic'.default.CamUpdateRate)
	{
		case "1": CamUpdateRate = 0.5; break;
		case "2": CamUpdateRate = 0.2; break;
		case "3": CamUpdateRate = 0.1; break;
		case "4": CamUpdateRate = 0.0666; break;
		default:  CamUpdateRate = 0.0; break;
	}

	if (Instigator.IsLocallyControlled())
	{
		UpdateGLIndicator();

		CamTex.Client = self;
		if (Camera != None)
			CamTex.Revision++;
	}
	if (Camera == None && Role == ROLE_Authority)
	{
		foreach DynamicActors (class'M50Camera', C)
		{
			if (C.InstigatorController == Instigator.Controller)
			{
				C.Weapon = self;
				CamStart(C);
				if (!Instigator.IsLocallyControlled())
					ClientCamStart(C);
				return;
			}
		}
	}
}
// Leave cam...
simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		if (GLIndicator != None)
		{
			GLIndicator.Destroy();
			GLIndicator = None;
		}
		if ( Camera != None && PlayerController(Instigator.Controller).ViewTarget == Camera )
			PlayerView();
		return true;
	}
	return false;
}

simulated event Destroyed()
{
	if (GLIndicator != None)
		GLIndicator.Destroy();
	CamTex.Client=None;
	Super.Destroyed();
}

simulated function bool AllowWeapPrevUI()
{
	if (Camera != None && PlayerController(Instigator.Controller).ViewTarget == Camera)
		return false;
	return super.AllowWeapPrevUI();
}
simulated function bool AllowWeapNextUI()
{
	if (Camera != None && PlayerController(Instigator.Controller).ViewTarget == Camera)
		return false;
	return super.AllowWeapNextUI();
}

// Cam zoom out
simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (CurrentWeapon == self && Camera != None && PlayerController(Instigator.Controller).ViewTarget == Camera)
	{
		ChangeZoom(0.2);
	    class'BUtil'.static.PlayFullSound(self, CamOutSound);
		return None;
	}
	else
        return Super.PrevWeapon(CurrentChoice,CurrentWeapon);
}
// Cam zoom in
simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (CurrentWeapon == self && Camera != None && PlayerController(Instigator.Controller).ViewTarget == Camera)
	{
		ChangeZoom(-0.2);
	    class'BUtil'.static.PlayFullSound(self, CamInSound);
		return None;
	}
	else
        return Super.NextWeapon(CurrentChoice,CurrentWeapon);
}
// Basic zooming for camera
simulated function ChangeZoom (float Value)
{
	local PlayerController PC;

	if (Camera == None || PlayerController(Instigator.Controller).ViewTarget != Camera)
	{
		super.ChangeZoom(Value);
		return;
	}
	PC = PlayerController(Instigator.Controller);
	if (PC == None)
		return;
	PC.ZoomLevel += Value;
	PC.ZoomLevel = FClamp(PC.ZoomLevel, 0.0, 0.9);
	PC.DesiredFOV = FClamp(90.0 - (PC.ZoomLevel * 88.0), 1, 170);
}
// End Cam System =============================================

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !IsGrenadeLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadGrenade() && !IsReloadingGrenade())
		LoadGrenade();
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
}

// AI Interface =====

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || !IsGrenadeLoaded())
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
	// Too close for grenade
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
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == GrenadeLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!IsGrenadeLoaded())
	{
		if (IsReloadingGrenade())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadGrenade())
		{
			LoadGrenade();
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.75, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.0;	}

// End AI Stuff =====

defaultproperties
{
     GrenadeLoadAnim="GrenadeReload"
     CamTex=ScriptedTexture'BallisticUI2.M50.M50LCDTex'
     CamGrabSound=Sound'BallisticSounds2.M50.M50CamPlace'
     LCDCamOnTex=Shader'BallisticUI2.M50.M50LCDTex_SD'
     CamInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     CamOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     CamUpAnim="CamUp"
     CamDownAnim="CamDown"
     CamUpdateRate=0.500000
     GrenOpenSound=Sound'BallisticSounds2.M50.M50GrenOpen'
     GrenLoadSound=Sound'BallisticSounds2.M50.M50GrenLoad'
     GrenCloseSound=Sound'BallisticSounds2.M50.M50GrenClose'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M50'
     BigIconCoords=(Y1=40,Y2=235)
     SightFXClass=Class'BallisticProV55.M50SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Splash=True
     bWT_Machinegun=True
     bWT_Projectile=True
     ManualLines(0)="Automatic 5.56 bullet fire. Low damage per shot with medium range, low penetration and low recoil."
     ManualLines(1)="Launches a grenade from the underslung launcher. This grenade has an arming delay and will ricochet from targets hit during this arming period, dealing minor damage. The arming delay can be used to shoot around corners."
     ManualLines(2)="A TX409-Tactical Video camera system is also included with this weapon. It allows the user to deploy a tactical camera to any surface using the Weapon Function key. To survey an area from a safe distance using the gun-mounted LCD, press Weapon Function again. Care should always be taken to deploy TX409-TV cameras in a hidden location to prevent them from being destroyed by enemies.||The M50 is effective at medium to long range."
     SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;0.4")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     CockAnimPostReload="ReloadEndCock"
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'BallisticSounds2.M50.M50Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.M50.M50ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.M50.M50ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M50.M50ClipIn')
     ClipInFrame=0.650000
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(Value=5.000000)
     bNoCrosshairInScope=False
     SightPivot=(Pitch=200)
     SightOffset=(Y=0.050000,Z=12.130000)
     SightDisplayFOV=40.000000
	 
     CrouchAimFactor=0.750000
     SightAimFactor=0.200000
     SprintOffSet=(Pitch=-3000,Yaw=-4000)
	 
     AimSpread=16
     ChaosDeclineTime=0.5
     ChaosSpeedThreshold=7000.000000
     ChaosAimSpread=728
	 
	 ViewRecoilFactor=0.35
     RecoilXCurve=(Points=((InVal=0,OutVal=0),(InVal=0.150000,OutVal=0.06),(InVal=0.40000,OutVal=0.21000),(InVal=0.6500000,OutVal=0.25000),(InVal=0.800000,OutVal=0.050000),(InVal=1.00000,OutVal=0.150000)))
     RecoilYCurve=(Points=((InVal=0,OutVal=0),(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.050000
     RecoilYFactor=0.050000
	 RecoilDeclineDelay=0.140000     
	 RecoilDeclineTime=0.5

	 
     FireModeClass(0)=Class'BallisticProV55.M50PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.M50SecondaryFire'
	 
     PutDownAnimRate=1.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="Enravion's crowning achievement, the M50 is the most extensively used weapon in the UTC military corps. The M50 is renowned for its accuracy, damage and reliability in the field. The sturdy M50 was extensively used in both wars and has helped annihilate countless Skrith, Krao and Cryon warriors. The weapon also has the advantage of launching a grenade from the attached M900, for flushing out enemies."
     Priority=41
     HudColor=(B=170,G=170,R=210)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     GroupOffset=3
     PickupClass=Class'BallisticProV55.M50Pickup'
     PlayerViewOffset=(X=1.000000,Y=7.000000,Z=-8.000000)
     AttachmentClass=Class'BallisticProV55.M50Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M50'
     IconCoords=(X2=127,Y2=31)
     ItemName="M50 Assault Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticProAnims.M50Assault'
     DrawScale=0.300000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Shader'BallisticWeapons2.M50.M50Skin1Shiney'
     Skins(2)=Shader'BallisticWeapons2.M50.M50Skin2Shiney'
     Skins(3)=Combiner'BallisticUI2.M50.NoiseComb'
     Skins(4)=Texture'BallisticWeapons2.M50.M50Laser'
     Skins(5)=Texture'BallisticWeapons2.M50.M50Gren'
}
