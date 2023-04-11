//=========================================================
// RCS-715 Tactical Buster.
//
// Heavyweight, powerful automatic shotgun. Large drum magazine, 
// high dps and controllable when stabilized, but poor
// shoulder fire performance, movement rate and general handling. 
// Analogous to a close range LMG in terms of overall balance.
//
// Balance basis: AA-12 (300RPM)
//
// By Jiffy, based on code by DarkCarnivour, Sergeant_Kelly and Azarael.
//==========================================================
class RCS715Shotgun extends BallisticProShotgun;

var Name					BulletBone;
var() bool					bLoaded;

var() BUtil.FullSound		GrenLoadSound;				//Grenade shovel load sound

var() Name 					ShovelAnim; 				//Anim for alt shovelling
var() Array<Name> 			SGPrepAnim;					//Anim to use for Loading each shell individually
var() Array<Name> 			ReloadAltAnim;				//Anim to use for Reloading each shell individually

var() float 				GrenadeLoadAnimRate;		//Grenade loading speed
var() float 				ShovelReloadAnimRate;		//Grenade reloading speed

var() float     			VisGrenades;				//Rockets currently visible in tube.
var() int       			Grenades;					//Rockets currently in the gun.
var() int					StartingGrenades;
var() bool					bReady;						//Weapon ready for alt fire

var() name					SightsBone;					// Bone to use for hiding sight; temporary
var() name  				SightsBoneHinge;			//Bone to use for hiding sight; temporary

struct RevInfo
{
	var() name	GrenName;
};
var() RevInfo	GrenadeBones[3]; 	//Bones for Grenades in holder
var() RevInfo	GLLoadGrenadeBones[3]; 	//Bones for Grenades in animation

replication
{
	// Things the server should send to the client.
	reliable if(Role==ROLE_Authority)
		Grenades, VisGrenades, bReady, bLoaded;
}

//=============================================
//End Variables
//=============================================


//Now adds initial ammo in all cases


function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
    if ( FireMode[m] != None && FireMode[m].AmmoClass != None )
    {
		Ammo[m] = Ammunition(Instigator.FindInventoryType(FireMode[m].AmmoClass));
        if (Ammo[m] == None)
        {
            Ammo[m] = Spawn(FireMode[m].AmmoClass, instigator);
            Instigator.AddInventory(Ammo[m]);
        }
		//Dropped pickup, just add ammo
        if ((WP != None) && (WP.bDropped || WP.AmmoAmount[m] > 0))
			Ammo[m].AddAmmo(WP.AmmoAmount[m]);
		//else add initial complement
		//if was just spawned and (wasn't dropped or there's no pickup) and (firemodes don't match)
		else if (bJustSpawned && (WP==None || !WP.bDropped) && m == 0)
			Ammo[m].AddAmmo(Ammo[m].InitialAmount);
        Ammo[m].GotoState('');
	}
}


//=============================================
//Start Server Stuff
//=============================================


simulated function PostNetBeginPlay()
{
	local int i;
	//Temporary hide bones
	SetBoneScale(8, 0.0, SightsBone);
	SetBoneScale(9, 0.0, SightsBoneHinge);
	
	for (i=0; i<=1; i++)
		SetBoneScale(i+3, 1.0, GLLoadGrenadeBones[i].GrenName);
	
	Super.PostNetBeginPlay();
	Grenades = StartingGrenades;
	VisGrenades = Grenades;
	UpdateBones();
}


//Ensure integrity of bones


simulated function PostNetReceive()
{
	super.PostNetReceive();
	UpdateBones();
}


//=============================================
//Start Notifies
//=============================================


//Delete a holder grenade


simulated function Special_ShellRemove()
{
	local int i;
	Grenades -=1;
	VisGrenades=Grenades;		
	
	for (i=0; i<=1; i++)
		SetBoneScale(i+3, 1.0, GLLoadGrenadeBones[i].GrenName);
	
	SetBoneScale(5, 0.0, GLLoadGrenadeBones[2].GrenName);
	UpdateBones();
}


