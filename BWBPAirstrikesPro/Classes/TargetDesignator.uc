class TargetDesignator extends BallisticWeapon;

#exec OBJ LOAD File=BWBP_OP_Tex.utx

struct StrikeInfoStruct
{
	var class<Projectile> 	        BombClass;		
     var int                        Cooldown;               // Cost of this strike.		
	var float						BomberSpeed;
	var float						BombRange;			    //Range either side of the mark location in which the bomber will fire. If zero, is a point drop.
	var float						BombInterval;			//Interval between bomb drops.
	var float						MinZDist;				//This much headroom must exist to call the strike in on a location.
	var float						MinRange;				//Horizontal distance player must be from strike location.
	var Vector					    BombOffset;
	var float 						Compensation;		    //Factor of the bomber's distance from the ground to adjust initial strike location by. Used for inherited velocity.
	var bool						bRemoteFired;			//Does not use a bomber. Spawns the Dropper class above the location, which manages the strike.
	var class<Actor> 		        Dropper;				//Actor to spawn above the location for remote-fired strikes which shouldn't use a plane.
	var string					    ModeDescription; 	    //A simple explanation of what this mode does.

};

var array<StrikeInfoStruct> StrikeInfo;			//Contains all the information about a given strike.

var Vector EndEffect;
var vector MarkLocation;

var int		LastRangeFound;
var float 	NextRangeFindTime;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientResupplyStart;
}

function ResupplyStart()
{
	FireMode[1].SetTimer(StrikeInfo[CurrentWeaponMode].Cooldown, false);
	if (!Instigator.IsLocallyControlled())
		ClientResupplyStart(StrikeInfo[CurrentWeaponMode].Cooldown);
}

simulated function ClientResupplyStart(int cd)
{
	FireMode[1].SetTimer(cd, false);
}

function bool CanBomb(vector MarkLocation, float NeededRadius)
{	
	if (!FastTrace(MarkLocation + StrikeInfo[CurrentWeaponMode].MinZDist * vect(0,0,1), MarkLocation))
		return false;
		
	if (LastRangeFound < StrikeInfo[CurrentWeaponMode].MinRange)
		return false;
		
	if (NeededRadius <= 0 || TargetDesignatorFire(FireMode[0]) == None)
		return true;

	MarkLocation += vect(0,0,100);
	
	return ( FastTrace(MarkLocation + vect(1,0,0) * NeededRadius, MarkLocation) && FastTrace(MarkLocation + vect(-1,0,0) * NeededRadius, MarkLocation)
		 && FastTrace(MarkLocation + vect(0,1,0) * NeededRadius, MarkLocation) && FastTrace(MarkLocation + vect(0,-1,0) * NeededRadius, MarkLocation) );
}

exec simulated function SwitchWeaponMode(optional byte i)
{
	if (ClientState == WS_PutDown || ClientState == WS_Hidden || IsFiring())
		return;
	bRedirectSwitchToFiremode=True;
	PendingMode = CurrentWeaponMode;
}

exec simulated function WeaponModeRelease()
{
	bRedirectSwitchToFiremode=False;
	ServerSwitchWeaponMode(PendingMode);
	CurrentWeaponMode = PendingMode;
}

function ServerSwitchWeaponMode(byte newMode)
{
	if (IsFiring())
		return;
		
	Super.ServerSwitchWeaponMode(newMode);
}

simulated function bool HasAmmo()
{
	return true;
}

simulated function Weapon PrevWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (bRedirectSwitchToFiremode)
	{
		PendingMode--;
		if (PendingMode >= StrikeInfo.Length)
			PendingMode = StrikeInfo.Length-1;
		return None;
	}

	return Super.PrevWeapon(CurrentChoice, CurrentWeapon);
}

simulated function Weapon NextWeapon(Weapon CurrentChoice, Weapon CurrentWeapon)
{
	if (bRedirectSwitchToFiremode)
	{
		PendingMode++;
		if (PendingMode >= StrikeInfo.Length)
			PendingMode = 0;
		return None;
	}

	return Super.NextWeapon(CurrentChoice, CurrentWeapon);
}

