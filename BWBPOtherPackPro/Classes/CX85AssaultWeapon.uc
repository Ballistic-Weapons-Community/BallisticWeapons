class CX85AssaultWeapon extends BallisticWeapon;

#exec OBJ LOAD File=BallisticSounds2.uax

var array<CX85DartDirect> StuckDarts;

var BUtil.FullSound DrumInSound, DrumOutSound;

var Name 			ReloadAltAnim;
var int 				AltAmmo;

var int				BaseTrackDist;

var	float			LastDetonationTime;

var bool				bPendingReceive; //Used when a dart has struck but not yet been replicated. Prevents detonation because of the desynchronised nature of the array.

replication
{
	reliable if (Role == ROLE_Authority)
	    AltAmmo, bPendingReceive, ClientAddProjectile, ClientRemoveProjectile;
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float AmmoDimensions;

	local float	ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;

	DrawCrosshairs(C);

	ScaleFactor = C.ClipX / 1600;
	AmmoDimensions = C.ClipY * 0.06;
	
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
	Count = Min(6,AltAmmo);
	
    for( i=0; i<Count; i++ )
    {
		C.SetPos(C.ClipX - (0.5*i+1) * AmmoDimensions, C.ClipY * (1 - (0.12 * class'HUD'.default.HUDScale)));
		C.DrawTile( Texture'BWBPOtherPackTex3.CX85.Dart_HUD',AmmoDimensions, AmmoDimensions, 0, 0, 128, 128);
	}
	
	if (bSkipDrawWeaponInfo)
		return;

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
}


//===========================================================================
// Generic code for weapons which have multiple magazines.
//===========================================================================
function ServerStartReload (optional byte i)
{
	local int m;
	local array<byte> Loadings[2];
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (MagAmmo < default.MagAmmo && Ammo[0].AmmoAmount > 0)
		Loadings[0] = 1;
	if (AltAmmo < 6 && Ammo[1].AmmoAmount > 0)
		Loadings[1] = 1;
	if (Loadings[0] == 0 && Loadings[1] == 0)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	
	if (i == 1)
		m = 0;
	else m = 1;
	
	if (Loadings[i] == 1)
	{
		ClientStartReload(i);
		CommonStartReload(i);
	}
	
	else if (Loadings[m] == 1)
	{
		ClientStartReload(m);
		CommonStartReload(m);
	}
	
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1)
			CommonStartReload(1);
		else
			CommonStartReload(0);
	}
}

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (i == 1)
	{
		ReloadState = RS_PreClipOut;
		PlayReloadAlt();
	}
	else
	{
		ReloadState = RS_StartShovel;
		PlayReload();
	}

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime*Default.SightingTimeScale);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;
	bNeedReload=false;
}

simulated function PlayReloadAlt()
{
	SafePlayAnim(ReloadAltAnim, 1, , 0, "RELOAD");
}

simulated function Notify_DrumOut()	
{	
	PlayOwnedSound(DrumOutSound.Sound,DrumOutSound.Slot,DrumOutSound.Volume,DrumOutSound.bNoOverride,DrumOutSound.Radius,DrumOutSound.Pitch,DrumOutSound.bAtten);
	ReloadState = RS_PreClipIn;
}

simulated function Notify_DrumIn()          
{   
	local int AmmoNeeded;
	
	PlayOwnedSound(DrumInSound.Sound,DrumInSound.Slot,DrumInSound.Volume,DrumInSound.bNoOverride,DrumInSound.Radius,DrumInSound.Pitch,DrumInSound.bAtten);    
	ReloadState = RS_PostClipIn; 
	
	if (Level.NetMode != NM_Client)
	{
		AmmoNeeded = default.AltAmmo - AltAmmo;
		if (AmmoNeeded > Ammo[1].AmmoAmount)
			AltAmmo +=Ammo[1].AmmoAmount;
		else
			AltAmmo = default.AltAmmo;   
		Ammo[1].UseAmmo (AmmoNeeded, True);
	}
}

