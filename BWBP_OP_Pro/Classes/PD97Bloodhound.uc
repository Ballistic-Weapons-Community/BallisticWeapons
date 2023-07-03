//===========================================================================
// PD-97 "Bloodhound".
//
// A personal defense weapon. Primary fire spits darts which apply DoT / HoT depending on 
// target's affiliation. Darts applied to foes will also mark out the enemy with a neon gas cloud.
// Weapon special dumps the effect of all attached darts at once.
//
// Secondary fire launches a tazer with a limited maximum range. This applies slow and damage 
// over time. Breaking line of sight or angling around the user will remove the tazer's effect.
//
// In classic, primary is a light missile.
// Secondary is a tracker dart that guides the missiles.
//
// In realistic, primary is a light shotgun.
//
// Coded by a bunch of people.
//===========================================================================
class PD97Bloodhound extends BallisticHandgun;

var PD97TazerEffect TazerEffect;
var array<PD97DartControl> StruckTargets;
var bool bShotgunMode; //Am I a shotgun? Are you??

var rotator DrumRot;
var byte DrumPos;
var bool bNeedRotate; //Used to ensure a rotation is called before the next shot

var array<Name> ShellBones[5];
var array<Name> SpareShellBones[5];

//Gyrojet variables
var   Pawn			LockedTarget;
var	  bool			bLockedOn;
var   Actor			CurrentRocket;			//Current rocket of interest. The rocket that can be used as camera or directed with laser
var array<Actor> ActiveRockets;
var() sound		LockedOnSound;		// beep!
var() sound		LockedOffSound;		// lock it off
var PD97TrackerBeacon ActiveBeacon;


replication
{
	reliable if(Role==ROLE_Authority)
		CurrentRocket, LockedTarget, bLockedOn;

	reliable if(Role<ROLE_Authority)
		ServerSetRocketTarget;

	reliable if (Role == ROLE_Authority)
	    ClientAddProjectile, ClientRemoveProjectile;
}

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	bShotgunMode=false;
	if (InStr(WeaponParams.LayoutTags, "shotgun") != -1)
	{
		bShotgunMode=true;
		if ( ThirdPersonActor != None )
		{
			PD97Attachment(ThirdPersonActor).bShotgunMode=true;
			PD97Attachment(ThirdPersonActor).InstantMode=MU_Primary;
		}
	}
}

simulated function Notify_DrumRotate ()
{
}

simulated function Notify_HideShell ()
{
	SetBoneScale(10, 0.0, 'EjectingShell');
}

simulated function ShellFired()
{
	SetBoneScale(DrumPos, 0.0, ShellBones[DrumPos]);
	bNeedRotate=true;
}
simulated function CycleDrum()
{
	if (DrumPos == 4)
		DrumPos = 0;
	else DrumPos++;
	DrumRot.Roll -= 65535 / 5;
	SetBoneRotation('drum',DrumRot);	
	bNeedRotate=false;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
		SelectAnim = 'PulloutOpen';
		PutDownAnim = 'PutawayOpen';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		SelectAnim = 'Pullout';
		PutDownAnim = 'Putaway';
	}
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	
	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim || Anim == DualReloadAnim || Anim == DualReloadEmptyAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			if (IdleAnim == 'Idle')
				IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
			SelectAnim = 'PulloutOpen';
			PutDownAnim = 'PutawayOpen';
		}
		else
		{
			if (Anim == FireMode[0].FireAnim || (anim == FireMode[1].FireAnim && !FireMode[1].IsFiring()))
			{
				bPreventReload=false;
				CycleDrum();
			}
			if (IdleAnim == 'OpenIdle')
				IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			SelectAnim = 'Pullout';
			PutDownAnim = 'Putaway';
		}
	}
	
	if (Anim == ZoomInAnim)
	{
		SightingState = SS_Active;
		ScopeUpAnimEnd();
		return;
	}
	else if (Anim == ZoomOutAnim)
	{
		SightingState = SS_None;
		ScopeDownAnimEnd();
		return;
	}

	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim) )
		bPreventReload=false;
		
	if (MeleeFireMode != None && anim == MeleeFireMode.FireAnim)
	{
		if (MeleeState == MS_StrikePending)
			MeleeState = MS_Pending;
		else MeleeState = MS_None;
		ReloadState = RS_None;
		if (Role == ROLE_Authority)
			bServerReloading=False;
		bPreventReload=false;
	}
		
	//Phase out channels 1 and 2 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		AnimBlendParams(2, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		CycleDrum();
		bPreventReload=False;
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
		if (Channel == 0 && (bNeedReload || ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))) && MeleeState < MS_Held)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	// animations not played on channel 0 are used for sight fires and blending, and are not permitted to drive the weapon's functions
	if (Channel > 0)
		return;

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
		if (MagAmmo - (int(!bNeedCock) * int(!bNonCocking) * int(bMagPlusOne))  >= default.MagAmmo || Ammo[0].AmmoAmount < 1 )
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
			AimComponent.ReAim(0.05);
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
		AimComponent.ReAim(0.05);
	}
	
	if (ReloadState == RS_GearSwitch)
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
}