simulated function bool PutDown()
{
	if (Instigator.IsLocallyControlled())
	{
		bRedirectSwitchToFiremode = False;
		PendingMode = CurrentWeaponMode;
	}
	return Super.PutDown();
}

// Draw the scope view
simulated event DrawScopeOverlays(Canvas C)
{
	if (LastRangeFound < StrikeInfo[CurrentWeaponMode].MinRange)
		ScopeViewTex = Texture'DesignatorScreenNo';
	else 
		ScopeViewTex = default.ScopeViewTex;

	Super.DrawScopeOverlays(C);
}

simulated function WeaponTick(float DT)
{
	local vector Start, HitLoc, HitNorm;
	local actor T;
	
	Super.WeaponTick(DT);
	
	if (bScopeView && Level.TimeSeconds > NextRangeFindTime)
	{
		Start = Instigator.Location + Instigator.EyePosition();
		T = Trace(HitLoc, HitNorm, Start + vector(Instigator.GetViewRotation()) * 30000, Start, true);
		if (T == None)
			LastRangeFound = 30001;
		else
			LastRangeFound = VSize(HitLoc-Start);
		NextRangeFindTime = Level.TimeSeconds + 0.5;
	}
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;
	local int i;
	local byte StartMode;

	Super(Weapon).NewDrawWeaponInfo (C, YPos);
	
	DrawCrosshairs(C);
	
	if (bSkipDrawWeaponInfo)
		return;

	ScaleFactor = C.ClipY / 900;
	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		Temp = GetHUDAmmoText(1);
		if (Temp == "0")
			C.DrawColor = class'hud'.default.RedColor;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
		C.DrawColor = class'hud'.default.WhiteColor;
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		if (!bRedirectSwitchToFiremode)
		{
			C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
			C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
			C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
			C.CurY = C.ClipY - (130 * ScaleFactor * class'HUD'.default.HudScale) - YL2 - YL;
			C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
			
			C.Font = GetFontSizeIndex(C, -5 + int(2* class'HUD'.default.HudScale));
			C.TextSize(StrikeInfo[CurrentWeaponMode].ModeDescription@"Min range:"@int(StrikeInfo[CurrentWeaponMode].MinRange / 52.5)$"m.", XL, YL);
			C.CurY += YL/2;
			C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
			C.DrawText(StrikeInfo[CurrentWeaponMode].ModeDescription@"Min range:"@int(StrikeInfo[CurrentWeaponMode].MinRange / 52.5)$"m.");
		}
		
		else
		{
			StartMode = PendingMode - 2;
			if (StartMode >= StrikeInfo.Length)
				StartMode = (StrikeInfo.Length-1) - (255 - StartMode);
				
				//case -2: desire 3
				//case -1: desire 2
				//case 0: desire 1
				//case 1: desire 0
				//case 2: desire -1
				
				
			for (i=-2; i<3; i++)
			{
				if (i != 0)
					C.SetDrawColor(255,128,128,255 - (75 * Abs(i)));
				else C.SetDrawColor(255,255,255,255);
				C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
				C.TextSize(WeaponModes[StartMode].ModeName, XL, YL2);
				C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
				C.CurY = C.ClipY - (130 * ScaleFactor * class'HUD'.default.HudScale) - (YL2 * (-i +1)) - YL;
				C.DrawText(WeaponModes[StartMode].ModeName, false);
				
				StartMode++;
				if (StartMode >= StrikeInfo.Length)
					StartMode = 0;
			}
		}
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

function bool ConsumeAmmo(int Mode, float load, optional bool bAmountNeededIsMax)
{
	return true;
}

function ReallyConsumeAmmo(int Mode, float load)
{
	Super.ConsumeAmmo(Mode,load);
}

// AI Interface
function float GetAIRating()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;
	if ( (B.Enemy == None) || (Instigator.Location.Z < B.Enemy.Location.Z) || !B.EnemyVisible() )
		return 0;
	if ( TerrainInfo(B.Enemy.Base) == None )
		return 0;
	return 0.1;
}

/* BestMode()
choose between regular or alt-fire
*/
function byte BestMode()
{
	return 0;
}