//Add a holder grenade


simulated function Special_ShellsIn()
{
	local int i;
	for (i=0; i<=1; i++)
		SetBoneScale(i+3, 1.0, GLLoadGrenadeBones[i].GrenName);

	if (ReloadState == RS_Shovel)
	{
		ReloadState = RS_PostShellIn;	
		if (Role == ROLE_Authority)
		{
			bLoaded = true;
			Grenades += 1;
			Ammo[1].UseAmmo (1, True);
		}
		PlaySound(GrenLoadSound.Sound, SLOT_Misc, 0.5, ,64);
		VisGrenades=Grenades;
	}
	UpdateBones();
}


//Triggered when the SG pump animation finishes


simulated function Special_GrenadeReady()
{	
	local int i;
	
	ReloadState = RS_None;
	if (Role == ROLE_Authority)
		bServerReloading=False;
	
	bReady = true;	
	for (i=0; i<=2; i++)
		SetBoneScale(i+3, 1.0, GLLoadGrenadeBones[i].GrenName);
		
	WeaponModes[0].ModeName="Grenade Loaded";
}


//Triggered after Alt nade is shot.


simulated function PrepPriFire()
{
	WeaponModes[0].ModeName=default.WeaponModes[0].ModeName;
}


//Delete animation grenade when loading


simulated function Notify_RemoveGrenadeGLLoad()
{
	local int i;
	for (i=0; i<=1; i++)
		SetBoneScale(i+3, 0.0, GLLoadGrenadeBones[i].GrenName);
		
	SetBoneScale(5, 1.0, GLLoadGrenadeBones[2].GrenName);
}


//Add grenade back to hand


simulated function Notify_ReturnGrenadeToHand()
{
	local int i;
	for (i=0; i<=1; i++)
		SetBoneScale(i+3, 1.0, GLLoadGrenadeBones[i].GrenName);
}

//=============================================
//End Notifies
//=============================================


simulated function BringUp(optional Weapon PrevWeapon)
{
	local int i;
	
	VisGrenades = Grenades;
	for (i=0; i<=1; i++)
		SetBoneScale(i+3, 1.0, GLLoadGrenadeBones[i].GrenName);
	UpdateBones();
	Super.BringUp(PrevWeapon);
	GunLength = default.GunLength;
}


//=============================================
//Reloading
//=============================================


simulated event AnimEnded (int Channel, name anim, float frame, float rate) 
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

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	// This is only applicable to the Altfire
	if (ReloadState == RS_PostShellIn)
	{
		if (Grenades >= 3 || Ammo[1].AmmoAmount < 1)
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	
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
	}
}


// Load in a grenade


simulated function LoadGrenadeLoop()
{
	if (Ammo[1].AmmoAmount < 1 && Grenades > 3)
		return;
	if ((ReloadState == RS_None || ReloadState == RS_StartShovel)&& Ammo[1].AmmoAmount >= 1)
	{
		PlayAnim(StartShovelAnim, 1.0, , 0);
		ReloadState = RS_StartShovel;
	}
}


// Initiate Alt Reloading Spaghetti


simulated function EmptyAltFire (byte Mode)
{
	if (Grenades <= 0 && ClientState == WS_ReadyToFire && FireCount < 1 && Instigator.IsLocallyControlled())
		ServerStartReload(Mode);
}


// Reload on Server, decide which ammo type to reload


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
	if (Grenades < 3 && Ammo[1].AmmoAmount > 0)
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


// Reload on Client


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
		ReloadState = RS_StartShovel;
		PlayReloadAlt();
	}	
	else
	{
		ReloadState = RS_PreClipOut;
		PlayReload();
	}
	
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


simulated function PlayReloadAlt()
{
	SafePlayAnim(StartShovelAnim, StartShovelAnimRate, , 0, "RELOAD");
}


simulated function PlayShovelLoop()
{
	SafePlayAnim(ReloadAltAnim[VisGrenades], ShovelReloadAnimRate, 0.0, , "RELOAD");
}


