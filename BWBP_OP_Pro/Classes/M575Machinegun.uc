//=============================================================================
// M575Machinegun.
//
// The "Guardian" M575 Machinegun has an extremely high fire rate, high ammo
// capacity and decent damage, but is extremely inacurate and can quickly fight
// its way from its owner's control. Secondary allows the user to mount the
// weapon on the ground by crouching.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M575Machinegun extends BallisticMachinegun;

var		bool		bScopeOn, bScopeAnimEnded;
var() 	name		ScopeOnAnim, ScopeOffAnim;
var() 	Material 	ScopeScopeViewTex;
var 	Rotator		ScopeOffRot, ScopeOnRot;

var() array<Material> AmpMaterials; //We're using this for the amp

var(M575)   bool	bAmped;				// Amp installed, gun has new effects
var(MARS) name		AmplifierBone;			// Bone to use for hiding amp
var(MARS) name		AmplifierOnAnim;			//
var(MARS) name		AmplifierOffAnim;		//
var(MARS) sound		AmplifierOnSound;		// Silencer stuck on sound
var(MARS) sound		AmplifierOffSound;		//
var(MARS) sound		AmplifierPowerOnSound;		// Silencer stuck on sound
var(MARS) sound		AmplifierPowerOffSound;		//
var(MARS) sound		AmplifierOnTurnSound;	// Silencer screw on sound
var(MARS) sound		AmplifierOffTurnSound;	//
var(MARS) float		AmpCharge;					// Existing ampjuice
var(MARS) float 	DrainRate;					// Rate that ampjuice leaks out
var(MARS) bool		bShowCharge;				// Hides charge until the amp is on

var int				IceCharge;
var float			LastChargeTime;

const ChargeInterval = 0.5;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchAmplifier;	
	reliable if (Role == ROLE_Authority)
		IceCharge, ClientSetHeat;
}

simulated function PostNetBeginPlay()
{
	if (bScopeOn)
		SetBoneRotation('ScopeHinge', ScopeOnRot);
	else
		SetBoneRotation('ScopeHinge', ScopeOffRot);
		
	bScopeAnimEnded = True;
	SetScopeProperties();
	super.PostNetBeginPlay();
}

simulated event Tick(float DT)
{
	if (bScopeAnimEnded)
	{
		if (bScopeOn)
			SetBoneRotation('ScopeHinge', ScopeOnRot);
		else
			SetBoneRotation('ScopeHinge', ScopeOffRot);
	}
	super.Tick(DT);
}

/*function Notify_Deploy()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local BallisticTurret Turret;
    local int Forward;

	if (Instigator.HeadVolume.bWaterVolume)
		return;
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	// BallisticPro specific: Can be deployed upon sandbags providing that sandbag is not hosting
	// another weapon already. When deployed upon sandbags, the weapon is automatically deployed 
	// to the centre of the bags.
	
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
			return;
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && HitLoc.Z <= Start.Z - class'BallisticTurret'.default.MinTurretEyeDepth - 4 && (T.bWorldGeometry && (Sandbag(T) == None || Sandbag(T).AttachedWeapon == None)) && HitNorm.Z >= 0.9 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	if(Sandbag(T) != None)
	{
		HitLoc = T.Location;
		HitLoc.Z += class'M575Turret'.default.CollisionHeight + T.CollisionHeight * 0.75;
	}
	
	else
	{
		HitLoc.Z += class'M575Turret'.default.CollisionHeight - 9;
	}
	
	CompressedEq = Instigator.Rotation;
		
	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.
	
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Turret = Spawn(class'M575Turret', None,, HitLoc, CompressedEq);
	
    if (Turret != None)
    {
    	if (Sandbag(T) != None)
			Sandbag(T).AttachedWeapon = Turret;
		Turret.InitDeployedTurretFor(self);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    else
		log("Notify_Deploy: Could not spawn turret for M575 Machinegun");
}*/

