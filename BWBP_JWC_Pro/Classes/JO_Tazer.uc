//=============================================================================
// JO_Tazer.
//
// A favourite of law enforcement officials.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_Tazer extends JunkObject;

var Emitter TazerEffect;

static function bool SetThirdPersonDisplay(Actor TPA)
{
	if (JunkWeaponAttachment(TPA) != None)
	{
		JunkWeaponAttachment(TPA).SpecialActor = TPA.Spawn(class'JunkTazerEffect',TPA,,TPA.Location, TPA.Rotation);
		class'BallisticEmitter'.static.ScaleEmitter(Emitter(JunkWeaponAttachment(TPA).SpecialActor), default.ThirdPersonDrawScale);
		TPA.Instigator.AttachToBone(JunkWeaponAttachment(TPA).SpecialActor, 'righthand');
//		JunkWeaponAttachment(TPA).SpecialActor.SetBase(TPA);

		JunkWeaponAttachment(TPA).SpecialActor.SetRelativeRotation(default.ThirdPersonPivot);
		JunkWeaponAttachment(TPA).SpecialActor.SetRelativeLocation(default.ThirdPersonOffset);
		JunkWeaponAttachment(TPA).SpecialActor.bHidden=false;
	}
	return false;
}
static function RestoreThirdPersonDisplay(Actor TPA)
{
	if (JunkWeaponAttachment(TPA) != None && JunkWeaponAttachment(TPA).SpecialActor != None)
		JunkWeaponAttachment(TPA).SpecialActor.Destroy();
}
simulated function PostInitialize (Actor JunkActor)
{
	if (JunkActor == None)
		return;
	if (TazerEffect == None)
	{
		TazerEffect = JunkActor.Spawn(class'JunkTazerEffect',JunkActor,,JunkActor.Location, JunkActor.Rotation);
		class'BallisticEmitter'.static.ScaleEmitter(TazerEffect, DrawScale*Weapon.DrawScale);
	}
	TazerEffect.SetBase(JunkActor);
}
simulated function Uninitialize(JunkObject NewJunk)
{
	if (TazerEffect != None)
		TazerEffect.Destroy();
	TazerEffect = None;
}
simulated function bool JunkRenderOverlays (Canvas C)
{
	if (TazerEffect != None && Weapon != None)
		C.DrawActor(TazerEffect,false,false, Weapon.DisplayFOV);
	return false;
}
function bool SendDamageEffect(WeaponFire Fire, JunkFireInfo FI, int OldHealth, Actor Victim, float Damage, vector HitLocation, vector Dir, class<DamageType> DT)
{
	local int i;
	local JunkViewMesser VM;

	if (Pawn(Victim) == None || Pawn(Victim).Health < 1 || Pawn(Victim).LastPainTime != Victim.level.TimeSeconds)
		return false;
	if (PlayerController(Pawn(Victim).Controller) != None)
	{
		for (i=0;i<Pawn(Victim).Controller.Attached.length;i++)
			if (JunkViewMesser(Pawn(Victim).Controller.Attached[i]) != None)
			{
				JunkViewMesser(Pawn(Victim).Controller.Attached[i]).AddImpulse();
				i=-1;
				break;
			}
		if (i != -1)
		{
			VM = Spawn(class'JunkViewMesser',Pawn(Victim).Controller);
			VM.SetBase(Pawn(Victim).Controller);
			VM.AddImpulse();
		}
	}
	else if (AIController(Pawn(Victim).Controller) != None)
	{
		AIController(Pawn(Victim).Controller).Startle(Weapon.Instigator);
		class'BC_BotStoopidizer'.static.DoBotStun(AIController(Pawn(Victim).Controller), 2, 15);
	}
	return false;
}

defaultproperties
{
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.TazerLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Tazer, zapping time"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.Tazer'
     AttachOffset=(X=0.400000)
     AttachPivot=(Yaw=-4096,Roll=-500)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=2000,Yaw=3000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=1000,Yaw=1500))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Pitch=-1000,Yaw=-1500))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-2000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTazerHit'
         Damage=(head=40,Limb=12,Misc=30)
         KickForce=90000
         DamageType=Class'BWBP_JWC_Pro.DTJunkTazer'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Electro-Swing',Volume=0.600000)
         Anims(0)="AvgHit1"
         Anims(1)="StabHit1"
         Anims(2)="AvgHit2"
         Anims(3)="StabHit2"
         Anims(4)="AvgHit3"
         Anims(5)="StabHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_Tazer.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=130.000000,Max=130.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=2000,Yaw=3000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=1000,Yaw=1500))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Pitch=-1000,Yaw=-1500))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-2000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTazerHit'
         Damage=(head=70,Limb=35,Misc=45)
         KickForce=95000
         DamageType=Class'BWBP_JWC_Pro.DTJunkTazer'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Electro-Swing',Volume=0.600000)
         Anims(0)="StabAttack"
         Anims(1)="AvgAttack"
         PreFireAnims(0)="StabPrepAttack"
         PreFireAnims(1)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_Tazer.JunkFireInfo1'

     SelectSound=(Sound=Sound'BWBP_JW_Sound.Misc.Pullout-Electro')
     FriendlyName="Tazer"
     InventoryGroup=6
     MeleeRating=85.000000
     RangeRating=0.000000
     SpawnWeight=0.900000
     PainThreshold=25
     NoUseThreshold=50
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.Tazer'
}
