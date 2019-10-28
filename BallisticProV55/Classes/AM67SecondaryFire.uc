//=============================================================================
// AM67SecondaryFire.
//
// A special attack that causes a blinding flash and motion blur for players
// and has a stun effect on bots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AM67SecondaryFire extends BallisticFire;

function float MaxRange()
{
	return 1200;
}

function DoFireEffect()
{
	local Controller C;
    local Vector StartTrace, Dir, EnemyEye;
    local float DF, Dist, EnemyDF;
    local int i;
    local AM67ViewMesser VM;

	Dir = GetFireSpread() >> GetFireAim(StartTrace);

	for (C=Level.ControllerList;C!=None;C=C.NextController)
	{
		if (C.Pawn == None || C.Pawn.Health <= 0)
			continue;
		EnemyEye = C.Pawn.EyePosition() + C.Pawn.Location;
		Dist = VSize(EnemyEye - StartTrace);
		DF = Dir Dot Normal(EnemyEye - StartTrace);
		if (DF > 0.8 && Dist < 1200 && Weapon.FastTrace(EnemyEye, StartTrace))
		{
			EnemyDF = Normal(StartTrace - EnemyEye) Dot vector(C.Pawn.GetViewRotation());
			EnemyDF = (EnemyDF+1)/2;
			if (EnemyDF < -0.7)
				EnemyDF = 0.1;
			DF = (DF-0.8)*5;
			if (Dist > 500)
				DF /= 1+(Dist-500)/700;
			DF *= EnemyDF;
			if (PlayerController(C) != None)
			{
				for (i=0;i<C.Attached.length;i++)
					if (AM67ViewMesser(C.Attached[i]) != None)
					{
						VM = AM67ViewMesser(C.Attached[i]);
						break;
					}
				if (VM == None)
				{
					VM = Spawn(class'AM67ViewMesser', C);
					VM.SetBase(C);
				}
				VM.AddImpulse(DF);
			}
			else if (AIController(C) != None && DF > 0.1)
			{
				class'BC_BotStoopidizer'.static.DoBotStun(AIController(C), 2*DF, 12*DF);
			}
		}
	}

	SendFireEffect(None, StartTrace + Dir * 1000, -Dir, 0);
	Super.DoFireEffect();
}

defaultproperties
{
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
     FlashBone="tip2"
     BallisticFireSound=(Sound=Sound'BallisticSounds3.AM67.AM67-SecFire',Volume=0.600000)
     EffectString="Blinding flash"
     bModeExclusive=False
     FireAnim="SecFire"
     FireEndAnim=
     FireRate=4.500000
     AmmoClass=Class'BallisticProV55.Ammo_50HV'
     AmmoPerFire=0
     BotRefireRate=0.300000
}
