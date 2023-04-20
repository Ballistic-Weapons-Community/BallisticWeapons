//=============================================================================
// GameStyle_Classic
//
// Defines the Ballistic Classic game style.
//=============================================================================
class GameStyle_Classic extends BC_GameStyle_Config
	config(BallisticProV55);

defaultproperties
{
	Index=GS_Classic
	StyleName="Classic"
	bRunInADS=False
	SightBobScale=0.3f

	// General
	MaxInventoryCapacity=0
    bAlternativePickups=False
	bUniversalMineLights=False

	// Pawn
	bBrightPlayers=False
    StartingHealth=100
    PlayerHealthMax=100
    PlayerSuperHealthMax=200
    StartingShield=0
	PlayerShieldMax=200

	// Movement
	bPlayerDeceleration=False
	bAllowDodging=True
	bAllowDoubleJump=True
	// this value is a fallback which is overridden by weapon ADS move factor,
	// and should be the highest possible ADS movement multiplier for your style
    PlayerWalkSpeedFactor=0.5
	PlayerCrouchSpeedFactor=0.35
    PlayerStrafeScale=1
    PlayerBackpedalScale=1
    PlayerGroundSpeed=360.000000
    PlayerAirSpeed=360.000000
	PlayerAnimationGroundSpeed=440
    PlayerAccelRate=2048.000000
    PlayerJumpZ=294
	PlayerDodgeSpeedFactor=1.5
    PlayerDodgeZ=210

	bEnableSprint=true
	StaminaChargeRate=20
	StaminaDrainRate=20
	SprintSpeedFactor=1.35f
	JumpDrain=2

    HealthKillReward=0
	KillRewardHealthMax=0
	ShieldKillReward=0
	KillRewardShieldMax=0
	
	//Conflict
	ConflictWeaponSlots=20
	ConflictEquipmentSlots=2
}