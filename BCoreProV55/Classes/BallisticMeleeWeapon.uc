//=============================================================================
// BallisticMeleeWeapon.
//
// Base class for melee weapons that can be used to block the attacks of enemy
// weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticMeleeWeapon extends BallisticWeapon 
	abstract
	HideDropDown
	CacheExempt;

var() bool			bCanBlock; 		// Capable of blocking
var   bool			bBlocked;		// Currently blocking
var() name			BlockUpAnim;	// Anim for going into blocking
var() name			BlockDownAnim;	// Anim when blocking stops
var() name			BlockIdleAnim;	// Anim when in block mode and idle

var float			FatigueDeclineTime;
var float			FatigueDeclineDelay;

var float			MeleeSpreadAngle;

replication
{
	reliable if ( Role<ROLE_Authority )
		ServerSetBlocked;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	MeleeSpreadAngle = BallisticMeleeFire(BFireMode[0]).GetCrosshairInaccAngle();
}

function ServerSetBlocked(bool NewValue)
{
	bBlocked=NewValue;
	BallisticAttachment(ThirdPersonActor).SetBlocked(NewValue);
}

simulated function float ChargeBar()
{
	return MeleeFatigue;
}

//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (!bCanBlock || bBlocked)
		return;
		
	ServerSetBlocked(true);
	bBlocked=true;

	if (!IsFiring())
		PlayAnim(BlockUpAnim, 1.5);
	IdleAnim = BlockIdleAnim;
	/*if (BallisticAttachment(ThirdPersonActor) != None)
		Instigator.SetAnimAction('Blocking');*/
}
//simulated function DoWeaponSpecialRelease(optional byte i)
exec simulated function WeaponSpecialRelease(optional byte i)
{
	if (!bCanBlock || !bBlocked)
		return;

	ServerSetBlocked(false);
	bBlocked=false;

	if (!IsFiring())
		PlayAnim(BlockDownAnim, 1.5);
	IdleAnim = default.IdleAnim;
}

final function bool CheckBlockArc(Vector HitLocation, Pawn InstigatedBy)
{
    local float result;

    /*
    HACK.
    Due to rewound collision cylinders, the hit location can be substantially different than the defender's current location
    I need to think about a fix for this
    We check to see if the defender is facing the attacker instead
    */
    if (Level.NetMode == NM_DedicatedServer)
        result = Normal(InstigatedBy.Location - (Instigator.Location + Instigator.EyePosition()) ) Dot Vector(Instigator.GetViewRotation());

    else 
        result = Normal(HitLocation - (Instigator.Location+Instigator.EyePosition()) ) Dot Vector(Instigator.GetViewRotation());

    return result > 0.4;
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local class<BallisticDamageType> BDT;
	
	if (InstigatedBy != None && InstigatedBy.Controller != None && InstigatedBy.Controller.SameTeamAs(InstigatorController))
		return;
		
	BDT = class<BallisticDamageType>(DamageType);
	
	if (VSize(Momentum) < 60)
	{
		if (VSize(Instigator.Location - InstigatedBy.Location) < 384)
			Momentum = vect(0,0,0);
		else Momentum *= 0.5;
	}
	
	if (BDT != None)
	{
		if (bBlocked && !IsFiring() && level.TimeSeconds > LastFireTime + 1 && BDT.default.bCanBeBlocked && CheckBlockArc(HitLocation, InstigatedBy))
		{
			BlockDamage(Damage, InstigatedBy, BDT);
		}
	}
}

//=================================================================
// BlockDamage
//
// Calculates damage reduction for blockable damage types
//=================================================================
function BlockDamage(out int Damage, Pawn InstigatedBy, class<BallisticDamageType> DamageType)
{
	local float ReducibleDamage;
	local float BlockFatigueFactor;
	
	ReducibleDamage = Damage * (1f - DamageType.default.BlockPenetration);
	
	// if the weapon has block penetration, this portion of damage is guaranteed
	Damage -= ReducibleDamage;
	
	// reducible damage portion varies depending on fatigue level
	BlockFatigueFactor = MeleeFatigue * 0.5f;

	Damage += ReducibleDamage * BlockFatigueFactor;
	
	// defender receives fatigue from blocking the weapon, based on the attack type
	ApplyBlockFatigue(DamageType.default.BlockFatiguePenalty);
	
	// display block fx
	BallisticAttachment(ThirdPersonActor).UpdateBlockHit();
	
	// attacker receives additional fatigue for hitting block
	if (instigatedBy != None && BallisticWeapon(instigatedBy.Weapon) != None)
		BallisticWeapon(instigatedBy.Weapon).ApplyAttackFatigue();
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (bBlocked && (anim == FireMode[0].FireAnim || anim == FireMode[1].FireAnim))
	{
		PlayAnim(BlockUpAnim, 1.5);
		IdleAnim = BlockIdleAnim;
		/*if (BallisticAttachment(ThirdPersonActor) != None)
			Instigator.SetAnimAction('Blocking');
		Instigator.ClientMessage("Blocking");*/
	}
	else
	{
		if (!bBlocked)
			IdleAnim = default.IdleAnim;
		/*if (BallisticAttachment(ThirdPersonActor) != None)
			Instigator.SetAnimAction('LowerBlock');	*/
		Super.AnimEnd(Channel);
	}
}

