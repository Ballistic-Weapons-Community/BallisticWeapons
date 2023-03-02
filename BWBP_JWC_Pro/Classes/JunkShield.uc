//=============================================================================
// JunkShield.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkShield extends Inventory config(BWBP_JWC_Pro);

var() rotator		DownDir;		// FIXME
var() rotator		UpDir;
var() float			DownCoverage;
var() float			UpCoverage;
var() float			BlockRate;
var() float			Rating;

var(Anims) name			BringUpAnim;
var(Anims) name			PutDownAnim;
var(Anims) name			IdleDownAnim;
var(Anims) name			IdleUpAnim;
var(Anims) name			BlockStartAnim;
var(Anims) name			BlockEndAnim;
var(Anims) name			BlockLeftAnim;
var(Anims) name			BlockRightAnim;
var(Anims) name			BlockCenterAnim;
var(Anims) name			MoveAwayAnim;
var(Anims) name			MoveAwayBlockedAnim;

//var() vector		PlayerViewOffset;
//var() rotator		PlayerViewPivot;
var(FirstPerson) float			DisplayFOV;

var   Actor			ShieldProp;
var(FirstPerson) class<Actor>	ShieldPropClass;
var(FirstPerson) vector			AttachOffset;
var(FirstPerson) rotator		AttachPivot;
var(FirstPerson) name			AttachBone;
var   Weapon		Weapon;
var   bool			bBlocking;
var   float			LastBlockTime;
var   Rotator		LastHitDir;
var	  bool			bActive;
var	  bool			bDrawShield;

var() int			Health;			//FIXME
var() int			HurtThreshold;
var() int			MinProtection;
var() int			MaxProtection;
var() bool			bBlockByHealth;

var() config bool	bListed;	//FIXME

var() Material		RedTeamSkin;
var() Material		BlueTeamSkin;

var   float			Hand;
var   float			RenderedHand;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientActivate, ClientDeactivate, ClientDoBlock, ClientShieldBroken, ClientShieldUp, ClientShieldDown;
	reliable if (Role < ROLE_Authority)
		Activate, Deactivate, ShieldUp, ShieldDown;
	unreliable if (bNetDirty && bNetOwner && Role == ROLE_Authority)
		Health;
}

simulated function ClientShieldUp()
{
	PlayAnim(BlockStartAnim);
	bBlocking=true;
}
function ShieldUp()
{
	if (!bActive)
		return;
	ClientShieldUp();
	bBlocking=true;
	JunkShieldAttachment(ThirdPersonActor).SetBlocking(bBlocking);
}
simulated function ClientShieldDown()
{
	PlayAnim(BlockEndAnim);
	bBlocking=false;
}
function ShieldDown()
{
	if (!bActive)
		return;
	ClientShieldDown();
	bBlocking=false;
	JunkShieldAttachment(ThirdPersonActor).SetBlocking(bBlocking);
}

simulated function WeaponFired()
{
	if (bBlocking)
		PlayAnim(MoveAwayBlockedAnim);
	else
		PlayAnim(MoveAwayAnim);
//	bBlocking=false;
}