simulated function Notify_DrumDown()
{
	local int i, j;
	
	j=DrumPos;
	
	for (i=0; i < default.MagAmmo; i++)
	{
		if (i < Ammo[0].AmmoAmount)
			SetBoneScale(j, 1, ShellBones[j]);
		else SetBoneScale(j+default.MagAmmo*2, 0, SpareShellBones[j]);
		
		if (j == 4)
			j = 0;
		else j++;
	}
}

simulated function Notify_ClipIn()
{
	local int i;
	
	Super.Notify_ClipIn();
	
	for (i=0; i < default.MagAmmo; i++)
		SetBoneScale(i+default.MagAmmo*2, 1, SpareShellBones[i]);
	SetBoneScale(10, 1, 'EjectingShell');
}

//===========================================================================
// Dual wield properties.
//===========================================================================
simulated function bool MasterCanSendMode(int Mode) {return Othergun.class==class;}

simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return True;
	return super.CanAlternate(Mode);
}

//===========================================================================
// Darts.
//===========================================================================
function AddControl(PD97DartControl DC)
{
	StruckTargets[StruckTargets.Length] = DC;
}

function LostControl(PD97DartControl DC)
{
	local int i;
	
	for (i=0; i < StruckTargets.Length; i++)
	{
		if (StruckTargets[i] == DC)
		{
			StruckTargets.Remove(i, 1);
			return;
		}
	}
}
//===========================================================================
// Tazer implementation.
//===========================================================================
simulated function RenderOverlays (Canvas C)
{
	Super.RenderOverlays(C);

	if (TazerEffect != None)
	{
		TazerEffect.bHidden = true;
		TazerEffect.SetLocation(ConvertFOVs(GetBoneCoords('Tazer').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
		C.DrawActor(TazerEffect, false, false, Instigator.Controller.FovAngle);
	}
}

simulated function WeaponTick (float DT)
{
	super.WeaponTick(DT);

	if (TazerEffect != None && !Instigator.IsFirstPerson() && AIController(Instigator.Controller) == None)
	{
		TazerEffect.bHidden = False;
		TazerEffect.SetLocation(BallisticAttachment(ThirdPersonActor).GetModeTipLocation());
	}
	
	if (LockedTarget != None )
	{
		ServerSetRocketTarget(LockedTarget.Location);
	}
	else if (LockedTarget == None && bLockedOn)
	{
		BreakLock();
	}
	
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

//===========================================================================
// Gyrojet implementation.
//===========================================================================

exec simulated function WeaponSpecial(optional byte i)
{
	if (bLockedOn)
		BreakLock();
}


function AddProjectile(Actor Proj)
{
	ActiveRockets[ActiveRockets.Length] = Proj;
	ClientAddProjectile(Proj);
}

simulated function ClientAddProjectile(Actor Proj)
{
	ActiveRockets[ActiveRockets.Length] = Proj;
}

function LostChild(Actor Proj)
{
	local int i;
	
	if (PD97Rocket(Proj) != None)
	{
		for (i=0; i < ActiveRockets.Length && ActiveRockets[i] != Proj; i++);
		
		if (i < ActiveRockets.Length)
		{
			ActiveRockets.Remove(i, 1);
			ClientRemoveProjectile(Proj);
		}
	}
}

simulated function ClientRemoveProjectile(Actor Proj)
{
	local int i;
	
	for (i=0; i < ActiveRockets.Length && ActiveRockets[i] != Proj; i++);
	
	if (i < ActiveRockets.Length)
		ActiveRockets.Remove(i, 1);
}

simulated function GotTarget(Pawn A)
{
	LockedTarget = A;
	bLockedOn = true;
	Log("bLockedOn: "$bLockedOn);
	Log("LockedTarget:" $LockedTarget);
    PlaySound(LockedOnSound,,0.7,,16);
}

simulated function BreakLock()
{
	bLockedOn = false;
    PlaySound(LockedOffSound,,0.7,,16);

	if (ActiveBeacon != None)
		ActiveBeacon.Destroy();
}

simulated function Destroyed()
{
	BreakLock();
	super.Destroyed();
}

function ServerSetRocketTarget(vector Loc)
{
	local int i;
		//TargetLocation = Loc;
	for (i=0; i< ActiveRockets.Length; i++)
	{
		PD97Rocket(ActiveRockets[i]).SetRocketTarget(LockedTarget);
	}
//	if (CurrentRocket != None && PD97Rocket(CurrentRocket) != None)
//		PD97Rocket(CurrentRocket).SetTargetLocation(Loc);
}

simulated function vector GetRocketTarget()
{
	if (LockedTarget != None)
		return LockedTarget.Location;
	else
		return vect(0,0,0);
}

// AI Stuff
function byte BestMode()
{
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

defaultproperties
{
	SupportHandBone="Root01"
	AIRating=0.5
	CurrentRating=0.5
	ShellBones(0)="Shell1"
	ShellBones(1)="Shell2"
	ShellBones(2)="Shell3"
	ShellBones(3)="Shell4"
	ShellBones(4)="Shell5"
	SpareShellBones(0)="SpareShell1"
	SpareShellBones(1)="SpareShell2"
	SpareShellBones(2)="SpareShell3"
	SpareShellBones(3)="SpareShell4"
	SpareShellBones(4)="SpareShell5"
    LockedOnSound=Sound'MenuSounds.select3'
    LockedOffSound=Sound'2K4MenuSounds.Generic.msfxDown'
	bShouldDualInLoadout=True
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.500000
	BigIconMaterial=Texture'BWBP_OP_Tex.Bloodhound.BigIcon_PD97'
	IdleTweenTime=0.000000
	
	bWT_Bullet=True
	bWT_Heal=True
	ManualLines(0)="Fires projectile darts. Upon striking an enemy, these darts release a cloud of pink gas which allows the path of the enemy to be tracked. The darts will also deal damage over time. Upon striking an ally, the darts heal over time instead of dealing damage."
	ManualLines(1)="Launches a tazer. The user must hold down Altfire or the tazer will be retracted. Upon striking an enemy, transmits a current dealing paltry DPS but slowing the enemy movement."
	ManualLines(2)="Primarily a support weapon, the Bloodhound is most effective when used as part of a team. Nevertheless, sufficient dart hits can cause high damage. The Bloodhound has very low recoil."
	SpecialInfo(0)=(Info="120.0;15.0;0.8;50.0;0.0;0.5;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
	CockSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-Cock')
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipIn')
	ClipInFrame=0.650000
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightOffset=(X=0.000000,Y=0.0000,Z=0.00000)
	SightingTime=0.200000
	ParamsClasses(0)=Class'PD97WeaponParamsComp'
	ParamsClasses(1)=Class'PD97WeaponParamsClassic'
	ParamsClasses(2)=Class'PD97WeaponParamsRealistic'
    ParamsClasses(3)=Class'PD97WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_OP_Pro.PD97PrimaryFire'
	FireModeClass(1)=Class'BWBP_OP_Pro.PD97SecondaryFire'
	PutDownTime=0.600000
	BringUpTime=0.900000
	SelectForce="SwitchToAssaultRifle"
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.A73OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=186,R=12),Color2=(R=0),StartSize1=58,StartSize2=50)
    NDCrosshairInfo=(SpreadRatios=(Y2=0.500000))
	bShowChargingBar=True
	Description="Originally a specialist law enforcement weapon, the PD-97 'Bloodhound' has been adapted into a military role, used to control opponents and track their movement upon the battlefield. While less immediately lethal than most other weapons, its tactical repertoire is not to be underestimated."
	Priority=24
	HudColor=(B=250,G=150,R=150)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=13
	PickupClass=Class'BWBP_OP_Pro.PD97Pickup'
	PlayerViewOffset=(X=7.5,Y=4,Z=-4.5)
	AttachmentClass=Class'BWBP_OP_Pro.PD97Attachment'
	IconMaterial=Texture'BWBP_OP_Tex.Bloodhound.Icon_PD97'
	IconCoords=(X2=127,Y2=31)
	ItemName="PD-97 'Bloodhound'"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_Bloodhound'
	DrawScale=0.300000
}
