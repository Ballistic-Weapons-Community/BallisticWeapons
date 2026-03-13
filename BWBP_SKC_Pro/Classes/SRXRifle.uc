class SRXRifle extends BallisticWeapon;

var(SRX)   bool		bSilenced;				// Silencer on. Silenced
var(SRX) name		SilencerBone;			// Bone to use for hiding silencer
var(SRX) name		SilencerOnAnim;			// Think hard about this one...
var(SRX) name		SilencerOffAnim;		//
var(SRX) sound		SilencerOnSound;		// Silencer stuck on sound
var(SRX) sound		SilencerOffSound;		//

var() array<Material> AmpMaterials; //We're using this for the amp

var(SRX)   bool		bAmped;				// Amp installed, gun has new effects
var(SRX) name		AmplifierBone;			// Bone to use for hiding amp
var(SRX) name		AmplifierOnAnim;			//
var(SRX) name		AmplifierOffAnim;		//
var(SRX) sound		AmplifierOnSound;		// Silencer stuck on sound
var(SRX) sound		AmplifierOffSound;		//
var(SRX) sound		AmplifierPowerOnSound;		// Silencer stuck on sound
var(SRX) sound		AmplifierPowerOffSound;		//
var(SRX) float		AmpCharge;					// Existing ampjuice
var(SRX) float		DrainRate;					// Rate that ampjuice leaks out
var(SRX) bool		bShowCharge;				// Hides charge until the amp is on

var	  Rotator		RearSightBoneRot;
var(SRX) bool		bHasOptic;

// IR Code
var(SRX)	bool				bHasIR;
var(SRX)	Texture				ScopeviewTexIR;

var(SRX) 	BUtil.FullSound		ThermalOnSound;	// Sound when activating thermal mode
var(SRX)	BUtil.FullSound		ThermalOffSound;// Sound when deactivating thermal mode
var(SRX)	Array<Pawn>			PawnList;		// A list of all the potential pawns to view in thermal mode
var(SRX)	material			WallVisionSkin;	// Texture to assign to players when theyare viewed with Thermal mode
var(SRX)	bool				bThermal;		// Is thermal mode active?
var(SRX)	bool				bUpdatePawns;	// Should viewable pawn list be updated
var(SRX)	Pawn				UpdatedPawns[128];// List of pawns to view in thermal scope
var(SRX)	material			Flaretex;		// Texture to use to obscure vision when viewing enemies directly through the thermal scope
var(SRX)	float				ThermalRange;	// Maximum range at which it is possible to see enemies through walls
var(SRX)	ColorModifier		ColorMod;
var(SRX)	Array<M58Cloud>		SmokeList;		// A list of all the potential pawns to view in thermal mode
var(SRX)	actor				NVLight;
var(SRX)	float				NextPawnListUpdateTime;

//Scripted Ammo Screen Texture
var() ScriptedTexture 	WeaponScreen; //Scripted texture to write on
var() Material			WeaponScreenShader; //Scripted Texture with self illum applied
var() Material			ScreenBase;
var() Material			ScreenAmmoBlue; //Norm
var() Material			ScreenAmmoRed; //Low Ammo
var protected const color MyFontColor; //Why do I even need this?

var	float	AmmoBarPos;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientScreenStart, ClientSetHeat;
   	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer, ServerSwitchAmplifier,ServerAdjustThermal;	
}

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	bHasIR=false;
	
	bHasOptic=false;

	if (InStr(WeaponParams.LayoutTags, "IR") != -1)
	{
		bHasIR=true;
		bThermal=true;
		AdjustThermalView(true);
	}
	if (InStr(WeaponParams.LayoutTags, "optic") != -1)
	{
		bHasOptic=true;
		SetBoneScale(3, 0.0, 'IronsFront');
		SetBoneRotation('Sight',RearSightBoneRot);
	}
	else
	{
		Skins[4]=Texture'ONSstructureTextures.CoreGroup.Invisible';
		Skins[5]=Texture'ONSstructureTextures.CoreGroup.Invisible';
		Skins[6]=Texture'ONSstructureTextures.CoreGroup.Invisible';
		Skins[11]=Texture'ONSstructureTextures.CoreGroup.Invisible';
		Skins[12]=Texture'ONSstructureTextures.CoreGroup.Invisible';
	}
}

