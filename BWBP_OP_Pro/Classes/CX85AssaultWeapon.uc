class CX85AssaultWeapon extends BallisticWeapon;

#exec OBJ LOAD File=BW_Core_WeaponSound.uax

var array<CX85DartDirect> StuckDarts;

var BUtil.FullSound DrumInSound, DrumOutSound;

var Name 			ReloadAltAnim;
var int 			AltAmmo;

var int				BaseTrackDist;

var	float			LastDetonationTime;

var bool			bPendingReceive; //Used when a dart has struck but not yet been replicated. Prevents detonation because of the desynchronised nature of the array.


var   vector		TargetLocation;
var   bool			bLaserOn, bLaserOld, bLaserTarget;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

replication
{
	reliable if (Role == ROLE_Authority)
	    AltAmmo, bPendingReceive, ClientAddProjectile, ClientRemoveProjectile, bLaserOn;
}

simulated function vector GetModeEffectStart(byte mode)
{
    // 1st person
    if (Instigator.IsFirstPerson())
    {
        if ( WeaponCentered() )
			return CenteredEffectStart();
			
        if (mode == 0)
		    return ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 32);
        else 
            return ConvertFOVs(GetBoneCoords('tip2').Origin, DisplayFOV, Instigator.Controller.FovAngle, 32);
    }
    // 3rd person
    else
    {
        return (Instigator.Location +
            Instigator.EyeHeight*Vect(0,0,0.5) +
            Vector(Instigator.Rotation) * 40.0);
    }
}

