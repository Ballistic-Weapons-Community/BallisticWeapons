class TargetDesignatorFire extends BallisticFire;

var DesignatorBeamEffect Beam;
var float UpTime;
var bool bDoHit;
var bool bValidMark;
var bool bInitialMark;
var bool bAlreadyMarked;
var bool bMarkStarted;

var IonCannon IonCannon;
var float MarkTime;
var Vector MarkLocation;
var() float TraceRange;
var() float PaintDuration;
var Vector EndEffect;

var() Sound MarkSound;
var() Sound AquiredSound;

var() String TAGFireForce;
var() String TAGMarkForce;
var() String TAGAquiredForce;

var Vector WarnMarkLocation;

var()	int		MinApproachDist;

var() float MaxZDist;

simulated function bool AllowFire()
{
	if (!BW.bScopeView || TargetDesignator(BW).bRedirectSwitchToFiremode)
		return false;
	return Super.AllowFire();
}

function bool SpawnBomber(rotator BombDirection)
{
	local vector BomberStart, BomberStart2, BombTargetCenter, HitNormal, Extent, Temp;
	local float MinZDist;
	local BomberGeneric Bomber;
	local Actor Dropper;
	
	MinZDist = TargetDesignator(BW).StrikeInfo[BW.CurrentWeaponMode].MinZDist;

	BombDirection.Pitch = 0;
	Extent = class'BomberGeneric'.default.CollisionRadius * vect(1,1,0);
	Extent.Z = class'BomberGeneric'.default.CollisionHeight;
	//This clearly doesn't need to be an extent trace, does it Epic?
	//if (Weapon.Trace(BombTargetCenter, HitNormal, MarkLocation + MaxZDist * vect(0,0,1), MarkLocation + Extent.Z * vect(0,0,2), false, Extent) == None)
	if (Weapon.Trace(BombTargetCenter, HitNormal, MarkLocation + MaxZDist * vect(0,0,1), MarkLocation, false) == None)
		BombTargetCenter = MarkLocation + MaxZDist * vect(0,0,1);
	BombTargetCenter.Z -= class'BomberGeneric'.default.CollisionHeight * 2;
	if (VSize(BombTargetCenter - MarkLocation) < MinZDist)
	{
		if (MarkLocation != WarnMarkLocation)
		{
			PlayerController(Instigator.Controller).ClientMessage("Not enough space above the destination.");
			WarnMarkLocation = MarkLocation;
		}
		return false;
	}
	
	if (TargetDesignator(BW).StrikeInfo[BW.CurrentWeaponMode].bRemoteFired)
	{
		Dropper =  Weapon.Spawn(TargetDesignator(BW).StrikeInfo[BW.CurrentWeaponMode].Dropper, Instigator,, BombTargetCenter);
		if (Dropper == None)
			return false;
		return true;
	}
	
	
	else
	{
		if (Weapon.Trace(BomberStart, HitNormal, BombTargetCenter - vector(BombDirection) * 100000, BombTargetCenter, false, Extent) == None)
			BomberStart = BombTargetCenter - vector(BombDirection) * 100000;
		if (Weapon.Trace(BomberStart2, HitNormal, BombTargetCenter + vector(BombDirection) * 100000, BombTargetCenter, false, Extent) == None)
			BomberStart2 = BombTargetCenter + vector(BombDirection) * 100000;
			
		if (VSize(BomberStart - BombTargetCenter) < VSize(BomberStart2 - BombTargetCenter))
		{
			Temp = BomberStart;
			BomberStart = BomberStart2;
			BomberStart2 = Temp;
		}
		
		if (VSize(BomberStart - BombTargetCenter) < MinApproachDist)
		{
			if (MarkLocation != WarnMarkLocation)
			{
				PlayerController(Instigator.Controller).ClientMessage("Bomber's path is obstructed here.");
				WarnMarkLocation = MarkLocation;
			}
			return false;
		}

		Bomber = Weapon.Spawn(class'BomberGeneric', Instigator,, BomberStart, rotator(BombTargetCenter - BomberStart));
		if (Bomber == None)
		{
			PlayerController(Instigator.Controller).ClientMessage("Can't spawn bomber.");
			return false;
		}
			
		if (TargetDesignator(BW).StrikeInfo[BW.CurrentWeaponMode].Compensation > 0)
		{
			Temp = vect(0,0,0);
			Temp.X = BomberStart.Z * TargetDesignator(BW).StrikeInfo[BW.CurrentWeaponMode].Compensation;		
			BombTargetCenter += Temp >> rotator(BomberStart - BombTargetCenter);
		}
		Bomber.Initialize(BombTargetCenter, TargetDesignator(BW).StrikeInfo[BW.CurrentWeaponMode]);
		return true;
	}
}