//==============================================
// Screen Code
//==============================================

simulated function ClientScreenStart()
{
	ScreenStart();
}
// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	//if (CamoIndex >= 3)
		Skins[11] = WeaponScreenShader; //Set up scripted texture.
	UpdateScreen();//Give it some numbers n shit
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated event RenderTexture( ScriptedTexture Tex )
{
	// 0 is full, 256 is empty
	AmmoBarPos = 256-(((MagAmmo)/20.0f)*256);

	//Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenBase, MyFontColor); //Basic screen
	if (MagAmmo > 5)
	{
		Tex.DrawTile(AmmoBarPos,0,256,256,0,0,512,256,ScreenAmmoBlue, MyFontColor); //Ammo
	}
	else
	{
		Tex.DrawTile(AmmoBarPos,0,256,256,0,0,512,256,ScreenAmmoRed, MyFontColor); //Ammo
	}
	
}

simulated event RenderOverlays( Canvas C )
{
	if (Instigator.IsLocallyControlled() && bHasOptic)
		WeaponScreen.Revision++;

	super.RenderOverlays(C);
}
	
simulated function UpdateScreen()
{
	if (!bHasOptic || (Instigator != None && AIController(Instigator.Controller) != None)) //Bots cannot update your screen
		return;

	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
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

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	super.Notify_ClipIn();
	UpdateScreen();
}

//mount or unmount silencer, but take off amp where necessary
exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || (SightingState != SS_None && !bHasIR))
		return;
		
	TemporaryScopeDown(0.5);
	
	if (bHasIR && bScopeView)
	{
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
		return;
	}
	
	if (bAmped)	//take off amp
	{
		bAmped = !bAmped;
		ServerSwitchAmplifier(bAmped);
		SwitchAmplifier(bAmped);
	}
	else
	{
		bSilenced = !bSilenced;
		ServerSwitchSilencer(bSilenced);
		SwitchSilencer(bSilenced);
	}
}

function ServerWeaponSpecial(optional byte i)
{
	if (bHasIR && bScopeView)
	{
		bThermal = bool(i);
		ServerAdjustThermal(bThermal);
	}
}

//mount or unmount amp, but take off silencer where necessary
exec simulated function ToggleAmplifier(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;

	TemporaryScopeDown(0.5);

	if (bSilenced)	//take off silencer
	{
		bSilenced = !bSilenced;
		ServerSwitchSilencer(bSilenced);
		SwitchSilencer(bSilenced);
	}
	else
	{
		bAmped = !bAmped;
		ServerSwitchAmplifier(bAmped);
		SwitchAmplifier(bAmped);
	}
}

//==============================================
// Amp Code
//==============================================

function ServerSwitchAmplifier(bool bNewValue)
{
	bAmped = bNewValue;

	SwitchAmplifier(bAmped);

	bServerReloading=True;
	ReloadState = RS_GearSwitch;

	if (bAmped)
	{
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		CurrentWeaponMode=1;
		ServerSwitchWeaponMode(1);
		AmpCharge=10;
	}
	else
	{
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		CurrentWeaponMode=0;
		ServerSwitchWeaponMode(0);
		AmpCharge=0;
	}
		
	if (Role == ROLE_Authority)
		SRXAttachment(ThirdPersonActor).SetAmped(bNewValue);
		
	if (CurrentWeaponMode == 1 && AmpCharge > 0)	//red
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[14]=AmpMaterials[0];
		Skins[15]=AmpMaterials[2];
	}
	else if (CurrentWeaponMode == 2 && AmpCharge > 0)	//green
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[14]=AmpMaterials[1];
		Skins[15]=AmpMaterials[3];
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
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		AmpCharge=10;
	}
	else
	{
		PlayAnim(AmplifierOffAnim);
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		AmpCharge=0;
	}
		
	if (Role == ROLE_Authority)
		SRXAttachment(ThirdPersonActor).SetAmped(bNewValue);
		
	if (CurrentWeaponMode == 1 && AmpCharge > 0)	//red
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[14]=AmpMaterials[0];
		Skins[15]=AmpMaterials[2];
	}
	else if (CurrentWeaponMode == 2 && AmpCharge > 0)	//green
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[14]=AmpMaterials[1];
		Skins[15]=AmpMaterials[3];
	}
}