//==================================================================
// NewDrawWeaponInfo
//
// Draws icons for number of darts in mag
//==================================================================
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
	
    for( i=0; i < Count; i++ )
    {
		C.SetPos(C.ClipX - (0.5*i+1) * AmmoDimensions, C.ClipY * (1 - (0.12 * class'HUD'.default.HUDScale)));
		C.DrawTile( Texture'BWBP_OP_Tex.CX85.Dart_HUD',AmmoDimensions, AmmoDimensions, 0, 0, 128, 128);
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
// ServerStartReload
//
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

//==================================================================
// ClientStartReload
//
// Dispatch reload based on desired mag
//==================================================================
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

//==================================================================
// CommonStartReload
//
// Handle multiple magazines
//==================================================================
simulated function CommonStartReload (optional byte i)
{
	local int m;

	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;

    switch(i)
    {
    case 0:
    	ReloadState = RS_StartShovel;
		PlayReload();
        break;
    case 1:
    	ReloadState = RS_PreClipOut;
		PlayReloadAlt();
        break;
    }

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(Default.SightingTime);

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
// AddProjectile
//
// Adds/removes master mines from array on authoritative instance of weapon.
//
// Done this way because of replication.
//===========================================================================
function AddProjectile(CX85DartDirect Proj)
{
	StuckDarts[StuckDarts.Length] = Proj;
	ClientAddProjectile(Proj);
	bPendingReceive=False;
	
	if (Role == ROLE_Authority && !bLaserOn && !class'BallisticReplicationInfo'.static.IsArenaOrTactical())
		ServerSwitchlaser(true);
	
}

//===========================================================================
// ClientAddProjectile
//
// Adds/removes master mines from client version of weapon.
//===========================================================================
simulated function ClientAddProjectile(CX85DartDirect Proj)
{
	StuckDarts[StuckDarts.Length] = Proj;
}

//===========================================================================
// LostChild
//
// Called when an Actor spawned by this Weapon is destroyed.
// Checks for the Actor being a stuck dart, and removes the tracking if so.
//===========================================================================
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
	
	if (Role == ROLE_Authority && StuckDarts.Length == 0 && bLaserOn)
		ServerSwitchlaser(false);
	
}

//===========================================================================
// ClientRemoveProjectile
//
// Called when a dart spawned by this Weapon is destroyed.
// Removes the tracking from the client.
//===========================================================================
simulated function ClientRemoveProjectile(Actor Proj)
{
	local int i;
	
	for (i=0; i < StuckDarts.Length && StuckDarts[i] != Proj; i++);
	
	if (i < StuckDarts.Length)
		StuckDarts.Remove(i, 1);
}

//===========================================================================
// WeaponSpecial
//
// Allows the detonation of darts.
//===========================================================================
exec simulated function WeaponSpecial(optional byte i)
{
	if (Instigator.bNoWeaponFiring || bPendingReceive || LastDetonationTime + 0.75 > Level.TimeSeconds )
		return;
	ServerWeaponSpecial();
	LastDetonationTime = Level.TimeSeconds;
}

//===========================================================================
// ServerWeaponSpecial
//
// Allows the detonation of darts.
//===========================================================================
function ServerWeaponSpecial(optional byte i)
{
	if (Instigator.bNoWeaponFiring || bPendingReceive || LastDetonationTime + 0.75 > Level.TimeSeconds || StuckDarts.Length == 0)
		return;
		
	StuckDarts[StuckDarts.Length-1].Explode(StuckDarts[StuckDarts.Length-1].Location, Vector(StuckDarts[StuckDarts.Length-1].Rotation));
	LastDetonationTime = Level.TimeSeconds;
}

//===========================================================================
// RenderOverlays
//
// Draw targeting overlay if scoped.
//===========================================================================
simulated function RenderOverlays (Canvas C)
{
	Super.RenderOverlays(C);
	
	if (!IsInState('Lowered'))
		DrawLaserSight(C);
	if (bScopeView)
		DrawTargeting(C);
}

//===========================================================================
// GetFlechetteTarget
//
// Find and return the nearest stuck actor to guide the C/R projectiles.
//===========================================================================
simulated function vector GetFlechetteTarget()
{
	local float ShortestDistance;
	local Pawn ClosestVictim;
	local int i;
	
	if (StuckDarts.Length == 0)
	{
		bLaserTarget=false;
		return vect(0,0,0);
	}
		
	ShortestDistance = BaseTrackDist;
	
	for (i = 0; i < StuckDarts.Length; i++)
	{	
		if (StuckDarts[i].Tracked == None || StuckDarts[i].Tracked.Health < 1 || !StuckDarts[i].Tracked.bProjTarget)
			continue;
		if (VSize(StuckDarts[i].Tracked.Location - Instigator.Location) > StuckDarts[i].TrackCount * BaseTrackDist)
			continue;
		if (Normal(StuckDarts[i].Tracked.Location - Location) Dot Vector(Instigator.GetViewRotation()) < 0.8)
			continue;
		if (VSize(StuckDarts[i].Tracked.Location - Instigator.Location) < ShortestDistance)
			ClosestVictim = StuckDarts[i].Tracked;
	}
	if (ClosestVictim != None)
	{
		bLaserTarget=true;
		TargetLocation = ClosestVictim.Location;
		return ClosestVictim.Location;
	}
	else
	{
		bLaserTarget=false;
		return vect(0,0,0);
	}
}
//===========================================================================
// DrawTargeting
//
// Draw target boxes for tracked opponents.
//===========================================================================
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
		C.DrawTileStretched(Texture'BW_Core_WeaponTex.G5.G5Targetbox', (V2.X - V.X) + 32*ScaleFactor, (V2.Y - V.Y) + 32*ScaleFactor);
	}
}

//============================================================
// Laser management
//============================================================


simulated function WeaponTick(float DT)
{
	Super.WeaponTick(DT);

	if (Instigator != None && Instigator.IsLocallyControlled() && bLaserOn)
		GetFlechetteTarget(); //Continually check for targets

}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;

	CX85Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
	OnLaserSwitched();
}

simulated function ClientSwitchLaser()
{
	//TickLaser (0.05);
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
	}
	PlayIdle();
	OnLaserSwitched();
}

simulated function OnLaserSwitched()
{
	if (bLaserOn)
		ApplyLaserAim();
	else
		AimComponent.Recalculate();
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (bLaserOn)
		ApplyLaserAim();
}