function float SuggestAttackStyle()
{
    return 0;
}

function float SuggestDefenseStyle()
{
    return 2;
}

function float RangedAttackTime()
{
	return 6;
}

function bool RecommendRangedAttack()
{
	return true;
}

function bool RecommendLongRangedAttack()
{
	return true;
}

// End AI Interface

simulated function float ChargeBar()
{
	if (Ammo[0].AmmoAmount == 1 || Level.TimeSeconds > FireMode[1].NextTimerPop)
		return 0;
	return (60.0f - (FireMode[1].NextTimerPop - Level.TimeSeconds)) / 60.0f;
}

defaultproperties
{
    ManualLines(0)="Projects a laser, which must be kept aimed at a given point on the map to call in the active airstrike."
    ManualLines(1)="Raises the scope. The color of the scope changes from green to red, depending on whether or not the player is sufficiently far away from the aim point to call in the current airstrike."
    ManualLines(2)="Switch modes by holding down the Fire Mode key and scrolling the mouse.||Effective at medium range. Extremely effective at long range, against cover, and against groups."

    //Pro
	
	StrikeInfo(0)=(BombClass=Class'BWBPAirstrikesPro.CarpetBomberBomb',Cooldown=60,BomberSpeed=5500.000000,BombRange=7500.000000,BombInterval=0.150000,MinZDist=4096.000000,MinRange=4096.000000,BombOffset=(Y=250.000000),ModeDescription="Drops bombs with good blast radius in a line with midpoint on targeted location.")
    StrikeInfo(1)=(BombClass=Class'BWBPAirstrikesPro.CBU100BaseShell',Cooldown=45,BomberSpeed=9000.000000,MinZDist=4096.000000,MinRange=2048.000000,ModeDescription="Drops a cluster bomb which breaks into a massive number of explosive bomblets.")
    StrikeInfo(2)=(BombClass=Class'BWBPAirstrikesPro.GBU57Projectile',Cooldown=45,BomberSpeed=9000.000000,MinZDist=1024.000000,MinRange=1024.000000,ModeDescription="Drops an accurate bomb of medium power. Penetrates walls.")
    StrikeInfo(3)=(BombClass=Class'BWBPAirstrikesPro.JSOWBaseShell',Cooldown=45,BomberSpeed=5000.000000,BombRange=3500.000000,BombInterval=0.025000,MinZDist=1024.000000,MinRange=2048.000000,ModeDescription="Drops an incredible number of bombs in a line with midpoint at the indicated location.")
    StrikeInfo(4)=(Cooldown=45,MinZDist=2048.000000,MinRange=8192.000000,bRemoteFired=True,Dropper=Class'BWBPAirstrikesPro.MLRSDropper',ModeDescription="Remote rocket attack saturates the targeted area after a delay.")
    
	//Broken
	//StrikeInfo(0)=(BombClass=Class'BWBPAirstrikesPro.AIM9Missile',Cooldown=15,BomberSpeed=6000.000000,BombRange=2500.000000,BombInterval=0.350000,MinZDist=4096.000000,ModeDescription="Multiple missile attack targeted accurately on the indicated location.")
    //StrikeInfo(2)=(BombClass=Class'BWBPAirstrikesPro.CBU30BaseShell',Cooldown=30,BomberSpeed=9000.000000,MinZDist=2048.000000,MinRange=1024.000000,ModeDescription="Drops a cluster bomb. The clusters release toxic gas.")
    //StrikeInfo(3)=(BombClass=Class'BWBPAirstrikesPro.CBU58BaseShell',Cooldown=45,BomberSpeed=9000.000000,MinZDist=2048.000000,MinRange=1536.000000,ModeDescription="Drops a cluster bomb. The clusters start raging fires.")
    //StrikeInfo(4)=(BombClass=Class'BWBPAirstrikesPro.CBU72BaseShell',Cooldown=45,BomberSpeed=9000.000000,MinZDist=4096.000000,MinRange=2048.000000,ModeDescription="Drops 3 inaccurate clusters of high individual power.")
    //StrikeInfo(8)=(BombClass=Class'BWBPAirstrikesPro.MC1Bomb',Cooldown=60,BomberSpeed=5500.000000,MinZDist=2048.000000,MinRange=6000.000000,ModeDescription="Targeted chemical missile which releases toxic gas.")
    //StrikeInfo(9)=(BombClass=Class'BWBPAirstrikesPro.MK77Projectile',Cooldown=60,BomberSpeed=5500.000000,MinZDist=2048.000000,MinRange=7000.000000,ModeDescription="Targeted incendiary missile with secondary explosion.")
	//StrikeInfo(11)=(BombClass=Class'BWBPAirstrikesPro.NapalmBomb',Cooldown=60,BomberSpeed=5500.000000,BombRange=7500.000000,BombInterval=0.200000,MinZDist=4096.000000,MinRange=8192.000000,BombOffset=(Y=500.000000),ModeDescription="Carpet bombs in a line with napalm bombs. Very strong.")
    
	
	//Classic
	
	//StrikeInfo(12)=(BombClass=Class'BWBPAirstrikesPro.BLU82Projectile',Cooldown=45,BomberSpeed=10000.000000,BombRange=320.000000,BombInterval=0.330000,MinZDist=2048.000000,MinRange=14000.000000,ModeDescription="Extremely powerful, wide-ranged nuclear attack.")
    //StrikeInfo(13)=(BombClass=Class'BWBPAirstrikesPro.BLU96Projectile',Cooldown=45,BomberSpeed=10000.000000,BombRange=320.000000,BombInterval=0.330000,MinZDist=2048.000000,MinRange=14000.000000,ModeDescription="Powerful, wide-ranged fuel-air bomb.")
    //StrikeInfo(14)=(BombClass=Class'BWBPAirstrikesPro.GBU38Projectile',Cooldown=45,BomberSpeed=10000.000000,BombRange=320.000000,BombInterval=0.330000,MinZDist=2048.000000,MinRange=12000.000000,ModeDescription="Drops a single accurate bomb of monstrous power.")
    //StrikeInfo(15)=(BombClass=Class'BWBPAirstrikesPro.GBU43Projectile',Cooldown=45,BomberSpeed=10000.000000,BombRange=320.000000,BombInterval=0.330000,MinZDist=2048.000000,MinRange=12000.000000,ModeDescription="Drops a single accurate bomb of monstrous power.")
    //StrikeInfo(16)=(BombClass=Class'BWBPAirstrikesPro.LUU4BaseShell',Cooldown=45,BomberSpeed=10000.000000,BombRange=320.000000,BombInterval=0.330000,MinZDist=512.000000,MinRange=1.000000,ModeDescription="Illuminates the map. Is not an attack.")
    //StrikeInfo(17)=(BombClass=Class'BWBPAirstrikesPro.W54Projectile',Cooldown=45,BomberSpeed=1000.000000,BombRange=320.000000,BombInterval=0.330000,MinZDist=2048.000000,MinRange=18000.000000,ModeDescription="Drops a tactical nuke, wiping out anything nearby.")
	
	BigIconMaterial=Texture'BWBP_OP_Tex.Designator.BigIcon_Designator'
    bAllowWeaponInfoOverride=False
    bWT_Super=True
    bNoMag=True
    
	//Pro
    WeaponModes(0)=(ModeName="Carpet Bombing",ModeID="WM_FullAuto")
    WeaponModes(1)=(ModeName="CBU-100 Cluster Bomb",ModeID="WM_FullAuto")
    WeaponModes(2)=(ModeName="GBU-57 MOP",ModeID="WM_FullAuto")
    WeaponModes(3)=(ModeName="AGM-154 JSOW",ModeID="WM_FullAuto")
    WeaponModes(4)=(ModeName="MLRS Rocket Barrage",ModeID="WM_FullAuto")
    
	
	//Broken
	//WeaponModes(0)=(ModeName="AIM-9 Missiles",ModeID="WM_FullAuto",bUnavailable=True)
	//WeaponModes(2)=(ModeName="CBU-30 Chemical Cluster Bomb",bUnavailable=True)
    //WeaponModes(3)=(ModeName="CBU-58 Incendiary Cluster Bomb",ModeID="WM_FullAuto",bUnavailable=True)
    //WeaponModes(4)=(ModeName="CBU-72 Cluster Bomb",ModeID="WM_FullAuto",bUnavailable=True)
    //WeaponModes(8)=(ModeName="MC1 Chemical Bomb",ModeID="WM_FullAuto",bUnavailable=True)
    //WeaponModes(9)=(ModeName="MK-77 Incendiary Bomb",ModeID="WM_FullAuto",bUnavailable=True)
	//WeaponModes(11)=(ModeName="Napalm Carpet Bombing",ModeID="WM_FullAuto",bUnavailable=True)
	
	//Classic
	
	//WeaponModes(12)=(ModeName="BLU-82 'Daisy Cutter'",ModeID="WM_FullAuto,bUnavailable=True")
    //WeaponModes(13)=(ModeName="BLU-96 Fuel-Air Bomb",ModeID="WM_FullAuto,bUnavailable=True")
    //WeaponModes(14)=(ModeName="GBU-38 500lb JDAM",ModeID="WM_FullAuto,bUnavailable=True")
    //WeaponModes(15)=(ModeName="GBU-43 MOAB",ModeID="WM_FullAuto,bUnavailable=True")
    //WeaponModes(16)=(ModeName="LUU-4 Illumination Flare",ModeID="WM_FullAuto,bUnavailable=True")
    //WeaponModes(17)=(ModeName="W54 Nuclear Warhead",ModeID="WM_FullAuto,bUnavailable=True")
	
    CurrentWeaponMode=2
    ScopeXScale=1.400000
    ZoomInAnim="Raise"
    ZoomOutAnim="Lower"
    ScopeViewTex=Texture'BWBP_OP_Tex.Designator.DesignatorScreen'
    FullZoomFOV=20.000000
    bNoCrosshairInScope=True
    bAimDisabled=True
    ParamsClasses(0)=Class'TargetDesignatorWeaponParams'
	ParamsClasses(1)=Class'TargetDesignatorWeaponParamsClassic'
    FireModeClass(0)=Class'BWBPAirstrikesPro.TargetDesignatorFire'
    FireModeClass(1)=Class'BWBPAirstrikesPro.TargetDesignatorScopeFire'
    SelectAnimRate=3.100000
    PutDownAnimRate=2.800000
    SelectSound=Sound'WeaponSounds.LinkGun.SwitchToLinkGun'
    SelectForce="SwitchToLinkGun"
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc6',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',USize1=256,VSize1=256,USize2=128,VSize2=128,Color1=(B=0,G=206,R=207,A=255),Color2=(B=0,G=255,R=0,A=133),StartSize1=96,StartSize2=37)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
    AIRating=1.000000
    CurrentRating=1.000000
    bShowChargingBar=True
    Description="The Target Designator is a unique weapon which can call in various types of airstrike on a position by using Target Painter mechanics. This weapon is of no use in environments where there is no access to the sky."
    EffectOffset=(X=100.000000,Y=25.000000,Z=-3.000000)
    Priority=15
    HudColor=(G=200)
    SmallViewOffset=(X=22.000000,Y=20.150000,Z=-13.500000)
    CenteredOffsetY=-7.000000
    CenteredRoll=0
    CenteredYaw=-500
    CustomCrosshair=13
    CustomCrossHairColor=(B=128)
    CustomCrossHairScale=2.000000
    CustomCrossHairTextureName="Crosshairs.Hud.Crosshair_Circle2"
    InventoryGroup=0
    PickupClass=Class'BWBPAirstrikesPro.TargetDesignatorPickup'
    PlayerViewOffset=(X=27.000000,Y=20.150000,Z=-13.500000)
    BobDamping=1.575000
    AttachmentClass=Class'BWBPAirstrikesPro.TargetDesignatorAttachment'
    IconMaterial=Texture'BWBP_OP_Tex.Designator.SmallIcon_Designator'
    IconCoords=(X2=128,Y2=32)
    ItemName="MAU-52 Target Designator"
    Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_Designator'
    DrawScale=0.600000
    AmbientGlow=64
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
}