simulated function PlayShovelEnd()
{
	SafePlayAnim(EndShovelAnim, EndShovelAnimRate, 0.0, , "RELOAD");
}




simulated function UpdateBones()
{
	local int i;

	if (VisGrenades<0)
	VisGrenades=0;
	for(i=2;i>=VisGrenades;i--)
		SetBoneScale(i, 0.0, GrenadeBones[i].GrenName);
	if (VisGrenades>2)
		VisGrenades=3;
	for(i=0;i<VisGrenades;i++)
		SetBoneScale(i, 1.0, GrenadeBones[i].GrenName);
}


//=============================================
//End Reloading
//=============================================


//=============================================
//Start Drawing
//=============================================


//Modified to subtract active grenades and add little icons
simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float ScaleFactor2;

	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;
	local int	TempNum;

	DrawCrosshairs(C);
	
	//Draw grenades, they're not accounted for in alternative HUD
	ScaleFactor = C.ClipX / 1600;
	ScaleFactor2 = 99 * C.ClipX/3200;
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
	Count = Min(8,Grenades);
    for( i=0; i<Count; i++ )
    {
		C.SetPos(C.ClipX - (0.5*i+1) * ScaleFactor2, C.ClipY - 100 * ScaleFactor * class'HUD'.default.HudScale);
		C.DrawTile( Texture'BWBP_SKC_Tex.M1014.M1014-SGIcon',ScaleFactor2, ScaleFactor2, 0, 0, 128, 128);
	}

	if (bSkipDrawWeaponInfo)
		return;

	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 140 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		
		TempNum = Ammo[1].AmmoAmount;
		C.TextSize(TempNum, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 140 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(TempNum, false);
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 150 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
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


//Function called by alt fire to play SG special load animation.


simulated function PrepAltFire()
{
	if (ReloadState == RS_None)
	{
		ReloadState = RS_Cocking;
		if (Role == ROLE_Authority)
			bServerReloading=True;
		
		PlayAnim(SGPrepAnim[Grenades-1],GrenadeLoadAnimRate, 0.0);
	}
}


simulated function bool IsGrenadeLoaded()
{
	return bLoaded;
}


//=============================================
//Start Other Stuff
//=============================================


function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(10,1.0,'Shell1');
	SetBoneScale(11,0.0,'Shell2');
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if (MagAmmo < 1)
	{
		SetBoneScale(10,0.0,'Shell1');
		SetBoneScale(11,0.0,'Shell2');
	}
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount <=0 && MagAmmo <= 0)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 400)
		return 0;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
		return 1;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(B.Velocity) < 0.5))
		return 1;

	return Rand(2);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/4000));
    return FClamp(Result, -1.0, -0.3);
}

// End AI Stuff =====

simulated function Notify_BrassOut();