simulated function ServerSwitchWeaponMode (byte newMode)
{
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		SRXPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
}

simulated function CommonSwitchWeaponMode (byte newMode)
{
	super.CommonSwitchWeaponMode(newMode);

	SRXPrimaryFire(FireMode[0]).SwitchWeaponMode(newMode);
	if (newMode == 1 && AmpCharge > 0)	//red
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[14]=AmpMaterials[0];
		Skins[15]=AmpMaterials[2];
	}
	else if (newMode == 2 && AmpCharge > 0)	//green
	{
		SRXAttachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[14]=AmpMaterials[1];
		Skins[15]=AmpMaterials[3];
	}
}

//==============================================
// Suppressor Code
//==============================================

function ServerSwitchSilencer(bool bNewValue)
{
	bSilenced = bNewValue;

	SwitchSilencer(bSilenced);

	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	BFireMode[0].bAISilent = bSilenced;
	
	if (bSilenced)
	{
		BallisticInstantFire(BFireMode[0]).TraceRange.Max = 10000;
		BallisticInstantFire(BFireMode[0]).TraceRange.Min = 10000;
	}
	else
		BallisticInstantFire(BFireMode[0]).TraceRange = BallisticInstantFire(BFireMode[0]).default.TraceRange;
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
		
	ReloadState = RS_GearSwitch;

	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
		
	if (Role == ROLE_Authority)
		SRXAttachment(ThirdPersonActor).SetSilenced(bNewValue);	
}
simulated function Notify_SilencerOn()	{	PlaySound(SilencerOnSound,,0.5);	}
simulated function Notify_SilencerOff()	{	PlaySound(SilencerOffSound,,0.5);	}

simulated function Notify_SilencerShow(){	SetBoneScale (0, 1.0, SilencerBone);	}
simulated function Notify_SilencerHide(){	SetBoneScale (0, 0.0, SilencerBone);	}

simulated function Notify_AmplifierOn()	{	PlaySound(AmplifierOnSound,,0.5);		bShowCharge=true;}
simulated function Notify_AmplifierOff()	{	PlaySound(AmplifierOffSound,,0.5);		bShowCharge=false;}

simulated function Notify_AmplifierShow(){	SetBoneScale (2, 1.0, AmplifierBone);	}
simulated function Notify_AmplifierHide(){	SetBoneScale (2, 0.0, AmplifierBone);	}

simulated function Notify_ClipOutOfSight()	{	SetBoneScale (1, 1.0, 'Bullet');	}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

/*static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_SRXClip';
}*/

simulated function BringUp(optional Weapon PrevWeapon)
{
	local float BotRand;
	
	super.BringUp(PrevWeapon);

	if (bHasOptic && Instigator != None && AIController(Instigator.Controller) == None) //Player Screen ON
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}
	
	SetBoneScale (2, 0.0, AmplifierBone);
	if (bHasOptic)
	{
		SetBoneScale(3, 0.0, 'IronsFront');
		SetBoneRotation('Sight',RearSightBoneRot);
	}

	if (AIController(Instigator.Controller) != None)
	{
		BotRand = FRand();
		if (BotRand > 0.25)
		{
			bSilenced = true;
			ServerSwitchSilencer(bSilenced);
			SwitchSilencer(bSilenced);
		}
		else if (BotRand > 0.5)
		{
			bAmped = true;
			ServerSwitchAmplifier(bAmped);
			SwitchAmplifier(bAmped);
			AmpCharge=100;
			DrainRate=0;
			if (BotRand > 0.75)
				CommonSwitchWeaponMode(2);
		}
	}

	if (bAmped)
		SetBoneScale (2, 1.0, AmplifierBone);
	else
		SetBoneScale (2, 0.0, AmplifierBone);
	
	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
	
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
		if (P.PlayerReplicationInfo != None && P.PlayerReplicationInfo.Team != None && P.PlayerReplicationInfo.Team.TeamIndex == Instigator.PlayerReplicationInfo.Team.TeamIndex)
			continue;
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


