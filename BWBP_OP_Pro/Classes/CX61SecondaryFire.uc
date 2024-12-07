//=============================================================================
// CX61 Secondary Fire
//
// A medium ranged stream of fire which easily sears players and goes into small
// spaces. Uses trace / projectile combo for hit detection.
//
// by Azarael
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//=============================================================================
class CX61SecondaryFire extends BallisticFire;

var  	Actor						MuzzleFlame;
var   	bool						bIgnited;
var 	Sound						FireSoundLoop;
var BUtil.FullSound 				FlameEndSound;
const FLAMERINTERVAL = 0.2f;

simulated function bool HasAmmo()
{
	return CX61AssaultRifle(Weapon).StoredGas > 0;
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if(NewMode == 1)
	{
		BallisticFireSound.Sound=None;
		FireSoundLoop=Sound'BW_Core_WeaponSound.T10.T10-toxinLoop';
	}
	else
	{
		BallisticFireSound.Sound=Sound'BWBP_OP_Sounds.CX61.CX61-FlameLoopStart';
		FireSoundLoop=Sound'BWBP_OP_Sounds.CX61.CX61-FlameLoop';
	}

	if (Weapon.bBerserk)
	{
		FireRate *= 0.75;
		FireRecoil *= 0.75;
		FireChaos *= 0.75;
	}
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

	Load=AmmoPerFire;
}

event Timer()
{
	super.Timer();
	if ( bIgnited && (!IsFiring() || Weapon.GetFireMode(0).IsFiring() ) )
	{
		StopFlaming();
	}
}

function StopFlaming()
{
	bIgnited = false;
	
	if (MuzzleFlame != None)
	{	
		Emitter(MuzzleFlame).Kill();	
		MuzzleFlame = None;	
	}

	Instigator.AmbientSound = BW.UsedAmbientSound;
}

function float MaxRange()	{	return 800;	}