simulated function PlayReload()
{
	PlayAnim('ReloadHold', ReloadAnimRate, , 0.25);
}

// Play second half of reload anim. It will be different depending on how many bullets are being loaded
simulated function PlayReloadFinish()
{
	SetBoxVisibility();
	SetBeltVisibility(Ammo[0].AmmoAmount+MagAmmo+1);
	if (Ammo[0].AmmoAmount+MagAmmo < BeltLength+1)// Belt with no Box
		PlayAnim('ReloadFinishFew', 0.8*ReloadAnimRate, ,0.0);
	else						// Full Box and Belt
		PlayAnim('ReloadFinish', 0.8*ReloadAnimRate, ,0.0);
}

simulated function Notify_M353FlapOpenedReload ()
{
	super.PlayReload();
}

// Animation notify to make gun cock after reload
simulated function Notify_CockAfterReload()
{
	if (bNeedCock && MagAmmo > 0)
		CommonCockGun(2);
	else
		PlayAnim('ReloadFinishHold', ReloadAnimRate, 0.2);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim('ReloadEndCock'))
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

/*simulated function PositionSights ()
{
	super.PositionSights();
	if (SightingPhase <= 0.0)
		SetBoneRotation('TopHandle', rot(0,0,0));
	else if (SightingPhase >= 1.0 )
		SetBoneRotation('TopHandle', rot(0,0,-8192));
	else
		SetBoneRotation('TopHandle', class'BUtil'.static.RSmerp(SightingPhase, rot(0,0,0), rot(0,0,-8192)));
}*/

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

/*function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None || class != W.Class)
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
    }
 	
   	else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;
	    

    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            W.GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	if (MeleeFireMode != None)
		MeleeFireMode.Instigator = Instigator;

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}*/

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || Clientstate != WS_ReadyToFire || SightingState != SS_None)
		return;
		
	TemporaryScopeDown(0.5);
	
	if (Level.NetMode == NM_Client)
		ServerSwitchScopeType(!bScopeOn);
	SwitchScopeType(!bScopeOn);
}

function ServerSwitchScopeType(bool bNewScope)
{
	SwitchScopeType(bNewScope);
}

simulated function byte GetRecoilParamsIndex()
{
	return byte(bScopeOn);
}

simulated function SwitchScopeType(bool bNewScope)
{
	if (bNewScope == bScopeOn)
		return;
	
	if (Role == ROLE_Authority)
		bServerReloading=True;
	
	TemporaryScopeDown(0.5);
	ReloadState = RS_GearSwitch;
	
	bScopeAnimEnded = False;
	bScopeOn = bNewScope;
	
	SetBoneRotation('ScopeHinge', ScopeOnRot);
	
	if (bNewScope)
		PlayAnim(ScopeOnAnim);
	else
		PlayAnim(ScopeOffAnim);

	GetParams().static.SetRecoilParams(self);
}

simulated function Notify_ScopeShow(){	UpdateBones();}
simulated function Notify_ScopeHide(){	UpdateBones();}

simulated function UpdateBones()
{
	if (bScopeOn)
		SetBoneRotation('ScopeHinge', ScopeOnRot);
	else
		SetBoneRotation('ScopeHinge', ScopeOffRot);
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Anim == ScopeOffAnim || Anim == ScopeOnAnim)
	{
		if (Role == ROLE_Authority)
			bServerReloading=False;
			
		bScopeAnimEnded = True;
		SetScopeProperties();
	}
		
	super.AnimEnded(Channel, anim, frame, rate);
}

simulated function SetScopeProperties()
{
	if (bScopeOn)
	{
		ZoomType = ZT_Fixed;
		SightingTime = 0.6;
		ScopeViewTex = ScopeScopeViewTex;
		MaxZoom=2;
	}
	else
	{
		ZoomType = ZT_Irons;
		ScopeViewTex = None;
		SightingTime = default.SightingTime;
	}
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 1024, 2048); 
}

