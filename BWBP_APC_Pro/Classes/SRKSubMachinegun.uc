//=============================================================================
// SRK SMG.
//
// Medium range, controllable 3-round burst carbine.
// Lacks power and accuracy at range, but is easier to aim
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SRKSubMachinegun extends BallisticWeapon;

var() bool		bFirstDraw;
var() name		GrenadeLoadAnim;	//Anim for grenade reload
var() bool		bLoaded;

var() name		GrenBone;			
var() Sound		GrenSlideSound;		//Sounds for grenade reloading
var() Sound		ClipInSoundEmpty;	//

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_SHADRACHChaff';
}

//Chaff grenade spawn moved here
function GiveTo(Pawn Other, optional Pickup Pickup)
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
		{
			GenerateLayout(BallisticWeaponPickup(Pickup).LayoutIndex);
			GenerateCamo(BallisticWeaponPickup(Pickup).CamoIndex);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
		}
		else
		{
			GenerateLayout(255);
			GenerateCamo(255);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
            MagAmmo = MagAmmo + (int(!bNonCocking) *  int(bMagPlusOne) * int(!bNeedCock));
		}
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
            GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }

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
	
	if ( Instigator.FindInventoryType(class'BCGhostWeapon') != None ) //ghosts are scary
	return;
}
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	super.AnimEnd(Channel);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (bFirstDraw && MagAmmo > 0)
	{
     	BringUpTime=2.0;
     	SelectAnim='Pullout';
		bFirstDraw=false;
		bLoaded=False;
	}
	else
	{
     	BringUpTime=default.BringUpTime;
		SelectAnim='Pullout';
	}
	if (!bLoaded)
	{
		SetBoneScale (5, 0.0, GrenBone);
	}
	super.BringUp(PrevWeapon);
}

simulated function bool PutDown()
{

	if (!bLoaded)
	{
		SetBoneScale (5, 0.0, GrenBone);
	}

	if (super.PutDown())
	{
		return true;
	}
	return false;
}


// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || bLoaded)
		return;
	if (ReloadState == RS_None)
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
}

// Notifys for greande loading sounds
simulated function Notify_GrenVisible()	{	SetBoneScale (5, 1.0, GrenBone); ReloadState = RS_PreClipOut;}
simulated function Notify_GrenSlide()	{	PlaySound(GrenSlideSound, SLOT_Misc, 2.2, ,64);	}
simulated function Notify_GrenLoaded()	
{
    	local Inventory Inv;

	SRKSmgAttachment(ThirdPersonActor).bGrenadier=true;	
	SRKSmgAttachment(ThirdPersonActor).IAOverride(True);

	Ammo[1].UseAmmo (1, True);
	if (Ammo[1].AmmoAmount == 0)
	{
		for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
			if (ChaffGrenadeWeapon(Inv) != None)
			{
				ChaffGrenadeWeapon(Inv).RemoteKill();	
				break;
			}
	}
}
simulated function Notify_GrenReady()	{	ReloadState = RS_None; bLoaded = true;	}
simulated function Notify_GrenLaunch()	
{
	SetBoneScale (5, 0.0, GrenBone); 	
	SRKSmgAttachment(ThirdPersonActor).IAOverride(False);
	SRKSmgAttachment(ThirdPersonActor).bGrenadier=false;
}
simulated function Notify_GrenInvisible()	{ SetBoneScale (5, 0.0, GrenBone);	}

simulated function IndirectLaunch()
{
//	StartFire(1);
}

// HARDCODED SIGHTING TIME
simulated function TickSighting (float DT)
{
	if (SightingState == SS_None || SightingState == SS_Active)
		return;

	if (SightingState == SS_Raising)
	{	// Raising gun to sight position
		if (SightingPhase < 1.0)
		{
			if ((bScopeHeld || bPendingSightUp) && CanUseSights())
				SightingPhase += DT/0.20;
			else
			{
				SightingState = SS_Lowering;

				Instigator.Controller.bRun = 0;
			}
		}
		else
		{	// Got all the way up. Now go to scope/sight view
			SightingPhase = 1.0;
			SightingState = SS_Active;
			ScopeUpAnimEnd();
		}
	}
	else if (SightingState == SS_Lowering)
	{	// Lowering gun from sight pos
		if (SightingPhase > 0.0)
		{
			if (bScopeHeld && CanUseSights())
				SightingState = SS_Raising;
			else
				SightingPhase -= DT/0.20;
		}
		else
		{	// Got all the way down. Tell the system our anim has ended...
			SightingPhase = 0.0;
			SightingState = SS_None;
			ScopeDownAnimEnd();
		}
	}
}


simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (B.Skill > Rand(6))
	{
		if (AimComponent.GetChaos() < 0.1 || AimComponent.GetChaos() < 0.5 && VSize(B.Enemy.Location - Instigator.Location) > 500)
			return 1;
	}
	else if (FRand() > 0.75)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     bFirstDraw=True
     GrenadeLoadAnim="LoadGrenade"
     GrenBone="Grenade"
     GrenSlideSound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-GrenLock'
     ClipInSoundEmpty=Sound'BWBP_SKC_Sounds.MJ51.MJ51-MagInEmpty'
     SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;0.8;0.7;0.2")
     AIReloadTime=1.000000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_OP_Tex.SPXSmg.BigIcon_SPXSmg'
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-PullOut',Volume=2.200000)
     PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Putaway',Volume=2.200000)
     WeaponModes(0)=(ModeName="Semi-Auto")
     WeaponModes(1)=(ModeName="Burst Fire")
     WeaponModes(2)=(bUnavailable=True)
     WeaponModes(3)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
     CurrentWeaponMode=1
     bNoCrosshairInScope=True
     SightOffset=(X=0.000000,Y=-0.350000,Z=15.800000)
     CockSound=(Sound=Sound'BWBP_OP_Sounds.SRKS.SRKS-Cock',Volume=1.600000)
     ClipInSound=(Sound=Sound'BWBP_OP_Sounds.SRKS.SRKS-ClipIn',Volume=1.600000)
     ClipOutSound=(Sound=Sound'BWBP_OP_Sounds.SRKS.SRKS-ClipOut',Volume=1.600000)
     ClipInFrame=0.650000
     LongGunOffset=(X=5.000000)
     bWT_Bullet=True
     SightingTime=0.200000
     ReloadAnimRate=0.850000
     GunLength=50.000000
     FireModeClass(0)=Class'BWBP_APC_Pro.SRKSmgPrimaryFire'
     FireModeClass(1)=Class'BWBP_APC_Pro.SRKSmgSecondaryFire'
     IdleAnimRate=0.200000
     PutDownTime=0.700000
     BringUpTime=0.900000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross3',USize1=128,VSize1=128,USize2=128,VSize2=128,Color1=(B=0,G=0,R=255,A=255),Color2=(B=0,G=0,R=0,A=84),StartSize1=16,StartSize2=55)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     CurrentRating=0.600000
     Description="Primary: 10mm Burst Fire||Secondary: Load/Fire Radioactive Chaff Grenade||With projected success rates for the SRK-650 reaching the minimum requirements, NDTR Industries had already gotten the green light to work on their sister project that originally was supposed to coincide with the SRK-650. The SRK-205 is an SMG version of the 650, chambered in the 10mm Super Auto cartridge to get maximum damage within close quarters confinements. Like it's older brother, the 205 has the same red dot and ammo counter, along with a threaded barrel.  Unlike the 650, the 205 doesn't have any AMP modules made for it, but it does come with radioactive chaff grenades to fry Cryon units and irradiated fleshy targets alike."
     Priority=41
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=3
     PickupClass=Class'BWBP_APC_Pro.SRKSmgPickup'
     PlayerViewOffset=(X=-6.000000,Y=6.000000,Z=-14.000000)
     BobDamping=2.250000
     AttachmentClass=Class'BWBP_APC_Pro.SRKSmgAttachment'
     IconMaterial=Texture'BWBP_OP_Tex.SRKSmg.SmallIcon_SPXSmg'
     IconCoords=(X2=127,Y2=31)
     ItemName="SRK-205 Submachinegun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_SRK'
	 ParamsClasses(0)=Class'SRKSmgWeaponParamsArena'
     ParamsClasses(1)=Class'SRKSmgWeaponParamsClassic'
     ParamsClasses(2)=Class'SRKSmgWeaponParamsRealistic'
     ParamsClasses(3)=Class'SRKSmgWeaponParamsTactical'
     DrawScale=0.300000
}
