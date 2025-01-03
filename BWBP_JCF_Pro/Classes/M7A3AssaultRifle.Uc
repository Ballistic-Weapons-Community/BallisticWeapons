//=============================================================================
// CommandoAssaultRifle.
//
// Highly compact, but innacurate assault rifle with switchable stock,
// lasersight, large mag, quick reloading and red-dot sights.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class M7A3AssaultRifle extends BallisticWeapon;

var M7A3TazerEffect TazerEffect;

var(M7A3)	int	            	NumpadYOffset1; //Ammo tens
var(M7A3)	int	            	NumpadYOffset2; //Ammo ones
var(M7A3) 	ScriptedTexture   	WeaponScreen;
var(M7A3) 	int               	ScreenIndex;

var(M7A3) 	Material	        Screen;
var(M7A3) 	Material	        ScreenBase;
var(M7A3) 	Material	        Numbers;

var protected const color MyFontColor; //Why do I even need this?


replication
{
	reliable if (Role == ROLE_Authority)
		ClientScreenStart;
}

//========================== AMMO COUNTER NON-STATIC TEXTURE ============

simulated function ClientScreenStart()
{
	ScreenStart();
}

// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	Skins[ScreenIndex] = Screen; //Set up scripted texture.
	UpdateScreen();//Give it some numbers n shit
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated function Destroyed()
{
	if (Instigator != None && AIController(Instigator.Controller) == None)
		WeaponScreen.client=None;
	Super.Destroyed();
}

simulated event RenderTexture( ScriptedTexture Tex )
{
	Tex.DrawTile(20,0,128,64,0,0,128,64,ScreenBase, MyFontColor); //Basic screen

	Tex.DrawTile(85,32,70,70,45,NumpadYOffset1,50,50,Numbers, MyFontColor); //Ammo
	Tex.DrawTile(105,32,70,70,40,NumpadYOffset2,50,50,Numbers, MyFontColor);
}
	
simulated function UpdateScreen()
{
	if (Instigator != None && AIController(Instigator.Controller) != None) //Bots cannot update your screen
		return;

	if (Instigator.IsLocallyControlled())
	{
			WeaponScreen.Revision++;
	}
}
	
// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	if (bNoMag || (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false))
		ConsumeAmmo(Mode, Load, bAmountNeededIsMax);
	else
	{
		if (MagAmmo < Load)
			MagAmmo = 0;
		else
			MagAmmo -= Load;
	}
	UpdateScreen();
	return true;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (Instigator != None && AIController(Instigator.Controller) == None) //Player Screen ON
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}

	Super.BringUp(PrevWeapon);
}

//=====================================================================

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None && Type != 1)
		TemporaryScopeDown(0.5);
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

//===========================================================================
// Tazer implementation.
//===========================================================================
simulated function RenderOverlays (Canvas C)
{
	NumpadYOffset1=(5+(MagAmmo/10)*49);
	NumpadYOffset2=(5+(MagAmmo%10)*49);

	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
	
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
		TazerEffect.SetLocation(BallisticAttachment(ThirdPersonActor).GetTipLocation());
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

// AI Interface =====
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	Result += (Dist-1000) / 2000;

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
    ScreenIndex=5
	WeaponScreen=ScriptedTexture'BWBP_SKC_Tex.FG50.FG50-ScriptLCD'
	screen=Shader'BWBP_SKC_Tex.FG50.FG50-ScriptLCD-SD'
	ScreenBase=Texture'UCGeneric.SolidColours.Black'
	Numbers=Texture'BWBP_SKC_Tex.PUMA.PUMA-Numbers'
	MyFontColor=(B=255,G=255,R=255,A=255)
	
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_JCF_Tex.M7A3.BigIcon_M7A3'
	bWT_Bullet=True
	SpecialInfo(0)=(Info="340.0;30.0;1.2;60.0;0.9;0.0;0.0")
	BringUpSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3_Pickup',Volume=0.220000)
	PutDownSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3_Select',Volume=0.600000)
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3-Cock',Volume=1.300000)
	ClipHitSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3_Mag_Hit',Volume=1.300000)
	ClipOutSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3_Mag_Out',Volume=1.300000)
	ClipInSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3_Mag_In',Volume=1.300000)
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Single Fire")
	WeaponModes(1)=(bUnavailable=True)
	FullZoomFOV=50.000000
	bNoCrosshairInScope=True
	SightOffset=(X=-3.000000,Y=-0.30000,Z=11.280000)
	SightingTime=0.250000
	ReloadAnimRate=1.25
	GunLength=16.000000
	LongGunPivot=(Pitch=2000,Yaw=-1024)
	LongGunOffset=(X=-20.000000,Y=0.000000,Z=-15.000000)
	BobDamping=2.25
	FireModeClass(0)=Class'BWBP_JCF_Pro.M7A3PrimaryFire'
	FireModeClass(1)=Class'BWBP_JCF_Pro.M7A3SecondaryFire'
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.R78OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',USize1=256,VSize1=256,USize2=128,VSize2=128,Color1=(B=0,G=144,R=0,A=135),Color2=(B=0,G=0,R=255,A=110),StartSize1=138,StartSize2=44)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	AIRating=0.600000
	CurrentRating=0.600000
	bSniping=True
	Description="M7A3 Battle Rifle||Manufacturer: UTC Defense Tech|Primary: Automatic 7.62mm Fire|Secondary: Activate Zooming Scope||The M7A3 Assault Rifle, made by UTC Defense Tech, is one of the newer additions to the modern day battlefield. Using a special bullpup magazine and specialized 4.77mm rounds, the M7A3 can accurately pick off long range targets with ease. The low recoil and good controllability of the rounds more than make up for their subpar damage ratings, and soldiers on average can bring twice as many clips into the field with minimal added fatigue. The M7A3 is a good alternative for those who deem the M50 uncontrollable and who dislike its tendency to buck when firing."
	DisplayFOV=55.000000
	Priority=33
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	PickupClass=Class'BWBP_JCF_Pro.M7A3Pickup'
	PlayerViewOffset=(X=5.000000,Y=3.000000,Z=-8.000000)
	AttachmentClass=Class'BWBP_JCF_Pro.M7A3Attachment'
	IconMaterial=Texture'BWBP_JCF_Tex.M7A3.SmallIcon_M7A3'
	IconCoords=(X2=127,Y2=35)
	ItemName="M7A3 Battle Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	ParamsClasses(0)=Class'M7A3WeaponParamsArena'
	ParamsClasses(1)=Class'M7A3WeaponParamsClassic'
	ParamsClasses(2)=Class'M7A3WeaponParamsRealistic'
	ParamsClasses(3)=Class'M7A3WeaponParamsTactical'
	Mesh=SkeletalMesh'BWBP_JCF_Anims.M7A3_FPm'
	DrawScale=1.0000000
}
