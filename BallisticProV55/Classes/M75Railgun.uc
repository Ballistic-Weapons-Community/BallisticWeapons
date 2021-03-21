//=============================================================================
// M75Railgun.
//
// The M75-TIC(Tactical Infantry Cannon) Railgun. A powerful, long range weapon
// with a low, single shot fire rate. Difficult to use, but each shot is very
// dangerous, especially against vehicles. The railgun needs to charge up
// between shots and, although it can be fired as soon as a new round is
// chambered, damage only reaches its max if the RailPower is charged to full
// which takes several seconds between shots. Also, the extreme power of the
// Railgun allows it to fire through walls. The more charged, the further
// it will go through.
// Secondary fire is a powerful sniper scope. Using Weapon Special activates
// the Thermal mode to see through obstacles such as walls. The further away
// the enemies are, the more the user will have to focus on them to see them.
// Although Thermal mode makes it easier to see enemies and shoot them through
// walls, it makes everything else harder to see.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M75Railgun extends BallisticWeapon;

var() BUtil.FullSound	ThermalOnSound;	// Sound when activating thermal mode
var() BUtil.FullSound	ThermalOffSound;// Sound when deactivating thermal mode
var   Array<Pawn>		PawnList;		// A list of all the potential pawns to view in thermal mode
var() material			WallVisionSkin;	// Texture to assign to players when theyare viewed with Thermal mode
var   bool				bThermal;		// Is thermal mode active? Clientside
var   bool				bUpdatePawns;	// Should viewable pawn list be updated
var   Pawn				UpdatedPawns[16];// List of pawns to view in thermal scope
var() material			Flaretex;		// Texture to use to obscure vision when viewing enemies directly through the thermal scope
var() float				ThermalRange;	// Maximum range at which it is possible to see enemies through walls
var   ColorModifier		ColorMod;
var   float				NextPawnListUpdateTime;

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

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);
	if (ColorMod != None)
		return;
	ColorMod = ColorModifier(Level.ObjectPool.AllocateObject(class'ColorModifier'));
	if ( ColorMod != None )
	{
		ColorMod.Material = FinalBlend'BW_Core_WeaponTex.M75.OrangeFinal';
		ColorMod.Color.R = 255;
		ColorMod.Color.G = 96;
		ColorMod.Color.B = 0;
		ColorMod.Color.A = 255;
		ColorMod.AlphaBlend = false;
		ColorMod.RenderTwoSided=True;
	}
}
simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		if (Level.NetMode == NM_Client)
			AdjustThermalView(false);
		else ServerAdjustThermal(false);

		return true;
	}
	return false;
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ClientState != WS_ReadyToFire || ReloadState != RS_None)
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

simulated event Destroyed()
{
	if (ColorMod != None)
	{
		Level.ObjectPool.FreeObject(ColorMod);
		ColorMod = None;
	}
	AdjustThermalView(false);
	super.Destroyed();
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
				UpdatedPawns[i].bAlwaysRelevant = false;
		}
	}
}

//Moved here because Timer broke the weapon
simulated function WeaponTick (float DeltaTime)
{
	Super.WeaponTick(DeltaTime);

	if (Level.TimeSeconds >= NextPawnListUpdateTime)
		UpdatePawnList();
}