simulated function ApplyLaserAim()
{
	AimComponent.AimSpread.Max *= 0.8f;
	AimComponent.AimAdjustTime *= 1.5f;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_G5Painter');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();

	if ( ThirdPersonActor != None )
		CX85Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();

		if (ThirdPersonActor != None)
			CX85Attachment(ThirdPersonActor).bLaserOn = false;

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

// Draw a laser beam and dot to show exact path of bullets before they're fired, point it at the tracked dude
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc, AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || !bLaserOn || bScopeView || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	Loc = GetBoneCoords('tip').Origin;

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs), or closest target
	Laser.SetLocation(Loc);
	if (!bLaserTarget) //Calc from barrel to wall
	{
		AimDir = BallisticFire(FireMode[0]).GetFireDir(Start);
		End = Start + Normal(AimDir)*10000;
		Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
		if (Other == None)
			HitLocation = End;
		if ( ThirdPersonActor != None )
			CX85Attachment(ThirdPersonActor).LaserEndLoc = HitLocation;
	}
	else //Calc to target
	{
		HitLocation = ConvertFOVs(TargetLocation, Instigator.Controller.FovAngle, DisplayFOV, 400);
		if ( ThirdPersonActor != None )
			CX85Attachment(ThirdPersonActor).LaserEndLoc = TargetLocation;
	}
	
	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	
	if (LaserDot != None && !bLaserTarget)
		LaserDot.SetLocation(HitLocation);
	else
		LaserDot.SetLocation(TargetLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire /* && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2*/)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
		Laser.SetRotation(GetBoneRotation('tip'));

	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
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

simulated function PlayIdle()
{
	Super.PlayIdle();
	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
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
	DrumInSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	DrumOutSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOff',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	ReloadAltAnim="ReloadAlt"
	AltAmmo=6
	BaseTrackDist=3368
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_OP_Tex.CX85.BigIcon_CX85'
	
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic low-calibre fire. Has extremely long effective range, but as a low-calibre weapon, must be fired in bursts at range, subjecting the user to the effects of recoil."
	ManualLines(1)="Fires a dart. Good fire rate and fast flight speed. Enemies hit by the darts show up on the scope when within a given range of the user. The tracking range increases with successive hits."
	ManualLines(2)="Weapon Function for this weapon causes all the darts attached to the last player to be hit for the first time to explode. This feature works independently of range.||The CX85 is effective at long range."
	SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;1.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
	CockSound=(Sound=Sound'BWBP_OP_Sounds.CX85.CX85-Cock')
	ClipHitSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-MagIn')
	ClipOutSound=(Sound=Sound'BWBP_OP_Sounds.CX85.CX85-MagOut')
	ClipInSound=(Sound=Sound'BWBP_OP_Sounds.CX85.CX85-MagIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(bUnavailable=True)
	ScopeViewTex=Texture'BWBP_OP_Tex.CX85.CX85ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=20.000000
	bNoCrosshairInScope=True
	SightOffset=(X=-5,Y=0,Z=0)
	SightingTime=0.650000
	MinZoom=2.000000
	MaxZoom=8.000000
	ZoomStages=2
	GunLength=72.000000
	ParamsClasses(0)=Class'CX85WeaponParamsComp'
	ParamsClasses(1)=Class'CX85WeaponParamsClassic'
	ParamsClasses(2)=Class'CX85WeaponParamsRealistic'
    ParamsClasses(3)=Class'CX85WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_OP_Pro.CX85PrimaryFire'
	FireModeClass(1)=Class'BWBP_OP_Pro.CX85SecondaryFire'
	PutDownTime=0.700000
	BringUpTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc7',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50In',USize1=256,VSize1=256,Color1=(G=123,R=77,A=125),Color2=(G=183))
    NDCrosshairInfo=(SpreadRatios=(Y2=0.500000))
	AIRating=0.800000
	CurrentRating=0.800000
	Description="The Cimerion Labs CX85 was created to serve the purpose of enemy location and tracking in a battlefield environment where operatives needed tactical-level information on enemy positions and movements without the ability to rely upon allied intelligence. Capable of launching miniature darts, each packed with an explosive charge and a remote transmitter, the CX is able to discern the location of struck enemies. Should the user no longer have need for the tracking ability, the darts can be detonated at long range to damage the target and surrounding entities."
	Priority=40
	HudColor=(G=125,R=150)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=6
	GroupOffset=6
	PickupClass=Class'BWBP_OP_Pro.CX85Pickup'
	PlayerViewOffset=(X=10,Y=7,Z=-4)
	AttachmentClass=Class'BWBP_OP_Pro.CX85Attachment'
	IconMaterial=Texture'BWBP_OP_Tex.CX85.SmallIcon_CX85'
	IconCoords=(X2=127,Y2=31)
	ItemName="CX85 Combat Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_CX85'
	DrawScale=0.300000
}
