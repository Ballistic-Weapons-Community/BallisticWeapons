//=============================================================================
// G51Carbine.
//
// Medium range, controllable 3-round burst carbine.
// Lacks power and accuracy at range, but is easier to aim
//
// by Sarge.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G51Carbine extends BallisticWeapon;

var() name		GrenadeLoadAnim;	//Anim for grenade reload
var()   bool		bLoaded;


var() name		GrenBone;			
var() name		GrenBoneBase;
var() Sound		GrenSlideSound;		//Sounds for grenade reloading
var() Sound		ClipInSoundEmpty;		//			

var() name			BulletBone;
var() name			BulletBone2;

// IR Code
var() bool				bHasIR;
var()   Texture			ScopeviewTexIR;

var() BUtil.FullSound	ThermalOnSound;	// Sound when activating thermal mode
var() BUtil.FullSound	ThermalOffSound;// Sound when deactivating thermal mode
var(IR)   Array<Pawn>		PawnList;		// A list of all the potential pawns to view in thermal mode
var(IR) material			WallVisionSkin;	// Texture to assign to players when theyare viewed with Thermal mode
var()   bool				bThermal;		// Is thermal mode active?
var(IR)   bool				bUpdatePawns;	// Should viewable pawn list be updated
var(IR)   Pawn				UpdatedPawns[16];// List of pawns to view in thermal scope
var(IR) material			Flaretex;		// Texture to use to obscure vision when viewing enemies directly through the thermal scope
var(IR) float				ThermalRange;	// Maximum range at which it is possible to see enemies through walls
var(IR)   ColorModifier		ColorMod;
var(IR)   Array<M58Cloud>	SmokeList;		// A list of all the potential pawns to view in thermal mode
var(IR)   actor			NVLight;
var   float				NextPawnListUpdateTime;
var bool			bSilenced;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerAdjustThermal;
	reliable if (ROLE == ROLE_Authority)
		bLoaded;
}

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	bHasIR=false;
	bSilenced=false;

	if (InStr(WeaponParams.LayoutTags, "IR") != -1)
	{
		bHasIR=true;
		bThermal=true;
		AdjustThermalView(true);
	}

	if (InStr(WeaponParams.LayoutTags, "silencer") != -1)
	{
		bSilenced = true;
	}
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_STANAGChaff';
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

	if(Instigator.FindInventoryType(class'BWBP_SKC_Pro.ChaffGrenadeWeapon')!=None )
	{
		W = Spawn(class'BWBP_SKC_Pro.ChaffGrenadeWeapon',,,Instigator.Location);
		if( W != None)
		{
			W.GiveTo(Instigator);
			W.ConsumeAmmo(0, 9999, true);
			W.ConsumeAmmo(1, 9999, true);
		}
	}
}
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Anim == 'Fire' || Anim == 'ReloadEmpty')
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 2)
		{
			SetBoneScale(2,0.0,BulletBone);
			SetBoneScale(3,0.0,BulletBone2);
		}
	}
	super.AnimEnd(Channel);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (!bLoaded)
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}
	else
	{
		SetBoneScale (0, 1.0, GrenBone);
		SetBoneScale (1, 1.0, GrenBoneBase);
	}
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{

		SetBoneScale(2,0.0,BulletBone);
		SetBoneScale(3,0.0,BulletBone2);
		ReloadAnim = 'ReloadEmpty';
	}
	else
	{
		ReloadAnim = 'Reload';
	}
	super.BringUp(PrevWeapon);

	if (ColorMod != None)
		return;
	ColorMod = ColorModifier(Level.ObjectPool.AllocateObject(class'ColorModifier'));
	if ( ColorMod != None )
	{
		ColorMod.Material = FinalBlend'BW_Core_WeaponTex.M75.OrangeFinal';
		ColorMod.Color.R = 255;
		ColorMod.Color.G = 255;
		ColorMod.Color.B = 255;
		ColorMod.Color.A = 255;
		ColorMod.AlphaBlend = false;
		ColorMod.RenderTwoSided=True;
	}
}

simulated function bool PutDown()
{

	if (!bLoaded)
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}

	if (super.PutDown())
	{
		AdjustThermalView(false);
		return true;
	}
	return false;
}

