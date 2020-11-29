//=============================================================================
// A909Attachment.
//
// 3rd person weapon attachment for A909 Skrith Blades
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DefibFistsAttachment extends BallisticMeleeAttachment;

var() Sound DischargeSound;										// Sound of water discharge
var bool bPulse, bShock, bOldPulse, bOldShock;				// toggled to do pulse and shocks on clients
var Actor RightOne;
var Actor LeftOne;
var	Actor				LSparks;
var	Actor				RSparks;
var	bool				bDischarged;

replication
{
	reliable if (Role == ROLE_Authority)
		bPulse, bShock;
}

simulated function DoWave(bool bIsShock)
{
	if (Level.NetMode == NM_DedicatedServer)
	{
		if (bIsShock)
			bShock = !bShock;
		else bPulse = !bPulse;
	}
	
	else if (bIsShock)
		DoShockWave();
	else DoPulseWave();
}

simulated function PostNetReceive()
{
	Super.PostNetReceive();
	
	if (bPulse != bOldPulse)
	{
		bOldPulse = bPulse;
		DoPulseWave();
	}
	
	else if (bShock != bOldShock)
	{
		bOldShock = bShock;
		DoShockWave();
	}
}

simulated function DoPulseWave()
{
	spawn(class'IE_DefibDischarge', Instigator,, Instigator.Location);
}

simulated function DoShockWave()
{
	spawn(class'IE_DefibDischarge', Instigator,, Instigator.Location);
	Instigator.PlaySound(DischargeSound, SLOT_None, 1.8, , 192, 1.0 , false);
}


// GLOVES AND SPARKS CODE //


simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (Instigator != None)
	{
		LeftOne = Spawn(class'DefibFistsLeftBlades');
		Instigator.AttachToBone(LeftOne,'Bip01 L Hand');
	}
	if (Instigator != None)
	{
		RightOne = Spawn(class'DefibFistsRightBlades');
		Instigator.AttachToBone(RightOne,'Bip01 R Hand');
	}
}

simulated event Tick (float DT)
{
    if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
        {
            if (LSparks == None)
            {
                class'BUtil'.static.InitMuzzleFlash (LSparks, class'DefibFistsTazerEffect', DrawScale, self, 'LElectrode');
                LeftOne.AttachToBone(LSparks, 'LElectrode');
            }
            if (RSparks == None)
            {
                class'BUtil'.static.InitMuzzleFlash (RSparks, class'DefibFistsTazerEffect', DrawScale, self, 'RElectrode');    
                RightOne.AttachToBone(RSparks, 'RElectrode');
            }    
            bDischarged = False;            
        }
    super.Tick(DT);
}

simulated function Destroyed()
{
	if (LeftOne != None)
		LeftOne.Destroy();
	if (RightOne != None)
		RightOne.Destroy();
	if (LSparks != None)
		LSparks.Destroy();
	if (RSparks != None)
		RSparks.Destroy();		
	super.Destroyed();
}

defaultproperties
{
     DischargeSound=Sound'BWBP2-Sounds.LightningGun.LG-WaterDischarge'
     MeleeAltStrikeAnim="Punchies_UppercutRight"
     ImpactManager=Class'BallisticProV55.IM_MRS138TazerHit'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     IdleHeavyAnim="Punchies_Idle"
     IdleRifleAnim="Punchies_Idle"
     MeleeStrikeAnim="Punchies_JabLeft"
     DrawScale=0.600000
}