auto simulated state Flamer
{
	function DoFireEffect()
	{
		local Vector Start, Dir, End, HitLocation, HitNormal;
		local Rotator Aim;
		local actor Other;
		local float Dist;
		local int i;
		local CX61FlameProjectile Prj;
	
	    // the to-hit trace always starts right in front of the eye
		Start = Instigator.Location + Instigator.EyePosition();
		Aim = GetFireAim(Start);
		Aim = Rotator(GetFireSpread() >> Aim);
	
	    Dir = Vector(Aim);
		End = Start + (Dir*MaxRange());
	
		Weapon.bTraceWater=true;
		for (i=0;i<20;i++)
		{
			Other = Trace(HitLocation, HitNormal, End, Start, true);
			if (Other == None || Other.bWorldGeometry || Mover(Other) != none || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
				break;
			Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
		}
		Weapon.bTraceWater=false;
	
		if (Other == None)
			HitLocation = End;
		if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			Other = None;
	
		Dist = VSize(HitLocation-Start);
	
		Prj = Spawn (class'CX61FlameProjectile',Instigator,, Start, Rotator(HitLocation-Start));
		
		if (Prj != None)
		{
			Prj.Instigator = Instigator;
			Prj.InitFlame(HitLocation);
			Prj.bHitWall = Other != None;
		}
	
		CX61Attachment(Weapon.ThirdPersonActor).CX61UpdateFlameHit(Other, HitLocation, HitNormal);
		
		if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
			CX61AssaultRifle(Weapon).StoredGas -= 0.08;
		else
			CX61AssaultRifle(Weapon).StoredGas -= 0.1;
	
		Super(BallisticFire).DoFireEffect();
	}
	
	//Do the spread on the client side
	function PlayFiring()
	{
	    ClientPlayForceFeedback(FireForce);  // jdf
	    FireCount++;
	
		if (FireSoundLoop != None)
			Instigator.AmbientSound = FireSoundLoop;
	
		if (!bIgnited)
		{
			//BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
			bIgnited = true;
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		}
		if (MuzzleFlame == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlame, class'RX22AMuzzleFlame', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip2');
	}
	
	//server
	function ServerPlayFiring()
	{
		if (!bIgnited)
		{
			//BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
			bIgnited = true;
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		}
		if (FireCount == 0 && FireSoundLoop != None)
			Instigator.AmbientSound = FireSoundLoop;
	}
}

simulated state HealGas
{
	function DoFireEffect()
	{
		local Vector Start, Dir, End, HitLocation, HitNormal;
		local Rotator Aim;
		local actor Other;
		local float Dist;
		local int i;
		local CX61HealProjectile Prj;
	
	    // the to-hit trace always starts right in front of the eye
		Start = Instigator.Location + Instigator.EyePosition();
		Aim = GetFireAim(Start);
		Aim = Rotator(GetFireSpread() >> Aim);
	
	    Dir = Vector(Aim);
		End = Start + (Dir*MaxRange());
	
		Weapon.bTraceWater=true;
		for (i=0;i<20;i++)
		{
			Other = Trace(HitLocation, HitNormal, End, Start, true);
			if (Other == None || Other.bWorldGeometry || Mover(Other) != none || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
				break;
			Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
		}
		Weapon.bTraceWater=false;
	
		if (Other == None)
			HitLocation = End;
		if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			Other = None;
	
		Dist = VSize(HitLocation-Start);
	
		Prj = Spawn (class'CX61HealProjectile',Instigator,, Start, Rotator(HitLocation-Start));
		
		if (Prj != None)
		{
			Prj.Instigator = Instigator;
		}
		
		CX61AssaultRifle(Weapon).StoredGas -= 0.04;
		CX61Attachment(Weapon.ThirdPersonActor).CX61UpdateGasHit(HitLocation);
	
		Super(BallisticFire).DoFireEffect();
	}
	
	//Do the spread on the client side
	function PlayFiring()
	{
	    ClientPlayForceFeedback(FireForce);  // jdf
	    FireCount++;
		
		if (!bIgnited)
		{
			//BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
			bIgnited = true;
		}
	
		if (FireSoundLoop != None)
			Instigator.AmbientSound = FireSoundLoop;
	}
	
	//server
	function ServerPlayFiring()
	{
		if (!bIgnited)
		{
			//BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
			bIgnited = true;
		}
		
		if (FireCount == 0 && FireSoundLoop != None)
			Instigator.AmbientSound = FireSoundLoop;
	}
}

// Flamer should fire unless the gun's reloading
simulated function bool AllowFire()
{
	if (!CheckReloading() || Instigator.HeadVolume.bWaterVolume || CX61AssaultRifle(Weapon).StoredGas <= 0)
	{
		if (bIgnited)
			StopFiring();
		return false;
	}
	return true;
}

function StopFiring()
{
	bIgnited = false;
	Weapon.PlayOwnedSound(FlameEndSound.Sound,FlameEndSound.Slot,FlameEndSound.Volume,FlameEndSound.bNoOverride,FlameEndSound.Radius,FlameEndSound.Pitch,FlameEndSound.bAtten);
	Instigator.AmbientSound = None;
	NextFireTime = Level.TimeSeconds + FLAMERINTERVAL;
	if (MuzzleFlame != None)
	{
		Emitter(MuzzleFlame).Kill();
		MuzzleFlame = None;
	}
}

simulated function DestroyEffects()
{
	Super.DestroyEffects();
	if (MuzzleFlame != None)
		MuzzleFlame.Destroy();
}

defaultproperties
{
	FlameEndSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-FlameLoopEnd2',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	FireSoundLoop=Sound'BWBP_OP_Sounds.CX61.CX61-FlameLoop'
	FlashBone="'"
	FireChaos=0.050000
	BallisticFireSound=(Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	bPawnRapidFireAnim=True
	FireAnim=
	FireRate=0.090000
	AmmoClass=Class'BallisticProV55.Ammo_556mm'
	AmmoPerFire=0
	WarnTargetPct=0.200000
}