//Draws simple crosshairs to accurately describe hipfire at any FOV and resolution.
simulated function DrawCrosshairs(canvas C)
{
	local float 		ShortBound, LongBound;
	local float 		OffsetAdjustment;

	// Draw weapon specific Crosshairs
	if (bOldCrosshairs || (bScopeView && bNoCrosshairInScope))
		return;

	//C.SetDrawColor(150,150,255,255);
	C.DrawColor = class'HUD'.default.CrosshairColor;
	
	ShortBound = 2;
	LongBound= 10;
	
	OffsetAdjustment = C.ClipX / 2;
	OffsetAdjustment *= tan (MeleeSpreadAngle) / tan((Instigator.Controller.FovAngle/2) * 0.01745329252);
	
	//hor
	C.SetPos((C.ClipX / 2) - (LongBound + OffsetAdjustment), (C.ClipY/2) - (ShortBound/2));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound, ShortBound);
	
	C.SetPos((C.ClipX / 2) + OffsetAdjustment, (C.ClipY/2) - (ShortBound/2));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', LongBound, ShortBound);
	
	//ver
	C.SetPos((C.ClipX / 2) - (ShortBound/2), (C.ClipY/2) - (LongBound + OffsetAdjustment/3));
	C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, LongBound);
	
	C.SetPos((C.ClipX / 2) - (Shortbound/2), (C.ClipY/2) + OffsetAdjustment/3);
	C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, LongBound);
	
	
	//centre square
	if (bDrawCrosshairDot)
	{
		C.DrawColor.A = 255;
		C.SetPos((C.ClipX - ShortBound)/2, (C.ClipY - ShortBound)/2);
		C.DrawTileStretched(Texture'Engine.WhiteTexture', ShortBound, ShortBound);
	}
}

simulated event Tick (Float DT)
{
	Super.Tick (DT);
	
	if (LastFireTime < Level.TimeSeconds - FatigueDeclineDelay && MeleeFatigue > 0)
		MeleeFatigue = FMax(0, MeleeFatigue - DT/FatigueDeclineTime);
}

// AI Interface =====
function bool CanAttack(Actor Other)
{
	return VSize(Other.Location - Instigator.Location) < FireMode[0].MaxRange() * 2;
}

function float GetAIRating()
{
	local Bot B;
	local BallisticWeapon BW;
	local vector Dir;
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None)
		return AIRating;
		
	if (B.Enemy == None)
		return 0; // almost certainly useless against non-humans
		
	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);
	
	// favour melee when attacking the enemy's back
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0)
		Rating += 0.08 * B.Skill;
	
	BW = BallisticWeapon(B.Enemy.Weapon);
	
	if (BW != None)
	{ 
		// discourage melee-on-melee
		if (BW.bMeleeWeapon)
			Rating *= 0.75;
			
		// trying this against a shotgun or a PDW is a very bad idea
		if (BW.bWT_Shotgun || BW.InventoryGroup == 3)
			Rating = 0;	
	}
	
	Rating = class'BUtil'.static.DistanceAtten(Rating, 0.4, Dist, 128, 128);
	
	return Rating * (1 - MeleeFatigue);
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 1;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -1;
}

defaultproperties
{
	bCanBlock=True
	BlockUpAnim="PrepBlock"
	BlockDownAnim="EndBlock"
	BlockIdleAnim="BlockIdle"
	bNoMag=True
	bNonCocking=True
	AIRating=0.700000
	CurrentRating=0.700000
	WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bUseSights=False
	FatigueDeclineTime=4.000000
	FatigueDeclineDelay=0.750000
	bShowChargingBar=True
}
