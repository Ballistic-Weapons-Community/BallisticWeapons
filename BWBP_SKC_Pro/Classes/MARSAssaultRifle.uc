//=============================================================================
// Scoped F2000.
//=============================================================================
class MARSAssaultRifle extends BallisticWeapon;

//Grenade
var() Sound		GrenOpenSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//
var() name			GrenadeLoadAnim;	//Anim for grenade reload

//IR/NV
var() BUtil.FullSound	ThermalOnSound;	// Sound when activating thermal mode
var() BUtil.FullSound	ThermalOffSound;// Sound when deactivating thermal mode
var() BUtil.FullSound	NVOnSound;	// Sound when activating NV/Meat mode
var() BUtil.FullSound	NVOffSound; // Sound when deactivating NV/Meat mode
var   Array<Pawn>		PawnList;		// A list of all the potential pawns to view in thermal mode
var() material				WallVisionSkin;	// Texture to assign to players when theyare viewed with Thermal mode
var   bool					bThermal;		// Is thermal mode active?
var   bool					bUpdatePawns;	// Should viewable pawn list be updated
var   Pawn					UpdatedPawns[16];// List of pawns to view in thermal scope
var() material				Flaretex;		// Texture to use to obscure vision when viewing enemies directly through the thermal scope
var() float					ThermalRange;	// Maximum range at which it is possible to see enemies through walls
var   ColorModifier		ColorMod;
var   bool					bMeatVision;
var	  bool					bThermalSight;  //Thermal MARS's can see through their smoke
var   Pawn					Target;
var   float					TargetTime;
var   float					LastSendTargetTime;
var   float                 NextTargetFindTime, TargetFindInterval;
var   vector				TargetLocation;
var   Actor					NVLight;

replication
{
	reliable if (Role == ROLE_Authority)
		Target, bMeatVision, ClientGrenadePickedUp;
	reliable if (Role < ROLE_Authority)
		ServerAdjustThermal;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
	{
		bThermalSight=True;
	}
}

// Notifys for greande loading sounds
simulated function Notify_F2000GrenOpen()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_F2000GrenLoad()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_F2000GrenClose()	{	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64); MARSSecondaryFire(FireMode[1]).bLoaded = true; }

// A grenade has just been picked up. Loads one in if we're empty
function GrenadePickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadGrenade();
		else

			MARSSecondaryFire(FireMode[1]).bLoaded=true;
	}
	if (!Instigator.IsLocallyControlled())
		ClientGrenadePickedUp();
}

simulated function ClientGrenadePickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadGrenade();
		else
			MARSSecondaryFire(FireMode[1]).bLoaded=true;
	}
}

simulated function bool IsGrenadeLoaded()
{
	return MARSSecondaryFire(FireMode[1]).bLoaded;
}

// Tell our ammo that this is the MARS it must notify about grenade pickups
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_MARSGrenades(Ammo[1]) != None)
		Ammo_MARSGrenades(Ammo[1]).DaF2K = self;
}

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || MARSSecondaryFire(FireMode[1]).bLoaded)
	{
		if(!MARSSecondaryFire(FireMode[1]).bLoaded)
			PlayIdle();
		return;
	}

	if (ReloadState == RS_None)
	{
		ReloadState = RS_GearSwitch;
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
	}
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;

	GetAnimParams(channel, seq, frame, rate);
	if (seq == GrenadeLoadAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
		{
			LoadGrenade();
			ClientStartReload(1);
		}
		return;
	}
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
		{
			if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
				LoadGrenade();
		}
		else
			CommonStartReload(i);
	}
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return FireCount < 1;
	return super.CheckWeaponMode(Mode);
}

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
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

	if (AIController(Instigator.Controller) != None && !IsGrenadeLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadGrenade() && !IsReloadingGrenade())
		LoadGrenade();

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

	if (!bScopeView || Role < ROLE_Authority || Level.TimeSeconds < NextTargetFindTime)
		return;

    NextTargetFindTime = Level.TimeSeconds + TargetFindInterval;

	Start = Instigator.Location + Instigator.EyePosition();
	BestAim = 0.995;
	Targ = Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 20000);

    if (!FastTrace(Targ.Location, Instigator.Location))
        Targ = None;

    if (Targ != Target)
    {
        Target = Targ;
        TargetTime = 0;
    }

	if (Targ == None)
    {
    	TargetTime = FMax(0, TargetTime - DT * 0.5);
        return;
    }
    else if (Vehicle(Targ) != None)
        TargetTime += 1.2 * DT * (BestAim-0.95) * 20;
    else
        TargetTime += DT * (BestAim-0.95) * 20;
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

