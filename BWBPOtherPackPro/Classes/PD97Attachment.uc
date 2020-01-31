class PD97Attachment extends HandgunAttachment;

var Pawn TazerHit, OldTazerHit;
var PD97TazerEffect TazerEffect;

replication
{
	reliable if (Role == ROLE_Authority)
		TazerHit;
}

//===========================================================================
// PostNetReceive
//
// Notifies clients of targets
//===========================================================================
simulated function PostNetReceive()
{
	if (TazerHit != OldTazerHit)
	{
		OldTazerHit = TazerHit;
		if (TazerHit != None)
			GotTarget(TazerHit);
		else
		{
			TazerEffect.Kill();
			TazerEffect = None;
			if (PD97Bloodhound(Instigator.Weapon) != None)
				PD97Bloodhound(Instigator.Weapon).TazerEffect = None;
		}
	}
	
	Super.PostNetReceive();
}

//===========================================================================
 // GotTarget
 //
 // Called from secondary fire on tazer hit.
//===========================================================================
simulated function GotTarget(Pawn A)
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		TazerHit = A;
	if (TazerEffect == None)
	{
		TazerEffect = spawn(class'PD97TazerEffect', self,,,rot(0,0,0));
		if (PD97Bloodhound(Instigator.Weapon) != None)
			PD97Bloodhound(Instigator.Weapon).TazerEffect = TazerEffect;
		TazerEffect.SetTarget(A);
		TazerEffect.Instigator = Instigator;
		TazerEffect.UpdateTargets();
	}
	else
		TazerEffect.SetTarget(A);
}

//===========================================================================
 // TazeEnd
 //
 // Called from secondary fire on release of altfire key or from tazereffect on loss of target.
//===========================================================================
simulated function TazeEnd()
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		TazerHit = None;
	if (TazerEffect != None)
	{
		TazerEffect.KillFlashes();
		TazerEffect.SetTimer(0.0, false);
		TazerEffect.Kill();

		if (PD97Bloodhound(Instigator.Weapon) != None)
			PD97Bloodhound(Instigator.Weapon).TazerEffect = None;
	}
}

simulated function Tick(float DT)
{
	super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	
	if (TazerEffect != None && !Instigator.IsFirstPerson())
		TazerEffect.SetLocation(GetBoneCoords('tip2').Origin);
}

simulated function Destroyed()
{
	if (TazerEffect != None)
	{
		TazerEffect.KillFlashes();
		TazerEffect.SetTimer(0.0, false);
		TazerEffect.Kill();
	}
	
	Super.Destroyed();
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_BigBullet'
     AltFlashBone="ejector"
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     InstantMode=MU_None
     FlashMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_None
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_BreakOpen"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.70000
     Mesh=SkeletalMesh'BWBPOtherPackAnim.Bloodhound_TP'
     RelativeLocation=(Z=11.000000)
     DrawScale=0.200000
}