simulated function float ChargeBar()
{
	if (!bShowCharge)
		return 0;
	else
		return AmpCharge / 10;
}

simulated function WeaponTick(float DT)
{
	Super.WeaponTick(DT);
	
	if (!IsFiring() && IceCharge < 20 && Level.TimeSeconds > LastChargeTime + ChargeInterval)
	{
		IceCharge++;
		LastChargeTime = Level.TimeSeconds;
	}
	if (AmpCharge > 0)
		AmpCharge = FMax(0, AmpCharge - DrainRate*DT);
}

//==============================================
// Amp Code
//==============================================

//mount or unmount amp
/*exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	
	if (bAmped)	//take off amp
	{
		bAmped = !bAmped;
		ServerSwitchAmplifier(bAmped);
		SwitchAmplifier(bAmped);
	}
}*/

exec simulated function ToggleAmplifier(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;

	TemporaryScopeDown(0.5);

	bAmped = !bAmped;
	ServerSwitchAmplifier(bAmped);
	SwitchAmplifier(bAmped);
}
function ServerSwitchAmplifier(bool bNewValue)
{
	bAmped = bNewValue;

	SwitchAmplifier(bAmped);

	bServerReloading=True;
	ReloadState = RS_GearSwitch;

	if (bAmped)
	{
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		WeaponModes[3].bUnavailable=true;
		WeaponModes[4].bUnavailable=false;
		CurrentWeaponMode=4;
		ServerSwitchWeaponMode(4);
		AmpCharge=10;
	}
	else
	{
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		WeaponModes[3].bUnavailable=false;
		WeaponModes[4].bUnavailable=true;
		CurrentWeaponMode=3;
		ServerSwitchWeaponMode(3);
		AmpCharge=0;
	}
		
	if (Role == ROLE_Authority)
		M575Attachment(ThirdPersonActor).SetAmped(bNewValue);
		
	if (CurrentWeaponMode == 1 && AmpCharge > 0)	//blue
	{
		Skins[4]=AmpMaterials[0];
		Skins[5]=AmpMaterials[1];
	}
}

simulated function SwitchAmplifier(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
		
	ReloadState = RS_GearSwitch;

	if (bNewValue)
	{
		PlayAnim(AmplifierOnAnim);
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		WeaponModes[3].bUnavailable=true;
		WeaponModes[4].bUnavailable=false;
		AmpCharge=10;
	}
	else
	{
		PlayAnim(AmplifierOffAnim);
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		WeaponModes[3].bUnavailable=false;
		WeaponModes[4].bUnavailable=true;
		CurrentWeaponMode=3;
		ServerSwitchWeaponMode(3);
		AmpCharge=0;
	}
		
	if (Role == ROLE_Authority)
		M575Attachment(ThirdPersonActor).SetAmped(bNewValue);
		
	if (CurrentWeaponMode == 4 && AmpCharge > 0)	//blue
	{
		Skins[4]=AmpMaterials[0];
		Skins[5]=AmpMaterials[1];
	}
}

simulated function ServerSwitchWeaponMode (byte newMode)
{
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		M575PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
}

simulated function CommonSwitchWeaponMode (byte newMode)
{
	super.CommonSwitchWeaponMode(newMode);

	M575PrimaryFire(FireMode[0]).SwitchWeaponMode(newMode);
	if (newMode == 4 && AmpCharge > 0)	//blue
	{
		Skins[4]=AmpMaterials[0];
		Skins[5]=AmpMaterials[1];
	}
}