simulated function OnScopeViewChanged()
{
	super.OnScopeViewChanged();

	if (!bScopeView)
	{
		if (Target != None)
		{		
			class'BUtil'.static.PlayFullSound(self, NVOffSound);
			Target = None;
		}

		TargetTime=0;
	}
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
	local Pawn P;
	local int i, j;
	local float Dist, DotP, ImageScaleRatio;//, OtherRatio;
	local Array<Material>	OldSkins;
	local int OldSkinCount;
	local bool bLOS, bFocused;
	local vector Start;
	local Array<Material>	AttOldSkins0;
	local Array<Material>	AttOldSkins1;

	ImageScaleRatio = 1.3333333;

	C.Style = ERenderStyle.STY_Modulated;
	// Draw Spinning Sweeper thing
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.SetDrawColor(255,255,255,255);
	C.DrawTile(FinalBlend'BWBP_SKC_Tex.MARS.F2000IRNVFinal', (C.SizeY*ImageScaleRatio) * 0.75, C.SizeY, 0, 0, 1024, 1024);

	if (ColorMod == None || !bThermalSight)
		return;
	// Draw the players with an orange effect
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

//==============================================
//=========== Bullet in mag ====================
//==============================================
simulated function Notify_ClipOutOfSight()
{
}

//==============================================
//=========== Light + Garbage Cleanup ==========
//==============================================

simulated event Destroyed()
{
	AdjustThermalView(false);

	if (NVLight != None)
		NVLight.Destroy();
		
	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = false;

	super.Destroyed();
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		AdjustThermalView(false);
		return true;
	}

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = false;

	return false;
}

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
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || !IsGrenadeLoaded())
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	// Too close for grenade
	if (Dist < 500 &&  VDot > 0.3)
		result -= (500-Dist) / 1000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}

	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == GrenadeLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!IsGrenadeLoaded())
	{
		if (IsReloadingGrenade())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadGrenade())
		{
			LoadGrenade();
			return false;
		}
	}
	return super.CanAttack(Other);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.4;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.4;	}
// End AI Stuff =====

defaultproperties
{
	GrenOpenSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	GrenLoadSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	GrenCloseSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	GrenadeLoadAnim="GLReload"
	ThermalOnSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOn',Volume=0.500000,Pitch=1.000000)
	ThermalOffSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOff',Volume=0.500000,Pitch=1.000000)
	NVOnSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOn',Volume=1.600000,Pitch=0.900000)
	NVOffSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOff',Volume=1.600000,Pitch=0.900000)
	WallVisionSkin=FinalBlend'BW_Core_WeaponTex.M75.OrangeFinal'
	Flaretex=FinalBlend'BW_Core_WeaponTex.M75.OrangeFlareFinal'
	ThermalRange=2500.000000
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.MARS.BigIcon_F2000'
	BigIconCoords=(Y1=30,Y2=235)
	
	bWT_Bullet=True
	ManualLines(0)="5.56mm fire. Has a fast fire rate and high sustained DPS, but high recoil, limiting its hipfire."
	ManualLines(1)="Launches a smoke grenade. Upon impact, generates a cloud of smoke and deals minor radius damage. There is a bonus for a direct hit."
	ManualLines(2)="The Weapon Function key switches between various integrated scopes.|The Normal scope offers clear vision.|The Night Vision scope (green) illuminates the environment and shows enemies in orange.|The Infrared scope (red) highlights enemies with a box, even underwater or through smoke or trees.||Effective at medium range."
	SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.8;0.5;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(ModeName="Burst",Value=4.000000)
	WeaponModes(2)=(ModeName="Auto")

    TargetFindInterval=0.2
	
	CurrentWeaponMode=2
	
	CockAnimPostReload="ReloadEndCock"
	CockAnimRate=1.10000
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-BoltPull',Volume=1.100000,Radius=32.000000)
	ReloadAnimRate=1.10000
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-MagFiddle',Volume=1.400000,Radius=32.000000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-MagOut',Volume=1.400000,Radius=32.000000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-MagIn',Volume=1.400000,Radius=32.000000)
	ClipInFrame=0.650000
	ScopeViewTex=Texture'BWBP_SKC_Tex.MARS.MARS-Scope'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=45.000000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=255,R=255,A=134),Color2=(B=0,G=0,R=255,A=255),StartSize1=50,StartSize2=51)
	bNoCrosshairInScope=True
	SightOffset=(X=-5.000000,Y=-7.340000,Z=27.170000)
	MinZoom=2.000000
	MaxZoom=4.000000
	ZoomStages=1
	SMuzzleFlashOffset=(X=15.000000,Z=-10.000000)
	ParamsClasses(0)=Class'MARSWeaponParams'
	ParamsClasses(1)=Class'MARSWeaponParamsClassic'
	ParamsClasses(2)=Class'MARSWeaponParamsRealistic'
    ParamsClasses(3)=Class'MARSWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.MARSPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.MARSSecondaryFire'
	PutDownTime=0.700000
	BringUpTime=0.330000
	CockingBringUpTime=1.200000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.700000
	Description="The 2 variant of the Modular Assault Rifle System is one of many rifles built under NDTR Industries' MARS project. The project, which aimed to produce a successor to the army's current M50 and M30 rifles, has produced a number of functional prototypes. The 2 variant is a sharpshooter model with a longer barrel and an advanced, integral scope. Current tests show the MARS-2 to be reliable and effective, yet expensive."
	Priority=65
	HudColor=(G=0)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	PickupClass=Class'BWBP_SKC_Pro.MARSPickup'
	PlayerViewOffset=(X=0.500000,Y=14.000000,Z=-20.000000)
	BobDamping=2.000000
	AttachmentClass=Class'BWBP_SKC_Pro.MARSAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.MARS.SmallIcon_F2000'
	IconCoords=(X2=127,Y2=31)
	ItemName="MARS-2 Assault Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_F2000'
	DrawScale=0.350000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