simulated event Destroyed()
{
	if (ColorMod != None)
	{
		Level.ObjectPool.FreeObject(ColorMod);
		ColorMod = None;
	}
	AdjustThermalView(false);

	if (NVLight != None)
		NVLight.Destroy();
		

	super.Destroyed();
}

//=====================================================
// IR Scope
//=====================================================

exec simulated function WeaponSpecial(optional byte i)
{
	if (ClientState != WS_ReadyToFire || ReloadState != RS_None || !bHasIR)
		return;
		
	bThermal = !bThermal;
	if (bThermal)
	{
    	class'BUtil'.static.PlayFullSound(self, ThermalOnSound);
    	ServerWeaponSpecial(1);
    }
	else
	{
    	class'BUtil'.static.PlayFullSound(self, ThermalOffSound);
    	ServerWeaponSpecial(0);
    }
    
    AdjustThermalView(bThermal);
}

function ServerWeaponSpecial(optional byte i)
{
	bThermal = bool(i);
	ServerAdjustThermal(bThermal);
}

simulated function OnScopeViewChanged()
{
	super.OnScopeViewChanged();
		
	if (!bScopeView)
	{
		if (Level.NetMode == NM_Client)
			AdjustThermalView(false);
		else ServerAdjustThermal(false);
	}
	else if (bThermal)
	{
		if (Level.NetMode == NM_Client)
			AdjustThermalView(true);
		else ServerAdjustThermal(true);
	}	
}

simulated function SetNVLight(bool bOn)
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (bOn)
	{
		if (NVLight == None)
		{
			NVLight = Spawn(class'HKARNVLight',,,Instigator.location);
			NVLight.SetBase(Instigator);
		}
		NVLight.bDynamicLight = true;
	}
	else if (NVLight != None)
		NVLight.bDynamicLight = false;
}

simulated event WeaponTick(float DT)
{
	local actor T;

	local vector HitLoc, HitNorm, Start, End;

	super.WeaponTick(DT);

	if (Level.TimeSeconds >= NextPawnListUpdateTime)
		UpdatePawnList();

	if (bThermal && bScopeView)
	{
		SetNVLight(true);

		Start = Instigator.Location+Instigator.EyePosition();
		End = Start+vector(Instigator.GetViewRotation())*1500;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(16,16,16));
		if (T==None)
			HitLoc = End;

		if (VSize(HitLoc-Start) > 400)
			NVLight.SetLocation(Start + (HitLoc-Start)*0.5);
		else
			NVLight.SetLocation(HitLoc + HitNorm*30);
	}
	else
		SetNVLight(false);
}

// Draw the scope view
simulated event RenderOverlays (Canvas C)
{
	if ( (Instigator == None) || (Instigator.Controller == None))
		return;

	if (SprintControl != None)
		SprintControl.RenderOverlays(C);

	if (!bScopeView || ZoomType == ZT_Irons)
		DrawFPWeapon(C);
	else
	{
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());

		DrawScopeMuzzleFlash(C);
		DrawScopeOverlays(C);
	}
}

simulated event DrawScopeOverlays(Canvas C)
{  
	if (bThermal)
		DrawThermalMode(C);

	Super.DrawScopeOverlays(C);
}

simulated function UpdatePawnList()
{
	local Pawn P;
	local int i;
	local float Dist;

	PawnList.Length=0;
	ForEach DynamicActors( class 'Pawn', P)
	{
		PawnList[PawnList.length] = P;
		Dist = VSize(P.Location - Instigator.Location);
		if (Dist <= ThermalRange &&
			( Normal(P.Location-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()) > 1-((Instigator.Controller.FovAngle*0.9)/180) ) &&
			((Instigator.LineOfSightTo(P)) || Normal(P.Location - Instigator.Location) Dot Vector(Instigator.GetViewRotation()) > 0.985 + 0.015 * (Dist/ThermalRange)))
		{
			if (!Instigator.IsLocallyControlled())
			{
				P.NetUpdateTime = Level.TimeSeconds - 1;
				P.bAlwaysRelevant = true;
			}
			UpdatedPawns[i]=P;
			i++;
		}
	}
}