//===========================================================================
// Add/Remove master mines from array.
//
// Done this way because of replication.
//===========================================================================
function AddProjectile(CX85DartDirect Proj)
{
	StuckDarts[StuckDarts.Length] = Proj;
	ClientAddProjectile(Proj);
	bPendingReceive=False;
}

simulated function ClientAddProjectile(CX85DartDirect Proj)
{
	StuckDarts[StuckDarts.Length] = Proj;
}

function LostChild(Actor Proj)
{
	local int i;
	
	if (CX85DartDirect(Proj) != None)
	{
		for (i=0; i < StuckDarts.Length && StuckDarts[i] != Proj; i++);
		
		if (i < StuckDarts.Length)
		{
			StuckDarts.Remove(i, 1);
			ClientRemoveProjectile(Proj);
		}
	}
}

simulated function ClientRemoveProjectile(Actor Proj)
{
	local int i;
	
	for (i=0; i < StuckDarts.Length && StuckDarts[i] != Proj; i++);
	
	if (i < StuckDarts.Length)
		StuckDarts.Remove(i, 1);
}

//===========================================================================
// Allows the detonation of darts.
//===========================================================================
exec simulated function WeaponSpecial(optional byte i)
{
	if (Instigator.bNoWeaponFiring || bPendingReceive || LastDetonationTime + 0.75 > Level.TimeSeconds )
		return;
	ServerWeaponSpecial();
	LastDetonationTime = Level.TimeSeconds;
}

function ServerWeaponSpecial(optional byte i)
{
	if (Instigator.bNoWeaponFiring || bPendingReceive || LastDetonationTime + 0.75 > Level.TimeSeconds || StuckDarts.Length == 0)
		return;
		
	StuckDarts[StuckDarts.Length-1].Explode(StuckDarts[StuckDarts.Length-1].Location, Vector(StuckDarts[StuckDarts.Length-1].Rotation));
	LastDetonationTime = Level.TimeSeconds;
}

simulated function RenderOverlays (Canvas C)
{
	Super.RenderOverlays(C);
	
	if (bScopeView)
		DrawTargeting(C);
}