// Draws players in bright colors and all the other Thermal Mode stuff
simulated event DrawThermalMode (Canvas C)
{
	local Pawn P;
	local int i, j;
	local float Dist, DotP;//, OtherRatio;
	local Array<Material>	OldSkins;
	local int OldSkinCount;
	local bool bLOS, bFocused;
	local vector Start;
	local Array<Material>	AttOldSkins0;
	local Array<Material>	AttOldSkins1;
	
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

simulated function float ChargeBar()
{
	if (!bShowCharge)
		return 0;
	else
		return AmpCharge / 10;
}

simulated function AddHeat(float Amount)
{
	if (bBerserk)
		Amount *= 0.75;
		
	AmpCharge = FMax(0, AmpCharge + Amount);
	
	if (AmpCharge <= 0)
	{
		PlaySound(AmplifierPowerOffSound,,2.0,,32);
		Skins[14]=AmpMaterials[4];
		Skins[15]=AmpMaterials[5];
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		CurrentWeaponMode=0;
		ServerSwitchWeaponMode(0);
		if (Role == ROLE_Authority)
			SRXAttachment(ThirdPersonActor).SetAmped(false);
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	AmpCharge = NewHeat;
}

simulated event Tick(float DT)
{
	super.Tick(DT);
		
	if (AmpCharge > 0)
		AmpCharge = FMax(0, AmpCharge - DrainRate*DT);
		
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
function byte BestMode()	
{		
	return 0;
}

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
	ThermalOnSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOn',Volume=0.500000,Pitch=1.000000)
	ThermalOffSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOff',Volume=0.500000,Pitch=1.000000)
	WallVisionSkin=FinalBlend'BW_Core_WeaponTex.M75.OrangeFinal'
	Flaretex=FinalBlend'BW_Core_WeaponTex.M75.OrangeFlareFinal'
	ThermalRange=25000.000000

	DrainRate=0.15
	bShowChargingBar=True

	RearSightBoneRot=(Yaw=16384)

	AmpMaterials[0]=Shader'BW_Core_WeaponTex.Amp.Amp-FinalRed'
	AmpMaterials[1]=Shader'BW_Core_WeaponTex.Amp.Amp-FinalGreen'
	AmpMaterials[2]=Shader'BW_Core_WeaponTex.AMP.Amp-GlowRedShader'
	AmpMaterials[3]=Shader'BW_Core_WeaponTex.AMP.Amp-GlowGreenShader'
	AmpMaterials[4]=Texture'BW_Core_WeaponTex.Amp.Amp-BaseDepleted'
	AmpMaterials[5]=Texture'ONSstructureTextures.CoreGroup.Invisible'

	MyFontColor=(R=255,G=255,B=255,A=255)
	WeaponScreen=ScriptedTexture'BWBP_SKC_Tex.SRX.SRX-ScriptLCD'
	WeaponScreenShader=Shader'BWBP_SKC_Tex.SRX.SRX-ScriptLCD-SD'
	ScreenBase=Texture'BWBP_SKC_Tex.SRX.SRX-Screen'
	ScreenAmmoBlue=Texture'BWBP_SKC_Tex.SRX.SRX-Screen'
	ScreenAmmoRed=FinalBlend'BWBP_SKC_Tex.SRX.SRX-ScreenRed-FB'

	AmplifierBone="Amp"
	AmplifierOnAnim="AddAMP"
	AmplifierOffAnim="RemoveAMP"
	AmplifierOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
	AmplifierOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
	AmplifierPowerOnSound=Sound'BW_Core_WeaponSound.AMP.Amp-Install'
	AmplifierPowerOffSound=Sound'BW_Core_WeaponSound.AMP.Amp-Depleted'

	SilencerBone="Silencer"
	SilencerOnAnim="AddSilencer"
	SilencerOffAnim="RemoveSilencer"
	SilencerOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'

	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_SKC_Tex.SRX.BigIcon_SRXRifle'
	BigIconCoords=(Y2=240)

	bWT_Bullet=True
	ManualLines(0)="7.62mm Fire"
	ManualLines(1)="Attach/Detach AMP. Corrosive does extra damage to shield while Explosive damage does radius damage."
	ManualLines(2)="Attach/Detach Silencer."
	SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;1.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout',Volume=0.220000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway',Volume=0.220000)
	CockSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Cock',Volume=0.650000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipIn')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipHit')
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=0)
	WeaponModes(1)=(ModeName="Amplified: Explosive",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True,RecoilParamsIndex=1)
	WeaponModes(2)=(ModeName="Amplified: Corrosive",ModeID="WM_BigBurst",Value=4.000000,bUnavailable=True,RecoilParamsIndex=2)
	CurrentWeaponMode=0
	FullZoomFOV=70.000000
	bNoCrosshairInScope=True

	PlayerViewOffset=(X=5.000000,Y=4.50000,Z=-6.000000)
	SightOffset=(X=0.000000,Y=0.06,Z=2.7)
	SightAnimScale=0.6

	GunLength=72.000000
	ParamsClasses(0)=Class'SRXWeaponParamsComp'
	ParamsClasses(1)=Class'SRXWeaponParamsClassic'
	ParamsClasses(2)=Class'SRXWeaponParamsRealistic'
	ParamsClasses(3)=Class'SRXWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.SRXPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.SRXSecondaryFire'
	SelectAnimRate=1.350000
	BringUpTime=0.350000
	PutDownTime=0.350000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.80000
	CurrentRating=0.80000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Cross3',pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=128,VSize1=128,USize2=256,VSize2=256,Color1=(B=0,G=0,R=255,A=192),Color2=(B=255,G=255,R=255,A=123),StartSize1=20,StartSize2=57)
	Description="All weapons evolve over time, adapting to new environments and forms of combat, the SRK-650 Battle Rifle is no exception. NDTR's improvement over the original SRS-900 model, the SRK was created to stand up to the harsh winters of Kalendra with more rugged ergonomics, a holo-sight for closer ranged engagements and a digital ammo counter. But NDTR went one step and beyond by allowing the SRK to not just accept silencers, but also the new elemental AMP tech to counter Cryon armor and Krao hordes with acidic and explosive tech respectively. Slated to join it's longer ranged brother in due time, the SRK will be a blessing for the UTC troops, and a curse for their enemies."
	Priority=40
	HudColor=(B=50,G=50,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	PickupClass=Class'BWBP_SKC_Pro.SRXPickup'
	AttachmentClass=Class'BWBP_SKC_Pro.SRXAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.SRX.SmallIcon_SRXRifle'
	IconCoords=(X2=127,Y2=31)
	ItemName="SRK-650 Battle Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.SRX_FPm'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BWBP_SKC_Tex.SRX.SRX-RifleDark'
	Skins(2)=Texture'BWBP_SKC_Tex.SRX.SRX-StockBlack'
	Skins(3)=Texture'BWBP_SKC_Tex.SRX.SRX-Irons'
	Skins(4)=Texture'BWBP_SKC_Tex.SRX.SRX-Holo'
	Skins(5)=Texture'BWBP_SKC_Tex.SRX.SRX-Cable'
	Skins(6)=Texture'BWBP_SKC_Tex.SRX.SRX-Plating'
	Skins(7)=Texture'BWBP_SKC_Tex.SRX.SRX-Barrel'
	Skins(8)=Texture'BWBP_SKC_Tex.SRX.SRX-Misc'
	Skins(9)=Texture'BWBP_SKC_Tex.SRX.SRX-Muzzle'
	Skins(10)=Texture'UCGeneric.SolidColours.Black'
	Skins(11)=Texture'BWBP_SKC_Tex.SRX.SRX-ScreenMask'
	Skins(12)=Shader'BWBP_SKC_Tex.SRX.SRX-Reticle-S'
	Skins(13)=Texture'BWBP_SKC_Tex.SRX.SRX-Supp'
	Skins(14)=Shader'BW_Core_WeaponTex.AMP.Amp-FinalRed'
	Skins(15)=Shader'BW_Core_WeaponTex.AMP.Amp-GlowRedShader'
}