simulated function RenderOverlays( canvas Canvas )
{
	local vector V, newScale3D;
	local rotator R;

	if ( Instigator == None || Instigator.Controller == None)
		return;
	if ( Instigator.Controller != None )
		Hand = Instigator.Controller.Handedness;
	if (!bDrawShield || Hand < -1.0 || Hand > 1.0)
		return;

    if (Hand != RenderedHand)
    {
    	if (Hand < 0.0)
    	{
			BlockLeftAnim = Default.BlockRightAnim;
			BlockRightAnim = Default.BlockleftAnim;
		}
		else
		{
			BlockLeftAnim = Default.BlockLeftAnim;
			BlockRightAnim = Default.BlockRightAnim;
		}
		newScale3D = Default.DrawScale3D;
		if ( Hand != 0 )
			newScale3D.Y *= Hand;
		SetDrawScale3D(newScale3D);
		PlayerViewPivot = Default.PlayerViewPivot;
		PlayerViewOffset = Default.PlayerViewOffset;
		AttachOffset = Default.AttachOffset;
		AttachPivot = Default.AttachPivot;
		if (Hand != 0)
		{
			PlayerViewPivot.Roll = Default.PlayerViewPivot.Roll * Hand;
			PlayerViewPivot.Yaw = Default.PlayerViewPivot.Yaw * Hand;
			PlayerViewOffset.Y *= Hand;
			AttachOffset.Y = Default.AttachOffset.Y * Hand;
			AttachPivot.Roll = Default.AttachPivot.Roll * Hand;
			AttachPivot.Yaw = Default.AttachPivot.Yaw * Hand;
		}
		if (ShieldProp != None)
		{
			newScale3D = ShieldProp.Default.DrawScale3D;
			if ( Hand != 0 )
				newScale3D.Y *= Hand;
			ShieldProp.SetDrawScale3D(newScale3D);
		}
		RenderedHand = Hand;
	}

    SetLocation( Instigator.Location + Instigator.CalcDrawOffset(self) );
    SetRotation( Instigator.GetViewRotation() );

    bDrawingFirstPerson = true;
    Canvas.DrawActor(self, false, false, DisplayFOV);
    bDrawingFirstPerson = false;

	if (ShieldProp == None)
		return;

	R = GetBoneRotation(AttachBone);
	if (Hand < 0.0)
	{
		R.Roll *= -1;
		R.Roll += 32768;
	}
	V = GetBoneCoords(AttachBone).Origin + class'bUtil'.static.AlignedOffset(R, AttachOffset);
	ShieldProp.SetLocation(V);
	ShieldProp.SetRotation(class'bUtil'.static.RotateAboutAxis(R, AttachPivot));
	Canvas.DrawActor(ShieldProp, false, false, DisplayFOV);
}
// Draw extra shield info on HUD
simulated function DrawShieldInfo (Canvas Canvas)
{
	local float	ScaleFactor, XL, YL;

	if (!bActive)
		return;
	ScaleFactor = Canvas.ClipX / 1600;
	Canvas.Font = class'BallisticWeapon'.static.GetFontSizeIndex(Canvas, -1 + int(2 * class'HUD'.default.HudScale));
	Canvas.DrawColor = class'hud'.default.WhiteColor;

	Canvas.TextSize(Health, XL, YL);
	Canvas.CurX = Canvas.OrgX + 5 * ScaleFactor * class'HUD'.default.HudScale;
	Canvas.CurY = Canvas.ClipY - 140 * ScaleFactor * class'HUD'.default.HudScale - YL;
	Canvas.DrawText(Health, false);
}

simulated function ClientDoBlock (byte Side)
{
	if (Side == 0)
		PlayAnim(BlockLeftAnim);
	else if (Side == 2)
		PlayAnim(BlockCenterAnim);
	else
		PlayAnim(BlockRightAnim);
}

function BlockDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DT)
{
	local class<BallisticDamageType> BDT;
	local float BlockFactor, ShieldDamage;

	// FIXME: Let damage do stuff if it gets blocked...

	BDT = class<BallisticDamageType>(DT);
	if (BDT!=None)
	{
		if (!BDT.default.bCanBeBlocked || (!BDT.static.IsDamage(",Blunt,") && !BDT.static.IsDamage(",Slash,") && !BDT.static.IsDamage(",Stab,") && !BDT.static.IsDamage(",Hack,")))
			return;
		ShieldDamage = BDT.default.ShieldDamage;
	}
	else if (DT.default.bBulletHit)
		return;
	else if (ClassIsChildOf(DT, class'MeleeDamage') || Monster(InstigatedBy) != None)
		ShieldDamage = Damage*1.25;
	else if (ClassIsChildOf(DT, class'WeaponDamageType'))
		ShieldDamage = Damage*2;
	else
		return;

//	if (BDT!=None && BDT.default.bCanBeBlocked && (BDT.static.IsDamage(",Blunt,") || BDT.static.IsDamage(",Slash,") || BDT.static.IsDamage(",Stab,") || BDT.static.IsDamage(",Hack,")))
//	{
		if (ShieldDamage > HurtThreshold)
			Health -= ShieldDamage - HurtThreshold;
		if (ShieldDamage > MinProtection)
		{
			if (bBlockByHealth)
				BlockFactor = 1.0 - float(Health) / default.Health;
			else if (ShieldDamage >= MaxProtection)
				BlockFactor = 1.0;
			else
				BlockFactor = (ShieldDamage-MinProtection) / (MaxProtection-MinProtection);
		}
		Damage *= BlockFactor;
		Momentum *= BlockFactor;
//	}
}