//Blocks IR
/*simulated function UpdateSmokeList()
{
	local Smoke S;
	local int i;
	local float Dist;

	SmokeList.Length=0;
	ForEach VisibleActors( class 'M58Cloud', S)
	{
		SmokeList[SmokeList.length] = S;
	}
}*/

// Draws players in bright colors and all the other Thermal Mode stuff
simulated event DrawThermalMode (Canvas C)
{
	local Pawn P;
	local M58Cloud Other;
	local int i, j;
	local float Dist, DotP;//, OtherRatio;
	local Array<Material>	OldSkins;
	local int OldSkinCount;
	local bool bLOS, bFocused;
	local vector Start;
	local Array<Material>	AttOldSkins0;
	local Array<Material>	AttOldSkins1;
	
	local Vector					HitLocation, HitNormal;

	C.Style = ERenderStyle.STY_Modulated;
	
	// Draw Spinning Sweeper thing
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.SetDrawColor(255,255,255,255);
	C.DrawTile(FinalBlend'BW_Core_WeaponTex.Attachment.SKAR-IRFinal', C.SizeY, C.SizeY, 0, 0, 1024, 1024);
	// Draw some panning lines 
	C.SetPos(C.OrgX, C.OrgY);
	C.DrawTile(FinalBlend'BWBP_SKC_Tex.SKAR.SKAR-StaticFinal', C.SizeX, C.SizeY, 0, 0, 1024, 1024); 

	if (ColorMod == None)
		return;
	// Draw the players with an purp effect
	C.Style = ERenderStyle.STY_Alpha;
	Start = Instigator.Location + Instigator.EyePosition();
	for (j=0;j<PawnList.length;j++)
	{
		if (PawnList[j] != None && PawnList[j] != Level.GetLocalPlayerController().Pawn)
		{
			P = PawnList[j];
			bFocused=false;
			bLos=false;
			ThermalRange = default.ThermalRange + 2000 * FMin(1, VSize(P.Velocity) / 450);
			Dist = VSize(P.Location - Instigator.Location);
			if (Dist > ThermalRange)
				continue;
			DotP = Normal(P.Location - Start) Dot Vector(Instigator.GetViewRotation());
			if ( DotP < Cos((Instigator.Controller.FovAngle/1.7) * 0.017453) )
				continue;
			// If we have a clear LOS then they can be drawn
			if (Instigator.LineOfSightTo(P))
				bLOS=true;
			//check for smoke (todo: replace this with a more efficient vector check)
			//ForEach TraceActors(class'M58Cloud', Other, HitLocation, HitNormal, P.Location, Location)
			//{
			//	if (Other != None)
			//		bLOS=false;
			//}
			//Other = Trace(HitLocation, HitNormal, P.Location, Location, true, vect(1,1,1));
			//log("Trace found "$Other);
			//if (Other != None && M58Cloud(Other) != None)
			//	bLOS=false;
			if (bLOS)
			{
				DotP = (DotP-0.6) / 0.4;

				DotP = FMax(DotP, 0);

				if (Dist < 500)
					ColorMod.Color.R = DotP * 255.0;
				else
					ColorMod.Color.R = DotP * ( 255 - FClamp((Dist-500)/((ThermalRange-500)*0.8), 0, 1) * 255 );
				ColorMod.Color.G = DotP * ( 128.0 - (Dist/ThermalRange)*96.0 );

				// Remember old skins, set new skins, turn on unlit...
				OldSkinCount = P.Skins.length;
				for (i=0;i<Max(2, OldSkinCount);i++)
				{	if (OldSkinCount > i) OldSkins[i] = P.Skins[i]; else OldSkins[i]=None;	P.Skins[i] = ColorMod;	}
				P.bUnlit=true;
				for (i=0;i<P.Attached.length;i++)
					if (P.Attached[i] != None)
					{
						if (Pawn(P.Attached[i]) != None || ONSWeapon(P.Attached[i]) != None/* || InventoryAttachment(P.Attached[i])!= None*/)
						{
							if (P.Attached[i].Skins.length > 0)
							{	AttOldSkins0[i] = P.Attached[i].Skins[0];	P.Attached[i].Skins[0] = ColorMod;	}
							else
							{	AttOldSkins0[i] = None;	P.Attached[i].Skins[0] = ColorMod;	}
							if (P.Attached[i].Skins.length > 1)
							{	AttOldSkins1[i] = P.Attached[i].Skins[1];	P.Attached[i].Skins[1] = ColorMod;	}
							if (P.Attached[i].Skins.length > 1)
							{	AttOldSkins1[i] = None;	P.Attached[i].Skins[1] = ColorMod;	}
						}
						else
							P.Attached[i].SetDrawType(DT_None);
					}

				C.DrawActor(P, false, true);

				// Set old skins back, Unlit off
				P.Skins.length = OldSkinCount;
				for (i=0;i<P.Skins.length;i++)
					P.Skins[i] = OldSkins[i];
				P.bUnlit=false;

				for (i=0;i<P.Attached.length;i++)
					if (P.Attached[i] != None)
					{
						if (Pawn(P.Attached[i]) != None || ONSWeapon(P.Attached[i]) != None/* || InventoryAttachment(P.Attached[i])!= None*/)
						{
							if (AttOldSkins1[i] == None)
							{
								if (AttOldSkins0[i] == None)
									P.Attached[i].Skins.length = 0;
								else
								{
									P.Attached[i].Skins.length = 1;
									P.Attached[i].Skins[0] = AttOldSkins0[i];
								}
							}
							else
							{
								P.Attached[i].Skins[0] = AttOldSkins0[i];
								P.Attached[i].Skins[1] = AttOldSkins1[i];
							}
						}
						else
							P.Attached[i].SetDrawType(P.Attached[i].default.DrawType);
					}
				AttOldSkins0.length = 0;
				AttOldSkins1.length = 0;
			}
			else
				continue;
		}
	}
}

