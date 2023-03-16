//=============================================================================
// JSOCMachineGun
//
// A rapid fire, but inaccurate machine gun. Has two scope settings and bipod.
// Low zoom scope is an unmagified Red Dot Sight, High Zoom is a 3x G36 scope.
//
// Gun code by Sergeant Kelly
// Ballisic Weapon Code by Dark Carnivour
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MG36Carbine extends BallisticWeapon;

var   byte		GearStatus;

var() BUtil.FullSound	ThermalOnSound;	// Sound when activating thermal mode
var() BUtil.FullSound	ThermalOffSound;// Sound when deactivating thermal mode
var() BUtil.FullSound	NVOnSound;	// Sound when activating NV/Meat mode
var() BUtil.FullSound	NVOffSound; // Sound when deactivating NV/Meat mode
var   Array<Pawn>		PawnList;		// A list of all the potential pawns to view in thermal mode
var() material			WallVisionSkin;	// Texture to assign to players when theyare viewed with Thermal mode
var   bool				bThermal;		// Is thermal mode active?
var   bool				bUpdatePawns;	// Should viewable pawn list be updated
var   Pawn				UpdatedPawns[16];// List of pawns to view in thermal scope
var() material			Flaretex;		// Texture to use to obscure vision when viewing enemies directly through the thermal scope
var() float				ThermalRange;	// Maximum range at which it is possible to see enemies through walls
var   bool				bMeatVision;
var   Pawn				Target;
var   float				TargetTime;
var   float				LastSendTargetTime;
var   vector			TargetLocation;
var   Actor				NVLight;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//

replication
{
	reliable if (Role == ROLE_Authority)
		Target, bMeatVision;
	reliable if (Role < ROLE_Authority)
		ServerAdjustThermal;
}