simulated function AddHeat(float Amount)
{
	if (bBerserk)
		Amount *= 0.75;
		
	AmpCharge = FMax(0, AmpCharge + Amount);
	
	if (AmpCharge <= 0)
	{
		PlaySound(AmplifierPowerOffSound,,2.0,,32);
		Skins[4]=AmpMaterials[2];
		Skins[5]=AmpMaterials[3];
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		WeaponModes[3].bUnavailable=false;
		WeaponModes[4].bUnavailable=true;
		CurrentWeaponMode=3;
		ServerSwitchWeaponMode(3);
		if (Role == ROLE_Authority)
			M575Attachment(ThirdPersonActor).SetAmped(false);
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	AmpCharge = NewHeat;
}

simulated function Notify_AmpOn()	{	PlaySound(AmplifierOnSound,,0.5);		bShowCharge=true;}
simulated function Notify_AmpOff()	{	PlaySound(AmplifierOffSound,,0.5);		bShowCharge=false;}

simulated function Notify_AMPShow(){	SetBoneScale (2, 1.0, AmplifierBone);	}
simulated function Notify_AmpHide(){	SetBoneScale (2, 0.0, AmplifierBone);	}

simulated function Notify_AMPOnTurn(){	PlaySound(AmplifierOnTurnSound,,0.5);}
simulated function Notify_AMPOffTurn(){	PlaySound(AmplifierOffTurnSound,,0.5);}
//==============================================
// Regular Functions
//==============================================

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (bAmped)
		SetBoneScale (2, 1.0, AmplifierBone);
	else
		SetBoneScale (2, 0.0, AmplifierBone);
}



// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}