state Paint
{
	function Rotator AdjustAim(Vector Start, float InAimError)
	{
		local bool bRealAimHelp;
		local rotator Result;

		if ( Bot(Instigator.Controller) != None )
		{
			Instigator.Controller.Focus = None;
			if ( bAlreadyMarked )
				Instigator.Controller.FocalPoint = MarkLocation;
			else
				Instigator.Controller.FocalPoint = TargetDesignator(BW).MarkLocation;
			return rotator(Instigator.Controller.FocalPoint - Start);
		}
		else
		{
			if ( PlayerController(Instigator.Controller) != None )
			{
				bRealAimHelp = PlayerController(Instigator.Controller).bAimingHelp;
				PlayerController(Instigator.Controller).bAimingHelp = false;
			}
			Result =  Global.AdjustAim(Start, InAimError);
			if ( PlayerController(Instigator.Controller) != None )
				PlayerController(Instigator.Controller).bAimingHelp = bRealAimHelp;
			return Result;
		}
	}
    function BeginState()
    {
        IonCannon = None;

        if (Weapon.Role == ROLE_Authority)
        {
            if (Beam == None)
            {
                Beam = Weapon.Spawn(class'DesignatorBeamEffect', Instigator);
                Beam.bOnlyRelevantToOwner = true;
                Beam.EffectOffset = vect(-25, 35, 14);
            }
            bInitialMark = true;
            bValidMark = false;
            MarkTime = Level.TimeSeconds;
            SetTimer(0.25, true);
        }

        ClientPlayForceFeedback(TAGFireForce);
    }
	
	function Timer()
    {
        bDoHit = true;
    }

    function ModeTick(float dt)
    {
        local Vector StartTrace, EndTrace, X,Y,Z;
        local Vector HitLocation, HitNormal;
        local Actor Other;
        local Rotator Aim;

        if (!bIsFiring)
        {
            StopFiring();
        }

        Weapon.GetViewAxes(X,Y,Z);

        // the to-hit trace always starts right in front of the eye
        StartTrace = Instigator.Location + Instigator.EyePosition() + X*Instigator.CollisionRadius;

		Aim = AdjustAim(StartTrace, AimError);
        X = Vector(Aim);
        EndTrace = StartTrace + TraceRange * X;

        Other = Weapon.Trace(HitLocation, HitNormal, EndTrace, StartTrace, false);

        if (Other != None && Other != Instigator)
        {
            if ( bDoHit )
            {
                bValidMark = false;

                if (Other.bWorldGeometry)
                {
                    if (VSize(HitLocation - MarkLocation) < 50.0)
                    {
						Instigator.MakeNoise(3.0);
                        if (Level.TimeSeconds - MarkTime > 0.3)
                        {
							bValidMark = TargetDesignator(BW).CanBomb(HitLocation, class'BomberGeneric'.default.CollisionRadius);

							if (bValidMark)
							{
                                if (Level.TimeSeconds - MarkTime > PaintDuration && SpawnBomber(Instigator.Rotation))
                                {
									Instigator.PendingWeapon = None;
									if (TargetDesignator(BW).CurrentWeaponMode != 12)
									{
										TargetDesignator(BW).ReallyConsumeAmmo(ThisModeNum, 1);
										TargetDesignator(BW).ResupplyStart();
									}

                                    if (Beam != None)
                                        Beam.SetTargetState(PTS_Aquired);

                                    StopForceFeedback(TAGMarkForce);
                                    ClientPlayForceFeedback(TAGAquiredForce);

                                    StopFiring();
                                }
                                else
                                {
                                    if (!bMarkStarted)
                                    {
										bMarkStarted = true;
										ClientPlayForceFeedback(TAGMarkForce);
									}
                                }
                            }
                            else
                            {
                                MarkTime = Level.TimeSeconds;
                                bMarkStarted = false;
                                if ( Bot(Instigator.Controller) != None )
                                {
									Instigator.Controller.Focus = Instigator.Controller.Enemy;
									MarkLocation = Bot(Instigator.Controller).Enemy.Location - Bot(Instigator.Controller).Enemy.CollisionHeight * vect(0,0,2);
								}
                            }
                        }
                    }
                    else
                    {
						bAlreadyMarked = true;
                        MarkTime = Level.TimeSeconds;
                        MarkLocation = HitLocation;
                        bValidMark = false;
                        bMarkStarted = false;
                    }
                }
                else
                {
                    MarkTime = Level.TimeSeconds;
                    bValidMark = false;
                    bMarkStarted = false;
                }
                bDoHit = false;
            }

            EndEffect = HitLocation;
        }
        else
            EndEffect = EndTrace;

        TargetDesignator(BW).EndEffect = EndEffect;

        if (Beam != None)
        {
            Beam.EndEffect = EndEffect;
            if (bValidMark)
                Beam.SetTargetState(PTS_Marked);
            else
                Beam.SetTargetState(PTS_Aiming);
        }
    }
	
	function StopFiring()
    {
		bMarkStarted = false;
        if (Beam != None)
        {
            Beam.SetTargetState(PTS_Cancelled);
        }
        GotoState('');
    }

    function EndState()
    {
		bAlreadyMarked = false;
        SetTimer(0, false);
        StopForceFeedback(TAGFireForce);
    }
}


function DoFireEffect()
{
}

function ModeHoldFire()
{
    GotoState('Paint');
}

function StartBerserk()
{
}

function StopBerserk()
{
}

function StartSuperBerserk()
{
}

function vector GetFireStart(vector X, vector Y, vector Z)
{
    return Instigator.Location + Instigator.EyePosition() + X*Instigator.CollisionRadius;
}

function float MaxRange()
{
	return TraceRange;
}

defaultproperties
{
     TraceRange=50000.000000
     PaintDuration=0.600000
     MarkSound=Sound'WeaponSounds.TAGRifle.TAGFireB'
     AquiredSound=Sound'WeaponSounds.TAGRifle.TAGTargetAquired'
     TAGFireForce="TAGFireA"
     TAGMarkForce="TAGFireB"
     TAGAquiredForce="TAGAquire"
     MinApproachDist=2048
     MaxZDist=8200.000000
     bSplashDamage=True
     bRecommendSplashDamage=True
     bFireOnRelease=True
     FireEndAnim=
     FireRate=0.600000
     AmmoClass=Class'XWeapons.BallAmmo'
     BotRefireRate=1.000000
     WarnTargetPct=0.100000
}