//==============================================
//=========== Scope Code - Targetting + IRNV ===
//==============================================
function ServerWeaponSpecial(optional byte i)
{
	bMeatVision = !bMeatVision;
	if (bMeatVision)
		class'BUtil'.static.PlayFullSound(self, NVOnSound);
	else
		class'BUtil'.static.PlayFullSound(self, NVOffSound);
}
simulated event WeaponTick(float DT)
{
	local actor T;
	local float BestAim, BestDist;
	local Pawn Targ;
	local vector HitLoc, HitNorm, Start, End;

	super.WeaponTick(DT);

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

	if (!bScopeView || Role < Role_Authority)
		return;

	Start = Instigator.Location + Instigator.EyePosition();
	BestAim = 0.995;
	Targ = Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 20000);
	if (Targ != None)
	{
		if (Targ != Target)
		{
			Target = Targ;
			TargetTime = 0;
		}
		else if (Vehicle(Targ) != None)
			TargetTime += 1.2 * DT * (BestAim-0.95) * 20;
		else
			TargetTime += DT * (BestAim-0.95) * 20;
	}
	else
	{
		TargetTime = FMax(0, TargetTime - DT * 0.5);
	}
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	Target = None;
	TargetTime = 0;
	super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated event RenderOverlays (Canvas C)
{
	local float ImageScaleRatio;
	local Vector X, Y, Z;

	if (!bScopeView)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
		return;
	}
	if (bScopeView && ( (PlayerController(Instigator.Controller).DesiredFOV == PlayerController(Instigator.Controller).DefaultFOV && PlayerController(Instigator.Controller).bZooming==false)
		|| (Level.bClassicView && (PlayerController(Instigator.Controller).DesiredFOV == 90)) ))
	{
		SetScopeView(false);
		PlayAnim(ZoomOutAnim);
	}

    if (bThermal)
		DrawThermalMode(C);

	if (ZoomType == ZT_Irons)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
	}
	else
	{
		GetViewAxes(X, Y, Z);
		if (BFireMode[0].MuzzleFlash != None)
		{
			BFireMode[0].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
			BFireMode[0].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
			C.DrawActor(BFireMode[0].MuzzleFlash, false, false, DisplayFOV);
		}
		if (BFireMode[1].MuzzleFlash != None)
		{
			BFireMode[1].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
			BFireMode[1].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
			C.DrawActor(BFireMode[1].MuzzleFlash, false, false, DisplayFOV);
		}
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}

	// Draw Scope View
	// Draw the Scope View Tex
	C.SetDrawColor(255,255,255,255);
	C.SetPos(C.OrgX, C.OrgY);
	C.Style = ERenderStyle.STY_Alpha;
	C.ColorModulate.W = 1;
	ImageScaleRatio = 1.3333333;

	if (bThermal)
	{

    		C.DrawTile(Texture'BWBP_SKC_Tex.MARS.MARS-ScopeRed', (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);

        	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(Texture'BWBP_SKC_Tex.MARS.MARS-ScopeRed', C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        	C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(Texture'BWBP_SKC_Tex.MARS.MARS-ScopeRed', (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
	}
	else if (bMeatVision)
	{
    		C.DrawTile(Texture'BWBP_SKC_Tex.MARS.MARS-ScopeTarget', (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);

        	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(Texture'BWBP_SKC_Tex.MARS.MARS-ScopeTarget', C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        	C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(Texture'BWBP_SKC_Tex.MARS.MARS-ScopeTarget', (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
	}
	else
	{
    		C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);

        	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTex, C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        	C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
	}
		
	if (bMeatVision)
		DrawMeatVisionMode(C);
}

simulated event Timer()
{
	if (bUpdatePawns)
		UpdatePawnList();
	else
		super.Timer();
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

/*simulated function SetScopeView(bool bNewValue)
{
	bScopeView = bNewValue;
	if (!bScopeView)
	{
		Target = None;
		TargetTime=0;
	}
	if (Level.NetMode == NM_Client)
		ServerSetScopeView(bNewValue);
	bScopeView = bNewValue;
	SetScopeBehavior();

	if (!bNewValue && Target != None)
		class'BUtil'.static.PlayFullSound(self, NVOffSound);
}*/

simulated function SetNVLight(bool bOn)
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (bOn)
	{
		if (NVLight == None)
		{
			NVLight = Spawn(class'MARSNVLight',,,Instigator.location);
			NVLight.SetBase(Instigator);
		}
		NVLight.bDynamicLight = true;
	}
	else if (NVLight != None)
		NVLight.bDynamicLight = false;
}

// draws red blob that moves, scanline, and target boxes.
simulated event DrawMeatVisionMode (Canvas C)
{
	local Vector V, V2, V3, X, Y, Z;
	local float ScaleFactor;

	// Draw RED stuff
	C.Style = ERenderStyle.STY_Modulated;
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.SetDrawColor(255,255,255,255);
	C.DrawTile(FinalBlend'BWBP_SKC_Tex.MARS.F2000TargetFinal', (C.SizeY*1.3333333) * 0.75, C.SizeY, 0, 0, 1024, 1024);

	// Draw some panning lines
	C.SetPos(C.OrgX, C.OrgY);
	//C.DrawTile(FinalBlend'BW_Core_WeaponTex.M75.M75LinesFinal', C.SizeX, C.SizeY, 0, 0, 512, 512);

    C.Style = ERenderStyle.STY_Alpha;
	
	if (Target == None)
		return;

	// Draw Target Boxers
	ScaleFactor = C.ClipX / 1600;
	GetViewAxes(X, Y, Z);
	V  = C.WorldToScreen(Target.Location - Y*Target.CollisionRadius + Z*Target.CollisionHeight);
	V.X -= 32*ScaleFactor;
	V.Y -= 32*ScaleFactor;
	C.SetPos(V.X, V.Y);
	V2 = C.WorldToScreen(Target.Location + Y*Target.CollisionRadius - Z*Target.CollisionHeight);
	C.SetDrawColor(160,185,200,255);
      C.DrawTileStretched(Texture'BWBP_SKC_Tex.X82.X82Targetbox', (V2.X - V.X) + 32*ScaleFactor, (V2.Y - V.Y) + 32*ScaleFactor);

    V3 = C.WorldToScreen(Target.Location - Z*Target.CollisionHeight);
}

// Draws players through walls and all the other Thermal Mode stuff
simulated event DrawThermalMode (Canvas C)
{
	local float ImageScaleRatio;//, OtherRatio;

	ImageScaleRatio = 1.3333333;

	C.Style = ERenderStyle.STY_Modulated;
	// Draw Spinning Sweeper thing
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.SetDrawColor(255,255,255,255);
	C.DrawTile(FinalBlend'BWBP_SKC_Tex.MARS.F2000IRNVFinal', (C.SizeY*ImageScaleRatio) * 0.75, C.SizeY, 0, 0, 1024, 1024);
}

simulated function AdjustThermalView(bool bNewValue)
{
	if (AIController(Instigator.Controller) != None)
		return;
	if (!bNewValue)
		bUpdatePawns = false;
	else

	{
		bUpdatePawns = true;
		UpdatePawnList();
		SetTimer(1.0, true);
	}
	ServerAdjustThermal(bNewValue);
}

function ServerAdjustThermal(bool bNewValue)
{

	local int i;
//	bThermal = bNewValue;
	if (bNewValue)
	{
		bUpdatePawns = true;
		UpdatePawnList();
		SetTimer(1.0, true);
	}
	else
	{
		bUpdatePawns = false;
//		SetTimer(0.0, false);
		for (i=0;i<ArrayCount(UpdatedPawns);i++)
		{
			if (UpdatedPawns[i] != None)
				UpdatedPawns[i].bAlwaysRelevant = false;
		}
	}
}

//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (!bThermal && !bMeatVision) //Nothing on, turn on IRNV!
	{
		bThermal = !bThermal;
		if (bThermal)
				class'BUtil'.static.PlayFullSound(self, ThermalOnSound);
		else
				class'BUtil'.static.PlayFullSound(self, ThermalOffSound);
		AdjustThermalView(bThermal);
		if (!bScopeView)
			PlayerController(InstigatorController).ClientMessage("Activated nightvision scope.");
		return;
	}
	if (bThermal && !bMeatVision) //IRNV on! turn it off and turn on targeting!
	{
		bThermal = !bThermal;
		if (bThermal)
				class'BUtil'.static.PlayFullSound(self, ThermalOnSound);
		else
				class'BUtil'.static.PlayFullSound(self, ThermalOffSound);
		AdjustThermalView(bThermal);
		if (!bScopeView)
			PlayerController(InstigatorController).ClientMessage("Activated infrared targeting scope.");
		bMeatVision = !bMeatVision;
		if (bMeatVision)
				class'BUtil'.static.PlayFullSound(self, NVOnSound);
		else
				class'BUtil'.static.PlayFullSound(self, NVOffSound);
		return;
	}
	if (!bThermal && bMeatVision) //targeting on! turn it off!
	{
		bMeatVision = !bMeatVision;
		if (bMeatVision)
				class'BUtil'.static.PlayFullSound(self, NVOnSound);
		else
				class'BUtil'.static.PlayFullSound(self, NVOffSound);
		if (!bScopeView)
			PlayerController(InstigatorController).ClientMessage("Activated standard scope.");
		return;
	}
}

simulated event Destroyed()
{
	AdjustThermalView(false);
	super.Destroyed();
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		AdjustThermalView(false);
		return true;
	}
	return false;
}

//=================================
//Silencer Code
//=================================

function ServerSwitchSilencer(bool bNewValue)
{
	if (!Instigator.IsLocallyControlled())
		MG36PrimaryFire(FireMode[0]).SwitchSilencerMode(bNewValue);

	MG36Attachment(ThirdPersonActor).bSilenced=bNewValue;	
	PlaySuppressorAttachment(bNewValue);
	bSilenced = bNewValue;
	BFireMode[0].bAISilent = bSilenced;
}

exec simulated function SwitchSilencer() 
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;

	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	PlaySuppressorAttachment(bSilenced);
	MG36PrimaryFire(FireMode[0]).SwitchSilencerMode(bSilenced);
	MG36Attachment(ThirdPersonActor).IAOverride(bSilenced);
}

simulated function PlaySuppressorAttachment(bool bSuppressed)
{
	if (Role == ROLE_Authority)
		bServerReloading=True;
	ReloadState = RS_GearSwitch;
	
	if (bSuppressed)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}

simulated function Notify_SilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}

simulated function Notify_SilencerOff()
{
	PlaySound(SilencerOffSound,,0.5);
}

simulated function Notify_SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}

simulated function Notify_SilencerHide()
{
	SetBoneScale (0, 0.0, SilencerBone);
}

simulated function PlayReload()
{
	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

//=================================
// Bot crap
//=================================
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticProInstantFire(BFireMode[0]).DecayRange.Min, BallisticProInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
	 PlayerSpeedFactor=0.75
	 PlayerJumpFactor=0.75
	 AIReloadTime=4.000000
	 ManualLines(0)="Higher DPS than comparable weapons, but awkward recoil and highly visible tracers."
     ManualLines(1)="Attaches or remvoes the suppressor. When active, the suppressor reduces recoil and noise output and hides the muzzle flash, but reduces range."
     ManualLines(2)="The Weapon Function key switches between various integrated scopes.|The Normal scope offers clear vision.|The Night Vision scope (green) illuminates the environment and shows enemies in orange.|The Infrared scope (red) highlights enemies with a box, even underwater or through smoke or trees.||Effective at medium range."
     ThermalOnSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOn',Volume=0.500000,Pitch=1.000000)
     ThermalOffSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOff',Volume=0.500000,Pitch=1.000000)
     NVOnSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOn',Volume=1.600000,Pitch=0.900000)
     NVOffSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOff',Volume=1.600000,Pitch=0.900000)
	 WallVisionSkin=FinalBlend'BW_Core_WeaponTex.M75.OrangeFinal'
     Flaretex=FinalBlend'BW_Core_WeaponTex.M75.OrangeFlareFinal'
     ThermalRange=2500.000000
	 SilencerBone="Silencer"
	 ZoomType=ZT_Logarithmic
	 MinZoom=2.000000
     MaxZoom=5.000000
	 ZoomStages=3
	 SightingTime=0.850000
     SilencerOnSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOn'
     SilencerOffSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOff'
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     //Description="Despite being a relic from the old world, the MG36 still remains a deadly modular weapon to this day.  While it can be a carbine, the machinegun form is a popular choice among the troops to lay down suppressive fire while being able to reload far more quicker than a belt-fed LMG.  Plus with dual scopes and a threaded barrel to attach suppressors, the MG36 is a worthy candidate to hold key positions and thin out hordes of Krao."
     Description="Mk.88 Light Support Weapon||Manufacturer: Majestic Firearms 12|Primary: 5.56mm Rifle Rounds|Secondary: Attach Suppressor|Special: Mount Bipod (Unscoped)/ Activate NV (Scoped)||A limited production weapon, the Mk.88 was Majestic's first foray into infantry support weaponry. After the first Skrith war jump-started the ballistic weapons business, Majestic Firearms 12 designed the Mk.88 to replace the aging M353's still in use by the UTC. The fast-firing and powerful Mk.88 was well received by troops, however its high recoil and prohibitive cost prevented it from seeing mainstream adoption. The Mk.88 currently sees limited service in special operations units and private military groups."
	 TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_Tex.MG36.MG36_LargeIcon'
     BigIconCoords=(Y1=36,Y2=225)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.7;0.7;0.4")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M925.M925-Putaway')
     CockSound=(Sound=Sound'BWBP_SKC_Sounds.JSOC.JSOC-Cock',Volume=2.000000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.JSOC.JSOC-MagOut',Volume=2.400000)
     ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.JSOC.JSOC-MagIn',Volume=2.400000)
     ClipInFrame=0.650000
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(Value=4.000000)
     WeaponModes(3)=(bUnavailable=True)
     bNoCrosshairInScope=True
	 ScopeViewTex=Texture'BWBP_SKC_Tex.MG36.G36ScopeView'
     SightOffset=(X=-15.000000,Y=-0.350000,Z=12.300000)
     SightDisplayFOV=25.000000
     FullZoomFOV=45
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=0,R=255,A=197),Color2=(B=0,G=255,R=255,A=255),StartSize1=79,StartSize2=55)
     FireModeClass(0)=Class'BWBP_SKC_Pro.MG36PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.MG36SecondaryFire'
     IdleAnimRate=0.500000
     SelectAnimRate=1.000000
     PutDownAnimRate=1.000000
	 ReloadAnimRate=0.800000
     PutDownTime=0.600000
     BringUpTime=0.650000
	 CockingBringUpTime=1.300000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.70000
     CurrentRating=0.700000
     Priority=41
     HudColor=(B=24,G=48)
	 bCockOnEmpty=True
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     PickupClass=Class'BWBP_SKC_Pro.MG36Pickup'
     PlayerViewOffset=(X=5.000000,Y=5.000000,Z=-9.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBP_SKC_Pro.MG36Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.MG36.MG36_SmallIcon'
     IconCoords=(X2=127,Y2=31)
     ItemName="Mk.88 Light Support Weapon"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
	 ParamsClasses(0)=Class'MG36CarbineWeaponParamsArena'
	 ParamsClasses(1)=Class'MG36WeaponParamsClassic'
	 ParamsClasses(2)=Class'MG36WeaponParamsRealistic'
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_MG36'
     DrawScale=1.000000
}