defaultproperties
{
	AmplifierBone="AMP"
    AmplifierOnAnim="AMPApply"
    AmplifierOffAnim="AMPRemove"
    AmplifierOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
    AmplifierOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
    AmplifierPowerOnSound=Sound'BW_Core_WeaponSound.AMP.Amp-Install'
    AmplifierPowerOffSound=Sound'BW_Core_WeaponSound.AMP.Amp-Depleted'
	AmplifierOnTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	AmplifierOffTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	DrainRate=0.15
	
	AmpMaterials[0]=Shader'BW_Core_WeaponTex.Amp.Amp-FinalCyan'
	AmpMaterials[1]=Shader'BW_Core_WeaponTex.AMP.Amp-GlowCyanShader'
    AmpMaterials[2]=Texture'BW_Core_WeaponTex.Amp.Amp-BaseDepleted'
    AmpMaterials[3]=Texture'ONSstructureTextures.CoreGroup.Invisible'
	
	 ScopeOnAnim="ScopeOn"
     ScopeOffAnim="ScopeOff"
	 ScopeScopeViewTex=Texture'BWBP_OP_Tex.M575.M575Scope'
	 ScopeOnRot=(Roll=0)
	 ScopeOffRot=(Roll=-21845)
     BoxOnSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-BoxOn',Volume=1.500000)
     BoxOffSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-BoxOff',Volume=1.500000)
     FlapUpSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Open',Volume=1.500000)
     FlapDownSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Close',Volume=1.500000)
     PlayerSpeedFactor=0.90000
     PlayerJumpFactor=0.900000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBP_OP_Tex.M575.BigIcon_M575'
     BigIconCoords=(Y1=50,Y2=240)
	 SightAnimScale=0.5
     SightFXClass=Class'BWBP_OP_Pro.M575SightLEDs'
	 SightBobScale=0.6
     bWT_Bullet=True
     bWT_Machinegun=True
     ManualLines(0)="Automatic 5.56mm fire. Has a high rate of fire, moderate damage and good sustained damage output. As a machinegun, it has a very long effective range. Large magazine capacity allows the weapon to fire for a long time, but the reload time is long."
     ManualLines(1)="Automatic Ice Rounds. Slows the enemy down a small amount making it easier to hit the primary fire rounds. Does less damage and has a slightly slower fire rate, but will give an advantage once used."
     ManualLines(2)="Enable the Hybrid Scope. While the hybrid scope is enabled, you will have access to a fixed 2X Scope, which can be taken off when out of combat."
	 ManualLines(3)="In response to not just the regular UTC troops demanding a new LMG, but also the ODST troops finding the M353 to be inadequate in stopping skrith dead in their tracks, Enravion updated the platform into the new M575 Machine Gun. In addition to firing 7.62mm rounds instead of the old 5.56mm rounds, the M575 also has rail support for all the optics one could ever ask for; when the weapon first debuted, it came with a C-All Red Dot Sight along with a 2x magnifier scope. While the M353 is still hanging around, it is slated to be phased by the M575 within 6 months if all goes well."
     SpecialInfo(0)=(Info="330.0;25.0;0.7;-1.0;1.0;0.2;-999.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Pullout',Pitch=0.9,Volume=0.215000)
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Putaway',Pitch=0.9,Volume=0.285000)
     CockSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-BoltQuick',Volume=1.500000)
	 CockSelectSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-BoltQuick',Volume=1.500000)
     ReloadAnim="ReloadStart"
	 CockingBringUpTime=2.100000
	 //SightFXBone="Muzzle"
     ClipOutSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Belt')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-ShellIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(ModeName="Burst of Three")
     WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_BigBurst",Value=5.000000)
     WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	 WeaponModes(4)=(ModeName="Amp: Ice Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
     CurrentWeaponMode=3
     bNoCrosshairInScope=True
	 bShowChargingBar=True
     SightOffset=(X=0,Y=0,Z=2.1)
     FireModeClass(0)=Class'BWBP_OP_Pro.M575PrimaryFire'
     FireModeClass(1)=Class'BWBP_OP_Pro.M575SecondaryFire'
     SelectAnimRate=1.350000
     PutDownTime=0.550000
     BringUpTime=0.700000
     SelectForce="SwitchToAssaultRifle"
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M353InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=162,G=0,R=0,A=255),Color2=(B=0,G=255,R=255,A=255),StartSize1=96,StartSize2=96)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     AIRating=0.7500000
     CurrentRating=0.7500000
     Description="In response to not just the regular UTC troops demanding a new LMG, but also the ODST troops finding the M353 to be inadequate in stopping skrith dead in their tracks, Enravion updated the platform into the new M575 Machine Gun. In addition to firing 7.62mm rounds instead of the old 5.56mm rounds, the M575 also has rail support for all the optics one could ever ask for; when the weapon first debuted, it came with a C-All Red Dot Sight along with a 2x magnifier scope. While the M353 is still hanging around, it is slated to be phased by the M575 within 6 months if all goes well."
     Priority=43
     HudColor=(R=15,G=175,B=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BWBP_OP_Pro.M575Pickup'
     PlayerViewOffset=(X=6.00,Y=4.50,Z=-4.00)
     AttachmentClass=Class'BWBP_OP_Pro.M575Attachment'
     IconMaterial=Texture'BWBP_OP_Tex.M575.SmallIcon_M575'
     IconCoords=(X2=127,Y2=31)
     ItemName="M575 Medium Machinegun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClasses(0)=Class'M575MachinegunWeaponParamsComp'
	 ParamsClasses(1)=Class'M575MachinegunWeaponParamsClassic'
	 ParamsClasses(2)=Class'M575MachinegunWeaponParamsRealistic'
     ParamsClasses(3)=Class'M575MachinegunWeaponParamsTactical'
     Mesh=SkeletalMesh'BWBP_OP_Anim.M575_FPm'
     DrawScale=0.3
	 Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	 Skins(1)=Shader'BWBP_SKC_Tex.CYLO.CYLO-SightShader'
	 Skins(2)=Shader'BWBP_OP_Tex.M575.M575_scope_SH1'
	 Skins(3)=Shader'BWBP_OP_Tex.M575.M575_body_SH1'
	 Skins(4)=Shader'BW_Core_WeaponTex.AMP.Amp-FinalCyan'
	 Skins(5)=Shader'BW_Core_WeaponTex.AMP.Amp-GlowCyanShader'
}