simulated function AdjustThermalView(bool bNewValue)
{
	if (AIController(Instigator.Controller) != None)
		return;
	if (!bNewValue)
	{
		bUpdatePawns = false;
	}
	else
	{
		bUpdatePawns = true;
		UpdatePawnList();
		NextPawnListUpdateTime = Level.TimeSeconds + 1;
	}
}

function ServerAdjustThermal(bool bNewValue)
{
	local int i;
	
	if (bNewValue)
	{
		bUpdatePawns = true;
		UpdatePawnList();
		NextPawnListUpdateTime = Level.TimeSeconds + 1;
	}
	else
	{
		bUpdatePawns = false;
		for (i=0;i<ArrayCount(UpdatedPawns);i++)
		{
			if (UpdatedPawns[i] != None)
				UpdatedPawns[i].bAlwaysRelevant = UpdatedPawns[i].default.bAlwaysRelevant;
		}
	}
}

//======================================================
// Grenade Stuff
//======================================================

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || bLoaded)
		return;
	if (ReloadState == RS_None)
	{
		ReloadState = RS_GearSwitch;
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
	}
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(2,1.0,BulletBone);
	SetBoneScale(3,1.0,BulletBone2);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
	{
		SetBoneScale(2,0.0,BulletBone);
		SetBoneScale(3,0.0,BulletBone2);
	}
}


