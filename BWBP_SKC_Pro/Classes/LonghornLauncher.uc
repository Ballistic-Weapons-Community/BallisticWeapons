//=============================================================================
// LonghornLauncher.
//
// Lever Action Grenade Launcher - Fires cluster grenades. Alt fire simply shoots
// cluster. Shooting in the air will make it rain down with increased damage.
// Primary fire can be held to remotely detonate
//
// by Marc "Sergeant_Kelly", Casey "The_Xavious, and Azarael
//=============================================================================
class LonghornLauncher extends BallisticWeapon;

var	  bool		bGunCocked;
var	  bool		bQuickFire;

var   bool      bWasQuick;
var   float     LonghornHeldTime;
var   float     LonghornTimer;

var() Name	Shells[4];

simulated function AltFire(float F)	{	FirePressed(F);	}

simulated function OnScopeViewChanged()
{
	super.OnScopeViewChanged();

	if (!bScopeView)
	    CockAnim='Cock1';
}

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	ReloadState = RS_StartShovel;
	PlayReload();

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(default.SightingTime);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;
	bNeedReload=false;
}

simulated function PlayReload()
{
	if (SightingState != SS_None)
		TemporaryScopeDown(0.5);
		
    if (MagAmmo < 1 && Ammo[0].AmmoAmount >= default.MagAmmo)
    {
       ShovelIncrement=default.MagAmmo;
       ReloadAnim='ReloadFull';
       bCanSkipReload=False;
    }
	
    else
    {
       ShovelIncrement=1;
       ReloadAnim='ReloadSingle';
       bCanSkipReload=True;
    }
	
	SafePlayAnim(StartShovelAnim, ReloadAnimRate, , 0, "RELOAD");
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None && SightingState != SS_Active)
		TemporaryScopeDown(0.5);
}

simulated function bool CheckScope()
{
	if (level.TimeSeconds < NextCheckScopeTime)
		return true;

	NextCheckScopeTime = level.TimeSeconds + 0.25;
	
	//LH should hold scope while cocking
	if 
	(
		(ReloadState != RS_None && ReloadState != RS_Cocking) || 
		(Instigator.Controller.bRun == 0 && Instigator.Physics == PHYS_Walking) || 
		(SprintControl != None && SprintControl.bSprinting)
	)
	{
		StopScopeView();
		return false;
	}
		
	return true;
}

simulated function LonghornFired()
{
    local float r;
    
	bGunCocked = false;
    r=FRand();
    
	if (SightingState != SS_None)
    {
 		if (r < 0.50)
            CockAnim='SlowCocking1';
        else
            CockAnim='SlowCocking2';
	}
	
    else
    {
        if (r < 0.50)
			CockAnim='Cock1';
        else
			CockAnim='Cock2';
	}
	 
	SetBoneRotation('Hammer', rot(0,0,0));
}

simulated function Notify_CockStart()
{
	if (ReloadState == RS_None)
		return;
	if (ReloadState == RS_EndShovel)
		PlayOwnedSound(ClipHitSound.Sound,ClipHitSound.Slot,ClipHitSound.Volume,ClipHitSound.bNoOverride,ClipHitSound.Radius,ClipHitSound.Pitch,ClipHitSound.bAtten);
	else
		PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
	bGunCocked=true;
	bNeedCock=false;
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (Instigator.IsLocallyControlled())
		{
			bGunCocked=false;
			SetBoneRotation('Hammer', rot(0,0,0));
		}
		return true;
	}
	return false;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		SetBoneScale(0,0.0,Shells[0]);
		SetBoneScale(1,0.0,Shells[1]);
		SetBoneScale(2,0.0,Shells[2]);
		SetBoneScale(3,0.0,Shells[3]);
	}

	Super.BringUp(PrevWeapon);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (bGunCocked && Anim == CockAnim || Anim == EndShovelAnim)
	{
		SetBoneRotation('Hammer', rot(0,7282,0));
		IdleTweenTime=0.00;
	}
	Super.AnimEnd(Channel);
	IdleTweenTime = default.IdleTweenTime;
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Channel == 1)
	{
		//Phase out Channel 1 if a sight fire animation has just ended.
		if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
		{
			AnimBlendParams(1, 0);
			//Cut the basic fire anim if it's too long.
			if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
				FreezeAnimAt(0.0);
			bPreventReload=False;
		}
		return;
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

	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim))
		bPreventReload=false;
		
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (ReloadState == RS_None && anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
	}

	// Modified stuff from Engine.Weapon
	if (ClientState == WS_ReadyToFire && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))
        {
			bPreventReload=false;
            PlayIdle();
        }
    }
	// End stuff from Engine.Weapon

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
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1)
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

}

