//=============================================================================
// X82Rifle.
//
// BARRET Assault Rifle, aka thez Z. BArrate SOmepre rFIle. Good vs vars.
// Has underslung rifle. It also comes with MEAT VISION, btw.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class X82Rifle extends BallisticWeapon;

var   bool			bMeatVision;
var   Pawn			Target;
var   float			TargetTime;
var   float			LastSendTargetTime;
var   vector		TargetLocation;

var() BUtil.FullSound	NVOnSound;	// Sound when activating NV/Meat mode
var() BUtil.FullSound	NVOffSound; // Sound when deactivating NV/Meat mode

replication
{
	reliable if (Role == ROLE_Authority && bNetOwner)
		Target, bMeatVision;
}

function InitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock = false;
	Ammo[0].AmmoAmount = Turret.AmmoAmount[0];
	if (!Instigator.IsLocallyControlled())
		ClientInitWeaponFromTurret(Turret);
}

simulated function ClientInitWeaponFromTurret(BallisticTurret Turret)
{
	bNeedCock=false;
}

function Notify_Deploy()
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
		if (T != None && (T.bWorldGeometry && (Sandbag(T) == None || Sandbag(T).AttachedWeapon == None)) && HitNorm.Z >= 0.9 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	if(Sandbag(T) != None)
	{
		HitLoc = T.Location;
		HitLoc.Z += class'X82Turret'.default.CollisionHeight + 15;
	}
	
	else
	{
		HitLoc.Z += class'X82Turret'.default.CollisionHeight - 9;
	}
	
	CompressedEq = Instigator.Rotation;
		
	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.
	
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Turret = Spawn(class'X82Turret', None,, HitLoc, CompressedEq);
	
    if (Turret != None)
    {
    	if (Sandbag(T) != None)
			Sandbag(T).AttachedWeapon = Turret;
		Turret.InitDeployedTurretFor(self);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    else
		log("Notify_Deploy: Could not spawn turret for X82 Rifle");
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
	local SandbagLayer Bags;
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
		
	if(Instigator.IsHumanControlled() && Instigator.FindInventoryType(class'SandbagLayer') == None && class'SandbagLayer'.static.ShouldGiveBags(Instigator))
    {
        Bags = Spawn(class'SandbagLayer',,,Instigator.Location);
		
		if (Instigator.Weapon == None)
			Instigator.Weapon = Self;
			
        if( Bags != None )
            Bags.GiveTo(Instigator);
    }
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

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
	local float BestAim, BestDist;
	local Vector Start;
	local Pawn Targ;

	super.WeaponTick(DT);
	
	if (bScopeView)
	{
		BFireMode[0].BrassOffset = vect(0,-40,0);
	}
	
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
	if (!bScopeView)
	{
		BFireMode[0].BrassOffset = vect(0,0,0);
	}
}

simulated event RenderOverlays (Canvas C)
{
	if (!bScopeView)
	{
		WeaponRenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
		return;
	}
	else
	{
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}

	if (ScopeViewTex != None)
	{
		C.ColorModulate.W = 1;
   		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX, C.OrgY);
		
		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ScopeXScale))/2, C.SizeY, 0, 0, 1, 1024);

		C.SetPos((C.SizeX - (C.SizeY*ScopeXScale))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeY*ScopeXScale), C.SizeY, 0, 0, 1024, 1024);

		C.SetPos(C.SizeX - (C.SizeX - (C.SizeY*ScopeXScale))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ScopeXScale))/2, C.SizeY, 0, 0, 1, 1024);
	}
	
	if (bMeatVision)
		DrawMeatVisionMode(C);
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
      C.Style = ERenderStyle.STY_Alpha;
	C.SetPos(C.OrgX, C.OrgY);
	C.DrawTile(TexOscillator'BallisticRecolors3TexPro.X82.X82MeatOsc', C.SizeX, C.SizeY, 0, 0, 512, 512);

	// Draw some panning lines
	C.SetPos(C.OrgX, C.OrgY);
	C.DrawTile(FinalBlend'BallisticUI2.M75.M75LinesFinal', C.SizeX, C.SizeY, 0, 0, 512, 512);

	if (Target == None || !FastTrace(Instigator.Location, Target.Location))
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
      C.DrawTileStretched(Texture'BallisticRecolors3TexPro.X82.X82Targetbox', (V2.X - V.X) + 32*ScaleFactor, (V2.Y - V.Y) + 32*ScaleFactor);

    V3 = C.WorldToScreen(Target.Location - Z*Target.CollisionHeight);
}

