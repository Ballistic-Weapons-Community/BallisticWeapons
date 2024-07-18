//===========================================================================
// KF-8X Stealth Crossbow.
//
// Primary fires relatively slow projectile crossbow bolts for poor DPS.
// Secondary fires lightning projectiles which damage the target and inflict a DoT effect.
// Nearby targets hit with the primary will connect to the electrified target, limiting distance from
// them and sharing damage.
//
// Passively cloaks the user based on their movement speed. Low settings abusers have an additional
// penalty on this check.
//===========================================================================
class KF8XCrossbow extends BallisticWeapon;

//IR/NV
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
var   float             NextTargetFindTime, TargetFindInterval;
var   vector			TargetLocation;
var   Actor				NVLight;

var() Array<Name>		ReleaseStateAnim;
var() Name				ReloadAnim2;

var() Name				MagBone;
var() Rotator			MagBoneRotation;
var bool bNeedRotate; //Used to ensure a rotation is called before the next shot

struct RevInfo
{
	var() name	BoneName;
};
var() RevInfo	ArrowBones[7]; 	//Bones for showing/hiding arrows
var() Name		GunArrowBone;	//Bone for the arrow that fires

replication
{
	reliable if (Role == ROLE_Authority)
		Target, bMeatVision;
	reliable if (Role < ROLE_Authority)
		ServerAdjustThermal;
}

//change mag rotation if after firing, as well as code to continue reloading
simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Anim == 'FireCycle')
		RemoveGunArrow();
		
	if (Anim == 'FireCycleRotate')
	{
		RotateClip();
	}
	if (ReloadState == RS_PreClipOut)
	{
		if (HasAnim(ReloadAnim))
			SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
	}
	super.AnimEnded(Channel, anim, frame, rate);
}

//choose which animation to play for the initial reload

simulated function PlayReload()
{
	MagBoneRotation.Roll = 0;
	SetBoneRotation(MagBone, MagBoneRotation, 0, 1.0);
	
	if (MagAmmo == 1 && HasAnim(ReloadAnim2))
		SafePlayAnim(ReloadAnim2, ReloadAnimRate, , 0, "RELOAD");
		
	else if (MagAmmo == 0 && HasAnim(ReloadEmptyAnim))
		SafePlayAnim(ReloadEmptyAnim, ReloadAnimRate, , 0, "RELOAD");
		
	else if (MagAmmo > 1 && MagAmmo < 8)
		SafePlayAnim(ReleaseStateAnim[MagAmmo-2], ReloadAnimRate, , 0, "RELOAD");
}

//rotate drum, notify that we've done so
simulated function RotateClip()
{
	if (MagAmmo > 7)
	{
		bNeedRotate=false;
		return;
	}
	//65536 = 360 degrees
	//each cock sets the mag bone rotation by 4 degrees depending on the MagAmmo
	MagBoneRotation.Roll = -4 * (8-MagAmmo) * (65536/360);
	SetBoneRotation(MagBone, MagBoneRotation, 0, 1.0);
	//hide the arrow that has been shot
	SetBoneScale(MagAmmo-1, 0.0, ArrowBones[MagAmmo-1].BoneName);
	bNeedRotate=false;
}
simulated function RemoveGunArrow()
{
	SetBoneScale(9, 0.0, GunArrowBone);
}

//show arrows, this will be iterated according to the reload happening

simulated function ReturnArrow(int ArrowIndex)
{
	SetBoneScale(ArrowIndex, 1.0, ArrowBones[ArrowIndex].BoneName);
}

simulated function Notify_ReturnAllArrows()
{
	local int i;
	for (i=0; i<=6; i++)
	{
		ReturnArrow(i);
	}
}

simulated function Notify_ReturnFirstArrow()
{
	SetBoneScale(9, 1.0, GunArrowBone);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockStart()
{
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
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

	if (!bScopeView || Role < ROLE_Authority || Level.TimeSeconds < NextTargetFindTime)
		return;

    NextTargetFindTime = Level.TimeSeconds + TargetFindInterval;

	Start = Instigator.Location + Instigator.EyePosition();
	BestAim = 0.995;
	Targ = Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 20000);

    if (Targ != None && !FastTrace(Targ.Location, Instigator.Location))
        Targ = None;

    if (Targ != None && Targ != Target)
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

simulated event DrawScopeOverlays (Canvas C)
{
    if (bThermal)
		DrawThermalMode(C);

	if (bMeatVision)
		DrawMeatVisionMode(C);

	Super.DrawScopeOverlays(C);
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
	Super.OnScopeViewChanged();

	if (!bScopeView)
	{
		if (Target != None)
			class'BUtil'.static.PlayFullSound(self, NVOffSound);
		Target = None;
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
	C.DrawTile(FinalBlend'BWBP_SKC_Tex.MARS.F2000TargetFinal', C.SizeY, C.SizeY, 0, 0, 1024, 1024);

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
	C.Style = ERenderStyle.STY_Modulated;
	// Draw Spinning Sweeper thing
	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
	C.SetDrawColor(255,255,255,255);
	C.DrawTile(FinalBlend'BWBP_SKC_Tex.MARS.F2000IRNVFinal', C.SizeY, C.SizeY, 0, 0, 1024, 1024);
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
				UpdatedPawns[i].bAlwaysRelevant = UpdatedPawns[i].default.bAlwaysRelevant;
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
			NVLight = Spawn(class'KF8XNVLight',,,Instigator.location);
			NVLight.SetBase(Instigator);
		}
		NVLight.bDynamicLight = true;
	}
	else if (NVLight != None)
		NVLight.bDynamicLight = false;
}

