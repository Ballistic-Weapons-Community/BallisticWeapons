//===========================================================================
// BX-85 Stealth Crossbow.
//
// Primary fires relatively slow projectile crossbow bolts for poor DPS.
// Secondary fires lightning projectiles which damage the target and inflict a DoT effect.
// Nearby targets hit with the primary will connect to the electrified target, limiting distance from
// them and sharing damage.
//
// Passively cloaks the user based on their movement speed. Low settings abusers have an additional
// penalty on this check.
//===========================================================================
class BX85Crossbow extends BallisticWeapon;

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
		//65536 = 360 degrees
		//each cock sets the mag bone rotation by 4 degrees depending on the MagAmmo
		
		MagBoneRotation.Roll = -4 * (8-MagAmmo) * (65536/360);
		SetBoneRotation(MagBone, MagBoneRotation, 0, 1.0);
		
		RemoveArrow();
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

//hide the arrow that has been shot

simulated function RemoveArrow()
{
	SetBoneScale(MagAmmo-1, 0.0, ArrowBones[MagAmmo-1].BoneName);
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

	/*if (bThermal)
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
	{*/
    		C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);

        	C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTex, C.SizeY, C.SizeY, 0, 0, 1024, 1024);

        	C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
        	C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
	//}
		
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
			NVLight = Spawn(class'BX85NVLight',,,Instigator.location);
			NVLight.SetBase(Instigator);
		}
		NVLight.bDynamicLight = true;
	}
	else if (NVLight != None)
		NVLight.bDynamicLight = false;
}

simulated function float ChargeBar()
{
	return BX85Attachment(ThirdPersonActor).CurAlpha / 128.0f;
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
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=1)
	AIReloadTime=1.500000
	BigIconMaterial=Texture'BWBP_OP_Tex.XBow.BigIcon_Crossbow'
	IdleTweenTime=0.000000
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="Launches an instant-hit crossbow bolt. This attack has a long fire interval and moderate damage, but is almost invisible and makes no sound. As such, it is very difficult to detect."
	ManualLines(1)="Raises the scope."
	ManualLines(2)="Effective at long range. Excels at stealth."
	SpecialInfo(0)=(Info="120.0;15.0;0.8;50.0;0.0;0.5;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
	CockAnim='CockRotateMag'
	CockAnimRate=1.250000
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipIn')
	ClipInFrame=0.650000
	CurrentWeaponMode=0
	ScopeViewTex=Texture'BWBP_OP_Tex.R9A1.R9_scope_UI_DO1'
	FullZoomFOV=50.000000
	bNoCrosshairInScope=True
	SightOffset=(X=-2.000000,Y=5.000000,Z=5.200000)
	SightDisplayFOV=40.000000
	MinZoom=2.000000
	MaxZoom=16.000000
	ZoomStages=3
	ParamsClasses(0)=Class'BX85WeaponParams'
	CockSound=(Sound=Sound'BWBP_OP_Sounds.XBow.CockFast',Volume=1.200000)
	FireModeClass(0)=Class'BWBPOtherPackPro.BX85PrimaryFire'
	FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	PutDownTime=0.600000
	BringUpTime=0.900000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	bShowChargingBar=True
	Description="Originally a specialist law enforcement weapon, the PD-97 'Bloodhound' has been adapted into a military role, used to control opponents and track their movement upon the battlefield. While less immediately lethal than most other weapons, its tactical repertoire is not to be underestimated."
	Priority=24
	HudColor=(B=150,G=150,R=150)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	PickupClass=Class'BWBPOtherPackPro.BX85Pickup'
	PlayerViewOffset=(X=10.000000,Y=2.000000,Z=-7.000000)
	AttachmentClass=Class'BWBPOtherPackPro.BX85Attachment'
	IconMaterial=Texture'BWBP_OP_Tex.XBow.Icon_Crossbow'
	IconCoords=(X2=127,Y2=31)
	ItemName="BX85 Stealth Crossbow"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_OP_Anim.FPm_Crossbow'
	DrawScale=0.200000
	Skins(0)=Shader'BWBP_OP_Tex.XBow.XBow_SH1'
}