simulated event RenderOverlays (Canvas C)
{
	local float ImageScaleRatio;
	local Vector X, Y, Z;

	if (!bScopeView)
	{
		Super.RenderOverlays(C);
		return;
	}
	
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
    
    if (bThermal)
		DrawThermalMode(C);

	// Draw the Scope View Tex
	C.SetDrawColor(255,255,255,255);
	C.SetPos(C.OrgX, C.OrgY);
	C.Style = ERenderStyle.STY_Alpha;
	ImageScaleRatio = 1.3333333;
	C.ColorModulate.W = 1;
	C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1);

	C.SetPos((C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
	C.DrawTile(ScopeViewTex, (C.SizeY*ImageScaleRatio), C.SizeY, 0, 0, 1024, 1024);

	C.SetPos(C.SizeX - (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
	C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1);
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
	C.DrawTile(FinalBlend'BW_Core_WeaponTex.M75.M75SeekerFinal', (C.SizeY*ImageScaleRatio) * 0.75, C.SizeY, 0, 0, 1024, 1024);
	
	// Draw Expanding Circle thing
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.DrawTile(FinalBlend'BW_Core_WeaponTex.M75.M75RadarFinal', (C.SizeY*ImageScaleRatio) * 0.75, C.SizeY, 0, 0, 1024, 1024);
	
	// Draw some panning lines
	C.SetPos(C.OrgX, C.OrgY);
	C.DrawTile(FinalBlend'BW_Core_WeaponTex.M75.M75LinesFinal', C.SizeX, C.SizeY, 0, 0, 512, 512);

	if (ColorMod == None)
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
			// Players not normally visible must be aimed at. The further a player, the closer to the crosshair they must be
			else if (DotP > 0.984 + 0.016 * (Dist/ThermalRange))
				bFocused=true;
			if (bFocused || bLOS)
			{
				if (bLOS)
					DotP = (DotP-0.6) / 0.4;
				else
					DotP = (DotP-(0.984+(Dist/ThermalRange)*0.016)) / 0.016;

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

// Charging bar shows RailPower
simulated function float ChargeBar()
{
	return M75SecondaryFire(FireMode[1]).RailPower;
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
	if (Vehicle(B.Enemy) != None)
		Result *= 2;
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
	ThermalRange=3500.000000

	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_M75'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="Uncharged rail slug shot. High damage, moderate fire rate and recoil, and good penetration."
	ManualLines(1)="Charged rail slug shot. The railgun will fire when the fire key is released, or immediately upon becoming fully charged. Damage and penetration improve with charge, to extreme levels when fully charged."
	ManualLines(2)="Weapon Function toggles the thermal scope, allowing the user to see enemies through walls. The further away the opponent, the closer the player's aim needs to be to their position to view them.||As a heavy weapon, the M75 reduces the user's movement speed and jump ability.||The M75 is effective at long range and through cover."
	SpecialInfo(0)=(Info="300.0;30.0;1.0;80.0;1.0;0.0;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Putaway')
	CockAnimPostReload="Cock2"
	CockAnimRate=1.350000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Cock')
	ReloadAnimRate=1.400000
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Cliphit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Clipout')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Clipin')
	ClipInFrame=0.650000
	bAltTriggerReload=True
	WeaponModes(0)=(ModeName="Single Fire")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bNoTweenToScope=True
	ScopeViewTex=Texture'BW_Core_WeaponTex.M75.M75ScopeView'
	SightOffset=(X=-24,Z=24.7)
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=20.000000
	bNoCrosshairInScope=True
	MinZoom=4.000000
	MaxZoom=16.000000
	ZoomStages=2
	SMuzzleFlashOffset=(X=50.000000,Z=-35.000000)
	GunLength=80.000000
	ParamsClasses(0)=Class'M75WeaponParams'
    FireModeClass(0)=Class'BallisticProV55.M75PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.M75SecondaryFire'
	PutDownAnimRate=1.300000
	PutDownTime=0.800000
	BringUpTime=0.600000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.700000
	bSniping=True
	bShowChargingBar=True
	Description="There are very few things feared by the Skrith and the Railgun is one of them. Railguns use electromagnetism to fire metallic projectiles at incredible speeds, some moving at hundreds of thousands of feet per second. This one uses depleted uranium-dragonium slugs for ammo. Railguns were far too large and heavy for infantry use until Enravion developed the Tactical Infantry Cannon version. No comparable infantry weapon currently available is capable of as much damage in a single shot as the M75. When fully charged it can flip over a tank, or fire right through a concrete building. Designed for use against vehicles, no infantry armor could be considered protection against this weapon. The M75 does have some disadvantages though. Its slow firerate, great weight and highly visible trail make it a weapon that will benefit only the most skilled soldiers."
	DisplayFOV=45.000000
	Priority=34
	HudColor=(B=255,G=25,R=0)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	PickupClass=Class'BallisticProV55.M75Pickup'
	PlayerViewOffset=(X=15.000000,Y=11.000000,Z=-12.000000)
	AttachmentClass=Class'BallisticProV55.M75Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_M75'
	IconCoords=(X2=127,Y2=31)
	ItemName="M75 Railgun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=180
	LightSaturation=100
	LightBrightness=180.000000
	LightRadius=8.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_M75'
	DrawScale=0.400000
}