function DoBlocking( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local vector X,Y,Z, HitNormal;
	local float Rightness;

	BlockDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);

	LastBlockTime = level.TimeSeconds;
	HitNormal = Normal(HitLocation-(Instigator.Location+Instigator.EyePosition()));
	LastHitDir = Rotator(HitNormal)-Instigator.GetViewRotation();
	if (class<BallisticDamageType>(DamageType) != None)
		JunkShieldAttachment(ThirdPersonActor).BlockHit(HitLocation, DamageType);
	else
		JunkShieldAttachment(ThirdPersonActor).BlockHit(HitLocation, class'DTJunkClawHammer');
	GetAxes(Instigator.GetViewRotation(), X,Y,Z);
	Rightness = Y Dot HitNormal;
	if (Rightness < -0.3)
		ClientDoBlock(0);
	else if (Rightness > 0.3)
		ClientDoBlock(1);
	else
		ClientDoBlock(2);
}
function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local float NextTime;

	if ((ClassIsChildOf(DamageType, class'MeleeDamage') || Monster(InstigatedBy) != None) && HitLocation == vect(0,0,0))
		HitLocation = Instigator.Location + Normal(InstigatedBy.Location - Instigator.Location)*Instigator.CollisionRadius;

	if (Weapon.GetFireMode(1) != None && Weapon.GetFireMode(1).NextFireTime > Weapon.GetFireMode(0).NextFireTime)
		NextTime = Weapon.GetFireMode(1).NextFireTime - Weapon.GetFireMode(1).FireRate + FMax(BlockRate*0.8, Weapon.GetFireMode(1).FireRate);
	else
		NextTime = Weapon.GetFireMode(0).NextFireTime - Weapon.GetFireMode(0).FireRate + FMax(BlockRate*0.8, Weapon.GetFireMode(0).FireRate);

	if (bBlocking /*&& !Weapon.IsFiring()*/ && level.TimeSeconds >= NextTime)
	{
		if (level.TimeSeconds > LastBlockTime + BlockRate)
		{
			if (Normal(HitLocation-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()+UpDir) > UpCoverage)
				DoBlocking(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
		}
		else if (Normal(HitLocation-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()+LastHitDir) > DownCoverage)
			DoBlocking(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
	}
	else if (Normal(HitLocation-(Instigator.Location+Instigator.EyePosition())) Dot Vector(Instigator.GetViewRotation()+DownDir) > DownCoverage)
		DoBlocking(Damage, InstigatedBy, HitLocation, Momentum, DamageType);

	if (Health < 1)
	{
		ClientShieldBroken();
		if (!Instigator.IsLocallyControlled())
			SetTimer (0.1, false);
	}
}

event Timer()
{
	Destroy();
}

simulated function ClientShieldBroken ()
{
	JunkShieldProp(ShieldProp).GoCrazy();
	ShieldProp=None;
	Destroy();
}

simulated function AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);

	if (!bActive)
//	if (Anim == PutDownAnim)
		bDrawShield=False;
	else
	{
		if (bBlocking)
			LoopAnim(IdleUpAnim);
		else
			LoopAnim(IdleDownAnim);
	}
}

simulated function PostBeginPlay()
{
	if (ShieldPropClass != None)
		ShieldProp = Spawn(ShieldPropClass,self);
	ShieldProp.SetDrawScale(DrawScale*ShieldProp.DrawScale);
}
simulated function Destroyed()
{
	if (ShieldProp != None)
		ShieldProp.Destroy();
	super.Destroyed();
}
simulated function PostNetBeginPlay()
{
    Instigator = Pawn(Owner);
	super.PostNetBeginPlay();
}

simulated function ClientActivate()
{
	if (Instigator.PlayerReplicationInfo != None && Instigator.PlayerReplicationInfo.Team != None)
	{
		if (Instigator.PlayerReplicationInfo.Team.TeamIndex == 0)
			Skins[0] = RedTeamSkin;
		else
			Skins[0] = BlueTeamSkin;
	}
	PlayAnim(BringUpAnim);
	bActive=True;
	bDrawShield=true;
}
simulated function ClientDeactivate()
{
	PlayAnim(PutDownAnim);
	bActive=False;
	bBlocking=false;
}