// Notifys for greande loading sounds
simulated function Notify_GrenVisible()	{	SetBoneScale (0, 1.0, GrenBone); SetBoneScale (1, 1.0, GrenBoneBase);	ReloadState = RS_PreClipIn;}
simulated function Notify_GrenSlide()	{	PlaySound(GrenSlideSound, SLOT_Misc, 2.2, ,64);	}
simulated function Notify_GrenLoaded()	
{
    local Inventory Inv;

	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PostClipIn;

	G51Attachment(ThirdPersonActor).bGrenadier=true;	
	G51Attachment(ThirdPersonActor).IAOverride(True);

	Ammo[1].UseAmmo (1, True);
	bLoaded = true;
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
simulated function Notify_GrenReady()	{	ReloadState = RS_None;	}
simulated function Notify_GrenLaunch()	
{
	SetBoneScale (0, 0.0, GrenBone); 	
	G51Attachment(ThirdPersonActor).IAOverride(False);
	G51Attachment(ThirdPersonActor).bGrenadier=false;
}
simulated function Notify_GrenInvisible()	{ SetBoneScale (1, 0.0, GrenBoneBase);	}


simulated function PlayReload()
{

    if (MagAmmo < 1)
    {
       ReloadAnim='ReloadEmpty';
       ClipHitSound.Sound=ClipInSoundEmpty;
    }
    else
    {
       ReloadAnim='Reload';
       ClipHitSound.Sound=default.ClipHitSound.Sound;
    }
	if (!bLoaded)
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}
	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

simulated function IndirectLaunch()
{
//	StartFire(1);
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

	if (bHasIR || bSilenced || bNoaltfire)
		return 0;		

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
     ThermalOnSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOn',Volume=0.500000,Pitch=1.000000)
     ThermalOffSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOff',Volume=0.500000,Pitch=1.000000)
     WallVisionSkin=FinalBlend'BW_Core_WeaponTex.M75.OrangeFinal'
     Flaretex=FinalBlend'BW_Core_WeaponTex.M75.OrangeFlareFinal'
     ThermalRange=25000.000000
	 
     GrenadeLoadAnim="LoadGrenade"
     GrenBone="Grenade"
     GrenBoneBase="GrenadeHandle"
     GrenSlideSound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-GrenLock'
     ClipInSoundEmpty=Sound'BWBP_SKC_Sounds.MJ51.MJ51-MagInEmpty'
     BulletBone="Bullet1"
     BulletBone2="Bullet2"
     SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;0.8;0.7;0.2")
     AIReloadTime=1.000000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_Tex.G51.BigIcon_G51'
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-PullOut',Volume=0.223000)
     PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Putaway',Volume=0.270000)
     WeaponModes(0)=(ModeName="Semi-Auto")
     WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
     WeaponModes(2)=(bUnavailable=True)
     WeaponModes(3)=(ModeName="Automatic",bUnavailable=True,ModeID="WM_FullAuto")
     CurrentWeaponMode=1
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50Out',pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50In',USize1=128,VSize1=128,USize2=128,VSize2=128,Color1=(B=0,G=0,R=255,A=158),Color2=(B=0,G=255,R=255,A=255),StartSize1=75,StartSize2=72)
     bNoCrosshairInScope=True

	 PlayerViewOffset=(X=4.00,Y=4.50,Z=-3.00)
     SightOffset=(X=-0.50,Y=0.00,Z=-0.12)
	 SightBobScale=0.2

     CockSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Cock',Volume=1.800000)
     //ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-MagInEmpty',Volume=1.800000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-MagOut',Volume=1.800000)
	 ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-MagInEmpty',Volume=1.800000)
     ClipInFrame=0.650000
     LongGunOffset=(X=10.000000)
     bWT_Bullet=True
     SightingTime=0.200000
     GunLength=50.000000
     FireModeClass(0)=Class'BWBP_SKC_Pro.G51PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.G51SecondaryFire'
     IdleAnimRate=0.200000
     PutDownTime=0.700000
     BringUpTime=0.900000
	 CockingBringUpTime=2.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     Description="G51 Carbine||Manufacturer: Majestic Firearms 12|Primary: 5.56mm Rifle Fire|Secondary: Attach Smoke Grenade||The G51 is a 3-round burst carbine based off the popular SCAR-LK platform. While the S-AR 12 is the UTC's weapon of choice for close range engagements, the G51 is often seen in the hands of MP and urban security details. When paired with its native MOA-C Rifle Grenade attachment, the G51 makes an efficient riot control weapon. |Majestic Firearms 12 designed their G51 carbine alongside their MOA-C Chaff Grenade to produce a rifle with grenade launching capabilities without the need of a bulky launcher that has to be sperately maintained. Utilizing a hardened tungsten barrel and an advanced rifle grenade design, a soldier is able to seamlessly ready a grenade projectile without having to rechamber specilized rounds"
     Priority=41
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     PickupClass=Class'BWBP_SKC_Pro.G51Pickup'
	 SightAnimScale=0.3
     AttachmentClass=Class'BWBP_SKC_Pro.G51Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.G51.SmallIcon_G51'
     IconCoords=(X2=127,Y2=31)
     ItemName="G51 Carbine"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.G51Carbine_FPm'
	 ParamsClasses(0)=Class'G51WeaponParamsComp'
     ParamsClasses(1)=Class'G51WeaponParamsClassic'
     ParamsClasses(2)=Class'G51WeaponParamsRealistic'
	 ParamsClasses(3)=Class'G51WeaponParamsTactical'
     DrawScale=0.300000
}