simulated function float ChargeBar()
{
	return KF8XAttachment(ThirdPersonActor).CurAlpha / 128.0f;
}

// choose between regular or alt-fire
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
function float SuggestAttackStyle()	{	return -0.7;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.7;	}

defaultproperties
{
	MagBone="Magazine"
	ReloadEmptyAnim="ReloadEmpty"	//0 ammo
	ReloadAnim2="ReloadMagEmpty"	//1 ammo
	ReleaseStateAnim[0]="ReloadMagReleaseState6"	//2 ammo
	ReleaseStateAnim[1]="ReloadMagReleaseState5"	//3 ammo
	ReleaseStateAnim[2]="ReloadMagReleaseState4"	//4 ammo
	ReleaseStateAnim[3]="ReloadMagReleaseState3"	//5 ammo
	ReleaseStateAnim[4]="ReloadMagReleaseState2"	//6 ammo
	ReleaseStateAnim[5]="ReloadMagReleaseState1"	//7 ammo
	ReloadAnim="ReloadStateFinish"
	GunArrowBone="1"
	ArrowBones(0)=(BoneName="2")
	ArrowBones(1)=(BoneName="3")
	ArrowBones(2)=(BoneName="4")
	ArrowBones(3)=(BoneName="5")
	ArrowBones(4)=(BoneName="6")
	ArrowBones(5)=(BoneName="7")
	ArrowBones(6)=(BoneName="8")
	ThermalOnSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOn',Volume=0.500000,Pitch=1.000000)
	ThermalOffSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOff',Volume=0.500000,Pitch=1.000000)
	NVOnSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOn',Volume=1.600000,Pitch=0.900000)
	NVOffSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOff',Volume=1.600000,Pitch=0.900000)
	WallVisionSkin=FinalBlend'BW_Core_WeaponTex.M75.OrangeFinal'
	Flaretex=FinalBlend'BW_Core_WeaponTex.M75.OrangeFlareFinal'
	ThermalRange=2500.000000
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
	AIReloadTime=1.500000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.NRP57InA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=43,G=50,R=42,A=171),Color2=(B=16,G=27,R=104,A=151),StartSize1=96,StartSize2=76)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	BigIconMaterial=Texture'BWBP_OP_Tex.XBow.BigIcon_Crossbow'
	IdleTweenTime=0.000000
	
	bWT_Bullet=True
	ManualLines(0)="Launches a toxic crossbow bolt. This attack has a long fire interval and moderate damage, but is almost invisible and makes no sound. As such, it is very difficult to detect."
	ManualLines(1)="Raises the scope."
	ManualLines(2)="Effective at long range. Excels at stealth."
	SpecialInfo(0)=(Info="120.0;15.0;0.8;50.0;0.0;0.5;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout',Volume=0.220000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway',Volume=0.220000)
	CockAnim='CockRotateMag'
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Lever-Action",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
	WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
	CurrentWeaponMode=0
	ScopeViewTex=Texture'BWBP_OP_Tex.R9A1.R9_scope_UI_DO1'
	FullZoomFOV=50.000000
	bNoCrosshairInScope=True
	SightOffset=(X=0,Y=0,Z=0)
	MinZoom=2.000000
	MaxZoom=16.000000
	ZoomStages=3
	ParamsClasses(0)=Class'KF8XWeaponParamsComp'
	ParamsClasses(1)=Class'KF8XWeaponParamsClassic'
	ParamsClasses(2)=Class'KF8XWeaponParamsRealistic'
    ParamsClasses(3)=Class'KF8XWeaponParamsTactical'
	CockSound=(Sound=Sound'BWBP_OP_Sounds.XBow.CockFast',Volume=1.200000)
	FireModeClass(0)=Class'BWBP_OP_Pro.KF8XPrimaryFire'
	FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	PutDownTime=0.600000
	BringUpTime=0.900000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	bShowChargingBar=false
	Description="Crossbows have long since been phased out in the battlefield; they're reserved only for hunters or specialist groups across the several galaxies. It wasn't until the exploits of one Billy “Hambo” Hale that they began to pick up popularity again. He claimed he managed to take down a group of Skrith when they weren't looking during an expedition of the reclaimed Amazon.  Using only his wits, some tranquilizer bolts and his crossbow, Hambo's tale had created a surge in the crossbow market, with Enravion taking the lead with their KF-8X Crossbow model. A magazine fed crossbow that's pump action, it comes with a modular scope and poison bolts.  Originally it was supposed to have a built-in stealth generator courtesy of XWI, but it was soon removed after reports of several users becoming violently unhinged after prolonged exposure."
	Priority=24
	HudColor=(B=150,G=150,R=150)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	PickupClass=Class'BWBP_OP_Pro.KF8XPickup'
	PlayerViewOffset=(X=9,Y=6,Z=-6)
	AttachmentClass=Class'BWBP_OP_Pro.KF8XAttachment'
	IconMaterial=Texture'BWBP_OP_Tex.XBow.Icon_Crossbow'
	IconCoords=(X2=127,Y2=31)
	ItemName="KF-8X Stealth Crossbow"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_Crossbow'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BWBP_OP_Tex.XBow.XBow_SH1'
}