// AI Interface =====
function byte BestMode()	{	return 0;	}

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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 2048, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
	AimDisplacementDurationMult=1.25
	ManualLines(0)="High-powered .50 rifle fire. High damage and fire rate, but strong recoil."
	ManualLines(1)="Deploys the rifle upon the ground or a nearby wall. May also be deployed upon sandbags. Whilst deployed, becomes perfectly accurate, loses its iron sights and gains a reduction in recoil. Locational damage (damage which can target an area on the body) taken from the front is significantly reduced."
	ManualLines(2)="Weapon Function activates infrared vision. Viable infantry targets will be bordered by a box in the weapon's scope.||Effective at long range. Very effective at long range when deployed."
	NVOnSound=(Sound=Sound'PackageSounds4Pro.AH104.AH104-SightOn',Volume=1.600000,Pitch=0.900000)
	NVOffSound=(Sound=Sound'PackageSounds4Pro.AH104.AH104-SightOff',Volume=1.600000,Pitch=0.900000)
	PlayerSpeedFactor=0.750000
	PlayerJumpFactor=0.750000
	TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=3)
	BigIconMaterial=Texture'BallisticRecolors3TexPro.X82.BigIcon_X82'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	SpecialInfo(0)=(Info="360.0;35.0;1.0;80.0;10.0;0.0;0.0")
	BringUpSound=(Sound=Sound'BWBP4-Sounds.MRL.MRL-BigOn')
	PutDownSound=(Sound=Sound'BWBP4-Sounds.MRL.MRL-BigOff')
	MagAmmo=5
	CockAnimPostReload="Cock"
	CockAnimRate=1.700000
	CockSound=(Sound=Sound'PackageSounds4Pro.X82.X83-Charge',Volume=2.500000)
	ReloadAnimRate=0.70000
	ClipHitSound=(Sound=Sound'PackageSounds4Pro.X82.X83-In',Volume=1.500000)
	ClipOutSound=(Sound=Sound'PackageSounds4Pro.X82.X83-Out',Volume=1.500000)
	ClipInFrame=0.850000
	bCockOnEmpty=True
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	ZoomType=ZT_Logarithmic
	ScopeXScale=1.333300
	ScopeViewTex=Texture'BallisticRecolors3TexPro.X82.X82ScopeView'
	ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=20.000000
	bNoMeshInScope=True
	bNoCrosshairInScope=True
	SightPivot=(Roll=-1024)
	SightOffset=(X=13.000000,Y=-1.600000,Z=7.200000)
	SightingTime=0.750000
	MinZoom=4.000000
	MaxZoom=32.000000
	ZoomStages=3
	GunLength=80.000000

	SprintOffSet=(Pitch=-1000,Yaw=-2048)
	JumpOffSet=(Pitch=-6000,Yaw=2000)
	SightAimFactor=0.15
	AimAdjustTime=0.600000
	AimSpread=256
	ChaosDeclineTime=1.200000
	ChaosAimSpread=2048

	Begin Object Class=RecoilParams Name=X83RecoilParams
		ViewBindFactor=0.35
		XRandFactor=0.600000
		YRandFactor=0.300000
		DeclineTime=1.500000
		MaxRecoil=8192
		HipMultiplier=3
		CrouchMultiplier=0.7
	End Object
	RecoilParamsList(0)=RecoilParams'X83RecoilParams'

	FireModeClass(0)=Class'BWBPRecolorsPro.X82PrimaryFire'
	FireModeClass(1)=Class'BWBPRecolorsPro.X82SecondaryFire'
	SelectAnim="Takeout"
	PutDownAnim="PutDown"
	IdleAnimRate=0.040000
	SelectAnimRate=0.500000
	PutDownAnimRate=0.400000
	PutDownTime=0.400000
	BringUpTime=1.200000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.80000
	CurrentRating=0.800000
	bSniping=True
	Description="X83 Anti-Material Rifle||Manufacturer: Evravion Combat Solutions |Primary: Single Powerful Shot|Secondary: Activate Zooming Scope|Special: (Scoped) Activate Night Vision/Detector|Special: (Unscoped) Mount X-83 A1||Enravion's high powered X-83 A1 Anti-Material Rifle is a fearsome sight on the modern day battlefield. With an effective range of about 1.1 miles, the X-83 can target and eliminate infantry and light vehicles with ease and at range using its specialized .50 cal N6-BMG HEAP rounds. This special operations weapon, designed to disable key targets like parked aircraft and APCs, was used extensively prior to the Skrith wars."
	DisplayFOV=55.000000
	Priority=207
	HudColor=(B=175,G=175,R=175)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	GroupOffset=5
	PickupClass=Class'BWBPRecolorsPro.X82Pickup'
	PlayerViewOffset=(X=4.000000,Y=6.000000,Z=-7.500000)
	BobDamping=1.800000
	AttachmentClass=Class'BWBPRecolorsPro.X82Attachment'
	IconMaterial=Texture'BallisticRecolors3TexPro.X82.SmallIcon_X82'
	IconCoords=(X2=127,Y2=31)
	ItemName="X83 Sniper Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BallisticRecolors4AnimPro.X83A1_1st'
	DrawScale=0.450000
	Skins(0)=Shader'BallisticRecolors3TexPro.X82.X82SkinShine'
	Skins(1)=Texture'UT2004Weapons.Pickups.ClassicSniperAmmoT'
	Skins(2)=Shader'BallisticRecolors3TexPro.X82.X82SkinShine'
	Skins(3)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