simulated event DrawTargeting (Canvas C)
{
	local Vector V, V2, X, Y, Z;
	local float ScaleFactor;
	local float Distancing;
	local int i;

	if (StuckDarts.Length == 0)
		return;

	ScaleFactor = C.ClipX / 1600;
	GetViewAxes(X, Y, Z);
	
	for (i = 0; i < StuckDarts.Length; i++)
	{
		if (StuckDarts[i].Tracked == None || StuckDarts[i].Tracked.Health < 1 || !StuckDarts[i].Tracked.bProjTarget)
			continue;
		if (VSize(StuckDarts[i].Tracked.Location - Instigator.Location) > StuckDarts[i].TrackCount * BaseTrackDist)
			continue;
		if (Normal(StuckDarts[i].Tracked.Location - Location) Dot Vector(Instigator.GetViewRotation()) < 0.8)
			continue;
		V  = C.WorldToScreen(StuckDarts[i].Tracked.Location - Y*StuckDarts[i].Tracked.CollisionRadius + Z*StuckDarts[i].Tracked.CollisionHeight);
		V.X -= 32*ScaleFactor;
		V.Y -= 32*ScaleFactor;
		Distancing = 1 - VSize(StuckDarts[i].Tracked.Location - Instigator.Location) / (StuckDarts[i].TrackCount * BaseTrackDist);
		C.SetPos(V.X, V.Y);
		V2 = C.WorldToScreen(StuckDarts[i].Tracked.Location + Y*StuckDarts[i].Tracked.CollisionRadius - Z*StuckDarts[i].Tracked.CollisionHeight);
		C.SetDrawColor(255,255,255,255 * Distancing);
		C.DrawTileStretched(Texture'BallisticUI2.G5.G5Targetbox', (V2.X - V.X) + 32*ScaleFactor, (V2.Y - V.Y) + 32*ScaleFactor);
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
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 2048, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.6;	}
// End AI Stuff =====

defaultproperties
{
	DrumInSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOn',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	DrumOutSound=(Sound=Sound'BallisticSounds2.BX5.BX5-SecOff',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	ReloadAltAnim="ReloadAlt"
	AltAmmo=6
	BaseTrackDist=3368
	PlayerSpeedFactor=0.9
	PlayerJumpFactor=0.9
	TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBPOtherPackTex3.CX85.BigIcon_CX85'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic low-calibre fire. Has extremely long effective range, but as a low-calibre weapon, must be fired in bursts at range, subjecting the user to the effects of recoil."
	ManualLines(1)="Fires a dart. Good fire rate and fast flight speed. Enemies hit by the darts show up on the scope when within a given range of the user. The tracking range increases with successive hits."
	ManualLines(2)="Weapon Function for this weapon causes all the darts attached to the last player to be hit for the first time to explode. This feature works independently of range.||The CX85 is effective at long range."
	SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;1.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BallisticSounds2.R78.R78Pullout')
	PutDownSound=(Sound=Sound'BallisticSounds2.R78.R78Putaway')
	MagAmmo=50
	CockAnimRate=1.200000
	CockSound=(Sound=Sound'BallisticSounds2.MRT6.MRT6Cock',Volume=0.650000)
	ClipHitSound=(Sound=Sound'BWBP3-Sounds.SRS900.SRS-ClipHit')
	ClipOutSound=(Sound=Sound'BallisticSounds2.XK2.XK2-ClipOut')
	ClipInSound=(Sound=Sound'BallisticSounds2.XK2.XK2-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(bUnavailable=True)
	ZoomType=ZT_Logarithmic
	ScopeViewTex=Texture'BWBPOtherPackTex3.CX85.CX85ScopeView'
	ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=20.000000
	bNoMeshInScope=True
	bNoCrosshairInScope=True
	SightOffset=(X=-20.000000,Z=35.000000)
	SightingTime=0.650000
	MinZoom=2.000000
	MaxZoom=8.000000
	ZoomStages=2
	GunLength=72.000000
	 
	Begin Object Class=RecoilParams Name=CX85RecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.250000,OutVal=0.120000),(InVal=0.400000,OutVal=0.180000),(InVal=0.800000,OutVal=0.220000),(InVal=1.000000,OutVal=0.250000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.445000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=1.000000
		DeclineDelay=0.170000
	End Object
	RecoilParamsList(0)=RecoilParams'CX85RecoilParams'

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=768)
		ADSMultiplier=0.15
		SprintOffset=(Pitch=-3000,Yaw=-8000)
	End Object
	AimParamsList(0)=AimParams'ArenaAimParams'
	 
	FireModeClass(0)=Class'BWBPOtherPackPro.CX85PrimaryFire'
	FireModeClass(1)=Class'BWBPOtherPackPro.CX85SecondaryFire'
	PutDownTime=0.700000
	BringUpTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	Description="The Cimerion Labs CX85 was created to serve the purpose of enemy location and tracking in a battlefield environment where operatives needed tactical-level information on enemy positions and movements without the ability to rely upon allied intelligence. Capable of launching miniature darts, each packed with an explosive charge and a remote transmitter, the CX is able to discern the location of struck enemies. Should the user no longer have need for the tracking ability, the darts can be detonated at long range to damage the target and surrounding entities."
	DisplayFOV=55.000000
	Priority=40
	HudColor=(G=125,R=150)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	GroupOffset=6
	PickupClass=Class'BWBPOtherPackPro.CX85Pickup'
	PlayerViewOffset=(X=25.000000,Y=18.000000,Z=-25.000000)
	AttachmentClass=Class'BWBPOtherPackPro.CX85Attachment'
	IconMaterial=Texture'BWBPOtherPackTex3.CX85.SmallIcon_CX85'
	IconCoords=(X2=127,Y2=31)
	ItemName="CX85 Combat Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBPOtherPackAnim3.CX85_FP'
	DrawScale=0.500000
}