// Animation notify for when the clip is pulled out - grens are all visible
simulated function Notify_GrenVisible() //We can see these now
{
	SetBoneScale(0,1.0,Shells[0]);
	SetBoneScale(1,1.0,Shells[1]);
	SetBoneScale(2,1.0,Shells[2]);
	SetBoneScale(3,1.0,Shells[3]);
}
simulated function Notify_GrenVisiblePart() //Show gren 4
{
	SetBoneScale(3,1.0,Shells[3]);
}
simulated function Notify_GrenHide()
{
	if (MagAmmo <= 1)
	{
		SetBoneScale(0,0.0,Shells[0]);
		SetBoneScale(1,0.0,Shells[1]);
		SetBoneScale(2,0.0,Shells[2]);
		SetBoneScale(3,0.0,Shells[3]);
	}
}
simulated function UpdateBones()
{
	local int i;
	
	for(i=3; i>=MagAmmo; i--)
		SetBoneScale(i, 0.0, Shells[i]);
	for(i=0; i<MagAmmo && i<4; i++)
		SetBoneScale(i, 1.0, Shells[i]);
}

// AI Interface =====
function byte BestMode()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	if (Dist < 2048)
		return 1;
		
	if (Dist < 3072 && FRand() > 0.5)
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, 1536, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.4;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}
// End AI Stuff =====

simulated function float ChargeBar()
{
	if (CurrentWeaponMode == 0)
		return LonghornPrimaryFire(FireMode[0]).HoldTime / 0.4;
	return LonghornPrimaryFire(FireMode[0]).HoldTime / 0.8;
}

defaultproperties
{
	ManualLines(0)="Fires a grenade which inflicts massive damage on direct impact.||If the Fire key is held down, the grenade will enter manual detonation mode. Fire can then be released to cause the grenade to explode with moderate damage and split into clusters. These clusters inflict moderate damage.||If detonated high above the ground, the clusters will project downwards instead of randomly, and will inflict heavier damage with a wider radius."
	ManualLines(1)="Fires the grenade as its component clusters. Essentially an explosive projectile shotgun attack."
	ManualLines(2)="Effective at close and medium range and as a bombardment and indirect fire weapon."

	Shells(0)="GrenadeA"
	Shells(1)="GrenadeB"
	Shells(2)="GrenadeC"
	Shells(3)="GrenadeD"
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_SKC_Tex.Longhorn.BigIcon_LHorn'
	BigIconCoords=(Y1=30)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Grenade=True
	bWT_Spam=True
	SpecialInfo(0)=(Info="240.0;25.0;0.6;50.0;1.0;0.5;-999.0")
	BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-PullOut')
	PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-PutAway')
	CockAnim="Cock1"
	CockAnimRate=1.50000
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-CockAlt',Volume=0.950000)
	ReloadAnim="ReloadSingle"
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-CockShut',Volume=1.000000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-CockOpen')
	ClipInSound=(Sound=SoundGroup'BW_Core_WeaponSound.Marlin.Mar-ShellIn')
	ClipInFrame=0.650000
	bCanSkipReload=True
	bShovelLoad=True
	StartShovelAnim="ReloadStart"
	EndShovelAnim="ReloadEnd"
	WeaponModes(0)=(ModeName="Single Fire")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	FullZoomFOV=70.000000
	bNoCrosshairInScope=True
	SightPivot=(Pitch=150)
	SightOffset=(Y=19.600000,Z=26.400000)
	ParamsClasses(0)=Class'LonghornWeaponParams'
	ParamsClasses(1)=Class'LonghornWeaponParamsClassic'
	ParamsClasses(2)=Class'LonghornWeaponParamsRealistic'
    ParamsClasses(3)=Class'LonghornWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.LonghornPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.LonghornSecondaryFire'
	SelectAnimRate=1.100000
	PutDownAnimRate=1.500000
	PutDownTime=0.500000
	BringUpTime=0.450000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.750000
	CurrentRating=0.750000
	bShowChargingBar=True
	Description="Longhorn Lever-Action Repeater|Manufacturer: Redwood Firearms|Primary: Cluster Round|Secondary: Split Cluster Round|| The Longhorn is a large caliber lever-action rifle capable of firing everything from solid slugs to fragmentation grenades. This heavy duty hunting rifle first entered combat with the UTC Silver Ranger Division based in New Arizona. Outnumbered and outgunned, they had lost the battle of Phoenix Dam to the rebelling separatist groups. As the hostiles marched towards the colony's atmospheric stabilizer, they were continually dogged by the Rangers who had armed themselves with Longhorns filled with explosives and shrapnel. The lever-action launcher was easy to use and reliable and the rangers inflicted heavy casualties on the separatists before the stabilizer was lost and the colony compromised. Today, it is still in use with the Silver Rangers and is often loaded with powerful X2 SMRT Tandem-Cluster Grenades."
	HudColor=(G=200,R=225)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	PickupClass=Class'BWBP_SKC_Pro.LonghornPickup'
	PlayerViewOffset=(X=-30.000000,Y=5.000000,Z=-20.000000)
	BobDamping=1.800000
	AttachmentClass=Class'BWBP_SKC_Pro.LonghornAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.Longhorn.SmallIcon_LHorn'
	IconCoords=(X2=127,Y2=31)
	ItemName="Longhorn Repeater"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_Longhorn'
	DrawScale=0.900000
}