function Activate()
{
//	if (Role == ROLE_Authority && !Instigator.IsLocallyControlled())
		ClientActivate();
	AttachToPawn(Pawn(Owner));
	PlayAnim(BringUpAnim);
	bActive=True;
	JunkShieldAttachment(ThirdPersonActor).SetBlocking(bBlocking);
}
function Deactivate()
{
//	if (Role == ROLE_Authority && !Instigator.IsLocallyControlled())
		ClientDeactivate();
	DetachFromPawn(Instigator);
	bActive=False;
	bBlocking=false;
}

function AttachToPawn(Pawn P)
{
	local name BoneName;

	Instigator = P;
	if ( ThirdPersonActor == None )
	{
		ThirdPersonActor = Spawn(AttachmentClass,Owner);
		InventoryAttachment(ThirdPersonActor).InitFor(self);
	}
	else
		ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
	BoneName = P.GetOffHandBoneFor(self);
	if ( BoneName == '' )
	{
		ThirdPersonActor.SetLocation(P.Location);
		ThirdPersonActor.SetBase(P);
	}
	else
		P.AttachToBone(ThirdPersonActor,BoneName);
}

function GiveTo( pawn Other, optional Pickup Pickup )
{
	local Inventory Inv;
	super.GiveTo(Other, Pickup);

	if (JunkShieldPickup(Pickup) != None && JunkShieldPickup(Pickup).Health > 0)
		Health = JunkShieldPickup(Pickup).Health;

	if (Weapon == None)
		for ( Inv=Instigator.Inventory; Inv!=None; Inv=Inv.Inventory )
			if (JunkWeapon(Inv) != None && JunkWeapon(Inv).Shield == None)
			{	JunkWeapon(Inv).Shield = self;
				Weapon = JunkWeapon(Inv);
				break;	}
	if (!Instigator.IsHumanControlled() && JunkWeapon(Weapon) != None && JunkWeapon(Weapon).Junk != None && !JunkWeapon(Weapon).Junk.bDisallowShield)
		Activate();
}

defaultproperties
{
     DownDir=(Pitch=-4096,Yaw=-8192)
     UpDir=(Pitch=-1024,Yaw=-1024)
     DownCoverage=0.700000
     UpCoverage=0.400000
     BlockRate=0.800000
     rating=50.000000
     BringUpAnim="Pullout"
     PutDownAnim="putaway"
     IdleDownAnim="Idle"
     IdleUpAnim="BlockIdle"
     BlockStartAnim="PrepBlock"
     BlockEndAnim="EndBlock"
     BlockLeftAnim="BlockHitLeft"
     BlockRightAnim="BlockHitRight"
     BlockCenterAnim="BlockHitCenter"
     MoveAwayAnim="OutOfWay1"
     MoveAwayBlockedAnim="OutOfWay2"
     DisplayFOV=60.000000
     ShieldPropClass=Class'BWBP_JWC_Pro.JunkShieldProp'
     AttachOffset=(X=-1.000000,Y=0.500000,Z=1.500000)
     AttachPivot=(Pitch=500,Yaw=-16384,Roll=-1000)
     AttachBone="Prop"
     Health=100
     HurtThreshold=50
     MinProtection=100
     MaxProtection=200
     bListed=True
     RedTeamSkin=Shader'BWBP_JW_Tex.Hands.RedHandsShiny'
     BlueTeamSkin=Shader'BWBP_JW_Tex.Hands.BlueHandsShiny'
     RenderedHand=1.000000
     PickupClass=Class'BWBP_JWC_Pro.JunkShieldPickup'
     PlayerViewOffset=(X=-5.000000,Y=6.000000,Z=-18.000000)
     AttachmentClass=Class'BWBP_JWC_Pro.JunkShieldAttachment'
     ItemName="Junk Shield"
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'BWBP_JW_Anim.JunkShieldHands'
     DrawScale=0.280000
     AmbientGlow=20
     MaxLights=6
     ScaleGlow=1.500000
}