defaultproperties
{
	GrenLoadSound=(Sound=Sound'BWBP_OP_Sounds.AA12.GLShovel',Volume=1.800000)
	ShovelAnim="GLReload1"
	SGPrepAnim(0)="GLLoad1"
	SGPrepAnim(1)="GLLoad2"
	SGPrepAnim(2)="GLLoad3"
	ReloadAltAnim(0)="GLReload1"
	ReloadAltAnim(1)="GLReload2"
	ReloadAltAnim(2)="GLReload3"
	GrenadeLoadAnimRate=1.200000
	ShovelReloadAnimRate=1.500000
	Grenades=3
	StartingGrenades=3
	SightsBone="LadderSight"
	SightsBoneHinge="LadderSightHinge"
	GrenadeBones(0)=(GrenName="Grenade1")
	GrenadeBones(1)=(GrenName="Grenade2")
	GrenadeBones(2)=(GrenName="Grenade3")
	GLLoadGrenadeBones(0)=(GrenName="GrenadeHandle")
	GLLoadGrenadeBones(1)=(GrenName="HeldGrenade")
	GLLoadGrenadeBones(2)=(GrenName="EmptyGrenade")
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_OP_Tex.AssaultShotgun.BigIcon_AssaultShotgun'
	BigIconCoords=(Y1=40)
	
	bWT_Shotgun=True
	bWT_Machinegun=True
	bWT_Projectile=True
	ManualLines(0)="Automatic shotgun blasts with high DPS, good accuracy and controllable recoil."
	ManualLines(1)="Loads an incendiary grenade and fires. Deals good impact damage and minor radius damage, as well as a blast of fire upon impact."
	ManualLines(2)="This weapon is heavy and has poor shoulder fire properties.||Effective at close range."
	SpecialInfo(0)=(Info="300.0;30.0;0.5;60.0;0.0;1.0;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
	CockSound=(Sound=Sound'BWBP_OP_Sounds.AA12.Cock',Volume=1.400000)
	ReloadAnimRate=0.750000
	ClipOutSound=(Sound=Sound'BWBP_OP_Sounds.AA12.MagOut',Volume=1.300000)
	ClipInSound=(Sound=Sound'BWBP_OP_Sounds.AA12.MagIn',Volume=1.300000)
	StartShovelAnim="PrepReload"
	StartShovelAnimRate=1.300000
	EndShovelAnim="FinishReload"
	EndShovelAnimRate=1.300000
	WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Semi-Automatic",bUnavailable=true,ModeID="WM_SemiAuto")
	WeaponModes(2)=(ModeName="Burst",bUnavailable=true,ModeID="WM_Burst")
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.PentagramOutA',USize1=128,VSize1=128,USize2=256,VSize2=256,Color1=(B=0,G=0,R=255,A=61),Color2=(B=0,G=148,R=255,A=158),StartSize1=90,StartSize2=96)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	CurrentWeaponMode=0
	SightOffset=(X=0,Y=0,Z=1.4)
	bNoCrosshairInScope=True
	SightBobScale=0.35f
	GunLength=48.000000
	ParamsClasses(0)=Class'RCS715WeaponParamsComp'
	ParamsClasses(1)=Class'RCS715WeaponParamsClassic'
	ParamsClasses(2)=Class'RCS715WeaponParamsRealistic'
	ParamsClasses(3)=Class'RCS715WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_OP_Pro.RCS715PrimaryFire'
	FireModeClass(1)=Class'BWBP_OP_Pro.RCS715SecondaryFire'
	SelectAnimRate=0.900000
	PutDownTime=0.550000
	BringUpTime=0.700000
	CockingBringUpTime=1.500000
	AIRating=0.850000
	CurrentRating=0.850000
	Description="RCS-715 Tactical Buster||Manufacturer: JAX Industrial Firm|Primary: Automatic Shotgun Blast|Secondary: Incendiary Grenade||While not as prevalent as the Skrith menace, Cryon and Krao are just as deadly if not more in some situations.  The skrith may think they're inferior, but the combined menace has wreaked some damage across the universe, such as the tragedy that was the fall of Neo Cairo. Jaeger Firearms and Axo-tek Industries saw the damage to their home, deciding to team up under a new banner. The newly JAX Industrial Firm combined their forces to create not just a potent anti-krao weapon, but an anti-cryon weapon as well. The result is the RCS-715 Tactical Buster shotgun, a low recoil, high damaging shotgun that can destroy not just the Krao or Cryon, but the Skrith as well.  Though chambered in 12 gauge buckshot, it can also fire FRAG-12 or Inciendary shells without damaging the bolt."
	Priority=245
	HudColor=(G=25)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=7
	GroupOffset=7
	PickupClass=Class'BWBP_OP_Pro.RCS715Pickup'
	PlayerViewOffset=(X=9.00,Y=4.50,Z=-5.00)
	AttachmentClass=Class'BWBP_OP_Pro.RCS715Attachment'
	IconMaterial=Texture'BWBP_OP_Tex.AssaultShotgun.SmallIcon_AssaultShotgun'
	IconCoords=(X2=125,Y2=32)
	ItemName="RCS-715 Tactical Buster"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_AssaultShotgun'
	DrawScale=0.300000
}
